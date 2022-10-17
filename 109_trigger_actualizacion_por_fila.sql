/*
Vimos la creación de un disparador para el evento de actualización a nivel de sentencia, es decir, se dispara una vez por 
cada sentencia "update" sobre la tabla asociada.

En caso que una sola sentencia "update" modifique varios registros en la tabla asociada, el trigger se disparará una sola 
vez; si queremos que se active una vez por cada registro afectado, debemos indicarlo con "for each row".

La siguiente es la sintaxis para crear un trigger de actualización a nivel de fila, se dispare una vez por cada fila modificada 
sobre la tabla especificada:

 create or replace trigger NOMBREDISPARADOR
  MOMENTO update
  on NOMBRETABLA
  for each row
  begin
   CUERPO DEL TRIGGER;
  end NOMBREDISPARADOR;
  /
  
Creamos un desencadenador a nivel de fila, que se dispara una vez por cada fila afectada por un "update" sobre la tabla 
"libros". Se ingresa en la tabla "control" el nombre del usuario que altera la tabla "libros" (obtenida mediante la función 
"user") y la fecha en que lo hizo (mediante la función "sysdate"):

 create or replace trigger tr_actualizar_libros
  before update
  on libros
  for each row
 begin
  insert into control values(user,sysdate);
 end tr_actualizar_libros;
 /
 
Si al ejecutar un "update" sobre "libros" se actualizan 5 registros, en la tabla "control" se ingresarán 5 registros, uno por cada 
modificación. Si el trigger hubiese sido definido a nivel de sentencia (statement), se agregaría una sola fila en "control".
*/