-- A) 
-- Adding columns and constraints to existing tables

-- Add a DATE column to the STOCK table named FechaUltimaEntrada, which defaults to the current date.
ALTER TABLE STOCK ADD FECHAULTIMAENTRADA DATE DEFAULT '07/12/2022';

-- Add a column named Beneficio in the STOCK table to store the profit percentage type
-- applicable to each product in a given store. This column should accept values 1 through 5 only.
ALTER TABLE STOCK ADD BENEFICIO NUMBER(1);
ALTER TABLE STOCK ADD CONSTRAINT CK_BENEFICIO CHECK(BENEFICIO BETWEEN 1 AND 5);

-- In the PRODUCTO table:
-- Remove the Descripcion column.
ALTER TABLE PRODUCTO DROP COLUMN DESCRIPCION;

-- Add a column named Perecedero that accepts only 'S' (Yes) or 'N' (No) values,
-- indicating if the product is perishable.
ALTER TABLE PRODUCTO ADD PERECEDERO CHAR(1);
ALTER TABLE PRODUCTO ADD CONSTRAINT CK_PERECEDERO CHECK(PERECEDERO IN ('S', 'N'));

-- Modify the size of the Denoproducto column to VARCHAR2(50).
ALTER TABLE PRODUCTO MODIFY DENOPRODUCTO VARCHAR2(50);

-- In the FAMILIA table:
-- Add a column named IVA representing VAT percentage, constrained to only allow values 21, 10, or 4.
ALTER TABLE FAMILIA ADD IVA NUMBER(3);
ALTER TABLE FAMILIA ADD CONSTRAINT CK_IVA CHECK(IVA IN ('21', '10', '4'));

-- In the TIENDA table:
-- Ensure each store has a unique location by restricting the CODIGOPOSTAL field so that there can be
-- only one store per postal code.
ALTER TABLE TIENDA ADD CONSTRAINT UN_CODIGOPOSTAL UNIQUE(CODIGOPOSTAL);

-- B) Rename the STOCK table to PRODXTIENDAS.
RENAME STOCK TO PRODXTIENDAS;

-- C) Drop the FAMILIA table and any data it contains, along with any associated constraints.
DROP TABLE FAMILIA CASCADE CONSTRAINTS;

-- D) Create a new user named C##INVITADO and grant this user full privileges on the PRODUCTO table.
CREATE USER C##INVITADO IDENTIFIED BY INVITADO;
GRANT ALL ON PRODUCTO TO C##INVITADO;

-- E) Revoke modification and deletion permissions on the PRODUCTO table from the user C##INVITADO.
REVOKE ALTER, UPDATE ON PRODUCTO FROM C##INVITADO;
