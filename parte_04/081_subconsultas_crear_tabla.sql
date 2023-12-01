/*
Podemos crear una tabla e insertar datos en ella en una sola sentencia consultando otra tabla (o varias) con esta sintaxis:

 create table NOMBRENUEVATABLA
  as SUBCONSULTA;
Es decir, se crea una nueva tabla y se inserta en ella el resultado de una consulta a otra tabla.

Tenemos la tabla "libros" de una librería y queremos crear una tabla llamada "editoriales" que contenga los nombres de 
las editoriales.

La tabla "editoriales", que no existe, contendrá solamente un campo llamado "nombre". La tabla libros contiene varios registros.

Podemos crear la tabla "editoriales" con el campo "nombre" consultando la tabla "libros" y en el mismo momento 
insertar la información:

 create table editoriales
  as (select distinct editorial as nombre from libros);

La tabla "editoriales" se ha creado con el campo "nombre" seleccionado del campo "editorial" de "libros".

Los campos de la nueva tabla tienen el mismo nombre, tipo de dato y valores almacenados que los campos listados de 
la tabla consultada; si se quiere dar otro nombre a los campos de la nueva tabla se deben especificar alias.

Podemos emplear "group by", funciones de agrupamiento y "order by" en las consultas. También podemos crear 
una tabla que contenga datos de 2 o más tablas empleando combinaciones.
*/

 drop table libros;
 drop table editoriales;

 create table libros( 
  codigo number(5),
  titulo varchar2(40) not null,
  autor varchar2(30),
  editorial varchar2(20),
  precio number(5,2),
  primary key(codigo)
 ); 

 insert into libros values(1,'Uno','Richard Bach','Planeta',15);
 insert into libros values(2,'El aleph','Borges','Emece',25);
 insert into libros values(3,'Matematica estas ahi','Paenza','Nuevo siglo',18);
 insert into libros values(4,'Aprenda PHP','Mario Molina','Nuevo siglo',45);
 insert into libros values(5,'Ilusiones','Richard Bach','Planeta',14);
 insert into libros values(6,'Java en 10 minutos','Mario Molina','Nuevo siglo',50);
 
 -- Creamos una tabla llamada "editoriales" que contenga los nombres de las editoriales obteniendo tales nombres de la 
 -- tabla "libros":

create table editoriales as 
(select distinct editorial as nombre
from libros);

 -- Veamos la nueva tabla:

select * from editoriales;
 
 -- Necesitamos una nueva tabla llamada "librosporeditorial" que contenga la cantidad de libros de cada editorial. Primero 
 -- eliminamos la tabla:

drop table cantidadporeditorial;
 
 -- Creamos la nueva tabla empleando una subconsulta:

create table cantidadporeditorial as
(select editorial as nombre, count(*) as cantidad
from libros
group by editorial);
 
 -- Veamos los registros de la nueva tabla:

-- La tabla "cantidadporeditorial" se ha creado con el campo llamado "nombre" seleccionado del campo "editorial" de 
-- "libros" y con el campo "cantidad" con el valor calculado con count(*) de la tabla "libros".

 select *from cantidadporeditorial;

-- Queremos una tabla llamada "ofertas20" que contenga los mismos campos que "libros" y guarde los libros con un precio 
-- menor o igual a 20. Primero eliminamos la tabla "ofertas20":

drop table ofertas20;

-- Creamos "ofertas20" e insertamos la consulta de "libros":

-- La consulta retorna los libros de la tabla "libros" cuyo precio es menor o igual a 20 y los almacena en la nueva tabla 
-- ("ofertas20") ordenados en forma descendente por precio. Note que no se listan los campos a extraer, se coloca un 
-- asterisco para indicar que se incluyen todos los campos.

create table ofertas20 as
(select * from libros
where precio <= 20)
order by precio desc;

-- Veamos los registros de la nueva tabla:

select * from ofertas20;

