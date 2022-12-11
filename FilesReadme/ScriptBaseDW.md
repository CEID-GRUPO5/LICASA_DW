## **Script de la base de datos del DW**
 
``` sql

/*Creacion del DW*/
CREATE DATABASE "dwventaslica" WITH
OWNER licauser
CONNECTION LIMIT 3
COLLATE CASE_SENSITIVE
ISOLATION LEVEL SERIALIZABLE;

/*Creacion de Schema de configuracion -->*/
CREATE SCHEMA IF NOT EXISTS "configuracion" AUTHORIZATION licauser
QUOTA 2048 MB;

/*Creacion de objetos en el schema configuracion*/

/* Creacion de la tabla cargasdelta
Descripcion: Almacena la informacion de los deltas de la BD transaccional*/
CREATE TABLE "configuracion"."cargasdelta"
	("key"   VARCHAR(256) NOT NULL,
     "value" timestamp without time zone NOT NULL encode delta32k,
     CONSTRAINT cargasdelta_pkey PRIMARY KEY("key"),
	 CONSTRAINT cargasdelta_ukey UNIQUE("key"))
	 distkey("key") 
	 sortkey("key");
	 
/*Valores iniciales por tabla para configuración de Deltas*/
insert into "configuracion"."cargasdelta" values ('FACTURA_LINEA','1900-01-01 00:00:00.000');
insert into "configuracion"."cargasdelta" values ('COBRADOR','1900-01-01 00:00:00.000');
insert into "configuracion"."cargasdelta" values ('PROVEEDOR','1900-01-01 00:00:00.000');
insert into "configuracion"."cargasdelta" values ('BODEGA','1900-01-01 00:00:00.000');
insert into "configuracion"."cargasdelta" values ('CLIENTE','1900-01-01 00:00:00.000');
insert into "configuracion"."cargasdelta" values ('ARTICULO','1900-01-01 00:00:00.000');
insert into "configuracion"."cargasdelta" values ('VENDEDOR','1900-01-01 00:00:00.000');
/*<-- Fin insert*/

/*<-- Fin de creacion de schema configuracion*/

/*Creacion de schema licasa -->*/	 
CREATE SCHEMA IF NOT EXISTS "licasa" AUTHORIZATION licauser
QUOTA 5120 MB;

/*Creacion de los objetos en el schema licasa*/

/*Creacion de la tabla DimProveedor 
Descripcion: Almacena los registros de la dimension de Proveedor*/
CREATE TABLE "licasa"."dim_proveedor"
	("proveedor_key" BIGINT IDENTITY(1,1) NOT NULL encode az64,
	 "proveedor_id" VARCHAR(20) NOT NULL,
	 "proveedor_nombre" VARCHAR(150) NOT NULL,
	 CONSTRAINT dim_proveedor_pkey PRIMARY KEY ("proveedor_key"),
	 CONSTRAINT dim_proveedor_ukey UNIQUE ("proveedor_key"))
	 distkey("proveedor_key")
	 sortkey("proveedor_id");

/*Creacion de la tabla DimVendedor
Descripcion: Almacena los registros de la dimension de Vendedor*/
CREATE TABLE "licasa"."dim_vendedor"
	("vendedor_key" BIGINT IDENTITY(1,1) NOT NULL encode az64,
	 "vendedor_id" VARCHAR(20) NOT NULL,
	 "vendedor_nombre" VARCHAR(150) NOT NULL,
	 CONSTRAINT dim_vendedor_pkey PRIMARY KEY ("vendedor_key"),
	 CONSTRAINT dim_vendedor_ukey UNIQUE ("vendedor_key"))
	 distkey("vendedor_key")
	 sortkey("vendedor_id")
	 ;
	 
/*Creacion de la tabla DimArticulo
Descripcion: Almacena los registros de la dimension de Articulo*/
CREATE TABLE "licasa"."dim_articulo"
	("articulo_key" BIGINT IDENTITY(1,1) NOT NULL encode az64,
	 "articulo_id" VARCHAR(20) NOT NULL,
	"articulo_tipo" VARCHAR(20) NOT NULL,
	 "articulo_descripcion" VARCHAR(254) NOT NULL encode lzo,
	 "clasificacion1_grupo" VARCHAR(40) NOT NULL,
     "clasificacion2_subgrupo" VARCHAR(40) NOT NULL,
	 "clasificacion3_marca" VARCHAR(40) NOT NULL,
	 CONSTRAINT dim_articulo_pkey PRIMARY KEY ("articulo_key"),
	 CONSTRAINT dim_articulo_ukey UNIQUE ("articulo_key"))
	 distkey("articulo_key")
	 sortkey("articulo_id")
	 ;
	 
/*Creacion de la tabla DimBodega
Descripción: Tabla que almacena los registros correspondientes a la dimensión de Bodega*/
CREATE TABLE "licasa"."dim_bodega"
	("bodega_key" BIGINT NOT NULL IDENTITY (1,1) ENCODE az64,
	 "bodega_id" VARCHAR (4) NOT NULL,
	 "bodega_nombre" VARCHAR (40) NOT NULL,
	 CONSTRAINT dim_bodega_ukey UNIQUE ("bodega_key"),
	 CONSTRAINT dim_bodega_pkey PRIMARY KEY("bodega_key"))
	 distkey("bodega_key")
	 sortkey("bodega_id")
	 ;
	 
/*Creacion de la tabla DimCobrador
Descripción: Tabla que almacena los registros correspondientes a la dimensión de Cobrador*/
CREATE TABLE "licasa"."dim_cobrador"
	("cobrador_key" BIGINT NOT NULL IDENTITY (1,1) ENCODE az64,
	 "cobrador_id" VARCHAR (4) NOT NULL,
	 "cobrador_nombre" VARCHAR (40) NOT NULL,
	 CONSTRAINT dim_cobrador_ukey UNIQUE ("cobrador_key"),
	 CONSTRAINT dim_cobrador_pkey PRIMARY KEY("cobrador_key"))
	 distkey("cobrador_key")
	 sortkey("cobrador_id")
	 ;

/*Creacion de la tabla DimCliente
Descripción: Tabla que almacena los registros correspondientes a la dimensión de Cliente */
CREATE TABLE "licasa"."dim_cliente"
	("cliente_key" BIGINT NOT NULL IDENTITY (1,1) ENCODE az64,
	 "cliente_id" VARCHAR (20) NOT NULL,
	 "cliente_nombre" VARCHAR (150) NOT NULL,
	 "cliente_categoria" VARCHAR (40) NOT NULL,
	 "cliente_zona" VARCHAR (40) NOT NULL,
	 CONSTRAINT dim_cliente_ukey UNIQUE ("cliente_key"),
	 CONSTRAINT dim_cliente_pkey PRIMARY KEY("cliente_key"))
	 distkey("cliente_key")
	 sortkey("cliente_id")
	 ;
	 
/*Creacion de la tabla DimFecha
Descripción: Tabla que almacena los registros correspondientes a la dimensión de Fecha*/
CREATE TABLE "licasa"."dim_fecha"
	("fecha_key" BIGINT NOT NULL ENCODE az64,
	 "fecha_id" DATE NOT NULL ENCODE delta,
	 "dia" CHAR (2) NOT NULL,
	 "semana_mes" CHAR (2) NOT NULL,
	 "mes" CHAR (2) NOT NULL,
	 "semana_anio" CHAR (2) NOT NULL,
	 "fin_de_mes" CHAR (2) NOT NULL,
	 "trimestre" CHAR (1) NULL,
	 "semestre" CHAR (1) NOT NULL,
	 "anio" CHAR (4) NOT NULL,
	 "dia_nombre" VARCHAR (15) NOT NULL,
	 "mes_nombre" VARCHAR (15) NOT NULL,
	 CONSTRAINT dim_fecha_ukey UNIQUE ("fecha_key"),
	 CONSTRAINT dim_fecha_pkey PRIMARY KEY("fecha_key"))
	 distkey("fecha_key")
	 sortkey("fecha_id")
	 ;


/*Creacion de la tabla FactVentas
Descripción: Tabla que almacena los registros correspondientes a la tabla de hechos (fact) de Ventas*/
CREATE TABLE "licasa"."fact_ventas"
	("articulo_key" BIGINT NOT NULL,
	 "cliente_key" BIGINT NOT NULL,
	 "fecha_key" BIGINT NOT NULL,
	 "vendedor_key" BIGINT NOT NULL,
	 "proveedor_key" BIGINT NOT NULL,
	 "bodega_key" BIGINT NOT NULL,
	 "cobrador_key" BIGINT NOT NULL,
	 "factura_id" VARCHAR (50) NOT NULL,
	 "tipo_documento" VARCHAR (10) NOT NULL,
	 "linea_factura" smallint NOT NULL,
	 "precio_unitario" decimal (28,8) DEFAULT 0,
	 "cantidad_venta" integer DEFAULT 1,
	 "cantidad_vendida" decimal (28,8) DEFAULT 0,
	 "sub_total_vendido" decimal (28,8) DEFAULT 0,
	 "total_descuento" decimal (28,8) DEFAULT 0,
	 "total_descuento_global" decimal (28,8) DEFAULT 0,
	 "total_impuesto" decimal (28,8) DEFAULT 0,
	 "total_vendido" decimal (28,8) DEFAULT 0,
	 "total_costo" decimal (28,8) DEFAULT 0,
	 "utilidad_total" decimal (28,8) DEFAULT 0,
	 "anulada" VARCHAR (2) NOT NULL,
	 CONSTRAINT fact_ventas_pk PRIMARY KEY("articulo_key","cliente_key","fecha_key","vendedor_key","proveedor_key","bodega_key","cobrador_key"),
	 CONSTRAINT fact_ventas_uk UNIQUE ("articulo_key","cliente_key","fecha_key","vendedor_key","proveedor_key","bodega_key","cobrador_key"),
	 CONSTRAINT fact_ventas_facturaid_uk UNIQUE ("factura_id"))
	 distkey("factura_id")
	 sortkey("factura_id");


ALTER TABLE "licasa"."fact_ventas" ADD CONSTRAINT "dim_articulo_fk" FOREIGN KEY("articulo_key") REFERENCES "licasa"."dim_articulo"("articulo_key");

ALTER TABLE "licasa"."fact_ventas" ADD CONSTRAINT "dim_cliente_fk" FOREIGN KEY("cliente_key") REFERENCES "licasa"."dim_cliente"("cliente_key");

ALTER TABLE "licasa"."fact_ventas" ADD CONSTRAINT "dim_fecha_fk" FOREIGN KEY("fecha_key") REFERENCES "licasa"."dim_fecha"("fecha_key");

ALTER TABLE "licasa"."fact_ventas" ADD CONSTRAINT "dim_vendedor_fk" FOREIGN KEY("vendedor_key") REFERENCES "licasa"."dim_vendedor"("vendedor_key");

ALTER TABLE "licasa"."fact_ventas" ADD CONSTRAINT "dim_proveedor_fk" FOREIGN KEY("proveedor_key") REFERENCES "licasa"."dim_proveedor"("proveedor_key");

ALTER TABLE "licasa"."fact_ventas" ADD CONSTRAINT "dim_bodega_fk" FOREIGN KEY("bodega_key") REFERENCES "licasa"."dim_bodega"("bodega_key");

ALTER TABLE "licasa"."fact_ventas" ADD CONSTRAINT "dim_cobrador_fk" FOREIGN KEY("cobrador_key") REFERENCES "licasa"."dim_cobrador"("cobrador_key");


/*<-- Fin de creacion de schema licasa*/

``` 
---
[Anterior](MappingModeloDimensional.md)

[Regresar a pagina principal](../README.md)