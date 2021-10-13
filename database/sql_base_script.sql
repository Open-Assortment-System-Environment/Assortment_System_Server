-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.4-alpha
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: "Assortment_System_Server_DB" | type: DATABASE --
-- DROP DATABASE IF EXISTS "Assortment_System_Server_DB";
CREATE DATABASE "Assortment_System_Server_DB"
	ENCODING = 'UTF8'
	LC_COLLATE = 'de_DE.UTF-8'
	LC_CTYPE = 'de_DE.UTF-8'
	TABLESPACE = pg_default
	OWNER = postgres;
-- ddl-end --


SET check_function_bodies = false;
-- ddl-end --

-- object: parts | type: SCHEMA --
-- DROP SCHEMA IF EXISTS parts CASCADE;
CREATE SCHEMA parts;
-- ddl-end --
ALTER SCHEMA parts OWNER TO postgres;
-- ddl-end --

-- object: storage | type: SCHEMA --
-- DROP SCHEMA IF EXISTS storage CASCADE;
CREATE SCHEMA storage;
-- ddl-end --
ALTER SCHEMA storage OWNER TO postgres;
-- ddl-end --

-- object: assemblies | type: SCHEMA --
-- DROP SCHEMA IF EXISTS assemblies CASCADE;
CREATE SCHEMA assemblies;
-- ddl-end --
ALTER SCHEMA assemblies OWNER TO postgres;
-- ddl-end --

-- object: kicad | type: SCHEMA --
-- DROP SCHEMA IF EXISTS kicad CASCADE;
CREATE SCHEMA kicad;
-- ddl-end --
ALTER SCHEMA kicad OWNER TO postgres;
-- ddl-end --

-- object: global | type: SCHEMA --
-- DROP SCHEMA IF EXISTS global CASCADE;
CREATE SCHEMA global;
-- ddl-end --
ALTER SCHEMA global OWNER TO postgres;
-- ddl-end --

-- object: vendors | type: SCHEMA --
-- DROP SCHEMA IF EXISTS vendors CASCADE;
CREATE SCHEMA vendors;
-- ddl-end --
ALTER SCHEMA vendors OWNER TO postgres;
-- ddl-end --

SET search_path TO pg_catalog,public,parts,storage,assemblies,kicad,global,vendors;
-- ddl-end --

