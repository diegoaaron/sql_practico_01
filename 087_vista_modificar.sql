/*
Para modificar una vista puede eliminarla y volver a crearla o emplear "create or replace".

Sintaxis:

 create or replace view NOMBREVISTA
  as SUBCONSULTA;
  
Con "create or replace view" se modifica la definición de una vista existente o se crea si no existe.
*/

 drop table empleados;
 drop table secciones;

 create table secciones(
  codigo number(2),
  nombre varchar2(20),
  constraint PK_secciones primary key (codigo)
 );

 create table empleados(
  documento char(8),
  nombre varchar2(30),
  domicilio varchar2(30),
  seccion number(2) not null,
  constraint FK_empleados_seccion
   foreign key (seccion)
   references secciones(codigo),
  constraint PK_empleados
   primary key (documento)
);

 insert into secciones values(1,'Administracion');
 insert into secciones values(2,'Contaduría');
 insert into secciones values(3,'Sistemas');

 insert into empleados values('22222222','Lopez Ana','Colon 123',1);
 insert into empleados values('23333333','Lopez Luis','Sucre 235',1);
 insert into empleados values('24444444','Garcia Marcos','Sarmiento 1234',2);
 insert into empleados values('25555555','Gomez Pablo','Bulnes 321',3);
 insert into empleados values('26666666','Perez Laura','Peru 1254',3);
 
 -- Eliminamos la vista "vista_empleados":

  drop view vista_empleados;

-- Creamos la vista "vista_empleados" que muestre algunos campos de los empleados de la sección 1:

create view vista_empleados as 
select documento, nombre, seccion from empleados
where seccion = 1;

-- Consultamos la vista:

select * from vista_empleados;

-- Veamos el texto de la vista consultando "user_views":
-- "text" muestra el select con el que se creo la vista 

 select view_name,text from user_views 
 where view_name = 'VISTA_EMPLEADOS';

-- Modificamos la vista para que muestre el domicilio:

create or replace view vista_empleados as
select documento, nombre, seccion, domicilio from empleados
where seccion = 1;

-- Consultamos la vista para ver si se modificó:

select * from vista_empleados;

-- Veamos el texto de la vista consultando "user_views":

 select view_name, text from user_views 
 where view_name='VISTA_EMPLEADOS';

