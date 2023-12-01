/*
La restricción "unique" impide la duplicación de claves alternas (no primarias), es decir, 
especifica que dos registros no puedan tener el mismo valor en un campo. Se permiten valores nulos.

Se pueden aplicar varias restricciones de este tipo a una misma tabla, y pueden aplicarse a uno o varios 
campos que no sean clave primaria.

Se emplea cuando ya se estableció una clave primaria (como un número de legajo) pero se necesita asegurar 
que otros datos también sean únicos y no se repitan (como número de documento).

La sintaxis general es la siguiente:

 alter table NOMBRETABLA
 add constraint NOMBRERESTRICCION
 unique (CAMPO);

Por convención, cuando demos el nombre a las restricciones "unique" seguiremos la misma estructura:

"UQ_NOMBRETABLA_NOMBRECAMPO". Quizá parezca innecesario colocar el nombre de la tabla

Cuando agregamos una restricción a una tabla que contiene información, Oracle controla los datos existentes 
para confirmar que cumplen la condición de la restricción, si no los cumple, la restricción no se aplica y 
aparece un mensaje de error.

Un campo que se estableció como clave primaria no puede definirse como clave única; si una tabla tiene una 
clave primaria, puede tener una o varias claves únicas (aplicadas a otros campos que no sean clave primaria).

Si consultamos el catálogo "user_constraints", podemos ver las restricciones "unique" (y todos los tipos de restricciones) 
de todas las tablas del usuario actual. El resultado es una tabla que nos informa el propietario de la restricción (OWNER), 
el nombre de la restricción (CONSTRAINT_NAME), el tipo (CONSTRAINT_TYPE, si es "unique" muestra una "U"), 
el nombre de la tabla en la cual se aplica (TABLE_NAME), y otra información que no analizaremos por el momento.

También podemos consultar el catálogo "user_cons_columns"; nos mostrará el propietario de la restricción (OWNER), 
el nombre de la restricción (CONSTRAINT_NAME), la tabla a la cual se aplica (TABLE_NAME), el campo 
(COLUMN_NAME) y la posición (POSITION).

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

drop table remis;
  
create table remis(
  numero number(5),
  patente char(6),
  marca varchar2(15),
  modelo char(4)
);
  
-- Ingrese algunos registros, 2 de ellos con patente repetida y alguno con patente nula.

insert into remis values(12345,'aaa444','aksdjfl','aaaa');
insert into remis values(12346,'aaa444','aksdjfl','aabb');
insert into remis values(12345,null,'aksdjfl','aaaa');

-- Agregue una restricción "primary key" para el campo "numero".

update remis set numero=12347 where patente is null;

alter table remis
add constraint PK_REMIS_NUMERO
primary key(numero);

-- Intente agregar una restricción "unique" para asegurarse que la patente del remis no tomará valores repetidos.

update remis set patente='cc444' where patente is null;
update remis set patente='bbb444' where numero = 12345;

alter table remis
add constraint UQ_REMIS_PATENTE
unique(patente);

-- Intente ingresar un registro con patente repetida (no lo permite)

insert into remis values(12395,'aaa444','aksdjfl','aaaa');

-- Ingrese un registro con valor nulo para el campo "patente".

insert into remis values(12395,null,'aksdjfl','aaaa'); -- agrega el registro a pesar que es nulo

insert into remis values(12385,null,'aksdjfl','aaaa'); -- agrega el registro a pesar que es nulo

-- Muestre la información de las restricciones consultando "user_constraints" y "user_cons_columns" y 
-- analice la información retornada (2 filas en cada consulta)

select * from user_constraints where table_name like '%REMIS%';

select * from user_cons_columns where table_name like '%REMIS%';

select * from remis;