-- object: parts.parts | type: TABLE --
-- DROP TABLE IF EXISTS parts.parts CASCADE;
CREATE TABLE parts.parts (
	id bigint NOT NULL,
	name text NOT NULL,
	description text,
	weight double precision,
	id_3d_models bigint,
	type text NOT NULL,
	CONSTRAINT parts_pk PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON COLUMN parts.parts.name IS E'The name of the part (may be identical to the manufacture_id)';
-- ddl-end --
COMMENT ON COLUMN parts.parts.description IS E'An description of the part';
-- ddl-end --
ALTER TABLE parts.parts OWNER TO postgres;
-- ddl-end --

INSERT INTO parts.parts (id, name, description, weight, id_3d_models, type) VALUES (E'-1', E'Zero', E'a Part for test purposes', DEFAULT, DEFAULT, E'Zero');
-- ddl-end --

-- object: parts.documantations | type: TABLE --
-- DROP TABLE IF EXISTS parts.documantations CASCADE;
CREATE TABLE parts.documantations (
	id bigint NOT NULL,
	id_parts bigint NOT NULL,
	name text NOT NULL,
	description text,
	path text NOT NULL,
	type text NOT NULL,
	CONSTRAINT documantations_pk PRIMARY KEY (id,id_parts)

);
-- ddl-end --
COMMENT ON TABLE parts.documantations IS E'Here are the documantaion file stored, like the datasheets and manuels';
-- ddl-end --
COMMENT ON COLUMN parts.documantations.description IS E'an short description of what is dislplayed in the file';
-- ddl-end --
COMMENT ON COLUMN parts.documantations.path IS E'the path to the file';
-- ddl-end --
ALTER TABLE parts.documantations OWNER TO postgres;
-- ddl-end --

-- object: parts.images | type: TABLE --
-- DROP TABLE IF EXISTS parts.images CASCADE;
CREATE TABLE parts.images (
	id bigint NOT NULL,
	id_parts bigint NOT NULL,
	description text,
	path text NOT NULL,
	type text NOT NULL,
	CONSTRAINT images_pk PRIMARY KEY (id,id_parts)

);
-- ddl-end --
COMMENT ON TABLE parts.images IS E'here are the images of the part saved';
-- ddl-end --
COMMENT ON COLUMN parts.images.path IS E'the path to the file';
-- ddl-end --
ALTER TABLE parts.images OWNER TO postgres;
-- ddl-end --

-- object: parts.part_manufacturers | type: TABLE --
-- DROP TABLE IF EXISTS parts.part_manufacturers CASCADE;
CREATE TABLE parts.part_manufacturers (
	part_id bigint NOT NULL,
	manufacturer text NOT NULL,
	CONSTRAINT part_manufacturers_pk PRIMARY KEY (part_id,manufacturer)

);
-- ddl-end --
ALTER TABLE parts.part_manufacturers OWNER TO postgres;
-- ddl-end --

-- object: assemblies.assemblies | type: TABLE --
-- DROP TABLE IF EXISTS assemblies.assemblies CASCADE;
CREATE TABLE assemblies.assemblies (
	name text NOT NULL,
	description text NOT NULL,
	git_project text NOT NULL,
	CONSTRAINT assemblies_pk PRIMARY KEY (name)

);
-- ddl-end --
ALTER TABLE assemblies.assemblies OWNER TO postgres;
-- ddl-end --

-- object: assemblies.assembly_parts | type: TABLE --
-- DROP TABLE IF EXISTS assemblies.assembly_parts CASCADE;
CREATE TABLE assemblies.assembly_parts (
	assembly text NOT NULL,
	part_id bigint NOT NULL,
	quantity bigint NOT NULL,
	CONSTRAINT assembly_parts_pk PRIMARY KEY (assembly,part_id)

);
-- ddl-end --
ALTER TABLE assemblies.assembly_parts OWNER TO postgres;
-- ddl-end --

-- object: parts."3d_models" | type: TABLE --
-- DROP TABLE IF EXISTS parts."3d_models" CASCADE;
CREATE TABLE parts."3d_models" (
	id bigint NOT NULL,
	type text NOT NULL,
	CONSTRAINT "3d_models_pk" PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE parts."3d_models" IS E'here are the images of the part saved';
-- ddl-end --
COMMENT ON COLUMN parts."3d_models".type IS E'the model type(STL, WRL, ...)';
-- ddl-end --
ALTER TABLE parts."3d_models" OWNER TO postgres;
-- ddl-end --

-- object: kicad.footprints | type: TABLE --
-- DROP TABLE IF EXISTS kicad.footprints CASCADE;
CREATE TABLE kicad.footprints (
	library text NOT NULL,
	footprint text NOT NULL,
	CONSTRAINT footprints_pk PRIMARY KEY (library,footprint)

);
-- ddl-end --
ALTER TABLE kicad.footprints OWNER TO postgres;
-- ddl-end --

-- object: kicad.symbols | type: TABLE --
-- DROP TABLE IF EXISTS kicad.symbols CASCADE;
CREATE TABLE kicad.symbols (
	library text NOT NULL,
	symbol text NOT NULL,
	CONSTRAINT symbols_pk PRIMARY KEY (library,symbol)

);
-- ddl-end --
ALTER TABLE kicad.symbols OWNER TO postgres;
-- ddl-end --

-- object: kicad.parts | type: TABLE --
-- DROP TABLE IF EXISTS kicad.parts CASCADE;
CREATE TABLE kicad.parts (
	part_id bigint NOT NULL,
	library_footprints text NOT NULL,
	footprint_footprints text NOT NULL,
	library_symbols text NOT NULL,
	symbol_symbols text NOT NULL,
	CONSTRAINT parts_pk PRIMARY KEY (part_id,library_footprints,footprint_footprints,library_symbols,symbol_symbols)

);
-- ddl-end --
ALTER TABLE kicad.parts OWNER TO postgres;
-- ddl-end --

-- object: plpython3u | type: LANGUAGE --
-- DROP LANGUAGE IF EXISTS plpython3u CASCADE;
CREATE  LANGUAGE plpython3u;
-- ddl-end --
ALTER LANGUAGE plpython3u OWNER TO postgres;
-- ddl-end --

-- object: pg_catalog.plpython3_validator | type: FUNCTION --
-- DROP FUNCTION IF EXISTS pg_catalog.plpython3_validator(oid) CASCADE;
CREATE FUNCTION pg_catalog.plpython3_validator (_param1 oid)
	RETURNS void
	LANGUAGE c
	VOLATILE 
	STRICT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 1
	AS '$libdir/plpython3', 'plpython3_validator';
-- ddl-end --
ALTER FUNCTION pg_catalog.plpython3_validator(oid) OWNER TO postgres;
-- ddl-end --

-- object: pg_catalog.plpython3_call_handler | type: FUNCTION --
-- DROP FUNCTION IF EXISTS pg_catalog.plpython3_call_handler() CASCADE;
CREATE FUNCTION pg_catalog.plpython3_call_handler ()
	RETURNS language_handler
	LANGUAGE c
	VOLATILE 
	CALLED ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 1
	AS '$libdir/plpython3', 'plpython3_call_handler';
-- ddl-end --
ALTER FUNCTION pg_catalog.plpython3_call_handler() OWNER TO postgres;
-- ddl-end --

-- object: pg_catalog.plpython3_inline_handler | type: FUNCTION --
-- DROP FUNCTION IF EXISTS pg_catalog.plpython3_inline_handler(internal) CASCADE;
CREATE FUNCTION pg_catalog.plpython3_inline_handler (_param1 internal)
	RETURNS void
	LANGUAGE c
	VOLATILE 
	STRICT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 1
	AS '$libdir/plpython3', 'plpython3_inline_handler';
-- ddl-end --
ALTER FUNCTION pg_catalog.plpython3_inline_handler(internal) OWNER TO postgres;
-- ddl-end --

-- object: parts."3d_models_parts" | type: TABLE --
-- DROP TABLE IF EXISTS parts."3d_models_parts" CASCADE;
CREATE TABLE parts."3d_models_parts" (
	id_3d_models bigint NOT NULL,
	part_id bigint NOT NULL,
	CONSTRAINT "3d_models_parts_pk" PRIMARY KEY (id_3d_models,part_id)

);
-- ddl-end --
ALTER TABLE parts."3d_models_parts" OWNER TO postgres;
-- ddl-end --

-- object: parts.part_types | type: TABLE --
-- DROP TABLE IF EXISTS parts.part_types CASCADE;
CREATE TABLE parts.part_types (
	type text NOT NULL,
	description text NOT NULL,
	CONSTRAINT types_pk PRIMARY KEY (type)

);
-- ddl-end --
COMMENT ON TABLE parts.part_types IS E'this table contains all the posible types a part can have';
-- ddl-end --
ALTER TABLE parts.part_types OWNER TO postgres;
-- ddl-end --

INSERT INTO parts.part_types (type, description) VALUES (E'Zero', E'an type for test purposes');
-- ddl-end --

-- object: parts."value-types" | type: TYPE --
-- DROP TYPE IF EXISTS parts."value-types" CASCADE;
CREATE TYPE parts."value-types" AS
 ENUM ('bigint','text','double precision');
-- ddl-end --
ALTER TYPE parts."value-types" OWNER TO postgres;
-- ddl-end --

-- object: parts.type_attributes | type: TABLE --
-- DROP TABLE IF EXISTS parts.type_attributes CASCADE;
CREATE TABLE parts.type_attributes (
	"part-type" text NOT NULL,
	"part-attribut" text NOT NULL,
	CONSTRAINT type_attributes_pk PRIMARY KEY ("part-type","part-attribut")

);
-- ddl-end --
ALTER TABLE parts.type_attributes OWNER TO postgres;
-- ddl-end --

-- object: parts.part_attributes | type: TABLE --
-- DROP TABLE IF EXISTS parts.part_attributes CASCADE;
CREATE TABLE parts.part_attributes (
	name text NOT NULL,
	description text NOT NULL,
	universal bool NOT NULL,
	"value-type" text NOT NULL,
	unit text NOT NULL,
	CONSTRAINT attributes_pk PRIMARY KEY (name)

);
-- ddl-end --
COMMENT ON TABLE parts.part_attributes IS E'this table contains all the posible attributes a part can have';
-- ddl-end --
COMMENT ON COLUMN parts.part_attributes.universal IS E'when true it means that any part type can have this attribut';
-- ddl-end --
ALTER TABLE parts.part_attributes OWNER TO postgres;
-- ddl-end --

INSERT INTO parts.part_attributes (name, description, universal, "value-type", unit) VALUES (E'Zero', E'An Attrivute for test purpeses', E'true', E'string', E'Zero');
-- ddl-end --

-- object: parts.properties | type: TABLE --
-- DROP TABLE IF EXISTS parts.properties CASCADE;
CREATE TABLE parts.properties (
	part_id bigint NOT NULL,
	value text NOT NULL,
	attribut text NOT NULL,
	CONSTRAINT properties_pk PRIMARY KEY (part_id,attribut)

);
-- ddl-end --
ALTER TABLE parts.properties OWNER TO postgres;
-- ddl-end --

INSERT INTO parts.properties (part_id, value, attribut) VALUES (E'-1', E'"Zero"', E'Zero');
-- ddl-end --

-- object: parts_fk | type: CONSTRAINT --
-- ALTER TABLE parts.properties DROP CONSTRAINT IF EXISTS parts_fk CASCADE;
ALTER TABLE parts.properties ADD CONSTRAINT parts_fk FOREIGN KEY (part_id)
REFERENCES parts.parts (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: parts.value_types | type: TABLE --
-- DROP TABLE IF EXISTS parts.value_types CASCADE;
CREATE TABLE parts.value_types (
	type text NOT NULL,
	description text NOT NULL,
	CONSTRAINT "value-types_pk" PRIMARY KEY (type)

);
-- ddl-end --
ALTER TABLE parts.value_types OWNER TO postgres;
-- ddl-end --

INSERT INTO parts.value_types (type, description) VALUES (E'integer', E'howl numbers');
-- ddl-end --
INSERT INTO parts.value_types (type, description) VALUES (E'double', E'floats');
-- ddl-end --
INSERT INTO parts.value_types (type, description) VALUES (E'string', E'text');
-- ddl-end --
INSERT INTO parts.value_types (type, description) VALUES (E'boolean', E'true and false');
-- ddl-end --

-- object: value_types_fk | type: CONSTRAINT --
-- ALTER TABLE parts.part_attributes DROP CONSTRAINT IF EXISTS value_types_fk CASCADE;
ALTER TABLE parts.part_attributes ADD CONSTRAINT value_types_fk FOREIGN KEY ("value-type")
REFERENCES parts.value_types (type) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: global.units | type: TABLE --
-- DROP TABLE IF EXISTS global.units CASCADE;
CREATE TABLE global.units (
	name text NOT NULL,
	"short-name" text NOT NULL,
	description text NOT NULL,
	CONSTRAINT "base-unit_pk" PRIMARY KEY (name)

);
-- ddl-end --
COMMENT ON TABLE global.units IS E'All the saved values are saved as a base unit';
-- ddl-end --
ALTER TABLE global.units OWNER TO postgres;
-- ddl-end --

INSERT INTO global.units (name, "short-name", description) VALUES (E'Zero', E'zero', E'an unit for test purposes');
-- ddl-end --

-- object: part_types_fk | type: CONSTRAINT --
-- ALTER TABLE parts.parts DROP CONSTRAINT IF EXISTS part_types_fk CASCADE;
ALTER TABLE parts.parts ADD CONSTRAINT part_types_fk FOREIGN KEY (type)
REFERENCES parts.part_types (type) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: part_types_fk | type: CONSTRAINT --
-- ALTER TABLE parts.type_attributes DROP CONSTRAINT IF EXISTS part_types_fk CASCADE;
ALTER TABLE parts.type_attributes ADD CONSTRAINT part_types_fk FOREIGN KEY ("part-type")
REFERENCES parts.part_types (type) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: part_attributes_fk | type: CONSTRAINT --
-- ALTER TABLE parts.properties DROP CONSTRAINT IF EXISTS part_attributes_fk CASCADE;
ALTER TABLE parts.properties ADD CONSTRAINT part_attributes_fk FOREIGN KEY (attribut)
REFERENCES parts.part_attributes (name) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: global.subunits | type: TABLE --
-- DROP TABLE IF EXISTS global.subunits CASCADE;
CREATE TABLE global.subunits (
	name text NOT NULL,
	"base-unit-name" text NOT NULL,
	"short-name" text NOT NULL,
	factor double precision NOT NULL,
	description text,
	CONSTRAINT subunits_pk PRIMARY KEY (name,"base-unit-name")

);
-- ddl-end --
COMMENT ON TABLE global.subunits IS E'here are the sub units(z.B. from Meter there is the subunit mimimeter)';
-- ddl-end --
COMMENT ON COLUMN global.subunits.factor IS E'the faktor with that the (base)unit is multiplyt';
-- ddl-end --
ALTER TABLE global.subunits OWNER TO postgres;
-- ddl-end --

-- object: units_fk | type: CONSTRAINT --
-- ALTER TABLE global.subunits DROP CONSTRAINT IF EXISTS units_fk CASCADE;
ALTER TABLE global.subunits ADD CONSTRAINT units_fk FOREIGN KEY ("base-unit-name")
REFERENCES global.units (name) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: parts.manufacturers | type: TABLE --
-- DROP TABLE IF EXISTS parts.manufacturers CASCADE;
CREATE TABLE parts.manufacturers (
	name text NOT NULL,
	CONSTRAINT manufacturers_pk PRIMARY KEY (name)

);
-- ddl-end --
ALTER TABLE parts.manufacturers OWNER TO postgres;
-- ddl-end --

-- object: manufacturers_fk | type: CONSTRAINT --
-- ALTER TABLE parts.part_manufacturers DROP CONSTRAINT IF EXISTS manufacturers_fk CASCADE;
ALTER TABLE parts.part_manufacturers ADD CONSTRAINT manufacturers_fk FOREIGN KEY (manufacturer)
REFERENCES parts.manufacturers (name) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: part_attributes_fk | type: CONSTRAINT --
-- ALTER TABLE parts.type_attributes DROP CONSTRAINT IF EXISTS part_attributes_fk CASCADE;
ALTER TABLE parts.type_attributes ADD CONSTRAINT part_attributes_fk FOREIGN KEY ("part-attribut")
REFERENCES parts.part_attributes (name) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: storage.boxes | type: TABLE --
-- DROP TABLE IF EXISTS storage.boxes CASCADE;
CREATE TABLE storage.boxes (
	id bigint NOT NULL,
	storage_box_size bigint NOT NULL,
	storage_box_type text NOT NULL,
	CONSTRAINT storage_boxes__pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE storage.boxes OWNER TO postgres;
-- ddl-end --

-- object: storage.box_sizes | type: TABLE --
-- DROP TABLE IF EXISTS storage.box_sizes CASCADE;
CREATE TABLE storage.box_sizes (
	id bigint NOT NULL,
	hight double precision NOT NULL,
	width double precision NOT NULL,
	depth double precision NOT NULL,
	CONSTRAINT storage_box_sizes_pk PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON COLUMN storage.box_sizes.hight IS E'the box hight in mm';
-- ddl-end --
COMMENT ON COLUMN storage.box_sizes.width IS E'the box width in mm';
-- ddl-end --
COMMENT ON COLUMN storage.box_sizes.depth IS E'the box depth in mm';
-- ddl-end --
ALTER TABLE storage.box_sizes OWNER TO postgres;
-- ddl-end --

-- object: box_sizes_fk | type: CONSTRAINT --
-- ALTER TABLE storage.boxes DROP CONSTRAINT IF EXISTS box_sizes_fk CASCADE;
ALTER TABLE storage.boxes ADD CONSTRAINT box_sizes_fk FOREIGN KEY (storage_box_size)
REFERENCES storage.box_sizes (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: storage.box_types | type: TABLE --
-- DROP TABLE IF EXISTS storage.box_types CASCADE;
CREATE TABLE storage.box_types (
	type text NOT NULL,
	description text NOT NULL,
	CONSTRAINT storage_box_types_pk PRIMARY KEY (type)

);
-- ddl-end --
ALTER TABLE storage.box_types OWNER TO postgres;
-- ddl-end --

-- object: box_types_fk | type: CONSTRAINT --
-- ALTER TABLE storage.boxes DROP CONSTRAINT IF EXISTS box_types_fk CASCADE;
ALTER TABLE storage.boxes ADD CONSTRAINT box_types_fk FOREIGN KEY (storage_box_type)
REFERENCES storage.box_types (type) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: storage.part_box | type: TABLE --
-- DROP TABLE IF EXISTS storage.part_box CASCADE;
CREATE TABLE storage.part_box (
	box bigint NOT NULL,
	part bigint NOT NULL,
	quantity double precision NOT NULL,
	unit text NOT NULL,
	CONSTRAINT part_box_pk PRIMARY KEY (box,part)

);
-- ddl-end --
ALTER TABLE storage.part_box OWNER TO postgres;
-- ddl-end --

-- object: boxes_fk | type: CONSTRAINT --
-- ALTER TABLE storage.part_box DROP CONSTRAINT IF EXISTS boxes_fk CASCADE;
ALTER TABLE storage.part_box ADD CONSTRAINT boxes_fk FOREIGN KEY (box)
REFERENCES storage.boxes (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: parts_fk | type: CONSTRAINT --
-- ALTER TABLE storage.part_box DROP CONSTRAINT IF EXISTS parts_fk CASCADE;
ALTER TABLE storage.part_box ADD CONSTRAINT parts_fk FOREIGN KEY (part)
REFERENCES parts.parts (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: units_fk | type: CONSTRAINT --
-- ALTER TABLE parts.part_attributes DROP CONSTRAINT IF EXISTS units_fk CASCADE;
ALTER TABLE parts.part_attributes ADD CONSTRAINT units_fk FOREIGN KEY (unit)
REFERENCES global.units (name) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: units_fk | type: CONSTRAINT --
-- ALTER TABLE storage.part_box DROP CONSTRAINT IF EXISTS units_fk CASCADE;
ALTER TABLE storage.part_box ADD CONSTRAINT units_fk FOREIGN KEY (unit)
REFERENCES global.units (name) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: storage.drawers | type: TABLE --
-- DROP TABLE IF EXISTS storage.drawers CASCADE;
CREATE TABLE storage.drawers (
	id bigint NOT NULL,
	size bigint NOT NULL,
	CONSTRAINT storage_drawers_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE storage.drawers OWNER TO postgres;
-- ddl-end --

-- object: storage.drawer_sizes | type: TABLE --
-- DROP TABLE IF EXISTS storage.drawer_sizes CASCADE;
CREATE TABLE storage.drawer_sizes (
	id bigint NOT NULL,
	hight double precision NOT NULL,
	width bigint NOT NULL,
	depth bigint NOT NULL,
	CONSTRAINT storage_box_sizes_pk_cp PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON COLUMN storage.drawer_sizes.hight IS E'the box hight in mm';
-- ddl-end --
COMMENT ON COLUMN storage.drawer_sizes.width IS E'the number of boxes in the width';
-- ddl-end --
COMMENT ON COLUMN storage.drawer_sizes.depth IS E'the number of boxes in the depth';
-- ddl-end --
ALTER TABLE storage.drawer_sizes OWNER TO postgres;
-- ddl-end --

-- object: drawer_sizes_fk | type: CONSTRAINT --
-- ALTER TABLE storage.drawers DROP CONSTRAINT IF EXISTS drawer_sizes_fk CASCADE;
ALTER TABLE storage.drawers ADD CONSTRAINT drawer_sizes_fk FOREIGN KEY (size)
REFERENCES storage.drawer_sizes (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: storage.box_drawer | type: TABLE --
-- DROP TABLE IF EXISTS storage.box_drawer CASCADE;
CREATE TABLE storage.box_drawer (
	drawer bigint NOT NULL,
	storage_box bigint NOT NULL,
	width text NOT NULL,
	depth bigint NOT NULL,
	CONSTRAINT box_drawer_pk PRIMARY KEY (drawer,storage_box)

);
-- ddl-end --
COMMENT ON COLUMN storage.box_drawer.width IS E'the width coordinate\nstarting with A';
-- ddl-end --
COMMENT ON COLUMN storage.box_drawer.depth IS E'the depth coordinate\nstarting with 0';
-- ddl-end --
ALTER TABLE storage.box_drawer OWNER TO postgres;
-- ddl-end --

-- object: drawers_fk | type: CONSTRAINT --
-- ALTER TABLE storage.box_drawer DROP CONSTRAINT IF EXISTS drawers_fk CASCADE;
ALTER TABLE storage.box_drawer ADD CONSTRAINT drawers_fk FOREIGN KEY (drawer)
REFERENCES storage.drawers (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: boxes_fk | type: CONSTRAINT --
-- ALTER TABLE storage.box_drawer DROP CONSTRAINT IF EXISTS boxes_fk CASCADE;
ALTER TABLE storage.box_drawer ADD CONSTRAINT boxes_fk FOREIGN KEY (storage_box)
REFERENCES storage.boxes (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: storage.cabinets | type: TABLE --
-- DROP TABLE IF EXISTS storage.cabinets CASCADE;
CREATE TABLE storage.cabinets (
	id bigint NOT NULL,
	drawer_number bigint NOT NULL,
	location text,
	storage_drawer_size bigint,
	CONSTRAINT storage_cabinets_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE storage.cabinets OWNER TO postgres;
-- ddl-end --

-- object: drawer_sizes_fk | type: CONSTRAINT --
-- ALTER TABLE storage.cabinets DROP CONSTRAINT IF EXISTS drawer_sizes_fk CASCADE;
ALTER TABLE storage.cabinets ADD CONSTRAINT drawer_sizes_fk FOREIGN KEY (storage_drawer_size)
REFERENCES storage.drawer_sizes (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: storage.drawer_cabinet | type: TABLE --
-- DROP TABLE IF EXISTS storage.drawer_cabinet CASCADE;
CREATE TABLE storage.drawer_cabinet (
	cabinet bigint NOT NULL,
	drawer bigint NOT NULL,
	place bigint NOT NULL,
	CONSTRAINT drawer_cabinet_pk PRIMARY KEY (cabinet,drawer)

);
-- ddl-end --
ALTER TABLE storage.drawer_cabinet OWNER TO postgres;
-- ddl-end --

-- object: cabinets_fk | type: CONSTRAINT --
-- ALTER TABLE storage.drawer_cabinet DROP CONSTRAINT IF EXISTS cabinets_fk CASCADE;
ALTER TABLE storage.drawer_cabinet ADD CONSTRAINT cabinets_fk FOREIGN KEY (cabinet)
REFERENCES storage.cabinets (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: drawers_fk | type: CONSTRAINT --
-- ALTER TABLE storage.drawer_cabinet DROP CONSTRAINT IF EXISTS drawers_fk CASCADE;
ALTER TABLE storage.drawer_cabinet ADD CONSTRAINT drawers_fk FOREIGN KEY (drawer)
REFERENCES storage.drawers (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: drawer_cabinet_uq | type: CONSTRAINT --
-- ALTER TABLE storage.drawer_cabinet DROP CONSTRAINT IF EXISTS drawer_cabinet_uq CASCADE;
ALTER TABLE storage.drawer_cabinet ADD CONSTRAINT drawer_cabinet_uq UNIQUE (drawer);
-- ddl-end --

-- object: parts.get_next_parts_id | type: FUNCTION --
-- DROP FUNCTION IF EXISTS parts.get_next_parts_id() CASCADE;
CREATE FUNCTION parts.get_next_parts_id ()
	RETURNS bigint
	LANGUAGE plpython3u
	VOLATILE 
	CALLED ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 1
	AS $$
plan = plpy.prepare("SELECT id FROM parts.parts ORDER BY id")
ids = plpy.execute(plan)
res = -10
for id in range(ids.nrows()):
    res = id
    if ids[id]['id'] != id:
        return id
return 	res + 1
$$;
-- ddl-end --
ALTER FUNCTION parts.get_next_parts_id() OWNER TO postgres;
-- ddl-end --
COMMENT ON FUNCTION parts.get_next_parts_id() IS E'returns the next avalible part id';
-- ddl-end --

-- object: "3d_models_fk" | type: CONSTRAINT --
-- ALTER TABLE parts."3d_models_parts" DROP CONSTRAINT IF EXISTS "3d_models_fk" CASCADE;
ALTER TABLE parts."3d_models_parts" ADD CONSTRAINT "3d_models_fk" FOREIGN KEY (id_3d_models)
REFERENCES parts."3d_models" (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: parts_fk | type: CONSTRAINT --
-- ALTER TABLE parts."3d_models_parts" DROP CONSTRAINT IF EXISTS parts_fk CASCADE;
ALTER TABLE parts."3d_models_parts" ADD CONSTRAINT parts_fk FOREIGN KEY (part_id)
REFERENCES parts.parts (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: global.file_type | type: TABLE --
-- DROP TABLE IF EXISTS global.file_type CASCADE;
CREATE TABLE global.file_type (
	type text NOT NULL,
	description text NOT NULL,
	CONSTRAINT image_type_pk PRIMARY KEY (type)

);
-- ddl-end --
ALTER TABLE global.file_type OWNER TO postgres;
-- ddl-end --

INSERT INTO global.file_type (type, description) VALUES (E'url', E'an link to the website');
-- ddl-end --

-- object: file_type_fk | type: CONSTRAINT --
-- ALTER TABLE parts.images DROP CONSTRAINT IF EXISTS file_type_fk CASCADE;
ALTER TABLE parts.images ADD CONSTRAINT file_type_fk FOREIGN KEY (type)
REFERENCES global.file_type (type) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: global.file_extensions | type: TABLE --
-- DROP TABLE IF EXISTS global.file_extensions CASCADE;
CREATE TABLE global.file_extensions (
	extension text NOT NULL,
	type text NOT NULL,
	CONSTRAINT file_extensions_pk PRIMARY KEY (extension,type)

);
-- ddl-end --
ALTER TABLE global.file_extensions OWNER TO postgres;
-- ddl-end --

-- object: file_type_fk | type: CONSTRAINT --
-- ALTER TABLE global.file_extensions DROP CONSTRAINT IF EXISTS file_type_fk CASCADE;
ALTER TABLE global.file_extensions ADD CONSTRAINT file_type_fk FOREIGN KEY (type)
REFERENCES global.file_type (type) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: file_type_fk | type: CONSTRAINT --
-- ALTER TABLE parts.documantations DROP CONSTRAINT IF EXISTS file_type_fk CASCADE;
ALTER TABLE parts.documantations ADD CONSTRAINT file_type_fk FOREIGN KEY (type)
REFERENCES global.file_type (type) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: vendors.vendors | type: TABLE --
-- DROP TABLE IF EXISTS vendors.vendors CASCADE;
CREATE TABLE vendors.vendors (
	name text NOT NULL,
	url text NOT NULL,
	CONSTRAINT vendors_pk PRIMARY KEY (name)

);
-- ddl-end --
COMMENT ON COLUMN vendors.vendors.url IS E'the url to the main home page';
-- ddl-end --
ALTER TABLE vendors.vendors OWNER TO postgres;
-- ddl-end --

-- object: parts.purchase_information | type: TABLE --
-- DROP TABLE IF EXISTS parts.purchase_information CASCADE;
CREATE TABLE parts.purchase_information (
	vendor text NOT NULL,
	vendor_id text NOT NULL,
	part bigint NOT NULL,
	url text NOT NULL,
	CONSTRAINT purchase_information_pk PRIMARY KEY (vendor_id,vendor,part)

);
-- ddl-end --
ALTER TABLE parts.purchase_information OWNER TO postgres;
-- ddl-end --

-- object: vendors_fk | type: CONSTRAINT --
-- ALTER TABLE parts.purchase_information DROP CONSTRAINT IF EXISTS vendors_fk CASCADE;
ALTER TABLE parts.purchase_information ADD CONSTRAINT vendors_fk FOREIGN KEY (vendor)
REFERENCES vendors.vendors (name) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: parts_fk | type: CONSTRAINT --
-- ALTER TABLE parts.purchase_information DROP CONSTRAINT IF EXISTS parts_fk CASCADE;
ALTER TABLE parts.purchase_information ADD CONSTRAINT parts_fk FOREIGN KEY (part)
REFERENCES parts.parts (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: parts.purchase_price | type: TABLE --
-- DROP TABLE IF EXISTS parts.purchase_price CASCADE;
CREATE TABLE parts.purchase_price (
	vendor_id text NOT NULL,
	vendor text NOT NULL,
	part bigint NOT NULL,
	quantity bigint NOT NULL,
	unit_price double precision NOT NULL,
	currency text NOT NULL
);
-- ddl-end --
ALTER TABLE parts.purchase_price OWNER TO postgres;
-- ddl-end --

-- object: purchase_information_fk | type: CONSTRAINT --
-- ALTER TABLE parts.purchase_price DROP CONSTRAINT IF EXISTS purchase_information_fk CASCADE;
ALTER TABLE parts.purchase_price ADD CONSTRAINT purchase_information_fk FOREIGN KEY (vendor_id,vendor,part)
REFERENCES parts.purchase_information (vendor_id,vendor,part) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: global.currencys | type: TABLE --
-- DROP TABLE IF EXISTS global.currencys CASCADE;
CREATE TABLE global.currencys (
	name text NOT NULL,
	euro double precision NOT NULL,
	CONSTRAINT currencys_pk PRIMARY KEY (name)

);
-- ddl-end --
COMMENT ON COLUMN global.currencys.euro IS E'how much 1 x is in Euro';
-- ddl-end --
ALTER TABLE global.currencys OWNER TO postgres;
-- ddl-end --

-- object: currencys_fk | type: CONSTRAINT --
-- ALTER TABLE parts.purchase_price DROP CONSTRAINT IF EXISTS currencys_fk CASCADE;
ALTER TABLE parts.purchase_price ADD CONSTRAINT currencys_fk FOREIGN KEY (currency)
REFERENCES global.currencys (name) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: parts.get_next_3d_models_id | type: FUNCTION --
-- DROP FUNCTION IF EXISTS parts.get_next_3d_models_id() CASCADE;
CREATE FUNCTION parts.get_next_3d_models_id ()
	RETURNS bigint
	LANGUAGE plpython3u
	VOLATILE 
	CALLED ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 1
	AS $$
plan = plpy.prepare("SELECT id FROM parts.\"3d_models\" ORDER BY id")
ids = plpy.execute(plan)
res = -10
for id in range(ids.nrows()):
    res = id
    if ids[id]['id'] != id:
        return id
return 	res + 1
$$;
-- ddl-end --
ALTER FUNCTION parts.get_next_3d_models_id() OWNER TO postgres;
-- ddl-end --
COMMENT ON FUNCTION parts.get_next_3d_models_id() IS E'returns the next avalible 3d_model id';
-- ddl-end --

-- object: parts.get_next_images_id | type: FUNCTION --
-- DROP FUNCTION IF EXISTS parts.get_next_images_id() CASCADE;
CREATE FUNCTION parts.get_next_images_id ()
	RETURNS bigint
	LANGUAGE plpython3u
	VOLATILE 
	CALLED ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 1
	AS $$
plan = plpy.prepare("SELECT id FROM parts.images ORDER BY id")
ids = plpy.execute(plan)
res = -10
for id in range(ids.nrows()):
    res = id
    if ids[id]['id'] != id:
        return id
return 	res + 1
$$;
-- ddl-end --
ALTER FUNCTION parts.get_next_images_id() OWNER TO postgres;
-- ddl-end --
COMMENT ON FUNCTION parts.get_next_images_id() IS E'returns the next avalible image id';
-- ddl-end --

-- object: parts.get_next_documantations_id | type: FUNCTION --
-- DROP FUNCTION IF EXISTS parts.get_next_documantations_id() CASCADE;
CREATE FUNCTION parts.get_next_documantations_id ()
	RETURNS bigint
	LANGUAGE plpython3u
	VOLATILE 
	CALLED ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 1
	AS $$
plan = plpy.prepare("SELECT id FROM parts.documantations ORDER BY id")
ids = plpy.execute(plan)
res = -10
for id in range(ids.nrows()):
    res = id
    if ids[id]['id'] != id:
        return id
return 	res + 1
$$;
-- ddl-end --
ALTER FUNCTION parts.get_next_documantations_id() OWNER TO postgres;
-- ddl-end --
COMMENT ON FUNCTION parts.get_next_documantations_id() IS E'returns the next avalible documantations id';
-- ddl-end --

-- object: footprints_fk | type: CONSTRAINT --
-- ALTER TABLE kicad.parts DROP CONSTRAINT IF EXISTS footprints_fk CASCADE;
ALTER TABLE kicad.parts ADD CONSTRAINT footprints_fk FOREIGN KEY (library_footprints,footprint_footprints)
REFERENCES kicad.footprints (library,footprint) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: symbols_fk | type: CONSTRAINT --
-- ALTER TABLE kicad.parts DROP CONSTRAINT IF EXISTS symbols_fk CASCADE;
ALTER TABLE kicad.parts ADD CONSTRAINT symbols_fk FOREIGN KEY (library_symbols,symbol_symbols)
REFERENCES kicad.symbols (library,symbol) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: storage.part_box_history | type: TABLE --
-- DROP TABLE IF EXISTS storage.part_box_history CASCADE;
CREATE TABLE storage.part_box_history (
	"time" timestamp with time zone NOT NULL,
	box_part_box bigint NOT NULL,
	part_part_box bigint NOT NULL,
	quantity double precision NOT NULL,
	name_units text NOT NULL,
	CONSTRAINT part_box_history_pk PRIMARY KEY ("time",box_part_box,part_part_box)

);
-- ddl-end --
ALTER TABLE storage.part_box_history OWNER TO postgres;
-- ddl-end --

-- object: part_box_fk | type: CONSTRAINT --
-- ALTER TABLE storage.part_box_history DROP CONSTRAINT IF EXISTS part_box_fk CASCADE;
ALTER TABLE storage.part_box_history ADD CONSTRAINT part_box_fk FOREIGN KEY (box_part_box,part_part_box)
REFERENCES storage.part_box (box,part) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: units_fk | type: CONSTRAINT --
-- ALTER TABLE storage.part_box_history DROP CONSTRAINT IF EXISTS units_fk CASCADE;
ALTER TABLE storage.part_box_history ADD CONSTRAINT units_fk FOREIGN KEY (name_units)
REFERENCES global.units (name) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: storage.part_box_history_f_iu | type: FUNCTION --
-- DROP FUNCTION IF EXISTS storage.part_box_history_f_iu() CASCADE;
CREATE FUNCTION storage.part_box_history_f_iu ()
	RETURNS trigger
	LANGUAGE plpython3u
	VOLATILE 
	CALLED ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 1
	AS $$
plan = plpy.prepare("SELECT box, part, quantity FROM storage.part_box WHERE box= AND part=")
ids = plpy.execute(plan)
res = -10
for id in range(ids.nrows()):
    res = id
    if ids[id]['id'] != id:
        return id
return 	res + 1
$$;
-- ddl-end --
ALTER FUNCTION storage.part_box_history_f_iu() OWNER TO postgres;
-- ddl-end --

-- object: part_box_history_iu | type: TRIGGER --
-- DROP TRIGGER IF EXISTS part_box_history_iu ON storage.part_box CASCADE;
CREATE TRIGGER part_box_history_iu
	AFTER INSERT OR UPDATE
	ON storage.part_box
	FOR EACH STATEMENT
	EXECUTE PROCEDURE storage.part_box_history_f_iu();
-- ddl-end --

-- object: part_box_history_d | type: TRIGGER --
-- DROP TRIGGER IF EXISTS part_box_history_d ON storage.part_box CASCADE;
CREATE TRIGGER part_box_history_d
	AFTER DELETE 
	ON storage.part_box
	FOR EACH STATEMENT
	EXECUTE PROCEDURE storage.part_box_history_f_iu();
-- ddl-end --

-- object: parts_fk | type: CONSTRAINT --
-- ALTER TABLE parts.documantations DROP CONSTRAINT IF EXISTS parts_fk CASCADE;
ALTER TABLE parts.documantations ADD CONSTRAINT parts_fk FOREIGN KEY (id_parts)
REFERENCES parts.parts (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: parts_fk | type: CONSTRAINT --
-- ALTER TABLE parts.images DROP CONSTRAINT IF EXISTS parts_fk CASCADE;
ALTER TABLE parts.images ADD CONSTRAINT parts_fk FOREIGN KEY (id_parts)
REFERENCES parts.parts (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: parts_fk | type: CONSTRAINT --
-- ALTER TABLE parts.part_manufacturers DROP CONSTRAINT IF EXISTS parts_fk CASCADE;
ALTER TABLE parts.part_manufacturers ADD CONSTRAINT parts_fk FOREIGN KEY (part_id)
REFERENCES parts.parts (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: assemblies_fk | type: CONSTRAINT --
-- ALTER TABLE assemblies.assembly_parts DROP CONSTRAINT IF EXISTS assemblies_fk CASCADE;
ALTER TABLE assemblies.assembly_parts ADD CONSTRAINT assemblies_fk FOREIGN KEY (assembly)
REFERENCES assemblies.assemblies (name) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: parts_fk | type: CONSTRAINT --
-- ALTER TABLE assemblies.assembly_parts DROP CONSTRAINT IF EXISTS parts_fk CASCADE;
ALTER TABLE assemblies.assembly_parts ADD CONSTRAINT parts_fk FOREIGN KEY (part_id)
REFERENCES parts.parts (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: parts_fk | type: CONSTRAINT --
-- ALTER TABLE kicad.parts DROP CONSTRAINT IF EXISTS parts_fk CASCADE;
ALTER TABLE kicad.parts ADD CONSTRAINT parts_fk FOREIGN KEY (part_id)
REFERENCES parts.parts (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "grant_CU_eb94f049ac" | type: PERMISSION --
GRANT CREATE,USAGE
   ON SCHEMA public
   TO postgres;
-- ddl-end --

-- object: "grant_CU_cd8e46e7b6" | type: PERMISSION --
GRANT CREATE,USAGE
   ON SCHEMA public
   TO PUBLIC;
-- ddl-end --


