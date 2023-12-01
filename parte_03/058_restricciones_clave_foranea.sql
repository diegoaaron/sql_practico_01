/*
Hemos visto que una de las alternativas que Oracle ofrece para asegurar la integridad de datos es el uso de restricciones
(constraints). Aprendimos que las restricciones se establecen en tablas y campos asegurando que los datos sean válidos y 
que las relaciones entre las tablas se mantengan.

Vimos tres tipos de restricciones:

primary key, unique y check. Ahora veremos "foreign key".
Con la restricción "foreign key" se define un campo (o varios) cuyos valores coinciden con la clave primaria de la misma tabla 
o de otra, es decir, se define una referencia a un campo con una restricción "primary key" o "unique" de la misma tabla o de otra.

La integridad referencial asegura que se mantengan las referencias entre las claves primarias y las externas. Por ejemplo, 
controla que si se agrega un código de editorial en la tabla "libros", tal código exista en la tabla "editoriales".

También controla que no pueda eliminarse un registro de una tabla ni modificar la clave primaria si una clave externa hace 
referencia al registro. Por ejemplo, que no se pueda eliminar o modificar un código de "editoriales" si existen libros 
con dicho código.

La siguiente es la sintaxis parcial general para agregar una restricción "foreign key":

alter table NOMBRETABLA1
add constraint NOMBRERESTRICCION
foreign key (CAMPOCLAVEFORANEA)
references NOMBRETABLA2 (CAMPOCLAVEPRIMARIA);

Analicémosla:

- NOMBRETABLA1 referencia el nombre de la tabla a la cual le aplicamos la restricción,

- NOMBRERESTRICCION es el nombre que le damos a la misma,

- luego de "foreign key", entre paréntesis se coloca el campo de la tabla a la que le aplicamos la restricción que será 
establecida como clave foránea,

- luego de "references" indicamos el nombre de la tabla referenciada y el campo que es clave primaria en la misma, a la 
cual hace referencia la clave foránea. El campo de la tabla referenciada debe tener definida una restricción "primary key" 
o "unique"; si no la tiene, aparece un mensaje de error.

Para agregar una restricción "foreign key" al campo "codigoeditorial" de "libros", tipeamos:

alter table libros
add constraint FK_libros_codigoeditorial
foreign key (codigoeditorial)
references editoriales(codigo);

En el ejemplo implementamos una restricción "foreign key" para asegurarnos que el código de la editorial de la de la 
tabla "libros" ("codigoeditorial") esté asociada con un código válido en la tabla "editoriales" ("codigo").

Cuando agregamos cualquier restricción a una tabla que contiene información, Oracle controla los datos existentes para 
confirmar que cumplen con la restricción, si no los cumple, la restricción no se aplica y aparece un mensaje de error. Por 
ejemplo, si intentamos agregar una restricción "foreign key" a la tabla "libros" y existe un libro con un valor de código para 
editorial que no existe en la tabla "editoriales", la restricción no se agrega.

Actúa en inserciones. Si intentamos ingresar un registro (un libro) con un valor de clave foránea (codigoeditorial) que no 
existe en la tabla referenciada (editoriales), Oracle muestra un mensaje de error. Si al ingresar un registro (un libro), 
no colocamos el valor para el campo clave foránea (codigoeditorial), almacenará "null", porque esta restricción permite 
valores nulos (a menos que se haya especificado lo contrario al definir el campo).

Actúa en eliminaciones y actualizaciones. Si intentamos eliminar un registro o modificar un valor de clave primaria de unan 
tabla si una clave foránea hace referencia a dicho registro, Oracle no lo permite (excepto si se permite la acción en cascada, 
tema que veremos posteriormente). Por ejemplo, si intentamos eliminar una editorial a la que se hace referencia en "libros", 
aparece un mensaje de error.

Esta restricción (a diferencia de "primary key" y "unique") no crea índice automáticamente.

La cantidad y tipo de datos de los campos especificados luego de "foreign key" DEBEN coincidir con la cantidad y tipo de 
datos de los campos de la cláusula "references".

Esta restricción se puede definir dentro de la misma tabla (lo veremos más adelante) o entre distintas tablas.

Una tabla puede tener varias restricciones "foreign key".

No se puede eliminar una tabla referenciada en una restricción "foreign key", aparece un mensaje de error.

Una restriccion "foreign key" no puede modificarse, debe eliminarse (con "alter table" y "drop constraint") y volverse a crear.

Las restricciones "foreign key" se eliminan automáticamente al eliminar la tabla en la que fueron definidas.

Para ver información acerca de esta restricción podemos consultar los diccionarios "user_constraints" y "user_cons_columns".
*/

drop table libros;
drop table editoriales;

create table libros(
codigo number(5),
titulo varchar2(40),
autor varchar2(30),
codigoeditorial number(3)
);

create table editoriales(
codigo number(3),
nombre varchar2(20)
);


insert into editoriales values(1,'Emece');
insert into editoriales values(2,'Planeta');
insert into editoriales values(3,'Siglo XXI');

insert into libros values(100,'El aleph','Borges',1);
insert into libros values(101,'Martin Fierro','Jose Hernandez',2);
insert into libros values(102,'Aprenda PHP','Mario Molina',5);

-- Intentamos establecer una restricción "foreign key" sobre "codigoeditorial":
-- Mensaje de error; pues el campo "codigo" de la tabla "editoriales" no fue definida clave primaria ni única.

alter table libros
add constraint FK_LIBROS_CODIGOEDITORIAL
foreign key (codigoeditorial)
references editoriales(codigo);

-- Agregamos una restricción "primary key" sobre "codigo" de "editoriales":

