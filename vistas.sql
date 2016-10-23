CREATE OR REPLACE VIEW Cotizaciones_Mayor_1900 AS
	SELECT * FROM Cotizacion c WHERE c.costo > 1900;

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

CREATE OR REPLACE VIEW Seguro_Cobertura_Amplia(cliente_id,nombre_cliente,RFC) AS
	SELECT c.cliente_id, c.nombre, c.rfc
	FROM Cliente c
	WHERE c.cliente_id = ALL (
		SELECT p.cliente_id FROM Poliza p WHERE p.cotizacion_id = ALL (
			SELECT cot.cotizacion_id FROM Cotizacion cot WHERE cot.tipo_seguro_id = ALL (
				SELECT cts.tipo_seguro_id FROM CatalogoTiposSeguro cts WHERE cts.clave = 'CA'
				)
			)
		);

CREATE OR REPLACE VIEW Hospital_Poliza_Menor_Agosto2024(nombre_hospital) AS
	SELECT h.nombre
	FROM Hospital h
	WHERE h.hospital_id = ALL (
		SELECT s.siniestro_id FROM Siniestro s WHERE s.poliza_id = ALL (
			SELECT p.poliza_id FROM Poliza p WHERE p.fecha_fin < '01/09/2024'
			)
		);