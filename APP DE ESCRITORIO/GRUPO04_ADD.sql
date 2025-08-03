USE GRUPO04
go

CREATE TABLE Usuario
(
 nUsuCodigo INT ,
 cUsuUsuario VARCHAR(20) NOT NULL,
 cUsuClave VARCHAR(15) NOT NULL,
 nUsuEstado INT NOT NULL DEFAULT 1,
 dUsuFecRegistro DATETIME NOT NULL DEFAULT GETDATE(),
 CONSTRAINT Usuario_nUsuCodigo_PK PRIMARY KEY NONCLUSTERED(nUsuCodigo),

)
go

ALTER TABLE Usuario ADD per_id INT
ALTER TABLE Usuario ADD CONSTRAINT FK_Usuario_perid	FOREIGN KEY (per_id) REFERENCES personal (per_id)
SELECT * FROM Usuario

------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE usp_LoginUsuario
   @cUsuUsuario VARCHAR(20),
   @cUsuClave VARCHAR(15)   
AS
BEGIN 
 
   SELECT P.per_id,P.per_nombre,P.per_sueldoHora,U.cUsuUsuario,pu.pue_nombre
	FROM personal P 
	INNER JOIN puesto PU	ON  P.pue_id = Pu.pue_id
	INNER JOIN Usuario U	ON	P.per_id= U.per_id  WHERE U.cUsuUsuario=@cUsuUsuario AND U.cUsuClave=@cUsuClave
	
END
GO

 SELECT		p.pue_nombre AS Puesto,
			pe.per_nombre AS Personal,
			pe.per_id		AS IdPersonal
 FROM puesto p
 INNER JOIN Personal pe  ON p.pue_id = pe.pue_id

 select * from Usuario

INSERT INTO Usuario (nUsuCodigo,cUsuUsuario,cUsuClave,nUsuEstado,per_id)
	VALUES(1,'QHMario','pro20',1,47)
INSERT INTO Usuario (nUsuCodigo,cUsuUsuario,cUsuClave,nUsuEstado,per_id)
	VALUES(2,'RJose','operario',1,4)
INSERT INTO Usuario (nUsuCodigo,cUsuUsuario,cUsuClave,nUsuEstado,per_id)
	VALUES(3,'PJuan ','admin',1,1)

EXEC usp_LoginUsuario 'QHMario','pro20'
EXEC usp_LoginUsuario 'RJose','operario'
EXEC usp_LoginUsuario 'PJuan','admin'

-------------------------------------------------------------------------------------------------------------------

--CREATE TABLE Menus(
-- nMenCodigo INT,
-- cMenNombre VARCHAR(50) NOT NULL,
-- cMenDescripcion VARCHAR(50) NOT NULL,
-- nMenPadre INT NOT NULL,
-- dMenFecRegistro DATETIME NOT NULL DEFAULT GETDATE(),
-- CONSTRAINT Menus_nMenCodigo_PK PRIMARY KEY(nMenCodigo)
--)
--GO


--CREATE TABLE UsuPermiso(
--  nUsuCodigo INT,
--  nMenCodigo INT,
--  dUsuPermFecRegistro DATETIME NOT NULL DEFAULT  GETDATE(),
--  CONSTRAINT UsuPermiso_nUsuCodigo_nFormCodigo_PK PRIMARY KEY(nUsuCodigo,nMenCodigo),
--  CONSTRAINT UsuPermiso_nUsuCodigo_PK FOREIGN KEY(nUsuCodigo) REFERENCES Usuario(nUsuCodigo),
--  CONSTRAINT UsuPermiso_nMenCodigo_PK FOREIGN KEY(nMenCodigo) REFERENCES Menus(nMenCodigo)
--)
--GO

------------------------------------------------------------------------------------------------------------
CREATE PROC usp_verArticulo
@hpr_id	INT
AS
BEGIN
		SELECT	
				a.art_nombre
			FROM hproduccion hpr
			INNER JOIN articulo a	ON hpr.art_id = a.art_id 
			WHERE  hpr.hpr_id=@hpr_id 
