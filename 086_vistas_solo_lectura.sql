/*
Con la cláusula "with read only" (sólo lectura) evitamos que se puedan realizar inserciones, actualizaciones y eliminaciones 
mediante una vista.

Sintaxis:

 create view NOMBREVISTA
 as SUBCONSULTA
 with read only;

Evitamos que Oracle acepte "insert", "update" o "delete" sobre la vista si colocamos "with read only" luego de la subconsulta 
que define una vista.

Por ejemplo, creamos la siguiente vista:

 create view vista_empleados
 as
  select apellido, nombre, sexo, seccion
  from empleados
  with read only;

Oracle responde con un mensaje de error ante cualquier "insert", "update" o "delete" realizado sobre la vista.
*/

 drop table empleados;

 create table empleados(
  documento char(8),
  sexo char(1)
   constraint CK_empleados_sexo check (sexo in ('f','m')),
  apellido varchar2(20),
  nombre varchar2(20),
  domicilio varchar2(30),
  seccion varchar2(30),
  cantidadhijos number(2),
  constraint CK_empleados_hijos check (cantidadhijos>=0),
  estadocivil char(10)
   constraint CK_empleados_estadocivil check (estadocivil in ('casado','divorciado','soltero','viudo')),
  fechaingreso date
);

 insert into empleados values('22222222','f','Lopez','Ana','Colon 123','Administracion',2,'casado','10/10/1990');
 insert into empleados values('23333333','m','Lopez','Luis','Sucre 235','Administracion',0,'soltero','02/10/1990');
 insert into empleados values('24444444','m','Garcia','Marcos','Sarmiento 1234','Contaduria',3,'divorciado','07/12/1998');
 insert into empleados values('25555555','m','Gomez','Pablo','Bulnes 321','Contaduria',2,'casado','10/09/1998');
 insert into empleados values('26666666','f','Perez','Laura','Peru 1254','Sistemas',3,'casado','05/09/2000');
 
-- Eliminamos las vistas "vista_empleados" y "vista_empleados2":

 drop view vista_empleados;
 drop view vista_empleados2;

-- Creamos la vista "vista_empleados", que muestra solamente algunos campos de "empleados":
 
 create view vista_empleados as 
 select apellido, nombre, sexo, seccion from empleados;
 
 -- Creamos la vista "vista_empleados2", igual que "vista_empleados", pero ahora colocamos "with read only" para 
 -- impedir que puedan ejecutarse "insert", "update" y "delete" sobre esta vista:

create view vista_empleados2 as 
select apellido, nombre, sexo, seccion from empleados
with read only;

-- Actualizamos el nombre de un empleado a través de la vista "vista_empleados":

update vista_empleados set nombre = 'Beatriz' where nombre = 'Ana';

-- Veamos si la modificación se realizó en la tabla:

select * from empleados;

-- Intentamos actualizar el nombre de un empleado a través de la vista "vista_empleados2":
-- No lo permite 

update vista_empleados2 set nombre = 'Pedro' where nombre = 'Marcos';

-- Ingresamos un registro en la tabla "empleados" a través de la vista "vista_empleados":

insert into vista_empleados values ('Juarez', 'Juan', 'm', 'Sistemas');

-- Oracle acepta la inserción. Verificamos que la inserción se realizó en la tabla:

select * from empleados;

-- Intentamos ingresar un registro a través de la vista "vista_empleados2":
-- Oracle no lo permite porque la vista fue definida con "with read only".

insert into vista_empleados2 values('Gimenez','Julieta','f','Sistemas');

-- Eliminamos un registro en la tabla "empleados" a través de la vista "vista_empleados":

delete from vista_empleados where apellido = 'Juarez';

-- Oracle acepta la eliminación. Verificamos que la eliminación se realizó en la tabla:

select * from empleados;

-- Intentamos eliminar registros a través de la vista "vista_empleados2":

delete from vista_empleados2 where apellido = 'Lopez';

-- Oracle no lo permite porque la vista fue definida con "with read only".

-- Ejercicio 1 

 drop table clientes cascade constraints;

 create table clientes(
  nombre varchar2(40),
  documento char(8),
  domicilio varchar2(30),
  ciudad varchar2(30)
 );

 insert into clientes values('Juan Perez','22222222','Colon 1123','Cordoba');
 insert into clientes values('Karina Lopez','23333333','San Martin 254','Cordoba');
 insert into clientes values('Luis Garcia','24444444','Caseros 345','Cordoba');
 insert into clientes values('Marcos Gonzalez','25555555','Sucre 458','Santa Fe');
 insert into clientes values('Nora Torres','26666666','Bulnes 567','Santa Fe');
 insert into clientes values('Oscar Luque','27777777','San Martin 786','Santa Fe');
 insert into clientes values('Pedro Perez','28888888','Colon 234','Buenos Aires');
 insert into clientes values('Rosa Rodriguez','29999999','Avellaneda 23','Buenos Aires');

-- Cree o reemplace la vista "vista_clientes" para que recupere el nombre y ciudad de todos los clientes

-- Cree o reemplace la vista "vista_clientes2" para que recupere el nombre y ciudad de todos los clientes no permita 
-- modificaciones.

-- Consulte ambas vistas

-- Intente ingresar el siguiente registro mediante la vista que permite sólo lectura
-- Oracle no lo permite.

-- Ingrese el registro anterior en la vista "vista_clientes"

-- Intente modificar un registro mediante la vista que permite sólo lectura

-- Actualice el registro anterior en la vista "vista_clientes"

-- Intente eliminar un registro mediante la vista "vista_clientes2"

-- Elimine todos los clientes de "Buenos Aires" a través de la vista "vista_clientes"
