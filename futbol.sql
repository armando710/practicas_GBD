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
  id_equipo NUMBER(2) CONSTRAINT jugadores_fk REFERENCES equipos(id_equipos)ON DELETE CASCADE NULL
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