END
GO

EXEC usp_verArticulo 2

CREATE PROC usp_VerDetalleMaterial
@hpr_id INT
AS
BEGIN
	
  SELECT	 hpm.mat_id,
			 m.mat_nombre,
			hpm.hprmat_cantidad,
			m.mat_precioUnitario,
			hpm.hprmat_id,
		 SUM(hpm.hprmat_cantidad * m.mat_precioUnitario) AS valor_total_produccion
FROM
    hproduccionMaterial hpm
INNER JOIN
    material m ON hpm.mat_id = m.mat_id
WHERE
    hpm.hpr_id = @hpr_id
GROUP BY
    hpm.mat_id, m.mat_nombre,hpm.hprmat_cantidad,m.mat_precioUnitario,hpm.hprmat_id
END
GO

EXEC usp_VerDetalleMaterial 2
EXEC usp_VerDetalleMaterial 144



CREATE PROC usp_ModificarCantidadDetalle
@hprmat_id int,
@cantidad	int
AS
BEGIN
		UPDATE hproduccionMaterial SET hprmat_cantidad = @cantidad
										WHERE hprmat_id = @hprmat_id
END

EXEC usp_ModificarCantidadDetalle 8,20

CREATE PROC sp_EiminarDetalle
@hprmat_id INT
AS
BEGIN
		DELETE FROM hproduccionMaterial 
			WHERE hprmat_id = @hprmat_id
END


--CREATE PROC usp_NuevoDetalle
--@hpr_id INT,
--@mat_id	INT,
--@hprmat_cantidad INT
--AS
--BEGIN
--		INSERT INTO hproduccionMaterial (hpr_id,mat_id,hprmat_cantidad)
--				VALUES(@hpr_id,@mat_id,@hprmat_cantidad)
--END

-------------DATARELATION-----------------------------------------------------------------
--Nro de producciones que se generaron en la planta 
CREATE VIEW v_NroDeProducciones
as
SELECT	hpr.hpr_id			AS [ID HProducción],
		Convert(char(10),hpr.hpr_fecha	,103)	AS Fecha,
		a.art_nombre		AS	Articulo,
		p.per_nombre		AS Empleado,
		pl.pla_nombre		AS Planta,
		pl.pla_direccion	AS Dirección
	FROM hproduccion hpr
	INNER JOIN articulo a	ON	hpr.art_id = a.art_id
	INNER JOIN personal p	ON  hpr.per_id = p.per_id
	INNER JOIN planta pl	ON  hpr.pla_id = pl.pla_id

SELECT * FROM v_NroDeProducciones

--Mostrar informacion de los resultados respectivos detalles
CREATE VIEW v_DetalleProducciones
as
SELECT   hprm.hpr_id			AS IdProducción,
		hprm.mat_id			AS IdMaterial,
		m.mat_nombre		AS Material,
		hprm.hprmat_cantidad	AS Cantidad
	FROM hproduccionMaterial hprm
	--INNER JOIN hproduccion hpr		ON hpr.hpr_id = hprm.hpr_id
	INNER JOIN material m			ON hprm.mat_id = m.mat_id
SELECT * FROM v_DetalleProducciones
---------------------------------------------------------------------------------------------------

--Mostrar informacion de los resultados respectivos detalles personal

CREATE VIEW v_DetallePersonles
as
SELECT  distinct hprp.hpr_id			AS IdProducción,
		hprp.per_id		    AS IdPersonal,
		p.per_nombre		AS Personal,
		PU.pue_nombre		AS Puesto,
		hprp.hprper_horasProgramadas	AS HrsTrabajo
	FROM hproduccionPersonal hprp
	INNER JOIN hproduccion hpr		ON hprp.hpr_id = hprp.hpr_id
	INNER JOIN personal p			ON hprp.per_id = p.per_id
	INNER JOIN puesto PU			ON P.pue_id = PU.pue_id

	SELECT * FROM v_DetallePersonles


