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


