/*
Vimos que una subconsulta puede reemplazar una expresión. Dicha subconsulta debe devolver un valor escalar o una lista 
de valores de un campo; las subconsultas que retornan una lista de valores reemplazan a una expresión en una cláusula 
"where" que contiene la palabra clave "in".

El resultado de una subconsulta con "in" (o "not in") es una lista. Luego que la subconsulta retorna resultados, la consulta 
exterior los usa.

Podemos averiguar si un valor de la consulta externa pertenece o no al conjunto devuelto por una subconsulta empleando 
"in" y "not in".

La sintaxis básica es la siguiente:

 ...where EXPRESION in (SUBCONSULTA);
 
Este ejemplo muestra los nombres de las editoriales que ha publicado libros de un determinado autor:

 select nombre
  from editoriales
  where codigo in
   (select codigoeditorial
     from libros
     where autor='Richard Bach');

La subconsulta (consulta interna) retorna una lista de valores de un solo campo (codigoeditorial) que la consulta exterior luego
emplea al recuperar los datos.

Se averigua si el código devuelto por la consulta externa se encuentra dentro del conjunto de valores retornados por la consulta 
interna.

Podemos reemplazar por un "join" la consulta anterior:

 select distinct nombre
  from editoriales e
  join libros
  on codigoeditorial=e.codigo
  where autor='Richard Bach';
  
Una combinación (join) siempre puede ser expresada como una subconsulta; pero una subconsulta no siempre puede 
reemplazarse por una combinación que retorne el mismo resultado. Si es posible, es aconsejable emplear combinaciones 
en lugar de subconsultas, son más eficientes.

Se recomienda probar las subconsultas antes de incluirlas en una consulta exterior, así puede verificar que retorna lo 
necesario, porque a veces resulta difícil verlo en consultas anidadas.

También podemos buscar valores No coincidentes con una lista de valores que retorna una subconsulta; por ejemplo, las 
editoriales que no han publicado libros de un autor específico:

 select nombre
  from editoriales
  where codigo not in
   (select codigoeditorial
     from libros
     where autor='Richard Bach');
*/

 drop table libros;
 drop table editoriales;

 create table editoriales(
  codigo number(3),
  nombre varchar2(30),
  primary key (codigo)
 );
 
 create table libros (
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  codigoeditorial number(3),
  primary key(codigo),
 constraint FK_libros_editorial
   foreign key (codigoeditorial)
   references editoriales(codigo)
 );

 insert into editoriales values(1,'Planeta');
 insert into editoriales values(2,'Emece');
 insert into editoriales values(3,'Paidos');
 insert into editoriales values(4,'Siglo XXI');

 insert into libros values(100,'Uno','Richard Bach',1);
 insert into libros values(101,'Ilusiones','Richard Bach',1);
 insert into libros values(102,'Aprenda PHP','Mario Molina',4);
 insert into libros values(103,'El aleph','Borges',2);
 insert into libros values(104,'Puente al infinito','Richard Bach',2);

-- Queremos conocer el nombre de las editoriales que han publicado libros del autor "Richard Bach":

select nombre from editoriales
where codigo in (select codigoeditorial from libros where autor = 'Richard Bach');

-- Probamos la subconsulta separada de la consulta exterior para verificar que retorna una lista de valores de un solo campo:

select codigoeditorial from libros
where autor = 'Richard Bach'; 

-- Podemos reemplazar por un "join" la primera consulta:

select distinct nombre
from editoriales e
join libros
on codigoeditorial = e.codigo
where autor = 'Richard Bach';

-- También podemos buscar las editoriales que no han publicado libros de "Richard Bach":

select nombre
from editoriales
where codigo not in (select codigoeditorial from libros where autor = 'Richard Bach');

-- 

