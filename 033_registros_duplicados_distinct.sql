-- Con la cláusula "distinct" se especifica que los registros con ciertos datos duplicados sean obviadas en el resultado

-- La cláusula "distinct" afecta a todos los campos presentados. Para mostrar los títulos y editoriales 
-- de los libros sin repetir títulos ni editoriales, usamos:

 select distinct titulo,editorial from libros order by titulo;
 
drop table libros;

create table libros(
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(15)
);

insert into libros values('El aleph','Borges','Planeta');
insert into libros values('Martin Fierro','Jose Hernandez','Emece');
insert into libros values('Martin Fierro','Jose Hernandez','Planeta');
insert into libros values('Antologia poetica','Borges','Planeta');
insert into libros values('Aprenda PHP','Mario Molina','Emece');
insert into libros values('Aprenda PHP','Lopez','Emece');
insert into libros values('Manual de PHP', 'J. Paez', null);
insert into libros values('Cervantes y el quijote',null,'Paidos');
insert into libros values('Harry Potter y la piedra filosofal','J.K. Rowling','Emece');
insert into libros values('Harry Potter y la camara secreta','J.K. Rowling','Emece');
insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Paidos');
insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Planeta');
insert into libros values('PHP de la A a la Z',null,null);
insert into libros values('Uno','Richard Bach','Planeta');

-- Para obtener la lista de autores sin repetición

select distinct autor from libros;

-- Note que aparece "null" como un valor para "autor", para que no aparezca: 

select distinct autor from libros where autor is not null;

-- Contar los autores diferentes

select count(distinct autor) from libros;

-- La combinamos con "where" para obtener los distintos autores de la editorial "Planeta":

select distinct autor from libros where editorial <> 'Planeta';

-- Contamos los distintos autores que tiene cada editorial empleando "group by":

 select editorial, count(distinct autor) from libros group by editorial;
 
 -- Mostramos los títulos y editoriales de los libros sin repetir títulos ni editoriales:

select distinct titulo, editorial from libros order by titulo;

-- Note que los registros no están duplicados, aparecen títulos iguales pero con editorial diferente, cada registro es diferente.

-- Ejercicio 1

drop table clientes;

create table clientes (
  nombre varchar2(30) not null,
  domicilio varchar2(30),
  ciudad varchar2(20),
  provincia varchar2(20)
);
 
insert into clientes values ('Lopez Marcos','Colon 111','Cordoba','Cordoba');
insert into clientes values ('Perez Ana','San Martin 222','Cruz del Eje','Cordoba');
insert into clientes values ('Garcia Juan','Rivadavia 333','Villa del Rosario','Cordoba');
insert into clientes values ('Perez Luis','Sarmiento 444','Rosario','Santa Fe');
insert into clientes values ('Pereyra Lucas','San Martin 555','Cruz del Eje','Cordoba');
insert into clientes values ('Gomez Ines','San Martin 666','Santa Fe','Santa Fe');
insert into clientes values ('Torres Fabiola','Alem 777','Villa del Rosario','Cordoba');
insert into clientes values ('Lopez Carlos',null,'Cruz del Eje','Cordoba');
insert into clientes values ('Ramos Betina','San Martin 999','Cordoba','Cordoba');
insert into clientes values ('Lopez Lucas','San Martin 1010','Posadas','Misiones'); 
 
-- Obtenga las provincias sin repetir 

select distinct provincia from clientes;

-- Cuente las distintas provincias

select count(distinct provincia) from clientes;

-- Se necesitan los nombres de las ciudades sin repetir 

select distinct ciudad from clientes;

-- Obtenga la cantidad de ciudades distintas 

select count(distinct ciudad) from clientes;

-- Combine con "where" para obtener las distintas ciudades de la provincia de Cordoba 

select distinct ciudad from clientes where provincia = 'Cordoba';

-- Contamos las distintas ciudades de cada provincia empleando "group by" 

select provincia, count(*) from clientes group by provincia;


