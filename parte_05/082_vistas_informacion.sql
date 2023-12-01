/*
Las vistas son objetos, así que para obtener información de ellos pueden consultarse los siguientes catálogos.

"user_catalog" nos muestra todos los objetos del usuario actual, incluidas las vistas. En la columna "table_type" aparece 
"view" si es una vista. Ejemplo:

 select * from user_catalog where table_type='VIEW';
 
"user_objects" nos muestra información sobre todos los objetos del usuario actual. En la columna "OBJECT_TYPE" 
muestra "view" si es una vista, aparece la fecha de creación y demás información que no analizaremos por el momento.

Para ver todos los objetos del usuario actual que son vistas tipeamos:

 select * from user_objects where object_type='VIEW';
 
"user_views" nos muestra información referente a todas las vistas del usuario actual, el nombre de la vista, la longitud 
del texto, el texto que la define, etc.

Con la siguiente sentencia obtenemos información sobre todas las vistas cuyo nombre comience con la cadena "VISTA":

 select * from user_views where view_name like 'VISTA%';
*/
