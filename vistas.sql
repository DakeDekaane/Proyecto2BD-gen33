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

CREATE OR REPLACE VIEW Cotizaciones_Mayor_1900 AS
	SELECT * FROM Cot WHERE Cot.costo > 1900;

CREATE OR REPLACE VIEW Polizas_Octubre2016 AS
	SELECT * FROM Poliza p WHERE p.fecha_inicio > '31/09/2016';

CREATE OR REPLACE VIEW Poliza_Siniestro_Registrado(cliente_id,nombre_cliente,num_placas) AS
	SELECT c.cliente_id,c.nombre,p.num_placas
	FROM Cliente c, Poliza p
	WHERE c.cliente_id = ALL (
		SELECT p.num_placas FROM Poliza p WHERE p.poliza_id = ALL (
			SELECT s.poliza_id FROM Siniestro s WHERE s.estado_siniestro_id = ALL (
				SELECT es.tipo_estado_siniestro_id FROM EstadoSiniestro es WHERE es.tipo_estado_siniestro_id = ALL (
					SELECT ces.tipo_estado_siniestro_id FROM CatalogoEstadosSiniestro ces WHERE ces.clave = 'REGISTRADO'
					)
				)
			)
		);

CREATE OR REPLACE VIEW Seguro_Cobertura_Amplia(cliente_id,nombre_cliente,rfc) AS
	SELECT c.cliente_id, c.nombre, c.rfc
	FROM Cliente c
	WHERE c.cliente_id = ALL (
		SELECT p.cliente_id FROM Poliza p WHERE p.cotizacion_id = ALL (
			SELECT cot.cotizacion_id FROM Cot WHERE Cot.tipo_seguro_id = ALL (
				SELECT cts.tipo_seguro_id FROM CatalogoTiposSeguro cts WHERE cts.clave = 'CA'
				)
			)
		);

CREATE OR REPLACE VIEW Hospital_Poliza_Menor_Agosto2024(nombre_hospital) AS
	SELECT h.nombre
	FROM Hospital h
	WHERE h.hospital_id = ALL (
		SELECT s.hospital_id FROM Siniestro s WHERE s.poliza_id = ALL (
			SELECT p.poliza_id FROM Poliza p WHERE p.fecha_fin < '01/09/2024'
			)
		);

