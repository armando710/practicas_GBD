CREATE TABLE tipos_pieza(
  tipo CHAR(2) CONSTRAINT tipos_pieza_pk PRIMARY KEY,
  descripcion VARCHAR2(25) CONSTRAINT tipos_pieza_NN NOT NULL
);

CREATE TABLE almacenes(
  n_almacenes NUMBER(2) CONSTRAINT almacenes_pk PRIMARY KEY,
  descripcion VARCHAR2(2000) CONSTRAINT almacenes_nn NOT NULL,
  direccion VARCHAR2(100)
);

CREATE TABLE piezas (
  tipo CHAR(2) CONSTRAINT piezas_fk1 REFERENCES tipos_pieza(tipo),
  modelo NUMBER(2),
  precio_venta NUMBER(11,4) CONSTRAINT piezas_nn NOT NULL,
  CONSTRAINT piezas PRIMARY KEY(tipo, modelo)
);

CREATE TABLE empresas(
  cif CHAR(9)CONSTRAINT empresas_pk PRIMARY KEY,
  nombre VARCHAR2(50) CONSTRAINT empresas_nn NOT NULL ,
  telefono CHAR(9),
  direccion VARCHAR2(50),
  localidad VARCHAR2(50),
  provincia VARCHAR2(50),
  CONSTRAINT empresas UNIQUE(nombre)
);

CREATE TABLE suministros(
  tipo CHAR(2),
  modelo NUMBER(2),
  cif CHAR(9) CONSTRAINT suministros_fk2 REFERENCES empresas(cif),
  precio_compra NUMBER(11,4) CONSTRAINT suministros_nn NOT NULL,
  CONSTRAINT suministros_ck CHECK (precio_compra>0),
  CONSTRAINT suministros_pk PRIMARY KEY(tipo,modelo,cif),
  CONSTRAINT suministros_fk1 FOREIGN KEY (tipo, modelo) REFERENCES piezas(tipo,modelo)
);

CREATE TABLE existencias(
  tipo CHAR(2),
  modelo NUMBER(2),
  n_almacen NUMBER(2) CONSTRAINT existencias_fk2 REFERENCES almacenes(n_almacenes),
  cantidad NUMBER(9) CONSTRAINT existencias_nn NOT NULL,
  CONSTRAINT existencias_ck CHECK (cantidad>0),
  CONSTRAINT existencias_pk PRIMARY KEY (tipo,modelo,n_almacen),
  CONSTRAINT existencias_fk1 FOREIGN KEY (tipo,modelo) REFERENCES piezas(tipo,modelo)
);
CREATE TABLE pedidos(
  n_pedido NUMBER(4) CONSTRAINT pedidos_pk PRIMARY KEY,
  cif CHAR CONSTRAINT pedidos_nn1 NOT NULL,
  fecha DATE CONSTRAINT pedidos_nn2 NOT NULL,
  CONSTRAINT pedidos FOREIGN KEY (cif) REFERENCES empresas (cif)
);

