/*
En un trigger de actualizaci�n a nivel de fila, se puede especificar el nombre de un campo en la condici�n "updating" para 
determinar cu�l campo ha sido actualizado.

Sintaxis b�sica:

 create or replace trigger NOMBRETRIGGER
 MOMENTO update...
 for each row
 begin
  if updating ('CAMPO') then
   ...
  end if;
 end NOMBREDISPARADOR;
 /

El siguiente trigger se dispara cuando se actualiza la tabla "libros". Dentro del cuerpo del trigger se averigua el campo 
que ha sido modificado; en caso de modificarse el "precio", se ingresa en la tabla "controlPrecios" la fecha, el c�digo 
del libro y el antiguo y nuevo precio; en caso de actualizarse cualquier otro campo, se almacena en la tabla "control" el 
nombre del usuario que realiz� la modificaci�n, la fecha y el c�digo del libro modificado.

 create or replace trigger tr_actualizar_libros
 before update
 on libros
 for each row
 begin
  if updating ('precio') then
   insert into controlprecios values(sysdate,:old.codigo,:old.precio,:new.precio);
  else
   insert into control values(user,sysdate,:old.codigo);
  end if;
 end tr_actualizar_libros;
 /
*/