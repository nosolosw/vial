SELECT mun_cod.nombre AS "Municipio", \
       actuaciones.codigo_carretera AS "Código (LU-P)", \
       actuaciones.pk_inicial AS "PK  inicial", \
       actuaciones.pk_final AS "PK  final", \
       actuaciones.codigo_actuacion AS "Código actuación", \
       COALESCE(actuaciones.incidencia_tipo, '') AS "Tipo", \
       COALESCE(actuaciones.incidencia_lugar, '') AS "Lugar", \
       COALESCE(actuaciones.incidencia_comunicante, '') AS "Comunicante", \
       actuaciones.incidencia_deteccion_fecha AS "Fecha detección", \
       COALESCE(actuaciones.incidencia_contratista_nombre, '') AS "Contratista", \
       COALESCE(actuaciones.incidencia_contacto, '') AS "Contacto", \
       actuaciones.incidencia_resolucion_fecha AS "Fecha resolución", \
       COALESCE(actuaciones.incidencia_observaciones, '') AS "Observaciones" \
FROM inventario.actuaciones actuaciones, \
     inventario.actuacion_municipio act_mun, \
     inventario.municipio_codigo mun_cod, \
     inventario.carreteras carreteras \
WHERE actuaciones.codigo_actuacion = act_mun.codigo_actuacion AND \
      act_mun.codigo_municipio = mun_cod.codigo AND \
      actuaciones.codigo_carretera = carreteras.numero AND \
      actuaciones.tipo = 'Incidencia' \
[[WHERE]];
