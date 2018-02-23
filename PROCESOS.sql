CREATE TABLE tipos_apli(
  id_tipo NUMBER(2) CONSTRAINT tipos_apli_pk PRIMARY KEY,
  tipo VARCHAR2(25) CONSTRAINT tipos_apli_nn NOT NULL
                    CONSTRAINT tipos_apli_uk UNIQUE
);
CREATE TABLE aplicaciones(
  n_aplicacion NUMBER(4) CONSTRAINT aplicaciones_pk PRIMARY KEY,
  nombre VARCHAR2(25) CONSTRAINT aplicaciones_uk1 UNIQUE
                      CONSTRAINT aplicaciones_nn1 NOT NULL,
  extension VARCHAR2(10),
  id_tipo NUMBER(11,2) CONSTRAINT aplicaciones_fk REFERENCES tipos_apli(id_tipo)
                      CONSTRAINT aplicaciones_nn2 NOT NULL
);
CREATE TABLE procesos(
  n_aplicacion NUMBER(4) CONSTRAINT procesos_fk1 REFERENCES aplicaciones(n_aplicacion),
  id_proceso NUMBER(3),
  nombre VARCHAR2(25) CONSTRAINT procesos_uk1 UNIQUE
                      CONSTRAINT procesos_nn1 NOT NULL,
  mem_minima NUMBER(5,1) CONSTRAINT procesos_ck1 CHECK (mem_minima>=0),
  id_proceso_lanz NUMBER(3),
  n_apli_lanz NUMBER(4),
  CONSTRAINT procesos_pk PRIMARY KEY (n_aplicacion, id_proceso),
  CONSTRAINT procesos_fk2 FOREIGN KEY (id_proceso_lanz, n_apli_lanz) REFERENCES procesos(n_aplicacion, id_proceso)
  ON DELETE SET NULL
);
CREATE TABLE maquinas(
  n_maquina NUMBER(3) CONSTRAINT maquinas_pk PRIMARY KEY,
  ip1 NUMBER(3) CONSTRAINT maquinas_nn1 NOT NULL
                CONSTRAINT maquinas_ck1 CHECK (ip1>=0 AND ip1<=255),
  ip2 NUMBER(3) CONSTRAINT maquinas_nn2 NOT NULL
                CONSTRAINT maquinas_ck2 CHECK (ip2>=0 AND ip2<=255),
  ip3 NUMBER(3) CONSTRAINT maquinas_nn3 NOT NULL
                CONSTRAINT maquinas_ck3 CHECK (ip3>=0 AND ip3<=255),
  ip4 NUMBER(3) CONSTRAINT maquinas_nn4 NOT NULL
                CONSTRAINT maquinas_ck4 CHECK (ip4>=0 AND ip4<=255),
  nombre VARCHAR2(45) CONSTRAINT maquinas_uk2 UNIQUE
                      CONSTRAINT maquinas_nn5 NOT NULL,
  memoria NUMBER(5,1),
  CONSTRAINT maquinas_uk1 UNIQUE (ip1,ip2,ip3,ip4)
);
CREATE TABLE procesos_lanz(
  n_aplicacion NUMBER(4),
  id_procesos NUMBER(3),
  fecha_lanz TIMESTAMP ,
  fecha_term TIMESTAMP,
  bloqueado NUMBER(1)CONSTRAINT procesos_lanz_ck1 CHECK (bloqueado=1 OR bloqueado=0),
  n_maquina NUMBER(3) CONSTRAINT procesos_lanz_fk2 REFERENCES maquinas(n_maquina)
                      CONSTRAINT procesos_lanz_nn1 NOT NULL,
  CONSTRAINT procesos_lanz_pk PRIMARY KEY (n_aplicacion,id_procesos,fecha_lanz),
  CONSTRAINT procesos_lanz_fk1 FOREIGN KEY (n_aplicacion,id_procesos) REFERENCES procesos(n_aplicacion,id_proceso)
);
ALTER TABLE maquinas ADD (hd NUMBER(5,2))
                     ADD (tipo VARCHAR2(1) CONSTRAINT maquinas_ck5 CHECK (tipo='S' OR tipo='C'));
INSERT INTO tipos_apli VALUES (1, 'procesador texto');
INSERT INTO aplicaciones VALUES (1,'multiword','multi',1);
INSERT INTO maquinas VALUES (1,212,34,56,7,'ELECTRO',512,250,'S');
INSERT INTO maquinas VALUES (2,212,34,56,27,'MAGNUS',256,128,'C');
INSERT INTO maquinas VALUES (3,97,23,45,6,'GREGOR',1024,512,'S');

DROP TABLE maquinas CASCADE CONSTRAINTS;
SELECT * FROM maquinas;