--------------------------------------------
-- Bases de Datos PROTECO                 --
-- Proyecto 2: CreaciOn y manejo con SQL  --
-- Integrantes:                           --
--  * SAnchez Neri David Yaxkin           --
--  * MartInez Ortiz SaUl Axel            --
--------------------------------------------

-- CraciOn de las tablas 

CREATE TABLE CatalogoMarcas (
    marca_id    NUMBER(5,0)   PRIMARY KEY,
    clave       VARCHAR2(3)   NOT NULL,
    descripcion VARCHAR(15)   NOT NULL
);

CREATE TABLE CatalogoModelos (
    modelo_id   NUMBER(5,0)    PRIMARY KEY,
    clave       VARCHAR(3)        NOT NULL,
    descripcion VARCHAR2(15)   NOT NULL,
    marca_id    NUMBER(5,0)    NOT NULL,
      FOREIGN KEY (marca_id)
      REFERENCES catalogoMarcas(marca_id)
); 

CREATE TABLE Auto (
    auto_id   NUMBER(5,0) PRIMARY KEY,
    anio      NUMBER(4,0) NOT NULL,
    modelo_id NUMBER(5,0) NOT NULL,
      FOREIGN KEY (modelo_id) 
      REFERENCES catalogoModelos(modelo_id)
);

CREATE TABLE CatalogoEstadosRepublica (
    estado_id NUMBER(2,0)  PRIMARY KEY,
    clave     VARCHAR2(4)  NOT NULL,
    nombre    VARCHAR2(20) NOT NULL
);

CREATE TABLE Conductor (
    conductor_id   NUMBER(5,0) PRIMARY KEY,
    edad_inicial   NUMBER(2,0) NOT NULL,
    edad_final     NUMBER(2,0) NOT NULL,
    codigo_postal  NUMBER(5,0) NOT NULL,
    estado_id      NUMBER(2,0) NOT NULL,
      FOREIGN KEY (estado_id)
      REFERENCES CatalogoEstadosRepublica(estado_id)
);

CREATE TABLE Cliente (
    cliente_id NUMBER(5,0)  PRIMARY KEY,
    nombre     VARCHAR2(15) NOT NULL,
    ap_paterno VARCHAR2(15) NOT NULL,
    ap_materno VARCHAR2(15) NOT NULL,
    rfc        VARCHAR2(13) NOT NULL,
    email      VARCHAR2(30) NOT NULL,
    direccion  VARCHAR2(50) NOT NULL
);

CREATE TABLE Tarjeta (
    tarjeta_id      NUMBER(5,0)  PRIMARY KEY,
    numero_tarjeta  CHAR(20)     NOT NULL,
    tipo_tarjeta    VARCHAR2(15) NOT NULL,
    mes_expiracion  NUMBER(2,0)  NOT NULL,
    anio_expiracion NUMBER(4,0)  NOT NULL,
    num_seguridad   NUMBER(3,0)  NOT NULL,
    cliente_id      NUMBER(5,0)  NOT NULL,
      FOREIGN KEY (cliente_id)
      REFERENCES cliente(cliente_id)
);

CREATE TABLE CatalogoTiposSeguro (
    tipo_seguro_id NUMBER(5,0)  PRIMARY KEY,
    clave          CHAR(2)      NOT NULL,
    descripcion    VARCHAR2(20) NOT NULL
);

CREATE TABLE Cotizacion (
    cotizacion_id CHAR(4)    PRIMARY KEY,
    auto_id        NUMBER(5,0) NOT NULL,
    conductor_id   NUMBER(5,0) NOT NULL,
    tipo_seguro_id NUMBER(5,0) NOT NULL,
    costo          NUMBER(6,0) NOT NULL,
      FOREIGN KEY (auto_id)
      REFERENCES auto(auto_id),
      FOREIGN KEY (conductor_id)
      REFERENCES conductor(conductor_id),
      FOREIGN KEY (tipo_seguro_id)
      REFERENCES CatalogoTiposSeguro(tipo_seguro_id)
);

CREATE TABLE Poliza (
    poliza_id          NUMBER(5,0)  PRIMARY KEY,
    folio              NUMBER(13,0) NOT NULL,
    fecha_inicio       DATE         NOT NULL,
    hora_inicio        TIMESTAMP    NOT NULL,
    fecha_fin          DATE         NOT NULL,
    num_placas         VARCHAR2(8)  NOT NULL,
    num_serie_vehiculo CHAR(17)     NOT NULL,
    cliente_id         NUMBER(5,0)  NOT NULL,
    cotizacion_id      CHAR(4)     NOT NULL,
    poliza_id_anterior NUMBER(5,0)  NULL,
      FOREIGN KEY (cliente_id)
      REFERENCES cliente(cliente_id), 
      FOREIGN KEY (cotizacion_id)
      REFERENCES cotizacion(cotizacion_id),
      FOREIGN KEY (poliza_id)
      REFERENCES poliza(poliza_id)
);

