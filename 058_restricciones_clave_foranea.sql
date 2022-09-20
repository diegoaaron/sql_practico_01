/*
Hemos visto que una de las alternativas que Oracle ofrece para asegurar la integridad de datos es el uso de restricciones
(constraints). Aprendimos que las restricciones se establecen en tablas y campos asegurando que los datos sean v�lidos y 
que las relaciones entre las tablas se mantengan.

Vimos tres tipos de restricciones:

primary key, unique y check. Ahora veremos "foreign key".
Con la restricci�n "foreign key" se define un campo (o varios) cuyos valores coinciden con la clave primaria de la misma tabla 
o de otra, es decir, se define una referencia a un campo con una restricci�n "primary key" o "unique" de la misma tabla o de otra.

La integridad referencial asegura que se mantengan las referencias entre las claves primarias y las externas. Por ejemplo, 
controla que si se agrega un c�digo de editorial en la tabla "libros", tal c�digo exista en la tabla "editoriales".

Tambi�n controla que no pueda eliminarse un registro de una tabla ni modificar la clave primaria si una clave externa hace 
referencia al registro. Por ejemplo, que no se pueda eliminar o modificar un c�digo de "editoriales" si existen libros 
con dicho c�digo.

La siguiente es la sintaxis parcial general para agregar una restricci�n "foreign key":

alter table NOMBRETABLA1
add constraint NOMBRERESTRICCION
foreign key (CAMPOCLAVEFORANEA)
references NOMBRETABLA2 (CAMPOCLAVEPRIMARIA);

Analic�mosla:

- NOMBRETABLA1 referencia el nombre de la tabla a la cual le aplicamos la restricci�n,

- NOMBRERESTRICCION es el nombre que le damos a la misma,

- luego de "foreign key", entre par�ntesis se coloca el campo de la tabla a la que le aplicamos la restricci�n que ser� 
establecida como clave for�nea,

- luego de "references" indicamos el nombre de la tabla referenciada y el campo que es clave primaria en la misma, a la 
cual hace referencia la clave for�nea. El campo de la tabla referenciada debe tener definida una restricci�n "primary key" 
o "unique"; si no la tiene, aparece un mensaje de error.

Para agregar una restricci�n "foreign key" al campo "codigoeditorial" de "libros", tipeamos:

alter table libros
add constraint FK_libros_codigoeditorial
foreign key (codigoeditorial)
references editoriales(codigo);

En el ejemplo implementamos una restricci�n "foreign key" para asegurarnos que el c�digo de la editorial de la de la 
tabla "libros" ("codigoeditorial") est� asociada con un c�digo v�lido en la tabla "editoriales" ("codigo").

Cuando agregamos cualquier restricci�n a una tabla que contiene informaci�n, Oracle controla los datos existentes para 
confirmar que cumplen con la restricci�n, si no los cumple, la restricci�n no se aplica y aparece un mensaje de error. Por 
ejemplo, si intentamos agregar una restricci�n "foreign key" a la tabla "libros" y existe un libro con un valor de c�digo para 
editorial que no existe en la tabla "editoriales", la restricci�n no se agrega.

Act�a en inserciones. Si intentamos ingresar un registro (un libro) con un valor de clave for�nea (codigoeditorial) que no 
existe en la tabla referenciada (editoriales), Oracle muestra un mensaje de error. Si al ingresar un registro (un libro), 
no colocamos el valor para el campo clave for�nea (codigoeditorial), almacenar� "null", porque esta restricci�n permite 
valores nulos (a menos que se haya especificado lo contrario al definir el campo).

Act�a en eliminaciones y actualizaciones. Si intentamos eliminar un registro o modificar un valor de clave primaria de unan 
tabla si una clave for�nea hace referencia a dicho registro, Oracle no lo permite (excepto si se permite la acci�n en cascada, 
tema que veremos posteriormente). Por ejemplo, si intentamos eliminar una editorial a la que se hace referencia en "libros", 
aparece un mensaje de error.

Esta restricci�n (a diferencia de "primary key" y "unique") no crea �ndice autom�ticamente.

La cantidad y tipo de datos de los campos especificados luego de "foreign key" DEBEN coincidir con la cantidad y tipo de 
datos de los campos de la cl�usula "references".

Esta restricci�n se puede definir dentro de la misma tabla (lo veremos m�s adelante) o entre distintas tablas.

Una tabla puede tener varias restricciones "foreign key".

No se puede eliminar una tabla referenciada en una restricci�n "foreign key", aparece un mensaje de error.

Una restriccion "foreign key" no puede modificarse, debe eliminarse (con "alter table" y "drop constraint") y volverse a crear.

Las restricciones "foreign key" se eliminan autom�ticamente al eliminar la tabla en la que fueron definidas.

Para ver informaci�n acerca de esta restricci�n podemos consultar los diccionarios "user_constraints" y "user_cons_columns".
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

-- Intentamos establecer una restricci�n "foreign key" sobre "codigoeditorial":
-- Mensaje de error; pues el campo "codigo" de la tabla "editoriales" no fue definida clave primaria ni �nica.

alter table libros
add constraint FK_LIBROS_CODIGOEDITORIAL
foreign key (codigoeditorial)
references editoriales(codigo);

-- Agregamos una restricci�n "primary key" sobre "codigo" de "editoriales":

alter table editoriales
add constraint PK_EDITORIALES
primary key(codigo);

-- Intentamos nuevamente establecer una restricci�n "foreign key" sobre "codigoeditorial":
-- Mensaje de error. Oracle controla que los datos existentes no violen la restricci�n que intentamos establecer, como existe 
-- un valor de "codigoeditorial" inexistente en "editoriales", la restricci�n no puede establecerse.

-- Eliminamos el registro que infringe la regla:

delete from libros where codigoeditorial = 5;

-- Ahora si podemos establecer una restricci�n "foreign key" sobre "codigoeditorial" (utilizando el primer enunciado)

-- Veamos las restricciones de "libros" consultando "user_constraints":
-- aparece la restricci�n "FK_libros_codigoeditorial" indicando que es una "foreign key" con el caracter "R" en el tipo de 
-- restricci�n.

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

-- Ingresamos un libro sin especificar un valor para el c�digo de editorial:

 insert into libros values(103,'El experto en laberintos','Gaskin',default);

-- Veamos todos los registros de "libros":
-- Note que en "codigoeditorial" almacen� "null", porque esta restricci�n permite valores nulos (a menos que se haya 
-- especificado lo contrario al definir el campo).
 
 select *from libros;
 
 -- Intentamos agregar un libro con un c�digo de editorial inexistente en "editoriales":
-- Nos muestra un mensaje indicando que la restricci�n FK_LIBROS_EDITORIAL est� siendo violada, que no encuentra el 
-- valor de clave primaria en "editoriales".

 insert into libros values(104,'El anillo del hechicero','Gaskin',8);

-- Intentamos eliminar una editorial cuyo c�digo est� presente en "libros":
-- Un mensaje nos informa que la restricci�n de clave externa est� siendo violada, existen registros que hacen referencia 
-- al que queremos eliminar.

delete from editoriales where codigo=2;

-- Intente eliminar la tabla "editoriales":
-- Un mensaje de error indica que la acci�n no puede realizarse porque la tabla es referenciada por una "foreign key".

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

-- En este ejemplo, el campo "codigoprovincia" de "clientes" es una clave for�nea, se emplea para enlazar la tabla 
-- "clientes" con "provincias".
-- Intente agregar una restricci�n "foreign key" a la tabla "clientes" que haga referencia al campo "codigo" de "provincias"
-- No se puede porque "provincias" no tiene restricci�n "primary key" ni "unique".

alter table clientes
add constraint FK_CLIENTES_CODIGOPROVINCIA
foreign key (codigoprovincia)
references provincias(codigo);

-- Establezca una restricci�n "unique" al campo "codigo" de "provincias"

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
 
-- Intente agregar la restricci�n "foreign key" del punto 2 a la tabla "clientes"
-- No se puede porque hay un registro en "clientes" cuyo valor de "codigoprovincia" no existe en "provincias".

alter table clientes
add constraint FK_CLIENTES_CODIGOPROVINCIA
foreign key (codigoprovincia)
references provincias(codigo);

-- Elimine el registro de "clientes" que no cumple con la restricci�n y establezca la restricci�n nuevamente.

delete from clientes where codigo='103';

-- Intente agregar un cliente con un c�digo de provincia inexistente en "provincias"

 insert into clientes values(106,'Acosta Ana','Avellaneda 333','Posadas',null);

-- Intente eliminar el registro con c�digo 3, de "provincias".
-- No se puede porque hay registros en "clientes" al cual hace referencia.

delete from provincias where codigo = 3;

-- Elimine el registro con c�digo "4" de "provincias"
-- Se permite porque en "clientes" ning�n registro hace referencia a �l.

delete from provincias where codigo = 4;

-- Intente modificar el registro con c�digo 1, de "provincias"
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

-- Elimine la restricci�n "foreign key" de "clientes" y luego elimine la tabla "provincias"
 
 alter table clientes
 drop constraint FK_CLIENTES_CODIGOPROVINCIA;
 