-- Agregamos una columna a la tabla "editoriales" que contiene la ciudad en la cual está la casa central de cada editorial:

 alter table editoriales add ciudad varchar2(30);

-- Actualizamos dicho campo:

update editoriales set ciudad='Cordoba' where nombre='Planeta';
 update editoriales set ciudad='Cordoba' where nombre='Emece';
 update editoriales set ciudad='Buenos Aires' where nombre='Nuevo siglo';
 
 -- Queremos una nueva tabla llamada "librosdecordoba" que contenga los títulos y autores de los libros de editoriales 
 -- de Cordoba. En primer lugar, la eliminamos:

 drop table librosdecordoba;

 -- Consultamos las 2 tablas y guardamos el resultado en la nueva tabla que estamos creando:

 create table librosdecordoba as
  (select titulo,autor from libros
  join editoriales
  on editorial=nombre 
  where ciudad='Cordoba');
  
-- Consultamos la nueva tabla:

 select *from librosdecordoba;
 
 -- Ejercicio 1
 
  drop table empleados;
 drop table sucursales;

 create table sucursales( 
  codigo number(4),
  ciudad varchar2(30) not null,
  primary key(codigo)
 ); 

 create table empleados( 
  documento char(8) not null,
  nombre varchar2(30) not null,
  domicilio varchar2(30),
  seccion varchar2(20),
  sueldo number(6,2),
  codigosucursal number(4),
  primary key(documento),
  constraint FK_empleados_sucursal
   foreign key (codigosucursal)
   references sucursales(codigo)
 ); 

 insert into sucursales values(1,'Cordoba');
 insert into sucursales values(2,'Villa Maria');
 insert into sucursales values(3,'Carlos Paz');
 insert into sucursales values(4,'Cruz del Eje');

 insert into empleados values('22222222','Ana Acosta','Avellaneda 111','Secretaria',500,1);
 insert into empleados values('23333333','Carlos Caseros','Colon 222','Sistemas',800,1);
 insert into empleados values('24444444','Diana Dominguez','Dinamarca 333','Secretaria',550,2);
 insert into empleados values('25555555','Fabiola Fuentes','Francia 444','Sistemas',750,2);
 insert into empleados values('26666666','Gabriela Gonzalez','Guemes 555','Secretaria',580,3);
 insert into empleados values('27777777','Juan Juarez','Jujuy 777','Secretaria',500,4);
 insert into empleados values('28888888','Luis Lopez','Lules 888','Sistemas',780,4);
 insert into empleados values('29999999','Maria Morales','Marina 999','Contaduria',670,4);
 
-- Realice un join para mostrar todos los datos de "empleados" incluyendo la ciudad de la sucursal

select e.*, s.* from empleados e
full join sucursales s
on e.codigosucursal = s.codigo;

-- Cree una tabla llamada "secciones" que contenga las secciones de la empresa (primero elimínela)

  drop table secciones;

 create table secciones as
  (select distinct seccion as nombre
   from empleados);
   
-- Recupere la información de "secciones"

select * from secciones;

-- Se necesita una nueva tabla llamada "sueldosxseccion" que contenga la suma de los sueldos de los empleados por 
-- sección (de todas las sucursales). Primero elimine la tabla

 drop table sueldosxseccion;

 create table sueldosxseccion as
  (select seccion, sum(sueldo) as total
  from empleados
  group by seccion);

-- Recupere los registros de la nueva tabla

select * from sueldosxseccion;

-- Se necesita una nueva tabla llamada "sucursalCordoba" que contenga los nombres y sección de los empleados de la 
-- ciudad de Córdoba. En primer lugar, eliminamos la tabla. Luego, consulte las tablas "empleados" y "sucursales" 
-- y guarde el resultado en la nueva tabla

drop table sucursalCordoba;

create table sucursalCordoba as 
(select nombre, seccion from empleados e
inner join sucursales s
on e.codigosucursal = s.codigo
where s.ciudad = 'Cordoba');

-- Consulte la nueva tabla

select * from sucursalCordoba;
 
