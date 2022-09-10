/*

Para eliminar una restricci�n, la sintaxis b�sica es la siguiente:

 alter table NOMBRETABLA
  drop constraint NOMBRERESTRICCION;
  
Cuando eliminamos una tabla, todas las restricciones que fueron establecidas en ella, se eliminan tambi�n.

La condici�n de control que debe cumplir una restricci�n de control no puede modificarse, 
hay que eliminar la restricci�n y volver a crearla; igualmente con las restricciones "primary key" y "unique", 
no pueden modificarse los campos.

*/

drop table libros;

create table libros(
  codigo number(5) not null,
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(15),
  precio number(6,2)
);

-- Definimos una restricci�n "primary key" para nuestra tabla "libros" para asegurarnos que cada libro tendr� 
-- un c�digo diferente y �nico:

alter table libros
add constraint PK_LIBROS_CODIGO
primary key(codigo);

-- Definimos una restricci�n "check" para asegurarnos que el precio no ser� negativo:

alter table libros
add constraint CK_LIBROS_PRECIO
check (precio > 0);

-- Definimos una restricci�n "unique" para los campos "titulo", "autor" y "editorial":

alter table libros
add constraint UQ_LIBROS
unique (titulo, autor, editorial);

-- Vemos las restricciones:

select * from user_constraints where table_name = 'LIBROS';

/*
Aparecen 4 restricciones:

- 1 "check" que controla que el precio sea positivo

- 1 "check" , que se cre� al definir "not null" el campo "codigo", el nombre le fue dado por Oracle

- 1 "primary key" 

- 1 "unique".

*/

-- Eliminamos la restricci�n "PK_libros_codigo"

alter table libros
drop constraint PK_LIBROS_CODIGO;

-- Eliminamos la restricci�n de control "CK_libros_precio"

alter table libros
drop constraint CK_LIBROS_PRECIO;

-- Vemos si se eliminaron:

select * from user_constraints where table_name = 'LIBROS';

-- solo aparecen 2 restricciones (1 de not null, creada al definir el PK y la restriccion UNIQUE

-- Ejercicio 1

-- Setee el formato de "date" para que nos muestre hora y minutos

 ALTER SESSION SET NLS_DATE_FORMAT = 'HH24:MI';

drop table vehiculos;

create table vehiculos(
  patente char(6) not null,
  tipo char(1),--'a'=auto, 'm'=moto
  horallegada date not null,
  horasalida date
);

-- Establezca una restricci�n "check" que admita solamente los valores "a" y "m" para el campo "tipo"

alter table vehiculos
add constraint CK_VEHICULOS_TIPO
check (tipo in ('a', 'm'));

-- Agregue una restricci�n "primary key" que incluya los campos "patente" y "horallegada"

alter table vehiculos
add constraint PK_VEHICULOS
primary key(patente,horallegada);

-- Ingrese un veh�culo

insert into vehiculos values ('111222','a','18:00','20:00');

-- Intente ingresar un registro repitiendo la clave primaria.

insert into vehiculos values ('111222','m','18:00','21:00');

-- Ingrese un registro repitiendo la patente pero no la hora de llegada.

insert into vehiculos values ('111222','m','18:01','21:00');

-- Ingrese un registro repitiendo la hora de llegada pero no la patente.

insert into vehiculos values ('222333','a','18:00','20:00');

-- Vea todas las restricciones para la tabla "vehiculos"
-- aparecen 4 filas, 3 correspondientes a restricciones "check" y 1 a "primary key". Dos de las restricciones de 
-- control tienen nombres dados por Oracle.

select * from user_constraints where table_name = 'VEHICULOS';

-- Elimine la restricci�n "primary key"

alter table vehiculos
drop constraint  PK_VEHICULOS;

-- Vea si se ha eliminado. Ahora aparecen 3 restricciones.

select * from user_constraints where table_name = 'VEHICULOS';

-- Elimine la restricci�n de control que establece que el campo "patente" no sea nulo 
-- (busque el nombre consultando "user_constraints").

alter table vehiculos
drop constraint SYS_C008441;

alter table vehiculos
drop constraint SYS_C008442;

-- Vea si se han eliminado.

select * from user_constraints where table_name = 'VEHICULOS';

-- Vuelva a establecer la restricci�n "primary key" eliminada.

alter table vehiculos
add constraint PK_VEHICULOS
primary key(patente,horallegada);

-- La playa quiere incluir, para el campo "tipo", adem�s de los valores permitidos "a" (auto) y "m" (moto), el caracter 
--"c" (cami�n). No puede modificar la restricci�n, debe eliminarla y luego redefinirla con los 3 valores.

alter table vehiculos
drop constraint CK_VEHICULOS_TIPO;

alter table vehiculos
add constraint CK_VEHICULOS_TIPO
check (tipo in ('a','m','c'));

-- Consulte "user_constraints" para ver si la condici�n de chequeo de la restricci�n "CK_vehiculos_tipo" se ha modificado.

select * from user_constraints where table_name = 'VEHICULOS';



