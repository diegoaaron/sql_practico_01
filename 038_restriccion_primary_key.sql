/*

La restricción "primary key" asegura que los valores sean únicos para cada registro.

Cada vez que establecíamos la clave primaria para una tabla, Oracle creaba automáticamente una restricción "primary key" 
para dicha tabla. Dicha restricción, a la cual no le dábamos un nombre, recibía un nombre dado por Oracle que consta de una 
serie de letras y números aleatorios.

Podemos agregar una restricción "primary key" a una tabla existente con la sintaxis básica siguiente:

alter table NOMBRETABLA
add constraint NOMBRECONSTRAINT
primary key (CAMPO,...);

En el siguiente ejemplo definimos una restricción "primary key" para nuestra tabla "libros" para 
asegurarnos que cada libro tendrá un código diferente y único:

 alter table libros
 add constraint PK_libros_codigo
 primary key(codigo);

Con esta restricción, si intentamos ingresar un registro con un valor para el campo "codigo" que ya existe o el valor "null", 
aparece un mensaje de error, porque no se permiten valores duplicados ni nulos. Igualmente, si actualizamos.

Por convención, cuando demos el nombre a las restricciones "primary key" 
seguiremos el formato "PK_NOMBRETABLA_NOMBRECAMPO".

Cuando agregamos una restricción a una tabla que contiene información, Oracle controla los datos existentes para confirmar que 
cumplen las exigencias de la restricción, si no los cumple, la restricción no se aplica y aparece un mensaje de error. Por ejemplo,
si intentamos definir la restricción "primary key" para "libros" y hay registros con códigos repetidos o con un valor "null", 
la restricción no se establece.

Cuando establecíamos una clave primaria al definir la tabla, automáticamente Oracle redefinía el campo como "not null"; 
lo mismo sucede al agregar una restricción "primary key", los campos que se establecen como clave primaria se 
redefinen automáticamente "not null".

Se permite definir solamente una restricción "primary key" por tabla, que asegura la unicidad de cada registro de una tabla.

Si consultamos el catálogo "user_constraints", podemos ver las restricciones "primary key" (y todos los tipos de restricciones) 
de todas las tablas del usuario actual. 
El resultado es una tabla que nos informa el propietario de la restricción (OWNER), el nombre de la restricción (CONSTRAINT_NAME), 
el tipo (CONSTRAINT_TYPE, si es "primary key" muestra una "P"), el nombre de la tabla en la cual se aplica (TABLE_NAME), 
y otra información que no analizaremos por el momento.

También podemos consultar el catálogo "user_cons_columns"; nos mostrará el propietario de la restricción (OWNER), el nombre de la 
restricción (CONSTRAINT_NAME), la tabla a la cual se aplica (TABLE_NAME), el campo (COLUMN_NAME) y la posición (POSITION).

*/

select * from user_constraints;

select * from user_cons_columns;

drop table libros;

create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(15),
  primary key (codigo)
);

-- Veamos la restricción "primary key" que creó automáticamente Oracle:

select * from user_constraints where table_name='LIBROS';

-- Nos informa que la tabla "libros" (TABLE_NAME) tiene una restricción de tipo "primary key" (muestra "P" en "CONSTRAINT_TYPE") 
-- creada por "SYSTEM" (OWNER) cuyo nombre es "SYS_C008318" (nombre dado por Oracle a la restriccion).

-- Vamos a eliminar la tabla y la crearemos nuevamente, sin establecer la clave primaria:

drop table libros;

create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(15)
);

insert into libros values(1,'El aleph','Borges','Emece');
insert into libros values(1,'Ilusiones','Bach','Planeta');

-- Al intentar agregar una restricción "primary key" a la tabla, aparecerá un mensaje indicando que la clave primaria 
-- se viola y proponiendo que se elimine la clave repetida.

-- modificamos el código repetido 

update libros set codigo = 2 where titulo = 'Ilusiones';

-- Realizamos la corrección(agregando el campo codigo como llave primaria en la tabla)

alter table libros
add constraint PK_LIBROS_CODIGO
primary key(codigo);

-- vemos la restriccion definida en la tabla "user_constraints" 

select * from user_constraints where table_name='LIBROS';

-- al intentar ingresar un registro con el campo codigo duplicado, nos arrojara error

insert into libros values(1,'El quijote de la mancha','Cervantes','Emece');

-- tampoco se puede ingresar un valor nulo en el campo codigo

insert into libros values(null,'El quijote de la mancha','Cervantes','Emece');

-- El campo, luego de agregarse la restricción "primary key" se estableció como "not null"

describe libros;

-- Si intentamos agregar otra restricción "primary key", Oracle no lo permite:

alter table libros
add constraint PK_libros_titulo
primary key(titulo);

-- Veamos lo que nos informa el catálogo "user_const_columns":

 select * from user_cons_columns where table_name='LIBROS';

-- Ejercicio 1 



