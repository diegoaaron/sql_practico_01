/*
Continuamos con la restricción "foreign key". Si intentamos eliminar un registro de la tabla referenciada por una restricción 
"foreign key" cuyo valor de clave primaria existe referenciada en la tabla que tiene dicha restricción, la acción no se ejecuta 
y aparece un mensaje de error. Esto sucede porque, por defecto, para eliminaciones, la opción de la restricción "foreign key"
es "no action".

La restricción "foreign key" tiene la cláusula "on delete", que son opcionales. Esta cláusula especifica cómo debe actuar 
Oracle frente a eliminaciones en las tablas referenciadas en la restricción.

Las opciones para estas cláusulas son las siguientes:

- "set null": indica que si eliminamos un registro de la tabla referenciada (TABLA2) cuyo valor existe en la tabla principal 
(TABLA1), dicho registro se elimine y los valores coincidentes en la tabla principal se seteen a "null".

- "cascade": indica que si eliminamos un registro de la tabla referenciada en una "foreign key" (TABLA2), los registros 
coincidentes en la tabla principal (TABLA1), también se eliminen; es decir, si eliminamos un registro al cual una clave 
foránea referencia, dicha eliminación se extiende a la otra tabla (integridad referencial en cascada).

- "no action": es la predeterminada; indica que si se intenta eliminar un registro de la tabla referenciada por una 
"foreign key", Oracle no lo permita y muestre un mensaje de error. Se establece omitiendo la cláusula "on delete" al 
establecer la restricción.

La sintaxis completa para agregar esta restricción a una tabla es la siguiente:

 alter table TABLA1
  add constraint NOMBRERESTRICCION
  foreign key (CAMPOCLAVEFORANEA)
  references TABLA2(CAMPOCLAVEPRIMARIA)
  on delete OPCION;
Veamos un ejemplo. Definimos una restricción "foreign key" a la tabla "libros" estableciendo el campo "codigoeditorial" 
como clave foránea que referencia al campo "codigo" de la tabla "editoriales". La tabla "editoriales" tiene como clave 
primaria el campo "codigo". Especificamos la acción en cascada para las eliminaciones:

 alter table libros
  add constraint FK_libros_codigoeditorial
  foreign key (codigoeditorial)
  references editoriales(codigo)
  on delete cascade;
Si luego de establecer la restricción anterior, eliminamos una editorial de "editoriales" cuyo valor de código está 
presente en "libros", se elimina dicha editorial y todos los libros de tal editorial.

Si consultamos "user_constraints", en la columna "delete_rule" mostrará "cascade".

Para definir una restricción "foreign key" sobre la tabla "libros" estableciendo el campo "codigoeditorial" como clave 
foránea que referencia al campo "codigo" de la tabla "editoriales" especificando la acción de seteo a "null" tipeamos:

 alter table libros
  add constraint FK_libros_codigoeditorial
  foreign key (codigoeditorial)
  references editoriales(codigo)
  on delete set null;
Si luego de establecer la restricción anterior, eliminamos una editorial de "editoriales" cuyo valor de código está presente 
en "libros", se elimina dicha editorial y todos los valores de libros que coinciden con tal editorial se setean a null. Si 
consultamos "user_constraints", en la columna "delete_rule" mostrará "set null".

Sintetizando, si al agregar una restricción "foreign key":

- no se especifica acción para eliminaciones, y se intenta eliminar un registro de la tabla referenciada en la "foreign key" 
(editoriales) cuyo valor de clave primaria (codigo) existe en la tabla principal (libros), la acción no se realiza.

- se especifica "cascade" para eliminaciones ("on delete cascade") y elimina un registro de la tabla referenciada 
(editoriales) cuyo valor de clave primaria (codigo) existe en la tabla principal(libros), la eliminación de la tabla referenciada 
(editoriales) se realiza y se eliminan de la tabla principal (libros) todos los registros cuyo valor coincide con el registro 
eliminado de la tabla referenciada (editoriales).

- se especifica acción para eliminaciones ("on delete set null") y se elimina un registro de la tabla referenciada en la "foreign key" 
(editoriales) cuyo valor de clave primaria (codigo) existe en la tabla principal (libros), la acción se realiza y se setean a "null" 
todos los valores coincidentes en la tabla principal (libros).

La restricción "foreign key" NO tiene una cláusula para especificar acciones para actualizaciones.

Si intentamos actualizar un registro de la tabla referenciada por una restricción "foreign key" cuyo valor de clave primaria 
existe referenciada en la tabla que tiene dicha restricción, la acción no se ejecuta y aparece un mensaje de error. Esto 
sucede porque, por defecto (y como única opción), para actualizaciones existe "no action".
*/

