/*
Las operaciones de conjuntos combinan los resultados de dos o más consultas "select" en un único resultado.

Se usan cuando los datos que se quieren obtener pertenecen a distintas tablas y no se puede acceder a ellos con una sola 
consulta.

Es necesario que las tablas referenciadas tengan tipos de datos similares, la misma cantidad de campos y el mismo orden 
de campos en la lista de selección de cada consulta.

Hay tres operadores de conjuntos: union, intersect y minus. Veremos en primer lugar "union".

La sintaxis para unir dos consultas con el operador "union" es la siguiente:

 CONSULTA1
  union
  CONSULTA2;
  
Recuerde que las consultas DEBEN tener el mismo numero de valores retornados y los valores deben ser del mismo tipo.

Veamos un ejemplo. Una academia de enseñanza de idiomas da clases de inglés y frances; almacena los datos de los 
alumnos que estudian inglés en una tabla llamada "ingles" y los que están inscriptos en "francés" en una tabla denominada 
"frances".

La academia necesita el nombre y domicilio de todos los alumnos, de todos los cursos para enviarles una tarjeta de 
felicitación para el día del alumno.

Para obtener los datos necesarios de ambas tablas en una sola consulta necesitamos realizar una unión:

 select nombre, domicilio from ingles
  union
  select nombre, domicilio from frances;
  
El primer "select" devuelve el nombre y domicilio de todos los alumnos de "ingles"; el segundo, el nombre y domicilio de 
todos los alumnos de "frances". Esta sentencia de unión retornará la combinacion de los resultados de ambas 
consultas "select", mostrando el nombre y domicilio de los registros de ambas tablas.

Los encabezados del resultado de una unión son los que se especifican en el primer "select". El operador de conjunto "union" 
no retorna duplicados; es decir, si un registro de la primer consulta es igual a otro registro de la segunda consulta, tal 
registro aparece una sola vez. Si queremos que se incluyan TODOS los registros, aún duplicados, debemos emplear "union all":

 select nombre,domicilio from ingles
  union all
  select nombre,domicilio from frances;
En el ejemplo anterior, si un registro de la primer consulta es igual a otro registro de la segunda consulta, tal registro 
aparece dos veces; es decir, si un alumno está cursando ambos idiomas, aparecerá dos veces en el resultado.

"union" puede combinarse con la cláusula "order by".
*/

 drop table ingles;
 drop table frances;

 create table ingles(
  documento varchar2(8) not null,
  nombre varchar2(30),
  domicilio varchar2(30),
  primary key(documento)
 );

 create table frances(
  documento varchar2(8) not null,
  nombre varchar2(30),
  domicilio varchar2(30),
  primary key(documento)
 );

 insert into ingles values('20111222','Ana Acosta','Avellaneda 111');
 insert into ingles values('21222333','Betina Bustos','Bulnes 222');
 insert into ingles values('22333444','Carlos Caseros','Colon 333');
 insert into ingles values('23444555','Daniel Duarte','Duarte Quiros 444');
 insert into ingles values('24555666','Estela Esper','Esmeralda 555');

 insert into frances values('23444555','Daniel Duarte','Duarte Quiros 444');
 insert into frances values('24555666','Estela Esper','Esmeralda 555');
 insert into frances values('30111222','Fabiana Fuentes','Famatina 666');
 insert into frances values('30222333','Gaston Gonzalez','Guemes 777');

-- La academia necesita el nombre y domicilio de todos los alumnos, de todos los cursos para enviarles una tarjeta de 
-- invitación para un festejo el día del alumno.
-- Empleamos el operador "union" para obtener dicha información de ambas tablas:

select nombre, domicilio from ingles
union
select nombre, domicilio from frances;

-- Note que existen dos alumnos (Daniel Duarte y Estela Esper) que cursan ambos idiomas, están presentes en la tabla 
-- "ingles" y "frances"; tales registros aparecen una sola vez en el resultado de "union". Si queremos que los registros 
-- duplicados aparezcan, debemos emplear "all":

select nombre, domicilio from ingles
union all
select nombre, domicilio from frances;

-- Ordenamos por nombre:

select nombre, domicilio from ingles
union all
select nombre, domicilio from frances
order by nombre;

-- Podemos agregar una columna extra a la consulta con el encabezado "curso" en la que aparezca el literal "inglés" o 
-- "francés" según si la persona cursa uno u otro idioma:



