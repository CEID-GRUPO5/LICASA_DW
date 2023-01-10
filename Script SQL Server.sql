CREATE DATABASE "dwventaslica";
GO

USE "dwventaslica";
GO

CREATE USER lica FOR LOGIN lica;
GO 

/*Creacion de schema staging -->*/	 
CREATE SCHEMA "staging" AUTHORIZATION lica;
GO

/*Creacion de los objetos en el schema staging*/

/*Creacion de la tabla de staging dim_proveedor*/
CREATE TABLE "staging"."dim_proveedor"
	("proveedor_id" VARCHAR(20) NOT NULL,
	 "proveedor_nombre" VARCHAR(150) NOT NULL,
     "fecha_modificacion" DATETIME NOT NULL);

/*Creacion de la tabla de staging dim_vendedor*/
CREATE TABLE "staging"."dim_vendedor"
	("vendedor_id" VARCHAR(20) NOT NULL,
	 "vendedor_nombre" VARCHAR(150) NOT NULL,
	 "fecha_modificacion" DATETIME NOT NULL);
	 
/*Creacion de la tabla de staging dim_articulo*/
CREATE TABLE "staging"."dim_articulo"
	("articulo_id" VARCHAR(20) NOT NULL,
	 "articulo_tipo" VARCHAR(20) NOT NULL,
	 "articulo_descripcion" VARCHAR(254) NOT NULL,
	 "clasificacion1_grupo" VARCHAR(40) NOT NULL,
     "clasificacion2_subgrupo" VARCHAR(40) NOT NULL,
	 "clasificacion3_marca" VARCHAR(40) NOT NULL,
	 "fecha_modificacion" DATETIME NOT NULL);
	 
/*Creacion de la tabla de staging bodega*/
CREATE TABLE "staging"."dim_bodega"
	("bodega_id" VARCHAR (4) NOT NULL,
	 "bodega_nombre" VARCHAR (40) NOT NULL,
	 "fecha_modificacion" DATETIME NOT NULL);
	 
/*Creacion de la tabla de staging cobrador*/
CREATE TABLE "staging"."dim_cobrador"
	("cobrador_id" VARCHAR (4) NOT NULL,
	 "cobrador_nombre" VARCHAR (40) NOT NULL,
	 "fecha_modificacion" DATETIME NOT NULL);

/*Creacion de la tabla de staging cliente*/
CREATE TABLE "staging"."dim_cliente"
	("cliente_id" VARCHAR (20) NOT NULL,
	 "cliente_nombre" VARCHAR (150) NOT NULL,
	 "cliente_categoria" VARCHAR (40) NOT NULL,
	 "cliente_zona" VARCHAR (40) NOT NULL,
	 "fecha_modificacion" DATETIME NOT NULL);

/*Creacion de la tabla de staging para factura_linea*/
CREATE TABLE "staging"."dim_factura_linea"
	("factura_id" VARCHAR (50) NOT NULL,
	 "tipo_documento" VARCHAR (10) NOT NULL,
	 "linea_factura" smallint NOT NULL,
     "articulo" VARCHAR (20) NOT NULL,
	 "cliente" VARCHAR (20) NOT NULL,
	 "vendedor" VARCHAR (4) NOT NULL,
	 "proveedor" VARCHAR (20) NOT NULL,
	 "bodega" VARCHAR (4) NOT NULL,
	 "cobrador" VARCHAR (4) NOT NULL,
	 "precio_unitario" decimal (28,8) DEFAULT 0,
	 "cantidad_venta" integer DEFAULT 1,
	 "cantidad_vendida" decimal (28,8) DEFAULT 0,
	 "subtotal_vendido" decimal (28,8) DEFAULT 0,
	 "total_descuento" decimal (28,8) DEFAULT 0,
	 "total_descuento_global" decimal (28,8) DEFAULT 0,
	 "total_impuesto" decimal (28,8) DEFAULT 0,
	 "total_vendido" decimal (28,8) DEFAULT 0,
	 "total_costo" decimal (28,8) DEFAULT 0,
	 "utilidad_total" decimal (28,8) DEFAULT 0,
	 "anulada" VARCHAR (2) NOT NULL,
     "fecha_factura" DATETIME NOT NULL,
	 "fecha_modificacion" DATETIME NOT NULL);
GO

CREATE INDEX "proveedorid_ix" ON "staging"."dim_proveedor" ("proveedor_id");

CREATE INDEX "vendedorid_ix" ON "staging"."dim_vendedor" ("vendedor_id");

CREATE INDEX "articuloid_ix" ON "staging"."dim_articulo" ("articulo_id");

CREATE INDEX "bodegaid_ix" ON "staging"."dim_bodega" ("bodega_id");

CREATE INDEX "cobradorid_ix" ON "staging"."dim_cobrador" ("cobrador_id");

CREATE INDEX "clienteid_ix" ON "staging"."dim_cliente" ("cliente_id");
GO

/*<-- Fin de creacion de schema staging*/