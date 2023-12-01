-- like : comparador exclusivo de cadenas (tambien se puede utilizar en tipo date) , 
-- permite realizar busquedas en trozos de una cadena.
-- el operador igual ("=")  y diferencia ("<>") nos permite comparar cadenas de caracteres, pero al realizar la comparación, 
-- busca coincidencias de cadenas completas, realiza una búsqueda exacta.
-- El símbolo "%" (porcentaje) reemplaza cualquier cantidad de caracteres (incluyendo ningún caracter). 
-- El guión bajo "_" reemplaza un caracter.
-- Los valores nulos no se incluyen en las búsquedas con "like" y "not like".

drop table libros;

create table libros(
  titulo varchar2(40),
  autor varchar2(20) default 'Desconocido',
  editorial varchar2(20),
  edicion date,
  precio number(6,2)
);

insert into libros values('El aleph','Borges','Emece','12/05/2005',15.90);
insert into libros values('Antología poética','J. L. Borges','Planeta','16/08/2000',null);
insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll',null,'25/04/2000',19.90);
insert into libros values('Matematica estas ahi','Paenza','Siglo XXI','21/12/2006',15);
insert into libros values('Martin Fierro','Jose Hernandez',default,'22/09/2001',40);
insert into libros values('Aprenda PHP','Mario Molina','Nuevo siglo','22/05/1999',56.50);
insert into libros values(null,'Mario Molina','Nuevo siglo',null,45);

-- Recuperamos todos los libros que contengan en el campo "autor" la cadena "Borges":

select * from libros where autor like '%Borges%';

-- Seleccionamos los libros cuyos títulos comienzan con la letra "M":

select * from libros where titulo like 'M%';

-- Seleccionamos todos los títulos que NO comienzan con "M":

select * from libros where titulo not like 'M%';

-- Si queremos ver los libros de "Lewis Carroll" pero no recordamos si se escribe "Carroll" o "Carrolt", 

select * from libros where autor like '%Carrol_';

-- Recuperamos todos los libros que contengan en el campo "edicion", en la parte correspondiente al mes, la cadena "05":

select * from libros where edicion like '__/05%';

-- Recuperamos todos los libros cuyo precio se encuentra entre 10.00 y 19.99:

select * from libros where precio between 10.00 and 19.99;

select * from libros where precio like '1_,%';

-- Recuperamos los libros que NO incluyen centavos en sus precios:

select * from libros where precio not like '%,%';

-- Ejercicio 1

drop table empleados;

create table empleados(
  nombre varchar2(30),
  documento char(8) not null,
  domicilio varchar2(30),
  fechaingreso date,
  seccion varchar2(20),
  sueldo number(6,2),
  primary key(documento)
);

insert into empleados values('Juan Perez','22333444','Colon 123','08/10/1990','Gerencia',900.50);
insert into empleados values('Ana Acosta','23444555','Caseros 987','18/12/1995','Secretaria',590.30);
insert into empleados values('Lucas Duarte','25666777','Sucre 235','15/05/2005','Sistemas',790);
insert into empleados values('Pamela Gonzalez','26777888','Sarmiento 873','12/02/1999','Secretaria',550);
insert into empleados values('Marcos Juarez','30000111','Rivadavia 801','22/09/2002','Contaduria',630.70);
insert into empleados values('Yolanda perez','35111222','Colon 180','08/10/1990','Administracion',400);
insert into empleados values('Rodolfo perez','35555888','Coronel Olmedo 588','28/05/1990','Sistemas',800);

-- Muestre todos los empleados con apellido "Perez"  (no incluya "perez")

select * from empleados where nombre like '%Perez%';

-- Muestre todos los empleados cuyo domicilio comience con "Co" y tengan un "8"

select * from empleados where domicilio like 'Co%8%';

-- Seleccione todos los empleados cuyo documento finalice en 0 ó 4

select * from empleados where documento like '%4';

-- Seleccione todos los empleados cuyo documento NO comience con 2 y cuyo nombre finalice en "ez"

select * from empleados where documento not like '2%' and nombre like '%ez';

-- Recupere todos los nombres que tengan una "G" o una "J" en su nombre o apellido

select nombre from empleados where nombre like '%g%' or nombre like '%G%' or nombre like '%j%' or nombre like '%J%';

-- Muestre los nombres y sección de los empleados que pertenecen a secciones que 
-- comiencen con "S" o "G" y tengan 8 caracteres

select nombre, seccion from empleados where seccion like 'S_______' or seccion like 'G_______';

-- Muestre los nombres y sección de los empleados que pertenecen a secciones que NO comiencen con "S"

select nombre, seccion from empleados where seccion not like 'S%';

-- Muestre todos los nombres y sueldos de los empleados cuyos sueldos se encuentren entre 500,00 y 599,99

select nombre, sueldo from empleados where sueldo like '5__,%' or sueldo like '5__';

select nombre, sueldo from empleados where sueldo between 500.00 and 599.99;

-- Muestre los empleados que hayan ingresado en la década del 90. 

select * from empleados where fechaingreso like '__/__/__9_';

select * from empleados where fechaingreso like '%9_';

-- Agregue 50 centavos a todos los sueldos que no tengan centavos.

update empleados set sueldo = sueldo + 0.5 where sueldo not like '%,%';

-- Elimine todos los empleados cuyos apellidos comiencen con "p" (minúscula) 

delete from empleados where nombre like '%p%';



