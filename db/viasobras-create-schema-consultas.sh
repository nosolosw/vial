#!/bin/bash

config_file=$1
. $config_file

# Queries
# -------

psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname < funcions/create_schema_consultas.sql

psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname < funcions/preprocesar_consultas.sql

#COPY command needs absolute path

sql_query_path=`pwd`/funcions/consultas/c01-carreteras-general.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/c10-carreteras-anchofirme.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/c20-carreteras-tipofirme.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/c21-carreteras-tipofirme-mb.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/c22-carreteras-tipofirme-ts.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/c30-carreteras-aforos.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/c40-carreteras-cotas.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/c02-carreteras-categoria.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/c31-carreteras-aforos-ancho-menor-5.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/c32-carreteras-aforos-ancho-entre-5-y-7.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/c33-carreteras-aforos-ancho-mayor-7.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/c34-carreteras-aforos-tipopavimento-ts.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/c35-carreteras-aforos-tipopavimento-mb.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/c36-carreteras-aforos-tipopavimento-h.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/c37-carreteras-aforos-tipopavimento-o.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/c41-carreteras-cotas-minima-maxima.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/c38-aforos-agregados.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/c03-rampas-general.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/c04-tramos-antiguos-general.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/c50-accidentes.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/c51-accidentes-por-tipo.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/c52-accidentes-agregados.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

#CONSULTAS ACTUACIONES

sql_query_path=`pwd`/funcions/consultas/actuaciones/c01-listado-accidentes-tipo.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/actuaciones/c02-carreteras-mas-10-accidentes.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/actuaciones/c10-listado-autorizaciones-tipo.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/actuaciones/c11-listado-autorizaciones-peticionario.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/actuaciones/c12-listado-autorizaciones-beneficiario.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/actuaciones/c13-tasas-recaudadas.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/actuaciones/c20-listado-conservacion-tipo.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/actuaciones/c21-importe-economico-total.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/actuaciones/c22-listado-conservacion-fecha-inicio.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/actuaciones/c23-listado-conservacion-fecha-fin.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/actuaciones/c30-listado-propuesta-conservacion-tipo.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/actuaciones/c31-importe-economico-total.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/actuaciones/c40-listado-construccion-tipo.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/actuaciones/c41-importe-economico-total.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/actuaciones/c50-listado-denuncias-fecha-denuncia.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/actuaciones/c51-listado-denuncias-fecha-resolucion.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/actuaciones/c52-listado-denuncias-importe-igual-a.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/actuaciones/c53-listado-denuncias-importe-mayor-que.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/actuaciones/c54-listado-denuncias-importe-menor-que.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/actuaciones/c60-listado-incidencias-deteccion.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/actuaciones/c61-listado-incidencias-resolucion.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/actuaciones/c70-listado-inventario-tipo.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/actuaciones/c80-listado-travesias-tipo-suelo.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/actuaciones/c81-listado-travesias-nucleo-poblacion.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

sql_query_path=`pwd`/funcions/consultas/actuaciones/c90-listado-vialidad.sql
sql_query="\COPY public.consultas_sql (sql_string) FROM '$sql_query_path' WITH DELIMITER ':'"
psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname -c "$sql_query"

psql -h $viasobras_server -p $viasobras_port -U $viasobras_user \
    $viasobras_dbname < funcions/postprocesar_consultas.sql
