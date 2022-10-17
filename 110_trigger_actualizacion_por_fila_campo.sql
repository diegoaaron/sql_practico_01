/*
El trigger de actualización (a nivel de sentencia o de fila) permite incluir una lista de campos. Si se incluye el nombre de 
un campo (o varios) luego de "update", el trigger se disparará únicamente cuando alguno de esos campos (incluidos en 
la lista) es actualizado. Si se omite la lista de campos, el trigger se dispara cuando cualquier campo de la tabla asociada 
es modificado, es decir, por defecto toma todos los campos de la tabla.

La lista de campos solamente puede especificarse en disparadores de actualización, nunca en disparadores de inserción 
o borrado.

Sintaxis general:

 create or replace trigger NOMBREDISPARADOR
  MOMENTO update of CAMPOS
  on TABLA
  NIVEL--statement o for each row
 begin
  CUERPODEL DISPARADOR;
 end NOMBREDISPARADOR;
 /
 
"CAMPOS" son los campos de la tabla asociada que activarán el trigger si son modificados. Pueden incluirse más de uno, 
en tal caso, se separan con comas.

Creamos un desencadenador a nivel de fila que se dispara cada vez que se actualiza el campo "precio" de la tabla "libros":

 create or replace trigger tr_actualizar_precio_libros
  before update of precio
  on libros
  for each row
 begin
  insert into control values(user,sysdate);
 end tr_actualizar_precio_libros;
 /
 
Si realizamos un "update" sobre el campo "precio" de "libros", el trigger se dispara. Pero si realizamos un "update" 
sobre cualquier otro campo, el trigger no se dispara, ya que está definido solamente para el campo "precio".
*/





