/*
Una vista materializada se define como una vista com�n, pero en lugar de almacenar la definici�n de la vista, almacena 
el resultado de la consulta, es decir, la materializa, como un objeto persistente en la base de datos.

Sintaxis:

 create materialized view NOMBREVISTAMATERIALIZADA
  as SUBCONSULTA;

Existen varias cl�usulas que podemos agregar al crear una vista materializada, pero no las estudiaremos.

En el "from" de la consulta pueden listarse tablas, vistas y vistas materializadas.

Entonces, una vista materializada almacena su resultado f�sicamente. Una vista materializada (materialized view) es 
una instant�nea (snapshot), son sin�nimos.

Para obtener informaci�n acerca de las vistas materializadas podemos consultar el diccionario "user_objects", en la 
columna "object_type" aparecer� "materialized view" si es una vista materializada. Ejemplo:

 select *from user_objects where object_type='MATERIALIZED VIEW';
 
Tambi�n podemos consultar "user_mviews" para obtener informaci�n de todas las vistas materializadas del usuario actual:

 select *from user_mviews;
 
Este diccionario muestra mucha informaci�n que no explicaremos en detalle.

Para eliminar una vista materializada empleamos "drop materialized view":

 drop materialized view NOMBREVISTAMATERIALIZADA;
 
Ejemplo:

drop materialized view vm_promedios;

No se permite realizar "insert", "update" ni "delete" en las vistas materializadas.
*/