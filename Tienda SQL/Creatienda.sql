-- Table: FAMILIA
-- Stores the categories (families) to which products belong, such as computers, printers, etc.
-- Data insertion will occur before setting the relevant constraints.

CREATE TABLE FAMILIA
(
    CODFAMILIA NUMBER(3), -- Unique identifier for each product family.
    DENOFAMILIA VARCHAR2(50) CONSTRAINT NN_DENOFAMILIA NOT NULL, -- Name of the family.

    -- Constraints:
    CONSTRAINT PK_FAMILIA PRIMARY KEY(CODFAMILIA), -- Primary key constraint on family code.
    CONSTRAINT UN_DENOFAMILIA UNIQUE(DENOFAMILIA) -- Ensures each family name is unique.
);

-- Table: PRODUCTO
-- Holds general information about the products distributed by the company to stores.

CREATE TABLE PRODUCTO
(
    CODPRODUCTO NUMBER(5), -- Unique identifier for each product.
    DENOPRODUCTO VARCHAR2(20) CONSTRAINT NN_DENOPRODUCTO NOT NULL, -- Product name.
    DESCRIPCION VARCHAR2(100), -- Product description.
    PRECIOBASE NUMBER(8,2) CONSTRAINT NN_PRECIOBASE NOT NULL, -- Base price of the product.
    PORCREPOSICION NUMBER(3), -- Replenishment percentage used to calculate restock quantity when inventory is below minimum.
    UNIDADESMINIMAS NUMBER(4) CONSTRAINT NN_UNIDADESMINIMAS NOT NULL, -- Minimum recommended stock in storage.
    CODFAMILIA NUMBER(3) CONSTRAINT NN_CODFAMILIA NOT NULL, -- Family code to classify the product.

    -- Constraints:
    CONSTRAINT PK_PRODUCTO PRIMARY KEY(CODPRODUCTO), -- Primary key constraint on product code.
    CONSTRAINT CK_PRECIOBASE CHECK(PRECIOBASE > 0), -- Base price must be positive.
    CONSTRAINT CK_PORCREPOSICION CHECK(PORCREPOSICION > 0), -- Replenishment percentage must be positive.
    CONSTRAINT CK_UNIDADESMINIMAS CHECK(UNIDADESMINIMAS > 0), -- Minimum units in stock must be positive.
    CONSTRAINT FK_FAMILIA FOREIGN KEY(CODFAMILIA) REFERENCES FAMILIA(CODFAMILIA) -- Foreign key links each product to its family.
);

-- Table: TIENDA
-- Holds basic information about the stores that distribute products.

CREATE TABLE TIENDA
(
    CODTIENDA NUMBER(3), -- Unique identifier for each store.
    DENOTIENDA VARCHAR2(20) CONSTRAINT NN_DENOTIENDA NOT NULL, -- Store name.
    TELEFONO VARCHAR2(11), -- Store contact number.
    CODIGOPOSTAL VARCHAR2(5) CONSTRAINT NN_CODIGOPOSTAL NOT NULL, -- Postal code where the store is located.
    PROVINCIA VARCHAR2(5) CONSTRAINT NN_PROVINCIA NOT NULL, -- Province where the store is located.

    -- Constraints:
    CONSTRAINT PK_TIENDA PRIMARY KEY(CODTIENDA) -- Primary key constraint on store code.
);

-- Table: STOCK
-- Stores the available quantity of each product in each store. The primary key consists of CODTIENDA and CODPRODUCTO.

CREATE TABLE STOCK
(
    CODTIENDA NUMBER(3) CONSTRAINT NN_CODTIENDA NOT NULL, -- Store identifier.
    CODPRODUCTO NUMBER(5) CONSTRAINT NN_CODPRODUCTO NOT NULL, -- Product identifier.
    UNIDADES NUMBER(6) CONSTRAINT NN_UNIDADES NOT NULL, -- Quantity of the product available in the store.

    -- Constraints:
    CONSTRAINT PK_STOCK PRIMARY KEY(CODTIENDA, CODPRODUCTO), -- Primary key allows multiple products in each store and each product in multiple stores.
    CONSTRAINT FK_TIENDA FOREIGN KEY(CODTIENDA) REFERENCES TIENDA(CODTIENDA), -- Foreign key links stock entry to the store.
    CONSTRAINT FK_PRODUCTO FOREIGN KEY(CODPRODUCTO) REFERENCES PRODUCTO(CODPRODUCTO), -- Foreign key links stock entry to the product.
    CONSTRAINT CK_UNIDADES CHECK(UNIDADES >= 0) -- Ensures units in stock are non-negative.
);
