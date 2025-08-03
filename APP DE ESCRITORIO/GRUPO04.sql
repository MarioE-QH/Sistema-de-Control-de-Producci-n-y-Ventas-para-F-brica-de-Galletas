
USE master
GO

DROP DATABASE  GRUPO04
GO

CREATE DATABASE GRUPO04
GO
USE GRUPO04
GO

-- 'Unidad de Medida'
DROP TABLE IF EXISTS unidadMedida
GO
CREATE TABLE unidadMedida
(
    unm_id INT IDENTITY(1,1) PRIMARY KEY,
    unm_nombre VARCHAR(50) NOT NULL
)
GO

--'Material'
DROP TABLE IF EXISTS material
GO
CREATE TABLE material
(
    mat_id INT IDENTITY(1,1) PRIMARY KEY,
    mat_nombre VARCHAR(50) NOT NULL,
    unm_id INT NOT NULL,
    mat_cantidad INT NOT NULL DEFAULT 0,
    mat_precioUnitario DECIMAL(10,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (unm_id) REFERENCES unidadMedida(unm_id)
)
GO

-- 'Articulo'
DROP TABLE IF EXISTS articulo
GO
CREATE TABLE articulo
(
    art_id INT IDENTITY(1,1) PRIMARY KEY,
    art_nombre VARCHAR(50) NOT NULL,
    art_stock INT NOT NULL DEFAULT 0,
)
GO

--'Puesto'
DROP TABLE IF EXISTS puesto
GO
CREATE TABLE puesto
(
    pue_id INT IDENTITY(1,1) PRIMARY KEY,
    pue_nombre VARCHAR(50) NOT NULL,
)
GO
--'Personal'
DROP TABLE IF EXISTS personal
GO
CREATE TABLE personal
(
    per_id INT IDENTITY(1,1) PRIMARY KEY,
    per_nombre VARCHAR(50) NOT NULL,
    per_sueldoHora DECIMAL(10,2) NOT NULL DEFAULT 0,
    pue_id INT NOT NULL,
    FOREIGN KEY (pue_id) REFERENCES puesto(pue_id)
)
GO

--'horario del personal'
DROP TABLE IF EXISTS horarioPersonal
GO
CREATE TABLE horarioPersonal
(
    hper_id INT IDENTITY(1,1) PRIMARY KEY,
    hper_fecha DATE NOT NULL,
    hper_horaInicio TIME NOT NULL,
    hper_horaFin TIME NOT NULL,
    per_id INT NOT NULL,
    FOREIGN KEY (per_id) REFERENCES personal(per_id)
)

--  'Gerencia'
DROP TABLE IF EXISTS gerencia
GO
CREATE TABLE gerencia
(
    ger_id INT IDENTITY(1,1) PRIMARY KEY,
    ger_nombre VARCHAR(50) NOT NULL
)
GO

--  'cronograma'
DROP TABLE IF EXISTS cronograma
GO
CREATE TABLE cronograma
(
    cro_id INT IDENTITY(1,1) PRIMARY KEY,
    cro_fechaInicio DATE NOT NULL,
    cro_horaInicio TIME NOT NULL,
    cro_fechaFin DATE NOT NULL,
    cro_horaFin TIME NOT NULL,
)
GO

--  'Planta'
DROP TABLE IF EXISTS planta
GO
CREATE TABLE planta
(
    pla_id INT IDENTITY(1,1) PRIMARY KEY,
    pla_nombre VARCHAR(50) NOT NULL,
    pla_direccion VARCHAR(50) NOT NULL,
	cro_id	INT NOT NULL,
	FOREIGN KEY (cro_id) REFERENCES cronograma(cro_id)
)
GO


--  'tipo de resolucion'
DROP TABLE IF EXISTS tipoResolucion
GO
CREATE TABLE tipoResolucion
(
    tres_id INT IDENTITY(1,1) PRIMARY KEY,
    tres_nombre VARCHAR(50) NOT NULL
)
GO

--  'Resolucion'
DROP TABLE IF EXISTS resolucion
GO
CREATE TABLE resolucion
(
    res_id INT IDENTITY(1,1) PRIMARY KEY,
    res_serie VARCHAR(4) NOT NULL,
    res_numero INT CHECK (res_numero > 0),
    res_fecha DATE NOT NULL,
    res_descripcion VARCHAR(50) NULL,
    tres_id INT NOT NULL,
    res_idResolucion INT NULL,
    res_estado INT NOT NULL DEFAULT 0,
    ger_id INT NOT NULL,
    FOREIGN KEY (tres_id) REFERENCES tipoResolucion(tres_id),
    FOREIGN KEY (res_idResolucion) REFERENCES resolucion(res_id),
    FOREIGN KEY (ger_id) REFERENCES gerencia(ger_id)
)
GO

--  'HProduccion'
DROP TABLE IF EXISTS hproduccion
GO
CREATE TABLE hproduccion
(
    hpr_id INT IDENTITY(1,1) PRIMARY KEY,
    hpr_fecha DATE NOT NULL,
    art_id INT NOT NULL,
    hpr_cantidad INT NOT NULL DEFAULT 0 CHECK (hpr_cantidad >= 0),
    per_id INT NOT NULL,
    FOREIGN KEY (art_id) REFERENCES articulo(art_id),
    FOREIGN KEY (per_id) REFERENCES personal(per_id),
    hpr_fechaInicio DATE NULL,
    hpr_horaInicio TIME NULL,
    hpr_fechaFin DATE NULL,
    hpr_horaFin TIME NULL,
    hpr_presupuesto DECIMAL(10,2) NULL,
    pla_id INT NOT NULL,
    FOREIGN KEY (pla_id) REFERENCES planta(pla_id),
    res_id INT NULL,
    FOREIGN KEY (res_id) REFERENCES resolucion(res_id)
)
GO

--  'HProduccionMaterial'
DROP TABLE IF EXISTS hproduccionMaterial
GO
CREATE TABLE hproduccionMaterial
(
    hprmat_id INT IDENTITY(1,1) PRIMARY KEY,
    hpr_id INT NOT NULL,
    mat_id INT NOT NULL,
    hprmat_cantidad INT NOT NULL CHECK (hprmat_cantidad >= 1),
    FOREIGN KEY (hpr_id) REFERENCES hproduccion(hpr_id),
    FOREIGN KEY (mat_id) REFERENCES material(mat_id)
)
GO

--  'HProduccionPersonal'
DROP TABLE IF EXISTS hproduccionPersonal
GO
CREATE TABLE hproduccionPersonal
(
    hprper_id INT IDENTITY(1,1) PRIMARY KEY,
    hpr_id INT NOT NULL,
    per_id INT NOT NULL,
    hprper_horasProgramadas INT CHECK (hprper_horasProgramadas > 0),
    FOREIGN KEY (hpr_id) REFERENCES hproduccion(hpr_id),
    FOREIGN KEY (per_id) REFERENCES personal(per_id)
)
GO



DROP TABLE IF EXISTS hproduccionPersonal
DROP TABLE IF EXISTS hproduccionMaterial
DROP TABLE IF EXISTS hproduccion
DROP TABLE IF EXISTS resolucion
DROP TABLE IF EXISTS tipoResolucion
DROP TABLE IF EXISTS cronograma
DROP TABLE IF EXISTS planta
DROP TABLE IF EXISTS gerencia
DROP TABLE IF EXISTS horarioPersonal
DROP TABLE IF EXISTS personal
DROP TABLE IF EXISTS puesto
DROP TABLE IF EXISTS articulo
DROP TABLE IF EXISTS material
DROP TABLE IF EXISTS unidadMedida
GO



