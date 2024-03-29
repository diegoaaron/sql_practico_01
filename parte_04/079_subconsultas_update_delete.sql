/*
Dijimos que podemos emplear subconsultas en sentencias "insert", "update", "delete", adem�s de "select".

La sintaxis b�sica para realizar actualizaciones con subconsulta es la siguiente:

 update TABLA set CAMPO=NUEVOVALOR
  where CAMPO= (SUBCONSULTA);
  
Actualizamos el precio de todos los libros de editorial "Emece":

 update libros set precio=precio+(precio*0.1)
  where codigoeditorial=
   (select codigo
     from editoriales
     where nombre='Emece');

La subconsulta retorna un �nico valor. Tambi�n podemos hacerlo con un join.

La sintaxis b�sica para realizar eliminaciones con subconsulta es la siguiente:

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
    
La subconsulta es una combinaci�n que retorna una lista de valores que la consulta externa emplea al seleccionar los 
registros para la eliminaci�n.
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

-- Actualizamos el precio de todos los libros de editorial "Emece" increment�ndolos en un 10%:

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
-- C�rdoba. Actualice el campo "sueldo" de la tabla "empleados" de todos los empleados de tales sucursales empleando 
-- subconsulta.

update empleados e set e.sueldo = e.sueldo + (e.sueldo * 0.2)
where e.codigosucursal in (
select codigo from sucursales
where provincia = 'Cordoba');

-- La empleada "Ana Acosta" es trasladada a la sucursal de Carlos Paz. Se necesita actualizar el sueldo y la sucursal de tal 
-- empleada empleando subconsultas, debe tener el mismo sueldo que la empleada "Maria Morales".

update empleados set sueldo = 
(select sueldo from empleados where nombre = 'Maria Morales'),
codigosucursal =
(select codigo from sucursales
where ciudad = 'Carlos Paz') 
where nombre = 'Ana Acosta';

-- El empleado "Carlos Caseros" se traslada a la sucursal de "La Plata". Se necesita actualizar el sueldo y sucursal de 
-- tal empleado con los mismos valores que la empleada "Maria Morales" (emplee subconsulta).

update empleados set (sueldo, codigosucursal) = 
(select sueldo, codigosucursal from empleados 
where nombre = 'Maria Morales') 
where nombre = 'Carlos Caseros';

-- El supermercado cerrar� todas las sucursales de la provincia de "Cordoba". Elimine los empleados que pertenezcan 
-- a sucursales de tal provincia empleando subconsulta.

delete from empleados 
where codigosucursal in 
(select codigo from sucursales
where provincia = 'Cordoba');

-- Ejercicio 2 

 drop table inscriptos;
 drop table socios;

 create table socios(
  numero number(5),
  documento char(8),
  nombre varchar2(30),
  domicilio varchar2(30),
  primary key (numero)
 );
 
 create table inscriptos (
  numerosocio number(5) not null,
  deporte varchar2(20) not null,
  matricula char(1),-- 'n' o 's'
  primary key(numerosocio,deporte),
  constraint FK_inscriptos_socio
   foreign key (numerosocio)
   references socios(numero)
 );

 insert into socios values(1,'23333333','Alberto Paredes','Colon 111');
 insert into socios values(2,'24444444','Carlos Conte','Sarmiento 755');
 insert into socios values(3,'25555555','Fabian Fuentes','Caseros 987');
 insert into socios values(4,'26666666','Hector Lopez','Sucre 344');
 insert into socios values(5,'27777777','Ines Irala','Colon 888');

 insert into inscriptos values(1,'tenis','s');
 insert into inscriptos values(1,'basquet','s');
 insert into inscriptos values(1,'natacion','s');
 insert into inscriptos values(2,'tenis','s');
 insert into inscriptos values(2,'natacion','s');
 insert into inscriptos values(2,'basquet','n');
 insert into inscriptos values(2,'futbol','n');
 insert into inscriptos values(3,'tenis','s');
 insert into inscriptos values(3,'basquet','s');
 insert into inscriptos values(3,'natacion','n');
 insert into inscriptos values(4,'basquet','n');
 
 -- Realice una combinaci�n mostrando todos los datos de "socios", el deporte y la matr�cula de todos los socios 
 -- (se encuentren o no en "inscriptos")

select numero, documento, nombre, domicilio, deporte, matricula from socios s
full join inscriptos i
on numerosocio = numero;

-- Actualizamos la cuota ('s') de todas las inscripciones de un socio determinado (por documento) empleando 
-- subconsulta (3 registros)

update inscriptos set matricula = 's' 
where numerosocio =
(select numero from socios
where documento = '25555555');

-- Elimine todas las inscripciones de los socios que deben alguna matr�cula empleando subconsulta
 
delete from inscriptos 
where numerosocio in 
(select numero from socios s
join inscriptos 
on numerosocio = numero 
where matricula = 'n');
