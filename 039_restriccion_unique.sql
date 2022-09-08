/*
La restricci�n "unique" impide la duplicaci�n de claves alternas (no primarias), es decir, 
especifica que dos registros no puedan tener el mismo valor en un campo. Se permiten valores nulos.

Se pueden aplicar varias restricciones de este tipo a una misma tabla, y pueden aplicarse a uno o varios 
campos que no sean clave primaria.

Se emplea cuando ya se estableci� una clave primaria (como un n�mero de legajo) pero se necesita asegurar 
que otros datos tambi�n sean �nicos y no se repitan (como n�mero de documento).

La sintaxis general es la siguiente:

 alter table NOMBRETABLA
 add constraint NOMBRERESTRICCION
 unique (CAMPO);

Por convenci�n, cuando demos el nombre a las restricciones "unique" seguiremos la misma estructura:

"UQ_NOMBRETABLA_NOMBRECAMPO". Quiz� parezca innecesario colocar el nombre de la tabla

Cuando agregamos una restricci�n a una tabla que contiene informaci�n, Oracle controla los datos existentes 
para confirmar que cumplen la condici�n de la restricci�n, si no los cumple, la restricci�n no se aplica y 
aparece un mensaje de error.

Un campo que se estableci� como clave primaria no puede definirse como clave �nica; si una tabla tiene una 
clave primaria, puede tener una o varias claves �nicas (aplicadas a otros campos que no sean clave primaria).

Si consultamos el cat�logo "user_constraints", podemos ver las restricciones "unique" (y todos los tipos de restricciones) 
de todas las tablas del usuario actual. El resultado es una tabla que nos informa el propietario de la restricci�n (OWNER), 
el nombre de la restricci�n (CONSTRAINT_NAME), el tipo (CONSTRAINT_TYPE, si es "unique" muestra una "U"), 
el nombre de la tabla en la cual se aplica (TABLE_NAME), y otra informaci�n que no analizaremos por el momento.

Tambi�n podemos consultar el cat�logo "user_cons_columns"; nos mostrar� el propietario de la restricci�n (OWNER), 
el nombre de la restricci�n (CONSTRAINT_NAME), la tabla a la cual se aplica (TABLE_NAME), el campo 
(COLUMN_NAME) y la posici�n (POSITION).

*/

drop table alumnos;

create table alumnos(
  legajo char(4),
  apellido varchar2(20),
  nombre varchar2(20),
  documento char(8)
);

alter table alumnos
add constraint PK_ALUMNOS_LEGAJO
primary key(legajo);

alter table alumnos
add constraint UQ_ALUMNOS_DOCUMENTO
unique(documento);

insert into alumnos values('A111','Lopez','Ana','22223212');
insert into alumnos values('A123','Garcia','Maria','23333333');
insert into alumnos values('A230','Perez','Juan','23333433');
insert into alumnos values('A124','Suarez','Silvana','30111222');

-- validando en user_constraints 

select * from user_constraints where table_name='ALUMNOS';

-- validando en user_cons_columns 

select * from user_cons_columns where table_name='ALUMNOS';

-- Ejercicio 1

