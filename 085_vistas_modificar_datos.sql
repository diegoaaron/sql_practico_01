/*
Si se modifican los datos de una vista, se modifica la tabla base.

Se puede insertar, actualizar o eliminar datos de una tabla a través de una vista, teniendo en cuenta lo siguiente, las 
modificaciones que se realizan a las vistas:

- no pueden afectar a más de una tabla consultada. Pueden modificarse y eliminarse datos de una vista que combina varias 
tablas pero la modificación o eliminación solamente debe afectar a una sola tabla.

- no se pueden cambiar los campos resultado de un cálculo.

- pueden generar errores si afectan a campos a las que la vista no hace referencia. Por ejemplo, si se ingresa un registro en 
una vista que consulta una tabla que tiene campos not null que no están incluidos en la vista.
*/

drop table empleados;
drop table secciones;

 create table secciones(
  codigo number(2),
  nombre varchar2(20),
  constraint PK_secciones primary key (codigo)
 );

 create table empleados(
  legajo number(4) not null,
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
  sueldo number(6,2),
  constraint CK_empleados_sueldo check (sueldo>=0),
  constraint FK_empleados_seccion
   foreign key (seccion)
   references secciones(codigo),
  constraint UQ_empleados_documento
   unique(documento)
);

 insert into secciones values(1,'Administracion');
 insert into secciones values(2,'Contaduría');
 insert into secciones values(3,'Sistemas');

 insert into empleados values(100,'22222222','f','Lopez','Ana','Colon 123',1,2,'casado','10/10/1990',600);
 insert into empleados values(101,'23333333','m','Lopez','Luis','Sucre 235',1,0,'soltero','02/10/1990',650);
 insert into empleados values(103,'24444444', 'm', 'Garcia', 'Marcos', 'Sarmiento 1234', 2, 3, 'divorciado', '07/12/1998',800);
 insert into empleados values(104,'25555555','m','Gomez','Pablo','Bulnes 321',3,2,'casado','10/09/1998',900);
 insert into empleados values(105,'26666666','f','Perez','Laura','Peru 1254',3,3,'casado','05/09/2000',700);
 
 -- Eliminamos la vista "vista_empleados":

drop view vista_empleados;
 
 -- Creamos la vista "vista_empleados", que es resultado de una combinación en la cual se muestran 5 campos:

create view vista_empleados as 
select (apellido || ' ' || e.nombre) as nombre, sexo, s.nombre as seccion, cantidadhijos from empleados e
join secciones s
on codigo = seccion;

-- Vemos la información contenida en la vista:

select * from vista_empleados;
 
 -- Eliminamos la vista "vista_empleados2":

drop view vista_empleados2;
 
 -- Creamos otra vista de "empleados" denominada "vista_empleados2" que consulta solamente la tabla "empleados":

create view vista_empleados2 as 
select legajo, nombre, apellido, fechaingreso, seccion, sueldo from empleados
where sueldo >= 600;
 
 -- Consultamos la vista:

select * from vista_empleados2;
 
 -- No podemos ingresar un registro en la vista "vista_empleados" porque tal vista tiene campos calculados ("nombre", que 
 -- es una concatenación de "apellido" y "nombre"), además afecta a 2 tablas ("empleados" y "secciones") y hay campos no 
 -- accesibles desde la vista que no admiten valores nulos. Si ejecutamos el siguiente "insert", Oracle mostrará un mensaje 
 -- de error:
 
 insert into vista_empleados values('Pedro Perez', 'm', 'Sistemas', 2);
 
 -- Podemos ingresar un registro en la vista "vista_empleados2" porque tal vista afecta a una sola tabla y los campos 
 -- de ""empleados" no accesibles desde la vista admiten valores nulos:

insert into vista_empleados2 values(200, 'Pedro', 'Perez', '10/10/2000', 2, 800);
 
 -- Vemos la tabla "empleados" para comprobar que el nuevo registro insertado desde la vista está presente en "empleados", 
 -- los campos para los cuales no se ingresaron datos, almacenan el valor "null":

