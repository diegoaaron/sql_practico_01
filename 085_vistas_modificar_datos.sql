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


 
 