-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.3-beta1
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: assortm | type: DATABASE --
-- DROP DATABASE IF EXISTS assortm;
CREATE DATABASE assortm
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

SET search_path TO pg_catalog,public,parts,storage,assemblies,kicad,global;
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

-- object: parts.documantations | type: TABLE --
-- DROP TABLE IF EXISTS parts.documantations CASCADE;
CREATE TABLE parts.documantations (
	id bigint NOT NULL,
	id_parts bigint NOT NULL,
	name text NOT NULL,
	description text,
	CONSTRAINT documantations_pk PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE parts.documantations IS E'Here are the documantaion file stored, like the datasheets and manuels';
-- ddl-end --
COMMENT ON COLUMN parts.documantations.description IS E'an short description of what is dislplayed in the file';
-- ddl-end --
ALTER TABLE parts.documantations OWNER TO postgres;
-- ddl-end --

-- object: parts.images | type: TABLE --
-- DROP TABLE IF EXISTS parts.images CASCADE;
CREATE TABLE parts.images (
	id bigint NOT NULL,
	id_parts bigint NOT NULL,
	description text,
	CONSTRAINT images_pk PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE parts.images IS E'here are the images of the part saved';
-- ddl-end --
ALTER TABLE parts.images OWNER TO postgres;
-- ddl-end --

-- object: parts.part_manufacturers | type: TABLE --
-- DROP TABLE IF EXISTS parts.part_manufacturers CASCADE;
CREATE TABLE parts.part_manufacturers (
	manufacturer_id text NOT NULL,
	id_parts bigint NOT NULL,
	name_manufacturers text NOT NULL,
	CONSTRAINT parts_manufacturers_pk PRIMARY KEY (manufacturer_id)

);
-- ddl-end --
COMMENT ON COLUMN parts.part_manufacturers.manufacturer_id IS E'is the id/name of the part given by the manufacturer and could be identical to parts.name';
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
	name_assemblies text NOT NULL,
	id_parts bigint NOT NULL
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
	id bigint NOT NULL,
	library text,
	footprint text,
	CONSTRAINT footprints_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE kicad.footprints OWNER TO postgres;
-- ddl-end --

-- object: kicad.symbols | type: TABLE --
-- DROP TABLE IF EXISTS kicad.symbols CASCADE;
CREATE TABLE kicad.symbols (
	id bigint NOT NULL,
	library text,
	symbol text,
	CONSTRAINT symbols_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE kicad.symbols OWNER TO postgres;
-- ddl-end --

-- object: kicad.parts | type: TABLE --
-- DROP TABLE IF EXISTS kicad.parts CASCADE;
CREATE TABLE kicad.parts (
	id_parts bigint NOT NULL,
	id_footprints bigint NOT NULL,
	id_symbols bigint NOT NULL
);
-- ddl-end --
ALTER TABLE kicad.parts OWNER TO postgres;
-- ddl-end --

-- object: pg_catalog.plpython3_validator | type: FUNCTION --
-- DROP FUNCTION IF EXISTS pg_catalog.plpython3_validator(oid) CASCADE;
CREATE FUNCTION pg_catalog.plpython3_validator (_param1 oid)
	RETURNS void
	LANGUAGE c
	VOLATILE 
	STRICT
	SECURITY INVOKER
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
	COST 1
	AS '$libdir/plpython3', 'plpython3_inline_handler';
-- ddl-end --
ALTER FUNCTION pg_catalog.plpython3_inline_handler(internal) OWNER TO postgres;
-- ddl-end --

-- object: plpython3u | type: LANGUAGE --
-- DROP LANGUAGE IF EXISTS plpython3u CASCADE;
CREATE  LANGUAGE plpython3u;
-- ddl-end --
ALTER LANGUAGE plpython3u OWNER TO postgres;
-- ddl-end --

-- object: parts.get_next_part_id | type: FUNCTION --
-- DROP FUNCTION IF EXISTS parts.get_next_part_id() CASCADE;
CREATE FUNCTION parts.get_next_part_id ()
	RETURNS bigint
	LANGUAGE plpython3u
	VOLATILE 
	CALLED ON NULL INPUT
	SECURITY INVOKER
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
ALTER FUNCTION parts.get_next_part_id() OWNER TO postgres;
-- ddl-end --
COMMENT ON FUNCTION parts.get_next_part_id() IS E'returns the next avalible part id';
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
	"part-attribut" text NOT NULL,
	"part-type" text NOT NULL
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

-- object: parts.properties | type: TABLE --
-- DROP TABLE IF EXISTS parts.properties CASCADE;
CREATE TABLE parts.properties (
	part_id bigint NOT NULL,
	attribut text NOT NULL,
	value text NOT NULL
);
-- ddl-end --
ALTER TABLE parts.properties OWNER TO postgres;
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
	CONSTRAINT subunits_pk PRIMARY KEY (name)

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
ALTER TABLE parts.part_manufacturers ADD CONSTRAINT manufacturers_fk FOREIGN KEY (name_manufacturers)
REFERENCES parts.manufacturers (name) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: part_attributes_fk | type: CONSTRAINT --
-- ALTER TABLE parts.type_attributes DROP CONSTRAINT IF EXISTS part_attributes_fk CASCADE;
ALTER TABLE parts.type_attributes ADD CONSTRAINT part_attributes_fk FOREIGN KEY ("part-attribut")
REFERENCES parts.part_attributes (name) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: storage.storage_boxes | type: TABLE --
-- DROP TABLE IF EXISTS storage.storage_boxes CASCADE;
CREATE TABLE storage.storage_boxes (
	id bigint NOT NULL,
	storage_box_size bigint NOT NULL,
	storage_box_type text NOT NULL,
	CONSTRAINT storage_boxes__pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE storage.storage_boxes OWNER TO postgres;
-- ddl-end --

-- object: storage.storage_box_sizes | type: TABLE --
-- DROP TABLE IF EXISTS storage.storage_box_sizes CASCADE;
CREATE TABLE storage.storage_box_sizes (
	id bigint NOT NULL,
	hight double precision NOT NULL,
	width double precision NOT NULL,
	depth double precision NOT NULL,
	CONSTRAINT storage_box_sizes_pk PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON COLUMN storage.storage_box_sizes.hight IS E'the box hight in mm';
-- ddl-end --
COMMENT ON COLUMN storage.storage_box_sizes.width IS E'the box width in mm';
-- ddl-end --
COMMENT ON COLUMN storage.storage_box_sizes.depth IS E'the box depth in mm';
-- ddl-end --
ALTER TABLE storage.storage_box_sizes OWNER TO postgres;
-- ddl-end --

-- object: storage_box_sizes_fk | type: CONSTRAINT --
-- ALTER TABLE storage.storage_boxes DROP CONSTRAINT IF EXISTS storage_box_sizes_fk CASCADE;
ALTER TABLE storage.storage_boxes ADD CONSTRAINT storage_box_sizes_fk FOREIGN KEY (storage_box_size)
REFERENCES storage.storage_box_sizes (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: storage.storage_box_types | type: TABLE --
-- DROP TABLE IF EXISTS storage.storage_box_types CASCADE;
CREATE TABLE storage.storage_box_types (
	type text NOT NULL,
	description text NOT NULL,
	CONSTRAINT storage_box_types_pk PRIMARY KEY (type)

);
-- ddl-end --
ALTER TABLE storage.storage_box_types OWNER TO postgres;
-- ddl-end --

-- object: storage_box_types_fk | type: CONSTRAINT --
-- ALTER TABLE storage.storage_boxes DROP CONSTRAINT IF EXISTS storage_box_types_fk CASCADE;
ALTER TABLE storage.storage_boxes ADD CONSTRAINT storage_box_types_fk FOREIGN KEY (storage_box_type)
REFERENCES storage.storage_box_types (type) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: storage.part_stoge_boxes | type: TABLE --
-- DROP TABLE IF EXISTS storage.part_stoge_boxes CASCADE;
CREATE TABLE storage.part_stoge_boxes (
	box bigint NOT NULL,
	part bigint NOT NULL,
	quantity double precision NOT NULL,
	unit text NOT NULL
);
-- ddl-end --
ALTER TABLE storage.part_stoge_boxes OWNER TO postgres;
-- ddl-end --

-- object: storage_boxes_fk | type: CONSTRAINT --
-- ALTER TABLE storage.part_stoge_boxes DROP CONSTRAINT IF EXISTS storage_boxes_fk CASCADE;
ALTER TABLE storage.part_stoge_boxes ADD CONSTRAINT storage_boxes_fk FOREIGN KEY (box)
REFERENCES storage.storage_boxes (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: parts_fk | type: CONSTRAINT --
-- ALTER TABLE storage.part_stoge_boxes DROP CONSTRAINT IF EXISTS parts_fk CASCADE;
ALTER TABLE storage.part_stoge_boxes ADD CONSTRAINT parts_fk FOREIGN KEY (part)
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
-- ALTER TABLE storage.part_stoge_boxes DROP CONSTRAINT IF EXISTS units_fk CASCADE;
ALTER TABLE storage.part_stoge_boxes ADD CONSTRAINT units_fk FOREIGN KEY (unit)
REFERENCES global.units (name) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: storage.storage_drawers | type: TABLE --
-- DROP TABLE IF EXISTS storage.storage_drawers CASCADE;
CREATE TABLE storage.storage_drawers (
	id bigint NOT NULL,
	size bigint NOT NULL,
	CONSTRAINT storage_drawers_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE storage.storage_drawers OWNER TO postgres;
-- ddl-end --

-- object: storage.storage_drawer_sizes | type: TABLE --
-- DROP TABLE IF EXISTS storage.storage_drawer_sizes CASCADE;
CREATE TABLE storage.storage_drawer_sizes (
	id bigint NOT NULL,
	hight double precision NOT NULL,
	width bigint NOT NULL,
	depth bigint NOT NULL,
	CONSTRAINT storage_box_sizes_pk_cp PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON COLUMN storage.storage_drawer_sizes.hight IS E'the box hight in mm';
-- ddl-end --
COMMENT ON COLUMN storage.storage_drawer_sizes.width IS E'the number of boxes in the width';
-- ddl-end --
COMMENT ON COLUMN storage.storage_drawer_sizes.depth IS E'the number of boxes in the depth';
-- ddl-end --
ALTER TABLE storage.storage_drawer_sizes OWNER TO postgres;
-- ddl-end --

-- object: storage_drawer_sizes_fk | type: CONSTRAINT --
-- ALTER TABLE storage.storage_drawers DROP CONSTRAINT IF EXISTS storage_drawer_sizes_fk CASCADE;
ALTER TABLE storage.storage_drawers ADD CONSTRAINT storage_drawer_sizes_fk FOREIGN KEY (size)
REFERENCES storage.storage_drawer_sizes (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: storage.storage_box_drawers | type: TABLE --
-- DROP TABLE IF EXISTS storage.storage_box_drawers CASCADE;
CREATE TABLE storage.storage_box_drawers (
	drawer bigint NOT NULL,
	id_storage_boxes bigint,
	width text NOT NULL,
	depth bigint NOT NULL
);
-- ddl-end --
COMMENT ON COLUMN storage.storage_box_drawers.width IS E'the width coordinate\nstarting with A';
-- ddl-end --
COMMENT ON COLUMN storage.storage_box_drawers.depth IS E'the depth coordinate\nstarting with 0';
-- ddl-end --
ALTER TABLE storage.storage_box_drawers OWNER TO postgres;
-- ddl-end --

-- object: storage_drawers_fk | type: CONSTRAINT --
-- ALTER TABLE storage.storage_box_drawers DROP CONSTRAINT IF EXISTS storage_drawers_fk CASCADE;
ALTER TABLE storage.storage_box_drawers ADD CONSTRAINT storage_drawers_fk FOREIGN KEY (drawer)
REFERENCES storage.storage_drawers (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: storage_boxes_fk | type: CONSTRAINT --
-- ALTER TABLE storage.storage_box_drawers DROP CONSTRAINT IF EXISTS storage_boxes_fk CASCADE;
ALTER TABLE storage.storage_box_drawers ADD CONSTRAINT storage_boxes_fk FOREIGN KEY (id_storage_boxes)
REFERENCES storage.storage_boxes (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: storage.storage_cabinets | type: TABLE --
-- DROP TABLE IF EXISTS storage.storage_cabinets CASCADE;
CREATE TABLE storage.storage_cabinets (
	id bigint NOT NULL,
	drawer_number bigint NOT NULL,
	storage_drawer_size bigint,
	location text,
	CONSTRAINT storage_cabinets_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE storage.storage_cabinets OWNER TO postgres;
-- ddl-end --

-- object: storage_drawer_sizes_fk | type: CONSTRAINT --
-- ALTER TABLE storage.storage_cabinets DROP CONSTRAINT IF EXISTS storage_drawer_sizes_fk CASCADE;
ALTER TABLE storage.storage_cabinets ADD CONSTRAINT storage_drawer_sizes_fk FOREIGN KEY (storage_drawer_size)
REFERENCES storage.storage_drawer_sizes (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: storage.storage_drawer_cabinets | type: TABLE --
-- DROP TABLE IF EXISTS storage.storage_drawer_cabinets CASCADE;
CREATE TABLE storage.storage_drawer_cabinets (
	id_storage_cabinets bigint NOT NULL,
	id_storage_drawers bigint NOT NULL,
	place bigint NOT NULL
);
-- ddl-end --
ALTER TABLE storage.storage_drawer_cabinets OWNER TO postgres;
-- ddl-end --

-- object: storage_cabinets_fk | type: CONSTRAINT --
-- ALTER TABLE storage.storage_drawer_cabinets DROP CONSTRAINT IF EXISTS storage_cabinets_fk CASCADE;
ALTER TABLE storage.storage_drawer_cabinets ADD CONSTRAINT storage_cabinets_fk FOREIGN KEY (id_storage_cabinets)
REFERENCES storage.storage_cabinets (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: storage_drawers_fk | type: CONSTRAINT --
-- ALTER TABLE storage.storage_drawer_cabinets DROP CONSTRAINT IF EXISTS storage_drawers_fk CASCADE;
ALTER TABLE storage.storage_drawer_cabinets ADD CONSTRAINT storage_drawers_fk FOREIGN KEY (id_storage_drawers)
REFERENCES storage.storage_drawers (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: storage_drawer_cabinets_uq | type: CONSTRAINT --
-- ALTER TABLE storage.storage_drawer_cabinets DROP CONSTRAINT IF EXISTS storage_drawer_cabinets_uq CASCADE;
ALTER TABLE storage.storage_drawer_cabinets ADD CONSTRAINT storage_drawer_cabinets_uq UNIQUE (id_storage_drawers);
-- ddl-end --

-- object: footprints_fk | type: CONSTRAINT --
-- ALTER TABLE kicad.parts DROP CONSTRAINT IF EXISTS footprints_fk CASCADE;
ALTER TABLE kicad.parts ADD CONSTRAINT footprints_fk FOREIGN KEY (id_footprints)
REFERENCES kicad.footprints (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: symbols_fk | type: CONSTRAINT --
-- ALTER TABLE kicad.parts DROP CONSTRAINT IF EXISTS symbols_fk CASCADE;
ALTER TABLE kicad.parts ADD CONSTRAINT symbols_fk FOREIGN KEY (id_symbols)
REFERENCES kicad.symbols (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: parts."3d_models_parts" | type: TABLE --
-- DROP TABLE IF EXISTS parts."3d_models_parts" CASCADE;
CREATE TABLE parts."3d_models_parts" (
	id_3d_models bigint NOT NULL,
	id_parts bigint NOT NULL
);
-- ddl-end --
ALTER TABLE parts."3d_models_parts" OWNER TO postgres;
-- ddl-end --

-- object: "3d_models_fk" | type: CONSTRAINT --
-- ALTER TABLE parts."3d_models_parts" DROP CONSTRAINT IF EXISTS "3d_models_fk" CASCADE;
ALTER TABLE parts."3d_models_parts" ADD CONSTRAINT "3d_models_fk" FOREIGN KEY (id_3d_models)
REFERENCES parts."3d_models" (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: parts_fk | type: CONSTRAINT --
-- ALTER TABLE parts."3d_models_parts" DROP CONSTRAINT IF EXISTS parts_fk CASCADE;
ALTER TABLE parts."3d_models_parts" ADD CONSTRAINT parts_fk FOREIGN KEY (id_parts)
REFERENCES parts.parts (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
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
ALTER TABLE parts.part_manufacturers ADD CONSTRAINT parts_fk FOREIGN KEY (id_parts)
REFERENCES parts.parts (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: assemblies_fk | type: CONSTRAINT --
-- ALTER TABLE assemblies.assembly_parts DROP CONSTRAINT IF EXISTS assemblies_fk CASCADE;
ALTER TABLE assemblies.assembly_parts ADD CONSTRAINT assemblies_fk FOREIGN KEY (name_assemblies)
REFERENCES assemblies.assemblies (name) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: parts_fk | type: CONSTRAINT --
-- ALTER TABLE assemblies.assembly_parts DROP CONSTRAINT IF EXISTS parts_fk CASCADE;
ALTER TABLE assemblies.assembly_parts ADD CONSTRAINT parts_fk FOREIGN KEY (id_parts)
REFERENCES parts.parts (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: parts_fk | type: CONSTRAINT --
-- ALTER TABLE kicad.parts DROP CONSTRAINT IF EXISTS parts_fk CASCADE;
ALTER TABLE kicad.parts ADD CONSTRAINT parts_fk FOREIGN KEY (id_parts)
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