CREATE TABLE CatalogoAgencias (
    agencia_id  NUMBER(5,0) PRIMARY KEY,
    nombre      VARCHAR2(20) NOT NULL,
    descripcion VARCHAR2(30) NOT NULL
);

CREATE TABLE Hospital (
    hospital_id NUMBER(5,0)  PRIMARY KEY,
    nombre      VARCHAR2(20) NOT NULL,
    direccion   VARCHAR2(20) NOT NULL
);

CREATE TABLE CatalogoEstadosSiniestro (
    tipo_estado_siniestro_id NUMBER(5,0)  PRIMARY KEY,
    clave                    VARCHAR2(10) NOT NULL,
    descripcion              CHAR(50)     NOT NULL
);

CREATE TABLE Siniestro(
    siniestro_id        INTEGER       PRIMARY KEY,
    fecha               DATE          NOT NULL,
    hora                TIMESTAMP     NOT NULL,
    direccion           VARCHAR(50)   NOT NULL,
    poliza_id           NUMBER(5,0)   NOT NULL,
    estado_siniestro_id NUMBER(5,0)   NOT NULL,
    FOREIGN KEY (poliza_id)
    REFERENCES poliza(poliza_id)
);

CREATE TABLE EstadoSiniestro (
    estado_siniestro_id      NUMBER(5,0) PRIMARY KEY,
    fecha_asignacion         DATE        NOT NULL,
    siniestro_id             NUMBER(5,0) NOT NULL REFERENCES Siniestro(siniestro_id),
    tipo_estado_siniestro_id NUMBER(5,0) NOT NULL,
      CONSTRAINT sin_id UNIQUE(siniestro_id),
      FOREIGN KEY (tipo_estado_siniestro_id)
      REFERENCES CatalogoEstadosSiniestro(tipo_estado_siniestro_id)
);

CREATE TABLE SiniestroColision (
    siniestro_id     NUMBER(5,0) PRIMARY KEY REFERENCES Siniestro(siniestro_id),
    num_reporte_vial CHAR(8)     NOT NULL,
    grua              CHAR(2)    NOT NULL
);

CREATE TABLE SiniestroSocial (
    siniestro_id     NUMBER(5,0) PRIMARY KEY REFERENCES Siniestro(siniestro_id),
    persona_inv_id   NUMBER(5,0) NOT NULL,
    hospital_id      NUMBER(5,0) NULL,
    ambulancia       CHAR(2)     NOT NULL,
      FOREIGN KEY (hospital_id)
      REFERENCES Hospital(hospital_id)
);

CREATE TABLE SiniestroMaterial (
    siniestro_id      NUMBER(5,0) PRIMARY KEY  REFERENCES Siniestro(siniestro_id),
    descripcion_danio VARCHAR(50) NOT NULL,
    fotografia_danio  BLOB        NOT NULL
);

CREATE TABLE HistorialEstado (
    historial_estado_id      NUMBER(5,0) NOT NULL,
    fecha_asignacion         DATE        NOT NULL,
    siniestro_id             NUMBER(5,0) NOT NULL,
    tipo_estado_siniestro_id NUMBER(5,0) NOT NULL,
      FOREIGN KEY (siniestro_id)
      REFERENCES Siniestro(siniestro_id),
      FOREIGN KEY (tipo_estado_siniestro_id)
      REFERENCES CatalogoEstadosSiniestro(tipo_estado_siniestro_id)
);

CREATE TABLE AutoInvolucrado (
    auto_inv_id NUMBER(5,0)  PRIMARY KEY,
    marca       VARCHAR2(15) NOT NULL,
    modelo      VARCHAR2(15) NOT NULL,
    num_serie   CHAR(20)     NOT NULL,
    poliza      CHAR(20)     NOT NULL,
    agencia_id  NUMBER(5,0)  NULL,
    siniestro_id NUMBER(5,0) NOT NULL,
      FOREIGN KEY (agencia_id)
      REFERENCES CatalogoAgencias(agencia_id),
      FOREIGN KEY (siniestro_id)
      REFERENCES Siniestro(siniestro_id)
);

CREATE TABLE PersonaInvolucrada (
    persona_inv_id NUMBER(5,0)  PRIMARY KEY,
    nombre         VARCHAR2(15) NOT NULL,
    ap_paterno     VARCHAR2(15) NOT NULL,
    ap_materno     VARCHAR2(15) NOT NULL,
    rfc            VARCHAR2(13) NOT NULL,
    descripcion_danio VARCHAR(30) NOT NULL,
    siniestro_id      NUMBER(5,0) NOT NULL,
      FOREIGN KEY (siniestro_id)
      REFERENCES Siniestro(siniestro_id)
);