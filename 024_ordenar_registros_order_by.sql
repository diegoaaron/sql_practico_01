-- ordenando registros

-- Podemos ordenar el resultado de un "select" para que los registros se muestren ordenados por alg�n campo, 
-- para ello usamos la cl�usula "order by". Aparecen los registros ordenados alfab�ticamente por el campo especificado.

select * from libros order by titulo;

select * from libros order by 1;

-- Por defecto, si no aclaramos en la sentencia, los ordena de manera ascendente (de menor a mayor). 
-- Podemos ordenarlos de mayor a menor, para ello agregamos la palabra clave "desc":

select * from libros order by titulo desc;

-- Tambi�n podemos ordenar por varios campos (si el primer campo de orden tiene valores repetidos, se utiliza el segundo 
-- campo definido para ordenar)

select * from libros order by titulo asc, precio asc;

-- Debe aclararse al lado de cada campo, pues estas palabras claves afectan al campo inmediatamente anterior.

-- Es posible ordenar por un campo que no se lista en la selecci�n incluso por columnas calculados.

-- Se puede emplear "order by" con campos de tipo caracter, num�rico y date.

-- Ejercicio 1

drop table libros;

create table libros(
  titulo varchar2(40) not null,
  autor varchar2(20) default 'Desconocido',
  editorial varchar2(20),
  edicion date,
  precio number(6,2)
);

insert into libros values('El aleph','Borges','Emece','10/10/1980',25.33);
insert into libros values('Java en 10 minutos','Mario Molina','Siglo XXI','05/12/2005',50.65);
insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Emece','29/11/2000',19.95);
insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Planeta','27/11/2004',15);

-- Recuperamos los registros ordenados por el t�tulo

select * from libros order by titulo;

-- Ordenamos los registros por el campo "precio", referenciando el campo por su posici�n en la lista de selecci�n

select titulo, autor, precio from libros order by 3;

-- Los ordenamos por "editorial", de mayor a menor empleando "desc"

select * from libros order by editorial desc;

-- Ordenamos por dos campos

select * from libros order by titulo, editorial;

-- Ordenamos en distintos sentidos

select * from libros order by titulo asc, editorial desc;

-- Podemos ordenar por un campo que no se lista en la selecci�n

select titulo, autor, precio from libros order by precio;

-- Est� permitido ordenar por valores calculados, lo hacemos

select titulo, editorial, precio + (precio * 0.1) as "precio con descuento" from libros order by 3;

-- Ordenar los libros por la fecha de edici�n

select  titulo, editorial, edicion from libros order by edicion;

-- Mostramos el t�tulo y a�o de edici�n de todos los libros, ordenados por a�o de edici�n

select titulo, extract(year from edicion) as edicion from libros order by 2;

