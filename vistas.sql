--------------------------------------------
-- Bases de Datos PROTECO                 --
-- Proyecto 2: CreaciOn y manejo con SQL  --
-- Integrantes:                           --
--  * SAnchez Neri David Yaxkin           --
--  * MartInez Ortiz SaUl Axel            --
--------------------------------------------

-- Vista de las tablas
CREATE OR REPLACE VIEW Cotizaciones_Mayor_1900 AS
	SELECT * FROM Cot WHERE Cot.costo > 1900;

CREATE OR REPLACE VIEW Polizas_Octubre2016 AS
	SELECT * FROM Plz WHERE Plz.fecha_inicio > TO_DATE('30/09/2016','DD/MM/YYYY');

CREATE OR REPLACE VIEW Poliza_Siniestro_Registrado(cliente_id,nombre_cliente,num_placas) AS
	SELECT Cte.cliente_id,Cte.nombre,Plz.num_placas
	FROM Cte, Plz
	WHERE Cte.cliente_id = ANY (
		SELECT Plz.num_placas FROM Plz WHERE Plz.poliza_id = ANY (
			SELECT Sin.poliza_id FROM Sin WHERE Sin.estado_siniestro_id = ANY (
				SELECT ESin.tipo_estado_siniestro_id FROM ESin WHERE ESin.tipo_estado_siniestro_id = ANY (
					SELECT TipoSin.tipo_estado_siniestro_id FROM TipoSin WHERE TipoSin.clave = 'REGISTRADO'
					)
				)
			)
		);

CREATE OR REPLACE VIEW Seguro_Cobertura_Amplia(cliente_id,nombre_cliente,rfc) AS
	SELECT Cte.cliente_id, Cte.nombre, Cte.rfc
	FROM Cte
	WHERE Cte.cliente_id = ANY (
		SELECT Plz.cliente_id FROM Plz WHERE Plz.cotizacion_id = ANY (
			SELECT Cot.cotizacion_id FROM Cot WHERE Cot.tipo_seguro_id = ANY (
				SELECT TipoSeg.tipo_seguro_id FROM TipoSeg WHERE TipoSeg.clave = 'CA'
				)
			)
		);

CREATE OR REPLACE VIEW Cliente_Cotizacion(cliente_id,nombre_cliente,cotizacion_id) AS
	SELECT Cte.cliente_id, Cte.nombre, Cot.cotizacion_id
	FROM Cte,Cot,Plz
	WHERE ((Cte.cliente_id = Plz.cliente_id) AND (Plz.cotizacion_id = Cot.cotizacion_id));

CREATE OR REPLACE VIEW Cliente_Cotizacion(cliente_id,nombre_cliente,cotizacion_id) AS
	SELECT Cte.cliente_id, Cte.nombre, Cot.cotizacion_id
	FROM Cte,Cot
	WHERE Cte.cliente_id = ANY (
		SELECT Plz.cliente_id FROM Plz WHERE Plz.cotizacion_id = '0001'
		);


CREATE OR REPLACE VIEW Hospitales_Hasta_Agosto2024(nombre_hospital) AS
	SELECT Hosp.nombre
	FROM Hosp
	WHERE Hosp.hospital_id = ANY (
		SELECT SinSoc.hospital_id FROM SinSoc,Sin WHERE ((SinSoc.siniestro_id = Sin.siniestro_id) AND (Sin.poliza_id = ANY (
			SELECT Plz.poliza_id FROM Plz WHERE Plz.fecha_fin > TO_DATE('01/09/2024','DD/MM/YYYY')
			))
		)
	);

