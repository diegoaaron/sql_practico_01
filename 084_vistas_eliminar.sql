/*
Para quitar una vista se emplea "drop view":

 drop view NOMBREVISTA;
Eliminamos la vista denominada "vista_empleados":

 drop view vista_empleados;
Si se elimina una tabla a la que hace referencia una vista, la vista no se elimina, hay que eliminarla explícitamente.
*/

 drop table empleados;
 drop table secciones;

 create table secciones(
  codigo number(2),
  nombre varchar2(20),
  sueldo number(5,2),
  constraint CK_secciones_sueldo check (sueldo>=0),
  constraint PK_secciones primary key (codigo)
 );

 create table empleados(
  legajo number(3),
  documento char(8),
  sexo char(1),
  constraint CK_empleados_sexo check (sexo in ('f','m')),
  apellido varchar2(20),
  nombre varchar2(20),
  domicilio varchar2(30),
  seccion number(2) not null,
  cantidadhijos number(2),
  constraint CK_empleados_hijos check (cantidadhijos>=0),
  estadocivil char(10),
  constraint CK_empleados_estadocivil check (estadocivil in ('casado','divorciado','soltero','viudo')),
  fechaingreso date,
  constraint PK_empleados primary key (legajo),
  constraint FK_empleados_seccion
   foreign key (seccion)
   references secciones(codigo),
  constraint UQ_empleados_documento
   unique(documento)
 );

 insert into secciones values(1,'Administracion',300);
 insert into secciones values(2,'Contaduría',400);
 insert into secciones values(3,'Sistemas',500);

 insert into empleados
  values(100,'22222222','f','Lopez','Ana','Colon 123',1,2,'casado','10/10/1990');
 insert into empleados
  values(101,'23333333','m','Lopez','Luis','Sucre 235',1,0,'soltero','02/10/1990');
 insert into empleados 
  values(102,'24444444','m','Garcia','Marcos','Sarmiento 1234',2,3,'divorciado','07/12/1998');
 insert into empleados
  values(103,'25555555','m','Gomez','Pablo','Bulnes 321',3,2,'casado','10/09/1998');
 insert into empleados
 values(104,'26666666','f','Perez','Laura','Peru 1254',3,3,'casado','05/09/2000');
 
  -- Eliminamos la vista "vista_empleados":
drop view vista_empleados;

-- Creamos la vista "vista_empleados", que es resultado de una combinación en la  cual se muestran 5 campos:

create view vista_empleados as
select (apellido || ' ' || e.nombre) as nombre, sexo, s.nombre as seccion, cantidadhijos
from empleados e
join secciones s
on codigo = seccion;

 -- Veamos la información de la vista:

select * from vista_empleados;

-- Eliminamos la tabla "empleados":

drop table empleados;

-- Verificamos que la vista aún existe consultando "user_objects":

select * from user_objects where object_name = 'VISTA_EMPLEADOS';

-- Verificamos que la vista "vista_empleados" aún existe consultando "user_catalog":

select * from user_catalog where table_type = 'VIEW';

 -- Si consultamos la vista, aparecerá un mensaje de error, pues la tabla "empleados" a la cual hace referencia la vista, no existe:

select * from vista_empleados;

-- Eliminamos la vista:

drop view vista_empleados;

-- Verificamos que la vista ya no existe:

select * from user_catalog where table_name = 'VISTA_EMPLEADOS';

-- Ejercicio 1 

 drop table empleados;
 drop table secciones;

 create table secciones(
  codigo number(2),
  nombre varchar2(20),
  sueldo number(5,2),
  constraint CK_secciones_sueldo check (sueldo>=0),
  constraint PK_secciones primary key (codigo)
 );

 create table empleados(
  legajo number(3),
  documento char(8),
  sexo char(1),
  constraint CK_empleados_sexo check (sexo in ('f','m')),
  apellido varchar2(20),
  nombre varchar2(20),
  domicilio varchar2(30),
  seccion number(2) not null,
  cantidadhijos number(2),
  constraint CK_empleados_hijos check (cantidadhijos>=0),
  estadocivil char(10),
  constraint CK_empleados_estadocivil check (estadocivil in ('casado','divorciado','soltero','viudo')),
  fechaingreso date,
  constraint PK_empleados primary key (legajo),
  constraint FK_empleados_seccion
   foreign key (seccion)
   references secciones(codigo),
  constraint UQ_empleados_documento
   unique(documento)
);

 insert into secciones values(1,'Administracion',300);
 insert into secciones values(2,'Contaduría',400);
 insert into secciones values(3,'Sistemas',500);

 insert into empleados values(100,'22222222','f','Lopez','Ana','Colon 123',1,2,'casado','10/10/1990');
 insert into empleados values(101,'23333333','m','Lopez','Luis','Sucre 235',1,0,'soltero','02/10/1990');
 insert into empleados values(102,'24444444','m','Garcia','Marcos','Sarmiento 1234',2,3,'divorciado','07/12/1998');
 insert into empleados values(103,'25555555','m','Gomez','Pablo','Bulnes 321',3,2,'casado','10/09/1998');
 insert into empleados values(104,'26666666','f','Perez','Laura','Peru 1254',3,3,'casado','05/09/2000');
 
-- Eliminamos la vista "vista_empleados":

drop view vista_emleados;
 
 -- Creamos la vista "vista_empleados", que es resultado de una combinación en la cual se muestran 5 campos:

create view vista_empleados as 
select (apellido || ' ' || e.nombre) as nombre, sexo, s.nombre as seccion, cantidadhijos 
from empleados e
join secciones s
on codigo = seccion;

-- Veamos la información de la vista:

select * from vista_empleados;

-- Eliminamos la tabla "empleados":

drop table empleados;

-- Verificamos que la vista aún existe consultando "user_objects":

select * from user_objects where object_name = 'VISTA_EMPLEADOS';

-- Verificamos que la vista "vista_empleados" aún existe consultando "user_catalog":

select * from user_catalog where table_type = 'VIEW';

-- Si consultamos la vista, aparecerá un mensaje de error, pues la tabla "empleados" a la cual hace referencia la vista, no existe:

select * from vista_empleados;

-- Eliminamos la vista

drop view vista_empleados;

-- Verificamos que la vista ya no existe:

select * from user_catalog where table_name = 'VISTA_EMPLEADOS';
