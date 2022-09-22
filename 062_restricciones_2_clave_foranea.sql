/*
Continuamos con la restricci�n "foreign key". Si intentamos eliminar un registro de la tabla referenciada por una restricci�n 
"foreign key" cuyo valor de clave primaria existe referenciada en la tabla que tiene dicha restricci�n, la acci�n no se ejecuta 
y aparece un mensaje de error. Esto sucede porque, por defecto, para eliminaciones, la opci�n de la restricci�n "foreign key"
es "no action".

La restricci�n "foreign key" tiene la cl�usula "on delete", que son opcionales. Esta cl�usula especifica c�mo debe actuar 
Oracle frente a eliminaciones en las tablas referenciadas en la restricci�n.

Las opciones para estas cl�usulas son las siguientes:

- "set null": indica que si eliminamos un registro de la tabla referenciada (TABLA2) cuyo valor existe en la tabla principal 
(TABLA1), dicho registro se elimine y los valores coincidentes en la tabla principal se seteen a "null".

- "cascade": indica que si eliminamos un registro de la tabla referenciada en una "foreign key" (TABLA2), los registros 
coincidentes en la tabla principal (TABLA1), tambi�n se eliminen; es decir, si eliminamos un registro al cual una clave 
for�nea referencia, dicha eliminaci�n se extiende a la otra tabla (integridad referencial en cascada).

- "no action": es la predeterminada; indica que si se intenta eliminar un registro de la tabla referenciada por una 
"foreign key", Oracle no lo permita y muestre un mensaje de error. Se establece omitiendo la cl�usula "on delete" al 
establecer la restricci�n.

La sintaxis completa para agregar esta restricci�n a una tabla es la siguiente:

 alter table TABLA1
  add constraint NOMBRERESTRICCION
  foreign key (CAMPOCLAVEFORANEA)
  references TABLA2(CAMPOCLAVEPRIMARIA)
  on delete OPCION;
Veamos un ejemplo. Definimos una restricci�n "foreign key" a la tabla "libros" estableciendo el campo "codigoeditorial" 
como clave for�nea que referencia al campo "codigo" de la tabla "editoriales". La tabla "editoriales" tiene como clave 
primaria el campo "codigo". Especificamos la acci�n en cascada para las eliminaciones:

 alter table libros
  add constraint FK_libros_codigoeditorial
  foreign key (codigoeditorial)
  references editoriales(codigo)
  on delete cascade;
Si luego de establecer la restricci�n anterior, eliminamos una editorial de "editoriales" cuyo valor de c�digo est� 
presente en "libros", se elimina dicha editorial y todos los libros de tal editorial.

Si consultamos "user_constraints", en la columna "delete_rule" mostrar� "cascade".

Para definir una restricci�n "foreign key" sobre la tabla "libros" estableciendo el campo "codigoeditorial" como clave 
for�nea que referencia al campo "codigo" de la tabla "editoriales" especificando la acci�n de seteo a "null" tipeamos:

 alter table libros
  add constraint FK_libros_codigoeditorial
  foreign key (codigoeditorial)
  references editoriales(codigo)
  on delete set null;
Si luego de establecer la restricci�n anterior, eliminamos una editorial de "editoriales" cuyo valor de c�digo est� presente 
en "libros", se elimina dicha editorial y todos los valores de libros que coinciden con tal editorial se setean a null. Si 
consultamos "user_constraints", en la columna "delete_rule" mostrar� "set null".

Sintetizando, si al agregar una restricci�n "foreign key":

- no se especifica acci�n para eliminaciones, y se intenta eliminar un registro de la tabla referenciada en la "foreign key" 
(editoriales) cuyo valor de clave primaria (codigo) existe en la tabla principal (libros), la acci�n no se realiza.

- se especifica "cascade" para eliminaciones ("on delete cascade") y elimina un registro de la tabla referenciada 
(editoriales) cuyo valor de clave primaria (codigo) existe en la tabla principal(libros), la eliminaci�n de la tabla referenciada 
(editoriales) se realiza y se eliminan de la tabla principal (libros) todos los registros cuyo valor coincide con el registro 
eliminado de la tabla referenciada (editoriales).

- se especifica acci�n para eliminaciones ("on delete set null") y se elimina un registro de la tabla referenciada en la "foreign key" 
(editoriales) cuyo valor de clave primaria (codigo) existe en la tabla principal (libros), la acci�n se realiza y se setean a "null" 
todos los valores coincidentes en la tabla principal (libros).

La restricci�n "foreign key" NO tiene una cl�usula para especificar acciones para actualizaciones.

Si intentamos actualizar un registro de la tabla referenciada por una restricci�n "foreign key" cuyo valor de clave primaria 
existe referenciada en la tabla que tiene dicha restricci�n, la acci�n no se ejecuta y aparece un mensaje de error. Esto 
sucede porque, por defecto (y como �nica opci�n), para actualizaciones existe "no action".
*/

