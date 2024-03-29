/*

La restricci�n "primary key" asegura que los valores sean �nicos para cada registro.

Cada vez que establec�amos la clave primaria para una tabla, Oracle creaba autom�ticamente una restricci�n "primary key" 
para dicha tabla. Dicha restricci�n, a la cual no le d�bamos un nombre, recib�a un nombre dado por Oracle que consta de una 
serie de letras y n�meros aleatorios.

Podemos agregar una restricci�n "primary key" a una tabla existente con la sintaxis b�sica siguiente:

alter table NOMBRETABLA
add constraint NOMBRECONSTRAINT
primary key (CAMPO,...);

En el siguiente ejemplo definimos una restricci�n "primary key" para nuestra tabla "libros" para 
asegurarnos que cada libro tendr� un c�digo diferente y �nico:

 alter table libros
 add constraint PK_libros_codigo
 primary key(codigo);

Con esta restricci�n, si intentamos ingresar un registro con un valor para el campo "codigo" que ya existe o el valor "null", 
aparece un mensaje de error, porque no se permiten valores duplicados ni nulos. Igualmente, si actualizamos.

Por convenci�n, cuando demos el nombre a las restricciones "primary key" 
seguiremos el formato "PK_NOMBRETABLA_NOMBRECAMPO".

Cuando agregamos una restricci�n a una tabla que contiene informaci�n, Oracle controla los datos existentes para confirmar que 
cumplen las exigencias de la restricci�n, si no los cumple, la restricci�n no se aplica y aparece un mensaje de error. Por ejemplo,
si intentamos definir la restricci�n "primary key" para "libros" y hay registros con c�digos repetidos o con un valor "null", 
la restricci�n no se establece.

Cuando establec�amos una clave primaria al definir la tabla, autom�ticamente Oracle redefin�a el campo como "not null"; 
lo mismo sucede al agregar una restricci�n "primary key", los campos que se establecen como clave primaria se 
redefinen autom�ticamente "not null".

Se permite definir solamente una restricci�n "primary key" por tabla, que asegura la unicidad de cada registro de una tabla.

Si consultamos el cat�logo "user_constraints", podemos ver las restricciones "primary key" (y todos los tipos de restricciones) 
de todas las tablas del usuario actual. 
El resultado es una tabla que nos informa el propietario de la restricci�n (OWNER), el nombre de la restricci�n (CONSTRAINT_NAME), 
el tipo (CONSTRAINT_TYPE, si es "primary key" muestra una "P"), el nombre de la tabla en la cual se aplica (TABLE_NAME), 
y otra informaci�n que no analizaremos por el momento.

Tambi�n podemos consultar el cat�logo "user_cons_columns"; nos mostrar� el propietario de la restricci�n (OWNER), el nombre de la 
restricci�n (CONSTRAINT_NAME), la tabla a la cual se aplica (TABLE_NAME), el campo (COLUMN_NAME) y la posici�n (POSITION).

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

-- Veamos la restricci�n "primary key" que cre� autom�ticamente Oracle:

select * from user_constraints where table_name='LIBROS';

-- Nos informa que la tabla "libros" (TABLE_NAME) tiene una restricci�n de tipo "primary key" (muestra "P" en "CONSTRAINT_TYPE") 
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

-- Al intentar agregar una restricci�n "primary key" a la tabla, aparecer� un mensaje indicando que la clave primaria 
-- se viola y proponiendo que se elimine la clave repetida.

-- modificamos el c�digo repetido 

update libros set codigo = 2 where titulo = 'Ilusiones';

-- Realizamos la correcci�n(agregando el campo codigo como llave primaria en la tabla)

alter table libros
add constraint PK_LIBROS_CODIGO
primary key(codigo);

-- vemos la restriccion definida en la tabla "user_constraints" 

select * from user_constraints where table_name='LIBROS';

-- al intentar ingresar un registro con el campo codigo duplicado, nos arrojara error

insert into libros values(1,'El quijote de la mancha','Cervantes','Emece');

-- tampoco se puede ingresar un valor nulo en el campo codigo

insert into libros values(null,'El quijote de la mancha','Cervantes','Emece');

-- El campo, luego de agregarse la restricci�n "primary key" se estableci� como "not null"

describe libros;

-- Si intentamos agregar otra restricci�n "primary key", Oracle no lo permite:

alter table libros
add constraint PK_libros_titulo
primary key(titulo);

-- Veamos lo que nos informa el cat�logo "user_const_columns":

 select * from user_cons_columns where table_name='LIBROS';

-- Ejercicio 1 

drop table empleados;

create table empleados (
  documento char(8),
  nombre varchar2(30),
  seccion varchar2(20)
);

insert into empleados values ('11122255','luis perez','EC2');
insert into empleados values ('22222255','marcos perez','EC2');
insert into empleados values ('44422255','alejandro perez','EC2');
insert into empleados values ('11122255','percy perez','EC2');

-- Intente establecer una restricci�n "primary key" para la tabla para que el documento no se repita ni admita valores nulos.
-- No lo permite porque la tabla contiene datos que no cumplen con la restricci�n, debemos eliminar (o modificar) el 
-- registro que tiene documento duplicado.

alter table empleados
add constraint PK_EMPLEADOS_DOCUMENTO
primary key(documento);

update empleados set documento = '12322255' where nombre = 'percy perez'; 

-- Intente actualizar un documento para que se repita. No lo permite porque va contra la restricci�n.

update empleados set documento = '11122255' where nombre = 'percy perez'; 

-- Intente establecer otra restricci�n "primary key" con el campo "nombre".

alter table empleados
add constraint PK_EMPLEADOS_NOMBRE
primary key(nombre);

-- Vea las restricciones de la tabla "empleados" consultando el cat�logo "user_constraints" (1 restricci�n "P")

select * from user_constraints where table_name = 'EMPLEADOS';

-- Consulte el cat�logo "user_cons_columns"

select * from user_cons_columns where table_name = 'EMPLEADOS';

-- Ejercicio 2 

drop table remis;

create table remis(
  numero number(5),
  patente char(6),
  marca varchar2(15),
  modelo char(4)
);

-- Ingrese algunos registros sin repetir patente y repitiendo n�mero.

insert into remis values (123,'luis','EC2','xyz');
insert into remis values (124,'marcos','EC2','exy');
insert into remis values (124,'alex','EC2','exy');

-- Ingrese un registro con patente nula.

insert into remis values (126,null,'EC2','exy');

-- Intente definir una restricci�n "primary key" para el campo "numero".

alter table remis
add constraint PK_REMIS_NUMERO
primary key(numero);

-- Intente establecer una restricci�n "primary key" para el campo "patente".

alter table remis
add constraint PK_REMIS_PATENTE
primary key(patente);

-- Modifique el valor "null" de la patente.

update remis set patente = 'mario' where numero = 126;

-- Establezca una restricci�n "primary key" PATENTE

-- Vea la informaci�n de las restricciones consultando "user_constraints" (1 restricci�n "P")

select * from user_constraints where table_name = 'REMIS';

-- Consulte el cat�logo "user_cons_columns" y analice la informaci�n retornada (1 restricci�n)

select * from user_cons_columns where table_name = 'REMIS';


