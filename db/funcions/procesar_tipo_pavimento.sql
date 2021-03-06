BEGIN;

-- definition
DROP TABLE IF EXISTS inventario.tipo_pavimento;
CREATE TABLE inventario.tipo_pavimento (
       gid serial,
       codigo_carretera text,
       codigo_municipio text,
       tramo text,
       pk_inicial float,
       pk_final float,
       longitud integer,
       fecha_actualizacion date,
       valor text,
       observaciones text,
       PRIMARY KEY (gid),
       FOREIGN KEY (codigo_carretera) REFERENCES inventario.carreteras (numero)
               ON DELETE CASCADE
               ON UPDATE CASCADE
);

-- populate it
INSERT INTO inventario.tipo_pavimento(
       SELECT nextval('inventario.tipo_pavimento_gid_seq') AS gid,
              "numero_inv" AS codigo_carretera,
              to_char("cod_mun_lu", 'FM99999') AS codigo_municipio,
              "tramo" AS tramo,
              "pk_ini" AS pk_inicial,
              "pk_fin" AS pk_final,
              "longitud_t" AS longitud,
              '2012-06-01' AS fecha_actualizacion,
              "tipo_de_pa" AS valor,
              "observacio" AS observaciones
       FROM inventario.tipo_pavimento_tmp
);

DROP TABLE IF EXISTS inventario.tipo_pavimento_tmp;

-- linear referencing
SELECT AddGeometryColumn('inventario', 'tipo_pavimento', 'the_geom', '25829', 'MULTILINESTRINGM', 3);
ALTER TABLE inventario.tipo_pavimento DROP CONSTRAINT enforce_geotype_the_geom;
SELECT inventario.update_geom_line_all('inventario', 'tipo_pavimento');

-- indexes
CREATE INDEX tipo_pavimento_the_geom
       ON inventario.tipo_pavimento USING GIST(the_geom);
CREATE INDEX tipo_pavimento_codigo_carretera
       ON inventario.tipo_pavimento USING BTREE(codigo_carretera);
CREATE INDEX tipo_pavimento_codigo_municipio
       ON inventario.tipo_pavimento USING BTREE(codigo_municipio);
CREATE INDEX tipo_pavimento_codigo_carretera_concello
       ON inventario.tipo_pavimento USING BTREE(codigo_carretera, codigo_municipio);

-- triggers
DROP TRIGGER IF EXISTS update_geom_tipo_pavimento ON inventario.tipo_pavimento;
CREATE TRIGGER update_geom_tipo_pavimento
       BEFORE UPDATE OR INSERT
       ON inventario.tipo_pavimento FOR EACH ROW
       EXECUTE PROCEDURE inventario.update_geom_line_on_pk_change();

DROP TRIGGER IF EXISTS update_longitud ON inventario.tipo_pavimento;
CREATE TRIGGER update_longitud
       BEFORE UPDATE OR INSERT
       ON inventario.tipo_pavimento FOR EACH ROW
       EXECUTE PROCEDURE inventario.update_longitud();

COMMIT;
