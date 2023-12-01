/*
Podemos agregar un campo a una tabla y en el mismo momento aplicarle una restricción.
Para agregar un campo y establecer una restricción, la sintaxis básica es la siguiente:

 alter table TABLA
  add CAMPO DEFINICION
  constraint NOMBRERESTRICCION TIPO;
Agregamos a la tabla "libros", el campo "titulo" de tipo varchar2(30) y una restricción "unique":

 alter table libros
  add titulo varchar2(30) 
  constraint UQ_libros_autor unique;
Agregamos a la tabla "libros", el campo "codigo" de tipo number(4) not null y una restricción "primary key":

 alter table libros
  add codigo number(4) not null
  constraint PK_libros_codigo primary key;
Agregamos a la tabla "libros", el campo "precio" de tipo number(6,2) y una restricción "check":

 alter table libros
  add precio number(6,2)
  constraint CK_libros_precio check (precio>=0);
*/
  drop table libros;

 create table libros(
  autor varchar2(30),
  editorial varchar2(15)
 );

-- Agregamos el campo "titulo" de tipo varchar2(30) y una restricción "unique":

 alter table libros
  add titulo varchar2(30) 
  constraint UQ_libros_autor unique;

-- Veamos si la estructura cambió:

describe libros;

-- Agregamos el campo "codigo" de tipo number(4) not null y en la misma sentencia una restricción "primary key":

alter table libros
add codigo number(4) not null
constraint PK_LIBROS_CODIGO primary key;

-- Agregamos el campo "precio" de tipo number(6,2) y una restricción "check" que no permita valores negativos para dicho campo:

alter table libros
add precio number(6,2) 
constraint CK_LIBROS_PRECIO check (precio >= 0);

-- Veamos la estructura de la tabla y las restricciones:

describe libros;

select * from user_constraints where table_name='LIBROS';

-- Ejercicio 1

 drop table empleados;

 create table empleados(
  documento char(8) not null,
  nombre varchar2(10),
  domicilio varchar2(30),
  ciudad varchar2(20) default 'Buenos Aires'
 );
 
-- Agregue el campo "legajo" de tipo number(3) y una restricción "primary key"

alter table empleados 
add legajo number(3) 
constraint PK_EMPLEADOS_LEGAJO primary key;

-- Vea si la estructura cambió y si se agregó la restricción

describe empleados;

-- Agregue el campo "hijos" de tipo number(2) y en la misma sentencia una restricción "check" que no permita 
-- valores superiores a 30

alter table empleados
add hijos number(2)
constraint CK_EMPLEADOS_HIJOS check (hijos <= 30);

-- Ingrese algunos registros:

 insert into empleados values('22222222','Juan Lopez','Colon 123','Cordoba',100,2);
 insert into empleados values('23333333','Ana Garcia','Sucre 435','Cordoba',200,3);

-- Intente agregar el campo "sueldo" de tipo number(6,2) no nulo y una restricción "check" que no permita valores negativos 
-- para dicho campo. No lo permite porque no damos un valor por defecto para dicho campo no nulo y los registros existentes 
-- necesitan cargar un valor.

alter table empleados
add sueldo number(6,2) not null
constraint CK_EMPLEADOS_SUELDO check(sueldo >= 0);

-- Agregue el campo "sueldo" de tipo number(6,2) no nulo, con el valor por defecto 0 y una restricción "check" que no 
-- permita valores negativos para dicho campo

alter table empleados
add sueldo number(6,2) default 0 not null
constraint CK_EMPLEADOS_SUELDO check(sueldo >= 0);

-- Recupere los registros

select * from empleados;

-- Vea la nueva estructura de la tabla

describe empleados;

-- Vea las restricciones

select * from user_constraints where table_name='EMPLEADOS';






