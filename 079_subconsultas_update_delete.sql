/*
Dijimos que podemos emplear subconsultas en sentencias "insert", "update", "delete", además de "select".

La sintaxis básica para realizar actualizaciones con subconsulta es la siguiente:

 update TABLA set CAMPO=NUEVOVALOR
  where CAMPO= (SUBCONSULTA);
  
Actualizamos el precio de todos los libros de editorial "Emece":

 update libros set precio=precio+(precio*0.1)
  where codigoeditorial=
   (select codigo
     from editoriales
     where nombre='Emece');

La subconsulta retorna un único valor. También podemos hacerlo con un join.

La sintaxis básica para realizar eliminaciones con subconsulta es la siguiente:

 delete from TABLA
  where CAMPO OPERADOR (SUBCONSULTA);
  
Eliminamos todos los libros de las editoriales que tiene publicados libros de "Juan Perez":

 delete from libros
  where codigoeditorial in
   (select e.codigo
    from editoriales e
    join libros
    on codigoeditorial=e.codigo
    where autor='Juan Perez');
    
La subconsulta es una combinación que retorna una lista de valores que la consulta externa emplea al seleccionar los 
registros para la eliminación.
*/

 drop table libros;
 drop table editoriales;

 create table editoriales(
  codigo number(2),
  nombre varchar2(30),
  primary key (codigo)
 );
 
 create table libros (
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  codigoeditorial number(2),
  precio number(5,2),
  primary key(codigo),
  constraint FK_libros_editorial
   foreign key (codigoeditorial)
   references editoriales(codigo)
 );

 insert into editoriales values(1,'Planeta');
 insert into editoriales values(2,'Emece');
 insert into editoriales values(3,'Paidos');
 insert into editoriales values(4,'Siglo XXI');

 insert into libros values(100,'Uno','Richard Bach',1,15);
 insert into libros values(101,'Ilusiones','Richard Bach',2,20);
 insert into libros values(102,'El aleph','Borges',3,10);
 insert into libros values(103,'Aprenda PHP','Mario Molina',4,40);
 insert into libros values(104,'Poemas','Juan Perez',1,20);
 insert into libros values(105,'Cuentos','Juan Perez',3,25);
 insert into libros values(106,'Java en 10 minutos','Marcelo Perez',2,30);

-- Actualizamos el precio de todos los libros de editorial "Emece" incrementándolos en un 10%:

update libros set precio = precio + (precio * 0.1)
where codigoeditorial = 
(select codigo from editoriales
where nombre = 'Emece');

-- Eliminamos todos los libros de las editoriales que tiene publicados libros de "Juan Perez":

delete from libros 
where codigoeditorial in 
(select e.codigo from editoriales e
join libros 
on codigoeditorial = e.codigo
where autor = 'Juan Perez');

-- Ejercicio 1 

 drop table empleados;
 drop table sucursales;

 create table sucursales( 
  codigo number(2),
  ciudad varchar2(30) not null,
  provincia varchar2(30),
  primary key(codigo)
 ); 

 create table empleados( 
  documento char(8) not null,
  nombre varchar2(30) not null,
  codigosucursal number(2),
  sueldo number(6,2),
  primary key(documento),
  constraint FK_empleados_sucursal
   foreign key (codigosucursal)
   references sucursales(codigo)
 ); 

 insert into sucursales values(1,'Cordoba','Cordoba');
 insert into sucursales values(2,'Tucuman','Tucuman');
 insert into sucursales values(3,'Carlos Paz','Cordoba');
 insert into sucursales values(4,'Cruz del Eje','Cordoba');
 insert into sucursales values(5,'La Plata','Buenos Aires');

 insert into empleados values('22222222','Ana Acosta',1,500);
 insert into empleados values('23333333','Carlos Caseros',1,610);
 insert into empleados values('24444444','Diana Dominguez',2,600);
 insert into empleados values('25555555','Fabiola Fuentes',5,700);
 insert into empleados values('26666666','Gabriela Gonzalez',3,800);
 insert into empleados values('27777777','Juan Juarez',4,850);
 insert into empleados values('28888888','Luis Lopez',4,500);
 insert into empleados values('29999999','Maria Morales',5,800);
 
 -- Realice un join para mostrar el documento, nombre, sueldo, ciudad y provincia de todos los empleados

select e.documento, e.nombre, e.sueldo, s.provincia from empleados e
inner join sucursales s 
on e.codigosucursal = s.codigo;

-- El supermercado necesita incrementar en un 10% el sueldo de los empleados de la sucursal de "Cruz del Eje". 
-- Actualice el campo "sueldo" de la tabla "empleados" de todos los empleados de dicha sucursal empleando subconsulta.

update empleados e set e.sueldo = e.sueldo + (e.sueldo * 0.1)
where e.codigosucursal = (
select codigo from sucursales
where ciudad = 'Cruz del Eje');

-- El supermercado quiere incrementar en un 20% el sueldo de los empleados de las sucursales de la provincia de 
-- Córdoba. Actualice el campo "sueldo" de la tabla "empleados" de todos los empleados de tales sucursales empleando 
-- subconsulta.

update empleados e set e.sueldo = e.sueldo + (e.sueldo * 0.2)
where e.codigosucursal in (
select codigo from sucursales
where provincia = 'Cordoba');

-- La empleada "Ana Acosta" es trasladada a la sucursal de Carlos Paz. Se necesita actualizar el sueldo y la sucursal de tal 
-- empleada empleando subconsultas, debe tener el mismo sueldo que la empleada "Maria Morales".



-- El empleado "Carlos Caseros" se traslada a la sucursal de "La Plata". Se necesita actualizar el sueldo y sucursal de 
-- tal empleado con los mismos valores que la empleada "Maria Morales" (emplee subconsulta).



-- El supermercado cerrará todas las sucursales de la provincia de "Cordoba". Elimine los empleados que pertenezcan 
-- a sucursales de tal provincia empleando subconsulta.


