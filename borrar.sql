--------------------------------------------
-- Bases de Datos PROTECO                 --
-- Proyecto 2: CreaciOn y manejo con SQL  --
-- Integrantes:                           --
--  * SAnchez Neri David Yaxkin           --
--  * MartInez Ortiz SaUl Axel            --
--------------------------------------------

-- Borrado de tablas

DROP TABLE AutoInvolucrado;
DROP TABLE PersonaInvolucrada;
DROP TABLE HistorialEstado;
DROP TABLE EstadoSiniestro;
DROP TABLE SiniestroColision;
DROP TABLE SiniestroSocial;
DROP TABLE SiniestroMaterial;
DROP TABLE Siniestro;
DROP TABLE Poliza;
DROP TABLE Cotizacion;
DROP TABLE Tarjeta;
DROP TABLE Cliente;
DROP TABLE Auto;
DROP TABLE Conductor;
DROP TABLE Hospital;
DROP TABLE CatalogoEstadosSiniestro;
DROP TABLE CatalogoAgencias;
DROP TABLE CatalogoModelos;
DROP TABLE CatalogoMarcas;
DROP TABLE CatalogoEstadosRepublica;
DROP TABLE CatalogoTiposSeguro;

-- Borrado de sequencias
DROP SEQUENCE Seq_Auto;
DROP SEQUENCE Seq_AutoInvolucrado;
DROP SEQUENCE Seq_CatalogoAgencias;
DROP SEQUENCE Seq_CatalogoEstadosSiniestro;
DROP SEQUENCE Seq_CatalogoEstadosRepublica;
DROP SEQUENCE Seq_CatalogoMarcas;
DROP SEQUENCE Seq_CatalogoModelos;
DROP SEQUENCE Seq_CatalogoTiposSeguro;
DROP SEQUENCE Seq_Cliente;
DROP SEQUENCE Seq_Conductor;
DROP SEQUENCE Seq_Cotizacion;
DROP SEQUENCE Seq_EstadoSiniestro;
DROP SEQUENCE Seq_HistorialEstado;
DROP SEQUENCE Seq_Hospital;
DROP SEQUENCE Seq_PersonaInvolucrada;
DROP SEQUENCE Seq_Poliza;
DROP SEQUENCE Seq_Siniestro;
DROP SEQUENCE Seq_Tarjeta;

DROP VIEW Cotizaciones_Mayor_1900;
DROP VIEW Polizas_Octubre2016;
DROP VIEW Poliza_Siniestro_Registrado;
DROP VIEW Seguro_Cobertura_Amplia;
DROP VIEW Hospitales_Hasta_Agosto2024;