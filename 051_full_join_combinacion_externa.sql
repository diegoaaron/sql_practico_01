/*
Vimos que un "left join" encuentra registros de la tabla izquierda que se correspondan con los registros de la tabla derecha 
y si un valor de la tabla izquierda no se encuentra en la tabla derecha, el registro muestra los campos correspondientes a 
la tabla de la derecha seteados a "null". Aprendimos también que un "right join" opera del mismo modo sólo que la tabla 
derecha es la que localiza los registros en la tabla izquierda.

Una combinación externa completa ("full outer join" o "full join") retorna todos los registros de ambas tablas. Si un registro de 
una tabla izquierda no encuentra coincidencia en la tabla derecha, las columnas correspondientes a campos de la tabla 
derecha aparecen seteadas a "null", y si la tabla de la derecha no encuentra correspondencia en la tabla izquierda, los campos 
de esta última aparecen conteniendo "null".

Veamos un ejemplo:

select titulo,nombre
from editoriales e
full join libros l
on codigoeditorial = e.codigo;

La salida del "full join" precedente muestra todos los registros de ambas tablas, incluyendo los libros cuyo código de 
editorial no existe en la tabla "editoriales" y las editoriales de las cuales no hay correspondencia en "libros".
*/