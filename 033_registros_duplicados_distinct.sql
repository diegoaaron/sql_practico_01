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


 
 
 





