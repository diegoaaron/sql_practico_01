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

 drop table libros;
 drop table editoriales;

 create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  codigoeditorial number(3),
  primary key (codigo)
 );
 create table editoriales(
  codigo number(3),
  nombre varchar2(20),
  primary key (codigo)
);

 insert into editoriales values(1,'Emece');
 insert into editoriales values(2,'Planeta');
 insert into editoriales values(3,'Siglo XXI');

 insert into libros values(1,'El aleph','Borges',1);
 insert into libros values(2,'Martin Fierro','Jose Hernandez',2);
 insert into libros values(3,'Aprenda PHP','Mario Molina',2);
 insert into libros values(4,'El anillo del hechicero','Gaskin',3);

-- Establecemos una restricción "foreign key" para evitar que se ingrese en "libros" un código de editorial inexistente en 
-- "editoriales" con la opción "on cascade" para eliminaciones:

alter table libros
add constraint FK_LIBROS_CODIGOEDITORIAL
foreign key (codigoeditorial)
references editoriales(codigo)
on delete cascade;

-- Consultamos "user_constraints":
-- En la columna "delete_rule" de la restricción "foreign key" mostrará "cascade".

select constraint_name, constraint_type, delete_rule
from user_constraints
where table_name = 'LIBROS';

-- Si eliminamos una editorial, se borra tal editorial de "editoriales" y todos los registros de "libros" de dicha editorial:

delete from editoriales where codigo = 1; 

-- Veamos si la eliminación se extendió a "libros":
-- El libro "El aleph", de la editorial con código 1 se ha eliminado.

select * from libros;

-- Eliminamos la restricción "foreign key" de "libros":

alter table libros
drop constraint FK_LIBROS_CODIGOEDITORIAL;

-- Establecemos una restricción "foreign key" sobre "codigoeditorial" de "libros" con la opción "set null" para eliminaciones:

alter table libros
add constraint FK_LIBROS_CODIGOEDITORIAL
foreign key (codigoeditorial)
references editoriales(codigo)
on delete set null;

-- Consultamos "user_constraints":
-- En la columna "delete_rule" de la restricción "foreign key" mostrará "set null".

select constraint_name, constraint_type, delete_rule
from user_constraints
where table_name = 'LIBROS';

-- Si eliminamos una editorial cuyo código está presente en "libros", se borra tal editorial de "editoriales" y todos los registros 
-- de "libros" de dicha editorial se setean con el valor "null":
-- Ahora, los libros "Martin Fierro" y "Aprenda PHP" tiene valor nulo en "codigoeditorial".

delete from editoriales where codigo = 2;

select * from libros;

-- Eliminamos la restricción "foreign key" de "libros":

alter table libros
drop constraint FK_LIBROS_CODIGOEDITORIAL;

-- Establecemos una restricción "foreign key" sobre "codigoeditorial" de "libros" sin especificar opción para eliminaciones:

alter table libros
add constraint FK_LIBROS_CODIGOEDITORIAL
foreign key(codigoeditorial)
references editoriales(codigo);

-- Consultamos "user_constraints":
-- En la columna "delete_rule" de la restricción "foreign key" mostrará "no action".

select constraint_name, constraint_type, delete_rule
from user_constraints
where table_name = 'LIBROS';

-- Intentamos eliminar una editorial cuyo código esté presente en "libros":
-- Un mensaje de error indica que la acción no se ha realizado porque existen registros coincidentes.

delete from editoriales where codigo = 3;

-- Ejercicio 1

 drop table clientes;
 drop table provincias;

 create table clientes (
  codigo number(5),
  nombre varchar2(30),
  domicilio varchar2(30),
  ciudad varchar2(20),
  codigoprovincia number(2),
  primary key(codigo)
 );

 create table provincias(
  codigo number(2),
  nombre varchar2(20),
  primary key (codigo)
 );

 insert into provincias values(1,'Cordoba');
 insert into provincias values(2,'Santa Fe');
 insert into provincias values(3,'Misiones');
 insert into provincias values(4,'Rio Negro');

 insert into clientes values(100,'Perez Juan','San Martin 123','Carlos Paz',1);
 insert into clientes values(101,'Moreno Marcos','Colon 234','Rosario',2);
 insert into clientes values(102,'Acosta Ana','Avellaneda 333','Posadas',3);
 
 -- Establezca una restricción "foreign key" especificando la acción "set null" para eliminaciones.

alter table clientes
add constraint FK_CLIENTES_CODIGOPROVINCIA
foreign key (codigoprovincia)
references provincias(codigo)
on delete set null;

-- Elimine el registro con código 3, de "provincias" y consulte "clientes" para ver qué cambios ha realizado Oracle en los 
-- registros coincidentes. Todos los registros con "codigoprovincia" 3 han sido seteados a null.

delete from provincias where codigo = 3;

select * from clientes;

-- Consulte el diccionario "user_constraints" para ver qué acción se ha establecido para las eliminaciones

select constraint_name, constraint_type, delete_rule
from user_constraints
where table_name = 'CLIENTES';

-- Intente modificar el registro con código 2, de "provincias"

update provincias set codigo = 99 where codigo = 2;

-- Elimine la restricción "foreign key" establecida sobre "clientes"

alter table clientes
drop constraint FK_CLIENTES_CODIGOPROVINCIA;

-- Establezca una restricción "foreign key" sobre "codigoprovincia" de "clientes" especificando la acción "cascade" para 
-- eliminaciones

alter table clientes
add constraint FK_CLIENTES_CODIGOPROVINCIA
foreign key (codigoprovincia)
references provincias(codigo)
on delete cascade;

-- Consulte el diccionario "user_constraints" para ver qué acción se ha establecido para las eliminaciones sobre las 
-- restricciones "foreign key" de la tabla "clientes"



11- Elimine el registro con código 2, de "provincias"

12- Verifique que el cambio se realizó en cascada, es decir, que se eliminó en la tabla "provincias" y todos los clientes de la provincia eliminada

13- Elimine la restricción "foreign key"

14- Establezca una restricción "foreign key" sin especificar acción para eliminaciones

15- Intente eliminar un registro de la tabla "provincias" cuyo código exista en "clientes"

16- Consulte el diccionario "user_constraints" para ver qué acción se ha establecido para las eliminaciones sobre la restricción "FK_CLIENTES_CODIGOPROVINCIA"

17- Intente elimimar la tabla "provincias"

18- Elimine la restricción "foreign key"

19- Elimine la tabla "provincias"
