USE master
GO 
USE GRUPO04
GO

DROP TRIGGER IF EXISTS VerificarAutorizaciones
GO

CREATE TRIGGER VerificarAutorizaciones
ON hproduccion
AFTER INSERT
AS
BEGIN
    
    DECLARE @estado INT, @idResolucion INT;
 

    DECLARE AutorizacionCursor CURSOR FOR
    SELECT res_estado, res_id 
    FROM resolucion
    WHERE res_idResolucion = (SELECT res_id FROM inserted);

    OPEN AutorizacionCursor;
    FETCH NEXT FROM AutorizacionCursor INTO @estado, @idResolucion;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @estado = 0
        BEGIN
            RAISERROR ('La resolucion %d no ha sido autorizada', 16, 1, @idResolucion);
            ROLLBACK TRANSACTION;
            CLOSE AutorizacionCursor;
            DEALLOCATE AutorizacionCursor;
            RETURN;
        END

        FETCH NEXT FROM AutorizacionCursor INTO @estado, @idResolucion;
    END

    CLOSE AutorizacionCursor;
    DEALLOCATE AutorizacionCursor;

    UPDATE resolucion
    SET res_estado = 1
    WHERE res_id = (SELECT res_id FROM inserted);
END
GO



DROP TRIGGER IF EXISTS VerificarExistenciasEnAlmacen
GO

CREATE TRIGGER VerificarExistenciasEnAlmacen
ON hproduccionMaterial
AFTER INSERT
AS
BEGIN
    DECLARE @MaterialID INT, @CantidadRequerida INT;
    
    DECLARE MaterialCursor CURSOR FOR
    SELECT mat_id, hprmat_cantidad
    FROM inserted;
    
    OPEN MaterialCursor;
    FETCH NEXT FROM MaterialCursor INTO @MaterialID, @CantidadRequerida;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @StockDisponible INT;
        SELECT @StockDisponible = mat_cantidad
        FROM material
        WHERE mat_id = @MaterialID;
        
        IF @CantidadRequerida > @StockDisponible
        BEGIN
            RAISERROR ('No hay suficiente stock del material %d', 16, 1, @MaterialID);
            ROLLBACK TRANSACTION;
            CLOSE MaterialCursor;
            DEALLOCATE MaterialCursor;
            RETURN;
        END
        FETCH NEXT FROM MaterialCursor INTO @MaterialID, @CantidadRequerida;
    END
    
    CLOSE MaterialCursor;
    DEALLOCATE MaterialCursor;

    -- Actualizar el stock de los materiales
    DECLARE @MaterialID2 INT, @CantidadRequerida2 INT;

    DECLARE MaterialCursor2 CURSOR FOR
    SELECT mat_id, hprmat_cantidad
    FROM inserted;
    
    OPEN MaterialCursor2;
    FETCH NEXT FROM MaterialCursor2 INTO @MaterialID2, @CantidadRequerida2;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE material
        SET mat_cantidad = mat_cantidad - @CantidadRequerida2
        WHERE mat_id = @MaterialID2;

        FETCH NEXT FROM MaterialCursor2 INTO @MaterialID2, @CantidadRequerida2;
    END

    CLOSE MaterialCursor2;
    DEALLOCATE MaterialCursor2;
END
GO


DROP TRIGGER IF EXISTS VerificarDisponibilidadHoraria
GO

