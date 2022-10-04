/*
Con la cláusula "with read only" (sólo lectura) evitamos que se puedan realizar inserciones, actualizaciones y eliminaciones 
mediante una vista.

Sintaxis:

 create view NOMBREVISTA
 as SUBCONSULTA
 with read only;

Evitamos que Oracle acepte "insert", "update" o "delete" sobre la vista si colocamos "with read only" luego de la subconsulta 
que define una vista.

Por ejemplo, creamos la siguiente vista:

 create view vista_empleados
 as
  select apellido, nombre, sexo, seccion
  from empleados
  with read only;

Oracle responde con un mensaje de error ante cualquier "insert", "update" o "delete" realizado sobre la vista.
*/

