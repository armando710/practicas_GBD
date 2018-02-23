CREATE TABLE equipos (
  id_equipos NUMBER(2) CONSTRAINT equipos_pk PRIMARY KEY,
  nombre VARCHAR2(50) CONSTRAINT equipos_nn1 NOT NULL
                      CONSTRAINT equipos_uk UNIQUE,
  estadio VARCHAR2(50) CONSTRAINT equipos_nk2 UNIQUE,
  aforo NUMBER(6),
  ano_fundacion NUMBER(4),
  ciudad VARCHAR2(50) CONSTRAINT equipos_nn2 NOT NULL
);

CREATE TABLE jugadores(
  id_jugador NUMBER(2) CONSTRAINT jugadores_pk PRIMARY KEY,
  nombre VARCHAR2(50) CONSTRAINT jugadores_nn NOT NULL,
  fecha_nac DATE,
  id_equipo NUMBER(2) CONSTRAINT jugadores_fk REFERENCES equipos(id_equipos)ON DELETE set NULL
);

CREATE TABLE partidos(
  id_casa NUMBER(2) CONSTRAINT partidos_fk1 REFERENCES equipos(id_equipos) ON DELETE CASCADE NULL ,
  id_fuera NUMBER(2) CONSTRAINT partidos_fk2 REFERENCES equipos(id_equipos)ON DELETE CASCADE NULL ,
  fecha TIMESTAMP,
  goles_casa NUMBER(2),
  goles_fuera NUMBER(2),
  observaciones VARCHAR2(1000),
  CONSTRAINT partidos_pk  PRIMARY KEY (id_casa, id_fuera),
  CONSTRAINT partidos_ck CHECK (id_casa<>id_fuera)
);
CREATE TABLE goles(
  id_casa NUMBER(2),
  id_fuera NUMBER(2),
  minuto INTERVAL DAY TO SECOND,
  descripcion VARCHAR2(2000),
  id_jugador NUMBER(3) CONSTRAINT goles_fk2 REFERENCES jugadores(id_jugador),
  CONSTRAINT goles_pk PRIMARY KEY (id_casa,id_fuera,minuto),
  CONSTRAINT goles_fk1 FOREIGN KEY (id_casa,id_fuera) REFERENCES partidos(id_casa,id_fuera)ON DELETE CASCADE
);
ALTER TABLE equipos MODIFY aforo NOT NULL;
ALTER TABLE equipos MODIFY estadio NOT NULL;
ALTER TABLE equipos MODIFY ano_fundacion DATE;
ALTER TABLE jugadores DROP CONSTRAINT jugadores_nn;
INSERT INTO equipos VALUES (1,'Cascorro F.C.','arenera',4000,'1/1/1961','Burgos');
INSERT INTO equipos VALUES (2,'atletico matalasleñas','galvez',1200,'12/3/1961','Andorra');
INSERT INTO partidos VALUES (1,2,'5/11/1970',2,1,'cosas...');

SELECT * FROM equipos;
INSERT INTO jugadores VALUES (01,'amoribia','20/1/1990',01);
INSERT INTO jugadores VALUES (02,'garcia',null,02);
INSERT INTO jugadores VALUES (03,'pedrosa','12/7/1993',01);
INSERT INTO goles VALUES (01,02,INTERVAL '23' MINUTE,'falta directa',01 );
INSERT INTO goles VALUES (01,02,INTERVAL '40' MINUTE,'penalti',02 );
INSERT INTO goles VALUES (01,02,INTERVAL '70' MINUTE,'gran jugada',03 );
UPDATE equipos SET nombre = 'Real Cascorro' WHERE nombre='Cascorro F.C.';
UPDATE equipos SET AFORO=aforo+500;
commit;
DELETE equipos;
ALTER TABLE equipos ADD (provincia VARCHAR2(40) );
UPDATE equipos SET provincia ='Zamora' WHERE id_equipos=1;
UPDATE equipos SET provincia ='Andorra la vieja' WHERE id_equipos=2;