CREATE TRIGGER VerificarDisponibilidadHoraria
ON [dbo].[hproduccionPersonal]
AFTER INSERT
AS
BEGIN
    DECLARE @HojaProduccionID INT, @PersonalID INT, @HorasProgramadas INT;
    
    DECLARE PersonalCursor CURSOR FOR
    SELECT hpr_id, per_id, hprper_horasProgramadas
    FROM inserted;
    
    OPEN PersonalCursor;
    FETCH NEXT FROM PersonalCursor INTO @HojaProduccionID, @PersonalID, @HorasProgramadas;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
       -- Obtener el periodo de tiempo de la hoja de produccion
        DECLARE @FechaInicio DATE, @HoraInicio TIME, @FechaFin DATE, @HoraFin TIME;
        SELECT @FechaInicio = hpr_fechaInicio, @HoraInicio = hpr_horaInicio, @FechaFin = hpr_fechaFin, @HoraFin = hpr_horaFin
        FROM [dbo].[hproduccion]
        WHERE hpr_id = @HojaProduccionID;

        -- Obtener el periodo de tiempo del horario del personal 
        DECLARE @FechaHorario DATE, @HoraInicioHorario TIME, @HoraFinHorario TIME;
        SELECT @FechaHorario = hper_fecha, @HoraInicioHorario = hper_horaInicio, @HoraFinHorario = hper_horaFin
        FROM [dbo].[horarioPersonal]
        WHERE per_id = @PersonalID AND  hper_fecha BETWEEN @FechaInicio AND @FechaFin
        ORDER BY hper_fecha DESC OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;
        


        -- Verificar si el horario del personal esta disponible
        IF @FechaHorario IS NULL
        BEGIN
            RAISERROR ('El personal %d no tiene un horario asignado para la fecha', 16, 1, @PersonalID);
            ROLLBACK TRANSACTION;
            CLOSE PersonalCursor;
            DEALLOCATE PersonalCursor;
            RETURN;
        END
        --! Validar que el horario del personal este disponible
        ELSE IF @FechaHorario <> @FechaInicio OR @HoraInicioHorario > @HoraInicio 
        BEGIN
            RAISERROR ('El personal %d no esta disponible para la fecha', 16, 1, @PersonalID);
            ROLLBACK TRANSACTION;
            CLOSE PersonalCursor;
            DEALLOCATE PersonalCursor;
            RETURN;
        END
        FETCH NEXT FROM PersonalCursor INTO @HojaProduccionID, @PersonalID, @HorasProgramadas;
    END
    
    CLOSE PersonalCursor;
    DEALLOCATE PersonalCursor;
END
GO

DROP PROCEDURE IF EXISTS VerificarPresupuestoHojaProduccion
GO

CREATE PROCEDURE VerificarPresupuestoHojaProduccion
    @HojaProduccionID INT
AS
BEGIN
    BEGIN TRY
        DECLARE @TotalInsumos DECIMAL(10, 2);
        DECLARE @TotalSalarios DECIMAL(10, 2);
        DECLARE @Presupuesto DECIMAL(10, 2);

        -- Obtener el presupuesto asignado para la hoja de producción
        SELECT @Presupuesto = hpr_presupuesto
        FROM hproduccion
        WHERE hpr_id = @HojaProduccionID;

        -- Calcular el total de insumos para la hoja de producción
        SELECT @TotalInsumos = SUM(mat_precioUnitario * hpm.hprmat_cantidad)
        FROM hproduccionMaterial hpm
        INNER JOIN material m ON hpm.mat_id = m.mat_id
        WHERE hpm.hpr_id = @HojaProduccionID;

        -- Calcular el total de salarios para la hoja de producción
        SELECT @TotalSalarios = SUM(per_sueldoHora * hpp.hprper_horasProgramadas)
        FROM hproduccionPersonal hpp
        INNER JOIN personal p ON hpp.per_id = p.per_id
        WHERE hpp.hpr_id = @HojaProduccionID;

        -- Verificar si el total de insumos y salarios excede el presupuesto asignado
        IF (@TotalInsumos + @TotalSalarios) > @Presupuesto
        BEGIN
            BEGIN TRANSACTION;
            --! Eliminar detalles de materiales
            -- DELETE FROM hproduccionMaterial WHERE hpr_id = @HojaProduccionID;
            -- -- -- Eliminar detalles de personal
            -- DELETE FROM hproduccionPersonal WHERE hpr_id = @HojaProduccionID;
            -- -- Eliminar la hoja de producción
            -- DELETE FROM hproduccion WHERE hpr_id = @HojaProduccionID;
            -- ? este queda
            UPDATE resolucion
                SET res_estado = 0
            WHERE res_id = (SELECT res_id FROM hproduccion WHERE hpr_id = @HojaProduccionID);
            COMMIT;
            PRINT 'El monto total de insumos y salarios excede el presupuesto asignado.';
        END
        ELSE
        BEGIN
            BEGIN TRANSACTION;
            UPDATE resolucion
                SET res_estado = 1
            WHERE res_id = (SELECT res_id FROM hproduccion WHERE hpr_id = @HojaProduccionID);
            COMMIT;
            PRINT 'El monto total de insumos y salarios no excede el presupuesto asignado.';
        END
    END TRY
    BEGIN CATCH
        ROLLBACK;
        -- Manejar la excepción según sea necesario
        RAISERROR('Error al verificar el presupuesto de la hoja de producción.', 16, 1);
    END CATCH
END
GO

CREATE TRIGGER tr_actualizar_stock
ON hproduccion
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    
    UPDATE articulo
    SET art_stock = art_stock + i.hpr_cantidad
    FROM inserted i
    WHERE articulo.art_id = i.art_id;
END;
