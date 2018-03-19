CREATE TABLE canales(
  id_canal NUMBER(2) CONSTRAINT canales_pk PRIMARY KEY,
  nombre VARCHAR2(50) CONSTRAINT canales_uk1 UNIQUE
                      CONSTRAINT canales_nn1 NOT NULL
);
CREATE TABLE programas(
  id_prg NUMBER(4) CONSTRAINT programas_pk PRIMARY KEY,
  nombre VARCHAR2(50) CONSTRAINT programas_nn1 NOT NULL
                      CONSTRAINT programas_uk1 UNIQUE,
  es_serie CHAR(1) CONSTRAINT programas_nn2 NOT NULL
                  CONSTRAINT programas_ck1  CHECK (es_serie='S' OR  es_serie='N')
);
CREATE TABLE temporadas(
  id_prg NUMBER(4)CONSTRAINT temporadas_fk1 REFERENCES programas(id_prg),
  n_temporada NUMBER(2),
  nombre VARCHAR2(50),
  año_inicio NUMBER(4)CONSTRAINT temporadas_nn1 NOT NULL,
  año_fin NUMBER(4),
  CONSTRAINT temporadas_pk1 PRIMARY KEY (id_prg,n_temporada)
);
CREATE TABLE capitulos(
  id_prg NUMBER(4),
  n_temporada NUMBER(2),
  n_capitulo NUMBER(3),
  titulo VARCHAR2(50) CONSTRAINT capitulos_nn1 NOT NULL,
  duracion INTERVAL DAY TO SECOND,
  CONSTRAINT capitulos_pk PRIMARY KEY (id_prg,n_temporada,n_capitulo),
  CONSTRAINT capitulos_fk1 FOREIGN KEY (id_prg,n_temporada) REFERENCES temporadas(id_prg,n_temporada)
);
CREATE TABLE emisiones(
  id_canal NUMBER(2) CONSTRAINT emisiones_fk1 REFERENCES canales(id_canal),
  id_prg NUMBER(4),
  n_temporada NUMBER(2),
  n_capitulo NUMBER(3),
  fecha TIMESTAMP,
  id_prg_suelto NUMBER(4) CONSTRAINT emisiones_fk3 REFERENCES programas(id_prg),
  CONSTRAINT emisiones_pk PRIMARY KEY (id_canal,id_prg,n_temporada,n_capitulo),
  CONSTRAINT emisiones_fk2 FOREIGN KEY (id_prg,n_temporada,n_capitulo) REFERENCES capitulos(id_prg,n_temporada,n_capitulo)
);
ALTER TABLE emisiones DROP CONSTRAINT emisiones_pk;
ALTER TABLE emisiones ADD id_emision NUMBER(6) CONSTRAINT emisiones_pk PRIMARY KEY;

ALTER TABLE temporadas MODIFY año_fin;

ALTER TABLE emisiones MODIFY n_temporada NUMBER(3);
ALTER TABLE capitulos MODIFY n_temporada NUMBER(3);
ALTER TABLE temporadas MODIFY n_temporada NUMBER(3);

ALTER TABLE programas DROP CONSTRAINT programas_ck1;
ALTER TABLE programas MODIFY es_serie NUMBER(1);
ALTER TABLE programas add CONSTRAINT programas_ck1 CHECK (es_serie=1 OR  es_serie=0);

INSERT INTO emisiones VALUES

UPDATE emisiones
SET fecha=fecha -5;

UPDATE programas
SET nombre='el tunel' = nombre='the tunel'
WHERE;
