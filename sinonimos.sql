--------------------------------------------
-- Bases de Datos PROTECO                 --
-- Proyecto 2: CreaciOn y manejo con SQL  --
-- Integrantes:                           --
--  * SAnchez Neri David Yaxkin           --
--  * MartInez Ortiz SaUl Axel            --
--------------------------------------------

-- Creación de sinónimos
-- Se me hace un poco contraproducente usar un sinónimo para la tabla Auto
CREATE SYNONYM Auto FOR Auto; 
CREATE SYNONYM AutoInv FOR AutoInvolucrado;
CREATE SYNONYM Agencias FOR CatalogoAgencias;
CREATE SYNONYM TipoSin FOR CatalogoEstadosSiniestro;
CREATE SYNONYM EstadoRep FOR CatalogoEstadosRepublica;
CREATE SYNONYM Marca FOR CatalogoMarcas;
CREATE SYNONYM Modelo FOR CatalogoModelos;
CREATE SYNONYM TipoSeg FOR CatalogoTiposSeguro;
CREATE SYNONYM Cte FOR Cliente;
CREATE SYNONYM Cond FOR Conductor;
CREATE SYNONYM Cot FOR Cotizacion;
CREATE SYNONYM ESin FOR EstadoSiniestro;
CREATE SYNONYM Historial FOR HistorialEstado;
CREATE SYNONYM Hosp FOR Hospital;
CREATE SYNONYM PersonaInv FOR PersonaInvolucrada;
CREATE SYNONYM Plz FOR Poliza;
CREATE SYNONYM Sin FOR Siniestro;
CREATE SYNONYM SinColl FOR SiniestroColision;
CREATE SYNONYM SinMat FOR SiniestroMaterial;
CREATE SYNONYM SinSoc FOR SiniestroSocial;
CREATE SYNONYM TarjetaCredito for Tarjeta;