-----------------------------[PERSONAL]----------------------------------------------------------------------
-----------------------------[PERSONAL]----------------------------------------------------------------------

CREATE PROC usp_verPersonal
@hpr_id	INT
AS
BEGIN
		SELECT	p.per_nombre
			FROM hproduccion hpr
			INNER JOIN personal p	ON hpr.per_id = p.per_id
			WHERE  hpr.hpr_id=@hpr_id 
END
GO

EXEC usp_verPersonal 1

ALTER PROC usp_VerDetallePersonal
@hpr_id INT
AS
BEGIN
	
  SELECT	 p.per_id,
			 p.per_nombre,
			 pu.pue_nombre,
			 hpp.hprper_horasProgramadas,
			 p.per_sueldoHora,
			 SUM(hpp.hprper_horasProgramadas * p.per_sueldoHora) AS Sueldo_Personal,
			 hpp.hprper_id
FROM
    hproduccionPersonal hpp
INNER JOIN personal p	ON hpp.per_id = p.per_id
INNER JOIN puesto pu	ON p.pue_id = pu.pue_id
WHERE
    hpp.hpr_id = @hpr_id
GROUP BY
     p.per_id, p.per_nombre,hpp.hprper_horasProgramadas,p.per_sueldoHora,hpp.hprper_id, pu.pue_nombre
END
GO

UPDATE hproduccion SET per_id = 45 WHERE hpr_id = 144
SELECT * from hproduccionMaterial
SELECT * from personal


EXEC usp_VerDetallePersonal 1

CREATE PROC usp_ModificarCantidadDetalleP
@hprper_id int,
@HorasProgramadas	int
AS
BEGIN
		UPDATE hproduccionPersonal SET hprper_horasProgramadas = @HorasProgramadas
										WHERE hprper_id = @hprper_id
END

EXEC usp_ModificarCantidadDetalleP 8,20

CREATE PROC sp_EiminarDetalleP
@hprper_id INT
AS
BEGIN
		DELETE FROM hproduccionPersonal 
			WHERE hprper_id = @hprper_id
END



Alter TRIGGER trgUpdateMaterialStock
ON hproduccionMaterial
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    
    UPDATE material
    SET mat_cantidad = material.mat_cantidad +  
                        CASE					
                            WHEN INSERTED.hprmat_cantidad > DELETED.hprmat_cantidad THEN (DELETED.hprmat_cantidad - INSERTED.hprmat_cantidad)
                            WHEN INSERTED.hprmat_cantidad < DELETED.hprmat_cantidad THEN -(INSERTED.hprmat_cantidad - DELETED.hprmat_cantidad)
                            ELSE 0 
                        END
    FROM material
    INNER JOIN INSERTED ON material.mat_id = INSERTED.mat_id
    INNER JOIN DELETED ON material.mat_id = DELETED.mat_id;
END;


CREATE TRIGGER trgDeleteMaterialStock
ON hproduccionMaterial
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    
    UPDATE material
    SET mat_cantidad = material.mat_cantidad + DELETED.hprmat_cantidad
    FROM material
    INNER JOIN DELETED ON material.mat_id = DELETED.mat_id;
END;

  SELECT	 hpm.mat_id,
			 m.mat_nombre,
			hpm.hprmat_cantidad,
			m.mat_precioUnitario,
			hpm.hprmat_id,
		 SUM(hpm.hprmat_cantidad * m.mat_precioUnitario) AS valor_total_produccion
FROM
    hproduccionMaterial hpm
INNER JOIN
    material m ON hpm.mat_id = m.mat_id
WHERE
    hpm.hpr_id = 144
GROUP BY
    hpm.mat_id, m.mat_nombre,hpm.hprmat_cantidad,m.mat_precioUnitario,hpm.hprmat_id