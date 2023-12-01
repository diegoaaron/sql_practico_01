/*
Una subconsulta puede reemplazar una expresión. Dicha subconsulta debe devolver un valor escalar (o una lista de valores 
de un campo).

Las subconsultas que retornan un solo valor escalar se utiliza con un operador de comparación o en lugar de una expresión:

 select CAMPOS
  from TABLA
  where CAMPO OPERADOR (SUBCONSULTA);

 select CAMPO OPERADOR (SUBCONSULTA)
  from TABLA;

Si queremos saber el precio de un determinado libro y la diferencia con el precio del libro más costoso, anteriormente 
debíamos averiguar en una consulta el precio del libro más costoso y luego, en otra consulta, calcular la diferencia con el 
valor del libro que solicitamos. Podemos conseguirlo en una sola sentencia combinando dos consultas:

 select titulo,precio,
  precio-(select max(precio) from libros) as diferencia
  from libros
  where titulo='Uno';

En el ejemplo anterior se muestra el título, el precio de un libro y la diferencia entre el precio del libro y el máximo valor de precio.

Queremos saber el título, autor y precio del libro más costoso:

 select titulo,autor, precio
  from libros
  where precio=
   (select max(precio) from libros);

Note que el campo del "where" de la consulta exterior es compatible con el valor retornado por la expresión de la subconsulta.

Se pueden emplear en "select", "insert", "update" y "delete".

Para actualizar un registro empleando subconsulta la sintaxis básica es la siguiente:

 update TABLA set CAMPO=NUEVOVALOR
  where CAMPO= (SUBCONSULTA);

Para eliminar registros empleando subconsulta empleamos la siguiente sintaxis básica:

 delete from TABLA
  where CAMPO=(SUBCONSULTA);
*/

 drop table libros;

 create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(5,2)
 );
 
insert into libros values(1,'Alicia en el pais de las maravillas','Lewis Carroll','Emece',20.00);
 insert into libros values(2,'Alicia en el pais de las maravillas','Lewis Carroll','Plaza',35.00);
 insert into libros values(3,'Aprenda PHP','Mario Molina','Siglo XXI',40.00);
 insert into libros values(4,'El aleph','Borges','Emece',10.00);
 insert into libros values(5,'Ilusiones','Richard Bach','Planeta',15.00);
 insert into libros values(6,'Java en 10 minutos','Mario Molina','Siglo XXI',50.00);
 insert into libros values(7,'Martin Fierro','Jose Hernandez','Planeta',20.00);
 insert into libros values(8,'Martin Fierro','Jose Hernandez','Emece',30.00);
 insert into libros values(9,'Uno','Richard Bach','Planeta',10.00);

-- Obtenemos el título, precio de un libro específico y la diferencia entre su precio y el máximo valor:

select titulo, precio, precio - (select max(precio) from libros) as diferencia
from libros
where titulo = 'Uno';

-- Mostramos el título y precio del libro más costoso:

select titulo, autor, precio from libros
where precio = (select max(precio) from libros);

-- Actualizamos el precio del libro con máximo valor:

update libros set precio = 45
where precio = (select max(precio) from libros);

-- Eliminamos los libros con precio menor:

delete from libros
where precio = (select min(precio) from libros);

-- Ejercicio 1

 drop table alumnos;
 
  create table alumnos(
  documento char(8),
  nombre varchar2(30),
  nota number(4,2),
  primary key(documento),
  constraint CK_alumnos_nota_valores check (nota>=0 and nota <=10)
 );

 insert into alumnos values('30111111','Ana Algarbe',5.1);
 insert into alumnos values('30222222','Bernardo Bustamante',3.2);
 insert into alumnos values('30333333','Carolina Conte',4.5);
 insert into alumnos values('30444444','Diana Dominguez',9.7);
 insert into alumnos values('30555555','Fabian Fuentes',8.5);
 insert into alumnos values('30666666','Gaston Gonzalez',9.70);

-- Obtenga todos los datos de los alumnos con la nota más alta, empleando subconsulta

select * from alumnos
where nota = (select max(nota) from alumnos);

-- Realice la misma consulta anterior pero intente que la consulta interna retorne, además del máximo valor de nota, el 
-- nombre del alumno. Mensaje de error, porque la lista de selección de una subconsulta que va luego de un operador de 
-- comparación puede incluir sólo un campo o expresión (excepto si se emplea "exists" o "in").

select * from alumnos
where nota = (select nombre, max(nota) from alumnos);

-- Muestre los alumnos que tienen una nota menor al promedio, su nota, y la diferencia con el promedio.

select nombre, nota, nota - (select avg(nota) from alumnos) as diferencia 
from alumnos
where nota < (select avg(nota) from alumnos);

-- Cambie la nota del alumno que tiene la menor nota por 4.

update alumnos set nota = 4
where nota = (select min(nota) from alumnos);

-- Elimine los alumnos cuya nota es menor al promedio.

delete from alumnos
where nota < (select avg(nota) from alumnos);


