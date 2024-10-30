-- Tabla familia: Contiene las familias a las que pertenecen los productos, como por ejemplo ordenadores, impresoras,etc.
-- Primero voy a introducir los datos de las tablas para luego pasar a establecer las correspondientes restricciones.

CREATE TABLE FAMILIA
(
	CODFAMILIA NUMBER(3), --Codigo que distingue una familia de otra
	DENOFAMILIA VARCHAR2(50) CONSTRAINT NN_DENOFAMILIA NOT NULL, -- Denominacion de la familia.
	-- Restricciones:
	CONSTRAINT PK_FAMILIA PRIMARY KEY(CODFAMILIA),
	CONSTRAINT UN_DENOFAMILIA UNIQUE(DENOFAMILIA)
);

--Tabla producto: contendrá información general sobre los productos que distribuye la empresa a las tiendas.

CREATE TABLE PRODUCTO
(
	CODPRODUCTO NUMBER(5), -- Código que distingue un producto de otro.
	DENOPRODUCTO VARCHAR2(20) CONSTRAINT NN_DENOPRODUCTO NOT NULL, -- Denominación del producto.
	DESCRIPCION VARCHAR2(100), -- Descripción del producto.
	PRECIOBASE NUMBER(8,2) CONSTRAINT NN_PRECIOBASE NOT NULL, -- Precio base del producto.
	PORCREPOSICION NUMBER (3), -- Porcentaje de reposición aplicado a ese producto. Se utilizará para aplicar a las unidades mínimas y obtener el número total de unidades a reponer cuando el stock esté bajo mínimo
	UNIDADESMINIMAS NUMBER(4) CONSTRAINT NN_UNIDADESMINIMAS NOT NULL, --Unidades mínimas recomendables en almacen.
	CODFAMILIA NUMBER(3) CONSTRAINT NN_CODFAMILIA NOT NULL, --Codigo que distingue una familia de otra
	-- Restricciones:
	CONSTRAINT PK_PRODUCTO PRIMARY KEY(CODPRODUCTO),
	CONSTRAINT CK_PRECIOBASE CHECK(PRECIOBASE > 0),
	CONSTRAINT CK_PORCREPOSICION CHECK(PORCREPOSICION > 0),
	CONSTRAINT CK_UNIDADESMINIMAS CHECK(UNIDADESMINIMAS > 0),
	CONSTRAINT FK_FAMILIA FOREIGN KEY(CODFAMILIA) REFERENCES FAMILIA(CODFAMILIA)
);

-- Tabla tienda: contendrá información básica sobre las tiendas que distribuyen los productos.

CREATE TABLE TIENDA
(
	CODTIENDA NUMBER(3), -- Código que distingue una tienda de otra.
	DENOTIENDA VARCHAR2(20) CONSTRAINT NN_DENOTIENDA NOT NULL, -- Denominación o nombre de la tienda.
	TELEFONO VARCHAR2(11), -- Teléfono de la tienda.
	CODIGOPOSTAL VARCHAR2(5) CONSTRAINT NN_CODIGOPOSTAL NOT NULL, -- Codigo Postal donde se ubica la tienda.
	PROVINCIA VARCHAR2(5) CONSTRAINT NN_PROVINCIA NOT NULL, -- Provincia donde se ubica la tienda.
	-- Restricciones:
	CONSTRAINT PK_TIENDA PRIMARY KEY(CODTIENDA)
);

-- Tabla Stock: Contendrá para cada tienda el número de unidades disponibles de cada producto. La clave primaria está formada por la concatenación de los campos Codtienda y Codproducto.

CREATE TABLE STOCK
(
	CODTIENDA NUMBER(3) CONSTRAINT NN_CODTIENDA NOT NULL, -- Código que distingue una tienda de otra.
	CODPRODUCTO NUMBER(5) CONSTRAINT NN_CODPRODUCTO NOT NULL, -- Código que distingue un producto de otro.
	UNIDADES NUMBER(6) CONSTRAINT NN_UNIDADES NOT NULL, -- Unidades de ese producto en esa tienda.
	-- Restricciones:
	CONSTRAINT PK_STOCK PRIMARY KEY(CODTIENDA, CODPRODUCTO), -- Permite que un producto pueda aparecer en varias tiendas, y que en una tienda puedan haber varios productos.
	CONSTRAINT FK_TIENDA FOREIGN KEY(CODTIENDA) REFERENCES TIENDA(CODTIENDA),
	CONSTRAINT FK_PRODUCTO FOREIGN KEY(CODPRODUCTO) REFERENCES PRODUCTO(CODPRODUCTO),
	CONSTRAINT CK_UNIDADES CHECK(UNIDADES > = 0)
);
	