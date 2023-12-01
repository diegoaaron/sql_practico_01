/*
Los triggers son objetos, así que para obtener información de ellos pueden consultarse los siguientes diccionarios:

.
- "user_objects": nos muestra todos los objetos de la base de datos seleccionada, incluidos los triggers. En la columna 
"object_type" aparece "trigger" si es un disparador. En el siguiente ejemplo solicitamos todos los objetos que son disparadores:

 select *from user_objects where object_type='TRIGGER';

- "user_triggers": nos muestra todos los triggers de la base de datos actual. Muestra el nombre del desencadenador 
(trigger_name), si es before o after y si es a nivel de sentencia o por fila (trigger_type), el evento que lo desencadena 
(triggering_event), a qué objeto está asociado, si tabla o vista (base_object_type), el nombre de la tabla al que está 
asociado (table_name), los campos, si hay referencias, el estado, la descripción, el cuerpo (trigger_body), etc. En el 
siguiente ejemplo solicitamos información de todos los disparadores que comienzan con "TR":

 select trigger_name, triggering_event from user_triggers where trigger_name like 'TR%';
 
- "user_source": se puede visualizar el código fuente almacenado en un disparador consultando este diccionario: En el 
siguiente ejemplo solicitamos el código fuente del objeto "TR_insertar_libros":

 select *from user_source where name='TR_INSERTAR_LIBROS';
*/
