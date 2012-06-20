#!/bin/bash

. db_config

dropdb -h $viasobras_server -p $viasobras_port -U $viasobras_pguser $viasobras_dbname;
createdb -h $viasobras_server -p $viasobras_port -U $viasobras_pguser -O $viasobras_pguser \
    -T $viasobras_template $viasobras_dbname;

# Info base
# ---------

psql -h $viasobras_server -p $viasobras_port -U $viasobras_pguser \
    $viasobras_dbname < funcions/create_schema_infobase.sql
psql -h $viasobras_server -p $viasobras_port -U $viasobras_pguser \
    $viasobras_dbname < datos/info_base/concellos.sql
psql -h $viasobras_server -p $viasobras_port -U $viasobras_pguser \
    $viasobras_dbname < datos/info_base/nucleos.sql

# Inventario
# ----------

psql -h $viasobras_server -p $viasobras_port -U $viasobras_pguser \
    $viasobras_dbname < funcions/create_schema_inventario.sql
psql -h $viasobras_server -p $viasobras_port -U $viasobras_pguser \
    $viasobras_dbname < datos/inventario/rede_carreteras.sql
psql -h $viasobras_server -p $viasobras_port -U $viasobras_pguser \
    $viasobras_dbname < datos/inventario/accidentes.sql

# Import functions
psql -h $viasobras_server -p $viasobras_port -U $viasobras_pguser \
    $viasobras_dbname < funcions/update_geom_tipo_pavimento.sql
psql -h $viasobras_server -p $viasobras_port -U $viasobras_pguser \
    $viasobras_dbname < funcions/update_geom_ancho_plataforma.sql
psql -h $viasobras_server -p $viasobras_port -U $viasobras_pguser \
    $viasobras_dbname < funcions/trigger_update_geom_tipo_pavimento.sql
psql -h $viasobras_server -p $viasobras_port -U $viasobras_pguser \
    $viasobras_dbname < funcions/trigger_update_geom_ancho_plataforma.sql

# Post-procesado to create final tables from aforos.sql & inventario.sql
psql -h $viasobras_server -p $viasobras_port -U $viasobras_pguser \
    $viasobras_dbname < datos/inventario/aforos.sql
psql -h $viasobras_server -p $viasobras_port -U $viasobras_pguser \
   $viasobras_dbname < funcions/procesar_aforos.sql
psql -h $viasobras_server -p $viasobras_port -U $viasobras_pguser \
    $viasobras_dbname < datos/inventario/inventario.sql

# Import from CSV aux data to process inventario
csv_path=`pwd`/datos/inventario/municipio_codigo.csv #COPY command needs absolute path
sql_query="\COPY inventario.municipio_codigo (nombre, codigo) FROM '$csv_path' WITH DELIMITER ','"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_pguser \
    $viasobras_dbname -c "$sql_query"

psql -h $viasobras_server -p $viasobras_port -U $viasobras_pguser \
   $viasobras_dbname < funcions/procesar_inventario.sql

# Import from CSV link data between carreteras-concellos
csv_path=`pwd`/datos/inventario/carreteras_concellos.csv #COPY command needs absolute path
sql_query="\COPY inventario.carreteras_concellos (codigo_carretera, codigo_concello) FROM '$csv_path' WITH DELIMITER ','"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_pguser \
    $viasobras_dbname -c "$sql_query"

# Linear referencing: calibrate road, event points & dynamic segmentation
psql -h $viasobras_server -p $viasobras_port -U $viasobras_pguser \
    $viasobras_dbname < funcions/calibrate_carreteras.sql
psql -h $viasobras_server -p $viasobras_port -U $viasobras_pguser \
    $viasobras_dbname < funcions/create_accidentes_event_points.sql
psql -h $viasobras_server -p $viasobras_port -U $viasobras_pguser \
    $viasobras_dbname < funcions/create_aforos_event_points.sql
psql -h $viasobras_server -p $viasobras_port -U $viasobras_pguser \
    $viasobras_dbname < funcions/create_dynamic_segments_from_inventario.sql

#Create triggers
psql -h $viasobras_server -p $viasobras_port -U $viasobras_pguser \
    $viasobras_dbname < funcions/create_triggers.sql


# Grant permissions
# -----------------

psql -h $viasobras_server -p $viasobras_port -U $viasobras_pguser \
    $viasobras_dbname -c "GRANT ALL PRIVILEGES ON DATABASE $viasobras_dbname TO $viasobras_pguser;"