select * from empleados;
 
 -- Actualizamos el campo "nombre" de un registro de la vista "vista_empleados2":

update vista_empleados2 set nombre = 'Beatriz' where nombre = 'Ana';

-- Verificamos que se actualizó la tabla:

select * from empleados;

-- Si intentamos actualizar el campo "nombre" de un empleado a través de la vista "vista_empleados", Oracle no lo permite 
-- porque es una columna calculada (concatenación de dos campos):

update vista_empleados set nombre = 'Lopez Carmen' where nombre = 'Lopez Beatriz';

-- Si podemos actualizar otros campos, por ejemplo, el campo "cantidadhijos" de un empleado a través de la vista 
-- "vista_empleados":

update vista_empleados set cantidadhijos = 3
where nombre = 'Lopez Beatriz';

-- Verificamos que se actualizo la tabla

select * from empleados;

-- Eliminamos un registro de "empleados" a través de la vista "vista_empleados2":

delete from vista_empleados2 where apellido = 'Lopez' and nombre = 'Beatriz';

-- Verificamos que se eliminó tal registro de la tabla "empleados":

select * from empleados;

-- Podemos eliminar registros de empleados a través de la vista "vista_empleados":

delete from vista_empleados where seccion = 'Administracion';

-- Verificamos que no hay registros en "empleados" de la sección "1" ("Administracion"):

 select *from empleados;

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
 insert into inscriptos values('30000000',3,'n');
 insert into inscriptos values('30000000',6,null);
 insert into inscriptos values('31111111',1,'s');
 insert into inscriptos values('31111111',4,'s');
 insert into inscriptos values('32222222',1,'s');
 insert into inscriptos values('32222222',7,'s');
 
 -- Realice un join para mostrar todos los datos de todas las tablas, sin repetirlos (7 registros)

select documento, nombre, domicilio, c.numero, deporte, dia, profesor, matricula
from socios s
inner join inscriptos i
on s.documento = documentosocio
inner join cursos c
on c.numero = i.numero;

-- Elimine la vista "vista_cursos"

drop view vista_cursos;

-- Cree la vista "vista_cursos" que muestre el número, deporte y día de todos los cursos.

create view vista_cursos as
select numero, deporte, dia from cursos;

-- Consulte la vista ordenada por deporte (7 registros)

select * from vista_cursos 
order by deporte;

-- Ingrese un registro mediante la vista "vista_cursos" y vea si afectó a "cursos"

insert into vista_cursos values(8,'futbol','martes');

select * from cursos;

-- Actualice un registro sobre la vista y vea si afectó a la tabla "cursos"

update vista_cursos set dia = 'miercoles' where numero = 8;

select * from cursos;

-- Elimine un registro de la vista para el cual no haya inscriptos y vea si afectó a "cursos"

delete from vista_cursos where numero = 8;

select * from cursos;

-- Intente eliminar un registro de la vista para el cual haya inscriptos

delete from vista_cursos where numero = 1;

-- Elimine la vista "vista_inscriptos" y créela para que muestre el documento y nombre del socio, el numero de curso, 
-- el deporte y día de los cursos en los cuales está inscripto

drop view vista_inscriptos;

create view vista_inscriptos as
select i.documentosocio, s.nombre, i.numero, c.deporte, dia from inscriptos i
inner join socios s
on s.documento = documentosocio
inner join cursos c
on c.numero = i.numero;

-- Intente ingresar un registro en la vista:
-- No lo permite porque la modificación afecta a más de una tabla base.

insert into vista_inscriptos values('32222222','Hector Huerta',6,'futbol','lunes');

-- Intente actualizar el documento de un socio (no lo permite)

 update vista_inscriptos set documentosocio='30000111' where documentosocio='30000000';

-- Elimine un registro mediante la vista

 delete from vista_inscriptos where documentosocio='30000000' and deporte='tenis';

-- Verifique que el registro se ha eliminado de "inscriptos"

select * from inscriptos; 

