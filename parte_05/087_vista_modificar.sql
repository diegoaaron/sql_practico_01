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

-- Ejercicio 1 

 drop table inscriptos;
 drop table socios;
 drop table cursos;

 create table socios(
  documento char(8) not null,
  nombre varchar2(40),
  domicilio varchar2(30),
  constraint PK_socios_documento
   primary key (documento)
 );

 create table cursos(
  numero number(2),
  deporte varchar2(20),
  dia varchar2(15),
  constraint CK_inscriptos_dia check (dia in('lunes','martes','miercoles','jueves','viernes','sabado')),
  profesor varchar2(20),
  constraint PK_cursos_numero
   primary key (numero)
 );

 create table inscriptos(
  documentosocio char(8) not null,
  numero number(2) not null,
  matricula char(1),
  constraint PK_inscriptos_documento_numero
   primary key (documentosocio,numero),
  constraint FK_inscriptos_documento
   foreign key (documentosocio)
   references socios(documento),
  constraint FK_inscriptos_numero
   foreign key (numero)
   references cursos(numero)
  );

 insert into socios values('30000000','Fabian Fuentes','Caseros 987');
 insert into socios values('31111111','Gaston Garcia','Guemes 65');
 insert into socios values('32222222','Hector Huerta','Sucre 534');
 insert into socios values('33333333','Ines Irala','Bulnes 345');

 insert into cursos values(1,'tenis','lunes','Ana Acosta');
 insert into cursos values(2,'tenis','martes','Ana Acosta');
 insert into cursos values(3,'natacion','miercoles','Ana Acosta');
 insert into cursos values(4,'natacion','jueves','Carlos Caseres');
 insert into cursos values(5,'futbol','sabado','Pedro Perez');
 insert into cursos values(6,'futbol','lunes','Pedro Perez');
 insert into cursos values(7,'basquet','viernes','Pedro Perez');

 insert into inscriptos values('30000000',1,'s');
 insert into inscriptos values('30000000',3,'s');
 insert into inscriptos values('30000000',6,null);
 insert into inscriptos values('31111111',1,'n');
 insert into inscriptos values('31111111',4,'s');
 insert into inscriptos values('32222222',1,'n');
 insert into inscriptos values('32222222',7,'n');
 
 -- Cree o reemplace la vista "vista_inscriptos" que muestre el documento y nombre del socio, el deporte, el día y la matrícula, de todas las 
 -- inscripciones no pagas

create or replace view vista_deudores as
select documento, nombre, c.deporte, c.dia, matricula from socios s
inner join inscriptos i
on documento = documentosocio
inner join cursos c
on c.numero = i.numero
where matricula = 'n';

-- Consulte la vista

select * from vista_deudores;

-- Veamos el texto de la vista

select view_name, text from user_views
where view_name = 'VISTA_DEUDORES';

-- Modifique la vista para que muestre el domicilio
  
  create or replace view vista_deudores as 
  select documento, nombre, domicilio, c.deporte, c.dia, matricula from socios s
  inner join inscriptos i 
  on documento = documentosocio
  inner join cursos c
  on c.numero = i.numero
  where matricula = 'n';

-- Consulte la vista para ver si se modificó

select * from vista_deudores;

-- Vea el texto de la vista

select view_name, text from user_views
where view_name = 'VISTA_DEUDORES';
