-- ordenando registros

-- Podemos ordenar el resultado de un "select" para que los registros se muestren ordenados por algún campo, 
-- para ello usamos la cláusula "order by". Aparecen los registros ordenados alfabéticamente por el campo especificado.

select * from libros order by titulo;

select * from libros order by 1;

-- Por defecto, si no aclaramos en la sentencia, los ordena de manera ascendente (de menor a mayor). 
-- Podemos ordenarlos de mayor a menor, para ello agregamos la palabra clave "desc":

select * from libros order by titulo desc;

-- También podemos ordenar por varios campos (si el primer campo de orden tiene valores repetidos, se utiliza el segundo 
-- campo definido para ordenar)

select * from libros order by titulo asc, precio asc;

-- Debe aclararse al lado de cada campo, pues estas palabras claves afectan al campo inmediatamente anterior.

-- Es posible ordenar por un campo que no se lista en la selección incluso por columnas calculados.

-- Se puede emplear "order by" con campos de tipo caracter, numérico y date.

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

-- Recuperamos los registros ordenados por el título

select * from libros order by titulo;

-- Ordenamos los registros por el campo "precio", referenciando el campo por su posición en la lista de selección

select titulo, autor, precio from libros order by 3;

-- Los ordenamos por "editorial", de mayor a menor empleando "desc"

select * from libros order by editorial desc;

-- Ordenamos por dos campos

select * from libros order by titulo, editorial;

-- Ordenamos en distintos sentidos

select * from libros order by titulo asc, editorial desc;

-- Podemos ordenar por un campo que no se lista en la selección

select titulo, autor, precio from libros order by precio;

-- Está permitido ordenar por valores calculados, lo hacemos

select titulo, editorial, precio + (precio * 0.1) as "precio con descuento" from libros order by 3;

-- Ordenar los libros por la fecha de edición

select  titulo, editorial, edicion from libros order by edicion;

-- Mostramos el título y año de edición de todos los libros, ordenados por año de edición

select titulo, extract(year from edicion) as edicion from libros order by 2;

-- Ejercicio 2

drop table visitas;

create table visitas (
  nombre varchar2(30) default 'Anonimo',
  mail varchar2(50),
  pais varchar2(20),
  fecha date
  );
  
insert into visitas values ('Ana Maria Lopez','AnaMaria@hotmail.com','Argentina',to_date('2020/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'));
insert into visitas values ('Gustavo Gonzalez','GustavoGGonzalez@hotmail.com','Chile',to_date('2020/02/13 11:08:10', 'yyyy/mm/dd hh24:mi:ss'));
insert into visitas values ('Juancito','JuanJosePerez@hotmail.com','Argentina',to_date('2020/07/02 14:12:00', 'yyyy/mm/dd hh24:mi:ss'));
insert into visitas values ('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico',to_date('2020/06/17 20:00:00', 'yyyy/mm/dd hh24:mi:ss'));
insert into visitas values ('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico',to_date('2020/02/08 20:05:40', 'yyyy/mm/dd hh24:mi:ss'));
insert into visitas values ('Juancito','JuanJosePerez@hotmail.com','Argentina',to_date('2020/07/06 18:00:00', 'yyyy/mm/dd hh24:mi:ss'));
insert into visitas values ('Juancito','JuanJosePerez@hotmail.com','Argentina',to_date('2019/10/05 23:00:00', 'yyyy/mm/dd hh24:mi:ss'));

-- ordenar por fecha en orden descendente

select * from visitas order by fecha desc;

-- muestre el nombre del usuario, pais y el mes, ordenado por pais (ascendente) y el mes (descendente)

select nombre, pais, extract(month from fecha) as "mes" from visitas order by pais asc, 3 desc;

-- muestre los mail, país, ordenado por país, de todos los que visitaron la página en octubre

select mail, pais from visitas where extract(month from fecha) = 10 order by pais;

