--------------------------------------------
-- Bases de Datos PROTECO                 --
-- Proyecto 2: CreaciOn y manejo con SQL  --
-- Integrantes:                           --
--  * SAnchez Neri David Yaxkin           --
--  * MartInez Ortiz SaUl Axel            --
--------------------------------------------

-- Creación de sinónimos
CREATE SYNONYM Auto FOR Auto; -- Se me hace un poco contraproducente usar un sinónimo para esta tabla
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

-- Vista de las tablas
CREATE OR REPLACE VIEW Cotizaciones_Mayor_1900 AS
	SELECT * FROM Cot WHERE Cot.costo > 1900;

CREATE OR REPLACE VIEW Polizas_Octubre2016 AS
	SELECT * FROM Plz WHERE p.fecha_inicio > '31/09/2016';

CREATE OR REPLACE VIEW Poliza_Siniestro_Registrado(cliente_id,nombre_cliente,num_placas) AS
	SELECT Cte.cliente_id,Cte.nombre,Plz.num_placas
	FROM Cte, Plz
	WHERE Cte.cliente_id = ALL (
		SELECT Plz.num_placas FROM Plz WHERE Plz.poliza_id = ALL (
			SELECT Sin.poliza_id FROM Sin WHERE Sin.estado_siniestro_id = ALL (
				SELECT ESin.tipo_estado_siniestro_id FROM ESin WHERE ESin.tipo_estado_siniestro_id = ALL (
					SELECT TipoSin.tipo_estado_siniestro_id FROM TipoSin WHERE TipoSin.clave = 'REGISTRADO'
					)
				)
			)
		);

CREATE OR REPLACE VIEW Seguro_Cobertura_Amplia(cliente_id,nombre_cliente,rfc) AS
	SELECT Cte.cliente_id, Cte.nombre, Cte.rfc
	FROM Cte
	WHERE Cte.cliente_id = ALL (
		SELECT Plz.cliente_id FROM Plz WHERE Plz.cotizacion_id = ALL (
			SELECT Cot.cotizacion_id FROM Cot WHERE Cot.tipo_seguro_id = ALL (
				SELECT TipoSeg.tipo_seguro_id FROM TipoSeg WHERE TipoSeg.clave = 'CA'
				)
			)
		);

CREATE OR REPLACE VIEW Hospital_Poliza_Menor_Agosto2024(nombre_hospital) AS
	SELECT Hosp.nombre
	FROM Hosp
	WHERE Hosp.hospital_id = ALL (
		SELECT Sin.hospital_id FROM Sin WHERE Sin.poliza_id = ALL (
			SELECT Plz.poliza_id FROM Plz WHERE Plz.fecha_fin < '01/09/2024'
			)
		);

