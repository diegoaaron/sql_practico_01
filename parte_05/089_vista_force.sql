/*
Cuando creamos una vista, Oracle verifica que las tablas a las cuales se hace referencia en ella existan. Si la vista que se 
intenta crear hace referencia a tablas inexistentes, Oracle muestra un mensaje de error.

Podemos "forzar" a Oracle a crear una vista aunque no existan los objetos (tablas, vistas, etc.) que referenciamos en la misma. 
Para ello debemos agregar "force" al crearla:

 create force view NOMBREVISTA
  as SUBCONSULTA;

De esta manera, podemos crear una vista y después las tablas involucradas; luego, al consultar la vista, DEBEN existir las tablas.

Al crear la vista la opción predeterminada es "no force". Se recomienda crear las tablas y luego las vistas necesarias.

Otra cuestión a considerar es la siguiente: si crea una vista con "select *" y luego agrega campos a la estructura de las tablas 
involucradas, los nuevos campos no aparecerán en la vista; esto es porque los campos se seleccionan al ejecutar "create view"; 
debe volver a crear la vista (con "create view" o "create or replace view").
*/

 drop table empleados;
 drop view vista_empleados;

 create force view vista_empleados  as
  select documento,nombre,seccion
  from empleados;

 create table empleados(
  documento char(8),
  nombre varchar2(30),
  domicilio varchar2(30),
  seccion varchar2(30)
);

 insert into empleados values('22222222','Lopez Ana','Colon 123','Sistemas');
 insert into empleados values('23333333','Lopez Luis','Sucre 235','Sistemas');
 insert into empleados values('24444444','Garcia Marcos','Sarmiento 1234','Contaduria');
 insert into empleados values('25555555','Gomez Pablo','Bulnes 321','Contaduria');
 insert into empleados values('26666666','Perez Laura','Peru 1254','Secretaria');
 
 -- Consultamos la vista:

select * from vista_empleados;
 
 -- Veamos el texto de la vista consultando "user_views":

select view_name, text from user_views 
where view_name = 'VISTA_EMPLEADOS';
 
 -- Creamos o reemplazamos (si existe) la vista "vista_empleados" que muestre todos los campos de la tabla "empleados":

create or replace view vista_empleados as 
select * from empleados;
 
 -- Consultamos la vista:

select * from vista_empleados;

-- Agregamos un campo a la tabla "empleados":

alter table empleados 
add sueldo number(6,2);
 
 -- Consultamos la vista
 -- Note que el nuevo campo agregado a "empleados" no aparece, a pesar que la vista indica que muestre todos los 
 -- campos de dicha tabla; esto sucede porque los campos se seleccionan al ejecutar "create view", para que aparezcan 
 -- debemos volver a crear la vista:

 select * from vista_empleados;
 
 -- recreando la vista para mostrar los nuevos campos
 
 create or replace view vista_empleados as 
 select * from empleados;
 
 -- Consultemos la vista:
-- Ahora si aparece el campo sueldo.

select * from vista_empleados;
 
 -- Ejercicio 1 
 
  drop table clientes;

 drop view vista_clientes;
 
-- Intente crear o reemplazar la vista "vista_clientes" para que muestre el nombre, domicilio y ciudad de todos los clientes 
-- de "Cordoba" (sin emplear "force"). Mensaje de error porque la tabla referenciada no existe.

create or replace view vista_clientes as 
select nombre, ciudad from clientes 
where ciudad = 'Cordoba';

-- Cree o reemplace la vista "vista_clientes" para que recupere el nombre, apellido y ciudad de todos los clientes de 
-- "Cordoba" empleando "force"

create or replace force view vista_clientes as 
select nombre, ciudad from clientes 
where ciudad = 'Cordoba';

-- Cree la tabla:

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
 
 -- Cree o reemplace la vista "vista_clientes" para que muestre todos los campos de la tabla "clientes"

create or replace view vista_clientes as
select * from clientes;

-- Consulte la vista

select * from clientes;

-- Agregue un campo a la tabla "clientes"

alter table clientes 
add telefono char(11);

-- Consulte la vista "vista_clientes"
-- El nuevo campo agregado a "clientes" no aparece, pese a que la vista indica que muestre todos los campos de dicha tabla.

select * from vista_clientes;

-- Modifique la vista para que aparezcan todos los campos

create or replace view vista_clientes as
select * from clientes;

-- Consulte la vista:
-- Ahora si aparece el campo.

select * from vista_clientes;
 
