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

SET search_path TO pg_catalog,public,parts,storage,assemblies,kicad;
-- ddl-end --

-- object: parts.types_enum | type: TYPE --
-- DROP TYPE IF EXISTS parts.types_enum CASCADE;
CREATE TYPE parts.types_enum AS
 ENUM ('unknown','<base>');
-- ddl-end --
ALTER TYPE parts.types_enum OWNER TO postgres;
-- ddl-end --
COMMENT ON TYPE parts.types_enum IS E'the types of parts';
-- ddl-end --

-- object: parts.parts | type: TABLE --
-- DROP TABLE IF EXISTS parts.parts CASCADE;
CREATE TABLE parts.parts (
	id bigint NOT NULL,
	name text NOT NULL,
	description text,
	weight double precision,
	type parts.types_enum NOT NULL,
	id_3d_models bigint,
	CONSTRAINT parts_pk PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON COLUMN parts.parts.name IS E'The name of the part (may be identical to the manufacture_id)';
-- ddl-end --
COMMENT ON COLUMN parts.parts.description IS E'An description of the part';
-- ddl-end --
COMMENT ON COLUMN parts.parts.type IS E'the part type';
-- ddl-end --
ALTER TABLE parts.parts OWNER TO postgres;
-- ddl-end --

-- object: parts.manufacturers | type: TYPE --
-- DROP TYPE IF EXISTS parts.manufacturers CASCADE;
CREATE TYPE parts.manufacturers AS
 ENUM ('texas_instruments');
-- ddl-end --
ALTER TYPE parts.manufacturers OWNER TO postgres;
-- ddl-end --

-- object: parts.get_parts_type | type: FUNCTION --
-- DROP FUNCTION IF EXISTS parts.get_parts_type(bigint) CASCADE;
CREATE FUNCTION parts.get_parts_type (id_in bigint)
	RETURNS parts.types_enum
	LANGUAGE sql
	VOLATILE 
	CALLED ON NULL INPUT
	SECURITY INVOKER
	COST 1
	AS $$
SELECT parts.type FROM parts.parts WHERE parts.id = id_in;
$$;
-- ddl-end --
ALTER FUNCTION parts.get_parts_type(bigint) OWNER TO postgres;
-- ddl-end --

-- object: parts.documantations | type: TABLE --
-- DROP TABLE IF EXISTS parts.documantations CASCADE;
CREATE TABLE parts.documantations (
	location text NOT NULL,
	id_parts bigint NOT NULL,
	name text NOT NULL,
	description text,
	CONSTRAINT documantations_pk PRIMARY KEY (location)

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
	image_id bigint NOT NULL,
	id_parts bigint NOT NULL,
	image bytea NOT NULL,
	CONSTRAINT images_pk PRIMARY KEY (image_id)

);
-- ddl-end --
COMMENT ON TABLE parts.images IS E'here are the images of the part saved';
-- ddl-end --
COMMENT ON COLUMN parts.images.image IS E'the image';
-- ddl-end --
ALTER TABLE parts.images OWNER TO postgres;
-- ddl-end --

-- object: storage.storage_box_sizes | type: TYPE --
-- DROP TYPE IF EXISTS storage.storage_box_sizes CASCADE;
CREATE TYPE storage.storage_box_sizes AS
 ENUM ('20x70x70','40x70x70','60x70x70');
-- ddl-end --
ALTER TYPE storage.storage_box_sizes OWNER TO postgres;
-- ddl-end --

-- object: storage.box_types | type: TYPE --
-- DROP TYPE IF EXISTS storage.box_types CASCADE;
CREATE TYPE storage.box_types AS
 ENUM ('standard');
-- ddl-end --
ALTER TYPE storage.box_types OWNER TO postgres;
-- ddl-end --

-- object: storage.big_storage_places | type: TABLE --
-- DROP TABLE IF EXISTS storage.big_storage_places CASCADE;
CREATE TABLE storage.big_storage_places (
	id bigint NOT NULL,
	id_storage_boxes bigint,
	cabinet bigint,
	drawer text,
	drawer_place_row bigint,
	drawer_place_column text,
	CONSTRAINT storage_places_pk PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON COLUMN storage.big_storage_places.drawer_place_row IS E'that is the row of 70x70 Square';
-- ddl-end --
COMMENT ON COLUMN storage.big_storage_places.drawer_place_column IS E'that is the column of the 70x70 Square';
-- ddl-end --
ALTER TABLE storage.big_storage_places OWNER TO postgres;
-- ddl-end --

-- object: storage.storage_boxes | type: TABLE --
-- DROP TABLE IF EXISTS storage.storage_boxes CASCADE;
CREATE TABLE storage.storage_boxes (
	id bigint NOT NULL,
	size storage.storage_box_sizes,
	type storage.box_types,
	stock bigint,
	id_parts bigint NOT NULL,
	CONSTRAINT storage_boxes_pk PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON COLUMN storage.storage_boxes.id IS E'the id of the storage id';
-- ddl-end --
ALTER TABLE storage.storage_boxes OWNER TO postgres;
-- ddl-end --

-- object: parts.parts_manufacturers | type: TABLE --
-- DROP TABLE IF EXISTS parts.parts_manufacturers CASCADE;
CREATE TABLE parts.parts_manufacturers (
	manufacturer_id text NOT NULL,
	manufacturer parts.manufacturers NOT NULL,
	id_parts bigint NOT NULL,
	CONSTRAINT parts_manufacturers_pk PRIMARY KEY (manufacturer_id,manufacturer)

);
-- ddl-end --
COMMENT ON COLUMN parts.parts_manufacturers.manufacturer_id IS E'is the id/name of the manufacturer and could be identical to parts.name';
-- ddl-end --
ALTER TABLE parts.parts_manufacturers OWNER TO postgres;
-- ddl-end --

-- object: public.view_parts_parts_a_manufacturers | type: VIEW --
-- DROP VIEW IF EXISTS public.view_parts_parts_a_manufacturers CASCADE;
CREATE VIEW public.view_parts_parts_a_manufacturers
AS 

SELECT parts.id AS part_id,
    parts.name AS part_name,
    parts.description AS part_description,
    parts.weight AS part_weight,
    parts.type AS part_type,
    parts_manufacturers.manufacturer AS part_manufacturer,
    parts_manufacturers.manufacturer_id AS part_manufacturer_id,
    parts.id_3d_models AS id_3d_model
   FROM (parts.parts
     LEFT JOIN parts.parts_manufacturers ON ((parts.id = parts_manufacturers.id_parts)))
  WHERE ((parts_manufacturers.id_parts IS NULL) OR (parts.id = parts_manufacturers.id_parts));
-- ddl-end --
ALTER VIEW public.view_parts_parts_a_manufacturers OWNER TO postgres;
-- ddl-end --

-- object: public.view_parts_parts | type: VIEW --
-- DROP VIEW IF EXISTS public.view_parts_parts CASCADE;
CREATE VIEW public.view_parts_parts
AS 

SELECT parts.id AS part_id,
    parts.name AS part_name,
    parts.description AS part_description,
    parts.weight AS part_weight,
    parts.type AS part_type,
    parts.id_3d_models AS id_3d_model
   FROM parts.parts;
-- ddl-end --
ALTER VIEW public.view_parts_parts OWNER TO postgres;
-- ddl-end --

-- object: parts.unknown_parts | type: TABLE --
-- DROP TABLE IF EXISTS parts.unknown_parts CASCADE;
CREATE TABLE parts.unknown_parts (
	id_parts bigint NOT NULL,
	CONSTRAINT "parts-type-check" CHECK ((parts.get_parts_type(id_parts) = 'unknown'::parts.types_enum)),
	CONSTRAINT unknown_parts_pk PRIMARY KEY (id_parts),
	CONSTRAINT unknown_parts_uq UNIQUE (id_parts)

);
-- ddl-end --
COMMENT ON TABLE parts.unknown_parts IS E'These are the propety of the parts';
-- ddl-end --
COMMENT ON CONSTRAINT "parts-type-check" ON parts.unknown_parts  IS E'this cheks if the part is set as unknown in parts';
-- ddl-end --
ALTER TABLE parts.unknown_parts OWNER TO postgres;
-- ddl-end --

-- object: public.view_parts_unknown_parts | type: VIEW --
-- DROP VIEW IF EXISTS public.view_parts_unknown_parts CASCADE;
CREATE VIEW public.view_parts_unknown_parts
AS 

SELECT parts.id AS part_id,
    parts.name AS part_name,
    parts.description AS part_description,
    parts.weight AS part_weight,
    parts.type AS part_type,
    unknown_parts.id_parts AS id_u_parts,
    parts.id_3d_models AS id_3d_model
   FROM (parts.parts
     LEFT JOIN parts.unknown_parts ON ((parts.id = unknown_parts.id_parts)));
-- ddl-end --
ALTER VIEW public.view_parts_unknown_parts OWNER TO postgres;
-- ddl-end --

-- object: public.view_parts_unknown_parts_a_manufacturers | type: VIEW --
-- DROP VIEW IF EXISTS public.view_parts_unknown_parts_a_manufacturers CASCADE;
CREATE VIEW public.view_parts_unknown_parts_a_manufacturers
AS 

SELECT parts.id AS part_id,
    parts.name AS part_name,
    parts.description AS part_description,
    parts.weight AS part_weight,
    parts.type AS part_type,
    parts_manufacturers.manufacturer AS part_manufacturer,
    parts_manufacturers.manufacturer_id AS part_manufacturer_id,
    unknown_parts.id_parts AS id_u_parts,
    parts.id_3d_models AS id_3d_model
   FROM ((parts.parts
     LEFT JOIN parts.parts_manufacturers ON ((parts.id = parts_manufacturers.id_parts)))
     LEFT JOIN parts.unknown_parts ON ((parts.id = unknown_parts.id_parts)));
-- ddl-end --
ALTER VIEW public.view_parts_unknown_parts_a_manufacturers OWNER TO postgres;
-- ddl-end --

-- object: public.view_parts_documantations | type: VIEW --
-- DROP VIEW IF EXISTS public.view_parts_documantations CASCADE;
CREATE VIEW public.view_parts_documantations
AS 

SELECT documantations.location AS documantations_location,
    documantations.id_parts AS part_id,
    documantations.name AS documantation_name,
    documantations.description AS documantations_description
   FROM parts.documantations;
-- ddl-end --
ALTER VIEW public.view_parts_documantations OWNER TO postgres;
-- ddl-end --

-- object: public.view_parts_images | type: VIEW --
-- DROP VIEW IF EXISTS public.view_parts_images CASCADE;
CREATE VIEW public.view_parts_images
AS 

SELECT images.image_id,
    images.id_parts AS part_id,
    images.image
   FROM parts.images;
-- ddl-end --
ALTER VIEW public.view_parts_images OWNER TO postgres;
-- ddl-end --

-- object: public.view_parts_manufacturers | type: VIEW --
-- DROP VIEW IF EXISTS public.view_parts_manufacturers CASCADE;
CREATE VIEW public.view_parts_manufacturers
AS 

SELECT parts_manufacturers.id_parts AS part_id,
    parts_manufacturers.manufacturer AS part_manufacturer,
    parts_manufacturers.manufacturer_id AS part_manufacturer_id
   FROM parts.parts_manufacturers;
-- ddl-end --
ALTER VIEW public.view_parts_manufacturers OWNER TO postgres;
-- ddl-end --

-- object: assemblies.assemblies | type: TABLE --
-- DROP TABLE IF EXISTS assemblies.assemblies CASCADE;
CREATE TABLE assemblies.assemblies (
	name text NOT NULL,
	description text,
	git_project text,
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
	"3d_model" bytea NOT NULL,
	CONSTRAINT "3d_models_pk" PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE parts."3d_models" IS E'here are the images of the part saved';
-- ddl-end --
COMMENT ON COLUMN parts."3d_models"."3d_model" IS E'the image';
-- ddl-end --
ALTER TABLE parts."3d_models" OWNER TO postgres;
-- ddl-end --

-- object: public.view_parts_3d_models | type: VIEW --
-- DROP VIEW IF EXISTS public.view_parts_3d_models CASCADE;
CREATE VIEW public.view_parts_3d_models
AS 

SELECT "3d_models".id AS id_3d_model,
    "3d_models"."3d_model"
   FROM parts."3d_models";
-- ddl-end --
ALTER VIEW public.view_parts_3d_models OWNER TO postgres;
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
	id_parts bigint NOT NULL,
	library_footprints text NOT NULL,
	footprint_footprints text NOT NULL,
	library_symbols text NOT NULL,
	symbol_symbols text NOT NULL
);
-- ddl-end --
ALTER TABLE kicad.parts OWNER TO postgres;
-- ddl-end --

-- object: public.view_storage_storage_boxes | type: VIEW --
-- DROP VIEW IF EXISTS public.view_storage_storage_boxes CASCADE;
CREATE VIEW public.view_storage_storage_boxes
AS 

SELECT storage_boxes.id AS box_id,
    storage_boxes.id_parts AS part_id,
    storage_boxes.size AS box_size,
    storage_boxes.stock AS stocke
   FROM storage.storage_boxes;
-- ddl-end --
ALTER VIEW public.view_storage_storage_boxes OWNER TO postgres;
-- ddl-end --

-- object: public.view_storage_big_storage_places | type: VIEW --
-- DROP VIEW IF EXISTS public.view_storage_big_storage_places CASCADE;
CREATE VIEW public.view_storage_big_storage_places
AS 

SELECT big_storage_places.id AS big_storage_place_id,
    big_storage_places.id_storage_boxes,
    big_storage_places.cabinet AS big_storage_place_cabinet,
    big_storage_places.drawer AS big_storage_place_drawer,
    big_storage_places.drawer_place_row AS big_storage_place_drawer_place_row,
    big_storage_places.drawer_place_column AS big_storage_place_drawer_place_column
   FROM storage.big_storage_places;
-- ddl-end --
ALTER VIEW public.view_storage_big_storage_places OWNER TO postgres;
-- ddl-end --

-- object: public.view_storage_storage_boxes_a_big_storage_places | type: VIEW --
-- DROP VIEW IF EXISTS public.view_storage_storage_boxes_a_big_storage_places CASCADE;
CREATE VIEW public.view_storage_storage_boxes_a_big_storage_places
AS 

SELECT storage_boxes.id AS box_id,
    storage_boxes.id_parts AS part_id,
    storage_boxes.size AS box_size,
    storage_boxes.stock AS stocke,
    big_storage_places.id AS big_storage_place_id,
    big_storage_places.cabinet AS big_storage_place_cabinet,
    big_storage_places.drawer AS big_storage_place_drawer,
    big_storage_places.drawer_place_row AS big_storage_place_drawer_place_row,
    big_storage_places.drawer_place_column AS big_storage_place_drawer_place_column
   FROM (storage.storage_boxes
     LEFT JOIN storage.big_storage_places ON ((storage_boxes.id = big_storage_places.id_storage_boxes)));
-- ddl-end --
ALTER VIEW public.view_storage_storage_boxes_a_big_storage_places OWNER TO postgres;
-- ddl-end --

-- object: public.view_kicad_footprints | type: VIEW --
-- DROP VIEW IF EXISTS public.view_kicad_footprints CASCADE;
CREATE VIEW public.view_kicad_footprints
AS 

SELECT footprints.library AS kicad_footprint_library,
    footprints.footprint AS kicad_footprint
   FROM kicad.footprints;
-- ddl-end --
ALTER VIEW public.view_kicad_footprints OWNER TO postgres;
-- ddl-end --

-- object: public.view_kicad_symbols | type: VIEW --
-- DROP VIEW IF EXISTS public.view_kicad_symbols CASCADE;
CREATE VIEW public.view_kicad_symbols
AS 

SELECT symbols.library AS kicad_symbol_library,
    symbols.symbol AS kicad_symbol
   FROM kicad.symbols;
-- ddl-end --
ALTER VIEW public.view_kicad_symbols OWNER TO postgres;
-- ddl-end --

-- object: public.view_kicad_parts | type: VIEW --
-- DROP VIEW IF EXISTS public.view_kicad_parts CASCADE;
CREATE VIEW public.view_kicad_parts
AS 

SELECT parts.id_parts AS part_id,
    footprints.library AS kicad_footprint_library,
    footprints.footprint AS kicad_footprint,
    symbols.library AS kicad_symbol_library,
    symbols.symbol AS kicad_symbol
   FROM ((kicad.parts
     JOIN kicad.footprints ON (((parts.library_footprints = footprints.library) AND (parts.footprint_footprints = footprints.footprint))))
     JOIN kicad.symbols ON (((parts.library_symbols = symbols.library) AND (parts.symbol_symbols = symbols.symbol))));
-- ddl-end --
ALTER VIEW public.view_kicad_parts OWNER TO postgres;
-- ddl-end --

-- object: public.view_assemblies_assemblies | type: VIEW --
-- DROP VIEW IF EXISTS public.view_assemblies_assemblies CASCADE;
CREATE VIEW public.view_assemblies_assemblies
AS 

SELECT assemblies.name AS assembly_name,
    assemblies.description AS assembly_description,
    assemblies.git_project AS assembly_git_project
   FROM assemblies.assemblies;
-- ddl-end --
ALTER VIEW public.view_assemblies_assemblies OWNER TO postgres;
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
CREATE  LANGUAGE plpython3u
	HANDLER pg_catalog.plpython3_call_handler
VALIDATOR pg_catalog.plpython3_validator
INLINE pg_catalog.plpython3_inline_handler;
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

-- object: parts."<base>_parts" | type: TABLE --
-- DROP TABLE IF EXISTS parts."<base>_parts" CASCADE;
CREATE TABLE parts."<base>_parts" (
	id_parts bigint NOT NULL,
	CONSTRAINT "parts-type-check" CHECK ((parts.get_parts_type(id_parts) = '<base>'::parts.types_enum)),
	CONSTRAINT "<base>_parts_pk" PRIMARY KEY (id_parts),
	CONSTRAINT "<base>_parts_uq" UNIQUE (id_parts)

);
-- ddl-end --
COMMENT ON TABLE parts."<base>_parts" IS E'These are the propety of the parts';
-- ddl-end --
COMMENT ON CONSTRAINT "parts-type-check" ON parts."<base>_parts"  IS E'this cheks if the part is set as <base> in parts';
-- ddl-end --
ALTER TABLE parts."<base>_parts" OWNER TO postgres;
-- ddl-end --

-- object: public."view_parts_<base>_parts_a_manufacturers" | type: VIEW --
-- DROP VIEW IF EXISTS public."view_parts_<base>_parts_a_manufacturers" CASCADE;
CREATE VIEW public."view_parts_<base>_parts_a_manufacturers"
AS 

SELECT parts.id AS part_id,
    parts.name AS part_name,
    parts.description AS part_description,
    parts.weight AS part_weight,
    parts.type AS part_type,
    parts_manufacturers.manufacturer AS part_manufacturer,
    parts_manufacturers.manufacturer_id AS part_manufacturer_id,
    <base>_parts.id_parts AS id_u_parts,
	<base_par>,
    parts.id_3d_models AS id_3d_model
   FROM ((parts.parts
     LEFT JOIN parts.parts_manufacturers ON ((parts.id = parts_manufacturers.id_parts)))
     LEFT JOIN parts.<base>_parts ON ((parts.id = <base>_parts.id_parts)));
-- ddl-end --
ALTER VIEW public."view_parts_<base>_parts_a_manufacturers" OWNER TO postgres;
-- ddl-end --

-- object: public.view_parts_unknown_parts_cp | type: VIEW --
-- DROP VIEW IF EXISTS public.view_parts_unknown_parts_cp CASCADE;
CREATE VIEW public.view_parts_unknown_parts_cp
AS 

SELECT parts.id AS part_id,
    parts.name AS part_name,
    parts.description AS part_description,
    parts.weight AS part_weight,
    parts.type AS part_type,
    <base>_parts.id_parts AS id_u_parts,
	<base_par>,
    parts.id_3d_models AS id_3d_model
   FROM (parts.parts
     LEFT JOIN parts.<base>_parts ON ((parts.id = <base>_parts.id_parts)));
-- ddl-end --
ALTER VIEW public.view_parts_unknown_parts_cp OWNER TO postgres;
-- ddl-end --

-- object: "3d_models_fk" | type: CONSTRAINT --
-- ALTER TABLE parts.parts DROP CONSTRAINT IF EXISTS "3d_models_fk" CASCADE;
ALTER TABLE parts.parts ADD CONSTRAINT "3d_models_fk" FOREIGN KEY (id_3d_models)
REFERENCES parts."3d_models" (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
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

-- object: storage_boxes_fk | type: CONSTRAINT --
-- ALTER TABLE storage.big_storage_places DROP CONSTRAINT IF EXISTS storage_boxes_fk CASCADE;
ALTER TABLE storage.big_storage_places ADD CONSTRAINT storage_boxes_fk FOREIGN KEY (id_storage_boxes)
REFERENCES storage.storage_boxes (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: parts_fk | type: CONSTRAINT --
-- ALTER TABLE storage.storage_boxes DROP CONSTRAINT IF EXISTS parts_fk CASCADE;
ALTER TABLE storage.storage_boxes ADD CONSTRAINT parts_fk FOREIGN KEY (id_parts)
REFERENCES parts.parts (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: parts_fk | type: CONSTRAINT --
-- ALTER TABLE parts.parts_manufacturers DROP CONSTRAINT IF EXISTS parts_fk CASCADE;
ALTER TABLE parts.parts_manufacturers ADD CONSTRAINT parts_fk FOREIGN KEY (id_parts)
REFERENCES parts.parts (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: parts_fk | type: CONSTRAINT --
-- ALTER TABLE parts.unknown_parts DROP CONSTRAINT IF EXISTS parts_fk CASCADE;
ALTER TABLE parts.unknown_parts ADD CONSTRAINT parts_fk FOREIGN KEY (id_parts)
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

-- object: footprints_fk | type: CONSTRAINT --
-- ALTER TABLE kicad.parts DROP CONSTRAINT IF EXISTS footprints_fk CASCADE;
ALTER TABLE kicad.parts ADD CONSTRAINT footprints_fk FOREIGN KEY (library_footprints,footprint_footprints)
REFERENCES kicad.footprints (library,footprint) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: symbols_fk | type: CONSTRAINT --
-- ALTER TABLE kicad.parts DROP CONSTRAINT IF EXISTS symbols_fk CASCADE;
ALTER TABLE kicad.parts ADD CONSTRAINT symbols_fk FOREIGN KEY (library_symbols,symbol_symbols)
REFERENCES kicad.symbols (library,symbol) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: parts_fk | type: CONSTRAINT --
-- ALTER TABLE parts."<base>_parts" DROP CONSTRAINT IF EXISTS parts_fk CASCADE;
ALTER TABLE parts."<base>_parts" ADD CONSTRAINT parts_fk FOREIGN KEY (id_parts)
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


