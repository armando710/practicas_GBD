CREATE TABLE localidades(
  id_localidades NUMBER(5) CONSTRAINT localidades_pk PRIMARY KEY,
  nombre VARCHAR2(50) CONSTRAINT localidades_nn1 NOT NULL,
  poblacion NUMBER(8),
  n_provincia NUMBER(2) CONSTRAINT localidades_nn2 NOT NULL,
  CONSTRAINT  localidades_fk1 FOREIGN KEY (n_provincia) REFERENCES provincias(n_provincias)
);
CREATE TABLE provincias(
  n_provincias NUMBER(2) CONSTRAINT provincias_pk PRIMARY KEY,
  nombre VARCHAR(25) CONSTRAINT provincias_nn1 NOT NULL,
  superficie NUMBER(5),
  id_capital NUMBER(5)CONSTRAINT provincias_nn2 NOT NULL,
  id_comunidad NUMBER (2)CONSTRAINT provincias_nn3 NOT NULL,
  CONSTRAINT provincias_uk1 UNIQUE (nombre),
  CONSTRAINT provincias_uk2 UNIQUE (id_capital),
  CONSTRAINT provincias_fk1 FOREIGN KEY (id_capital) REFERENCES localidades(id_localidades),
  CONSTRAINT provincias_fk2 FOREIGN KEY (id_comunidad) REFERENCES comunidades(id_comnidad)
);
CREATE TABLE comunidades(
  id_comnidad NUMBER(2)CONSTRAINT comunidades_pk PRIMARY KEY,
  nombre VARCHAR(25) CONSTRAINT comunidades_nn1 NOT NULL,
  id_capital NUMBER(5)CONSTRAINT comunidades_nn2 NOT NULL,
  max_prov NUMBER(1),
  CONSTRAINT comunidades_uk1 UNIQUE (nombre),
  CONSTRAINT comunidades_uk2 UNIQUE (id_capital),
  CONSTRAINT comunidades_fk1 FOREIGN KEY (id_capital) REFERENCES localidades(id_localidades)
);
