/*
Una vista materializada se define como una vista común, pero en lugar de almacenar la definición de la vista, almacena 
el resultado de la consulta, es decir, la materializa, como un objeto persistente en la base de datos.

Sintaxis:

 create materialized view NOMBREVISTAMATERIALIZADA
  as SUBCONSULTA;

Existen varias cláusulas que podemos agregar al crear una vista materializada, pero no las estudiaremos.

En el "from" de la consulta pueden listarse tablas, vistas y vistas materializadas.

Entonces, una vista materializada almacena su resultado físicamente. Una vista materializada (materialized view) es 
una instantánea (snapshot), son sinónimos.

Para obtener información acerca de las vistas materializadas podemos consultar el diccionario "user_objects", en la 
columna "object_type" aparecerá "materialized view" si es una vista materializada. Ejemplo:

 select *from user_objects where object_type='MATERIALIZED VIEW';
 
También podemos consultar "user_mviews" para obtener información de todas las vistas materializadas del usuario actual:

 select *from user_mviews;
 
Este diccionario muestra mucha información que no explicaremos en detalle.

Para eliminar una vista materializada empleamos "drop materialized view":

 drop materialized view NOMBREVISTAMATERIALIZADA;
 
Ejemplo:

drop materialized view vm_promedios;

No se permite realizar "insert", "update" ni "delete" en las vistas materializadas.
*/