alter table editoriales
add constraint PK_EDITORIALES
primary key(codigo);

-- Intentamos nuevamente establecer una restricción "foreign key" sobre "codigoeditorial":
-- Mensaje de error. Oracle controla que los datos existentes no violen la restricción que intentamos establecer, como existe 
-- un valor de "codigoeditorial" inexistente en "editoriales", la restricción no puede establecerse.

-- Eliminamos el registro que infringe la regla:

delete from libros where codigoeditorial = 5;

-- Ahora si podemos establecer una restricción "foreign key" sobre "codigoeditorial" (utilizando el primer enunciado)

-- Veamos las restricciones de "libros" consultando "user_constraints":
-- aparece la restricción "FK_libros_codigoeditorial" indicando que es una "foreign key" con el caracter "R" en el tipo de 
-- restricción.

select constraint_name, constraint_type
from user_constraints
where table_name = 'LIBROS';

-- Consultamos "user_cons_columns":

select constraint_name, column_name
from user_cons_columns
where table_name = 'LIBROS';

-- Veamos las restricciones de "editoriales"

select constraint_name, constraint_type
from user_constraints
where table_name='EDITORIALES';

-- Ingresamos un libro sin especificar un valor para el código de editorial:

 insert into libros values(103,'El experto en laberintos','Gaskin',default);

-- Veamos todos los registros de "libros":
-- Note que en "codigoeditorial" almacenó "null", porque esta restricción permite valores nulos (a menos que se haya 
-- especificado lo contrario al definir el campo).
 
 select *from libros;
 
 -- Intentamos agregar un libro con un código de editorial inexistente en "editoriales":
-- Nos muestra un mensaje indicando que la restricción FK_LIBROS_EDITORIAL está siendo violada, que no encuentra el 
-- valor de clave primaria en "editoriales".

 insert into libros values(104,'El anillo del hechicero','Gaskin',8);

-- Intentamos eliminar una editorial cuyo código esté presente en "libros":
-- Un mensaje nos informa que la restricción de clave externa está siendo violada, existen registros que hacen referencia 
-- al que queremos eliminar.

delete from editoriales where codigo=2;

-- Intente eliminar la tabla "editoriales":
-- Un mensaje de error indica que la acción no puede realizarse porque la tabla es referenciada por una "foreign key".

drop table editoriales;

 -- Ejercicio 1
 
drop table clientes;
drop table provincias;

create table clientes (
  codigo number(5),
  nombre varchar2(30),
  domicilio varchar2(30),
  ciudad varchar2(20),
  codigoprovincia number(2)
);

create table provincias(
  codigo number(2),
  nombre varchar2(20)
 );

-- En este ejemplo, el campo "codigoprovincia" de "clientes" es una clave foránea, se emplea para enlazar la tabla 
-- "clientes" con "provincias".
-- Intente agregar una restricción "foreign key" a la tabla "clientes" que haga referencia al campo "codigo" de "provincias"
-- No se puede porque "provincias" no tiene restricción "primary key" ni "unique".

alter table clientes
add constraint FK_CLIENTES_CODIGOPROVINCIA
foreign key (codigoprovincia)
references provincias(codigo);

-- Establezca una restricción "unique" al campo "codigo" de "provincias"

alter table provincias
add constraint UQ_PROVINCIAS_CODIGO
unique(codigo);

-- Ingrese algunos registros para ambas tablas:

 insert into provincias values(1,'Cordoba');
 insert into provincias values(2,'Santa Fe');
 insert into provincias values(3,'Misiones');
 insert into provincias values(4,'Rio Negro');

 insert into clientes values(100,'Perez Juan','San Martin 123','Carlos Paz',1);
 insert into clientes values(101,'Moreno Marcos','Colon 234','Rosario',2);
 insert into clientes values(102,'Acosta Ana','Avellaneda 333','Posadas',3);
 insert into clientes values(103,'Luisa Lopez','Juarez 555','La Plata',6);
 
-- Intente agregar la restricción "foreign key" del punto 2 a la tabla "clientes"
-- No se puede porque hay un registro en "clientes" cuyo valor de "codigoprovincia" no existe en "provincias".

alter table clientes
add constraint FK_CLIENTES_CODIGOPROVINCIA
foreign key (codigoprovincia)
references provincias(codigo);

-- Elimine el registro de "clientes" que no cumple con la restricción y establezca la restricción nuevamente.

delete from clientes where codigo='103';

-- Intente agregar un cliente con un código de provincia inexistente en "provincias"

 insert into clientes values(106,'Acosta Ana','Avellaneda 333','Posadas',null);

-- Intente eliminar el registro con código 3, de "provincias".
-- No se puede porque hay registros en "clientes" al cual hace referencia.

delete from provincias where codigo = 3;

-- Elimine el registro con código "4" de "provincias"
-- Se permite porque en "clientes" ningún registro hace referencia a él.

delete from provincias where codigo = 4;

-- Intente modificar el registro con código 1, de "provincias"
-- No se puede porque hay registros en "clientes" al cual hace referencia.

update provincias set nombre='Loreto' where codigo = 1;

-- Vea las restricciones de "clientes" consultando "user_constraints"

select constraint_name, constraint_type
from user_constraints
where table_name='CLIENTES';

-- Vea las restricciones de "provincias"

select constraint_name, constraint_type
from user_constraints
where table_name='PROVINCIAS';

-- Intente eliminar la tabla "provincias" (mensaje de error)

drop table provincias;

-- Elimine la restricción "foreign key" de "clientes" y luego elimine la tabla "provincias"
 
 alter table clientes
 drop constraint FK_CLIENTES_CODIGOPROVINCIA;
 
