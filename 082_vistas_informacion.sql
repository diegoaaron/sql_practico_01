/*
Las vistas son objetos, as� que para obtener informaci�n de ellos pueden consultarse los siguientes cat�logos.

"user_catalog" nos muestra todos los objetos del usuario actual, incluidas las vistas. En la columna "table_type" aparece 
"view" si es una vista. Ejemplo:

 select * from user_catalog where table_type='VIEW';
 
"user_objects" nos muestra informaci�n sobre todos los objetos del usuario actual. En la columna "OBJECT_TYPE" 
muestra "view" si es una vista, aparece la fecha de creaci�n y dem�s informaci�n que no analizaremos por el momento.

Para ver todos los objetos del usuario actual que son vistas tipeamos:

 select * from user_objects where object_type='VIEW';
 
"user_views" nos muestra informaci�n referente a todas las vistas del usuario actual, el nombre de la vista, la longitud 
del texto, el texto que la define, etc.

Con la siguiente sentencia obtenemos informaci�n sobre todas las vistas cuyo nombre comience con la cadena "VISTA":

 select * from user_views where view_name like 'VISTA%';
*/
