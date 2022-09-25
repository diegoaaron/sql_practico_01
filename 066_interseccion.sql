/*
Continuamos aprendiendo las operaciones de conjuntos. Aprendimos "union" y "union all", ahora veremos "intersect".

Como cualquier otra operaci�n de conjuntos, "intersect" se emplea cuando los datos que se quieren obtener pertenecen a distintas tablas y no se 
puede acceder a ellos con una sola consulta.

Del mismo modo, las tablas referenciadas DEBEN tener tipos de datos similares, la misma cantidad de campos y el mismo orden de campos en la 
lista de selecci�n de cada consulta que intervenga en la intersecci�n.

"intersect" devuelve la intersecci�n de las consultas involucradas; es decir, el resultado retornar� los registros que se encuentran en la primera y 
segunda consulta (y dem�s si las hubiere), o sea, los registros que todas las consultas tienen en com�n.

Sintaxis:

 SENTENCIASELECT1
  intersect
  SENTENCIASELECT2;
  
No olvide que las consultas DEBEN tener el mismo numero de valores retornados y los valores deben ser del mismo tipo.

Una academia de ense�anza de idiomas da clases de ingl�s, frances y portugues; almacena los datos de los alumnos que estudian ingl�s en una 
tabla llamada "ingles", los que est�n inscriptos en "franc�s" en una tabla denominada "frances" y los que aprenden portugues en la tabla "portugues".

La academia necesita el nombre y domicilio de todos los alumnos que cursan los tres idiomas para enviarles una tarjeta de descuento.

Para obtener los datos necesarios de las tres tablas en una sola consulta necesitamos realizar una intresecci�n:

 select nombre, domicilio from ingles
  intersect
   select nombre, domicilio from frances
  intersect
   select nombre, domicilio from portugues;

El primer "select" devuelve el nombre y domicilio de todos los estudiantes de ingl�s; el segundo, el nombre y domicilio de todos los inscriptos a 
franc�s y la tercera los mismos campos de los alumnos de "portugues". Esta sentencia de intersecci�n retornar� los registros que coinciden en las 
tres consultas "select".

"intersect" puede combinarse con la cl�usula "order by".
*/

 drop table ingles;
 drop table frances;
 drop table portugues;

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

 create table portugues(
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

 insert into portugues values('23444555','Daniel Duarte','Duarte Quiros 444');
 insert into portugues values('22333444','Carlos Caseros','Colon 333');
 insert into portugues values('30222333','Gaston Gonzalez','Guemes 777');
 insert into portugues values('31222333','Hector Huerta','Homero 888');
 insert into portugues values('32333444','Ines Ilara','Inglaterra 999');

-- La academia necesita el nombre y domicilio de todos los alumnos que cursan los tres idiomas para enviarles una tarjeta de descuento.
-- Obtenemos los datos necesarios de las tres tablas en una sola consulta realizando una intersecci�n entre ellas:

-- Aparece solamente un registro, correspondiente a "Daniel Duarte", que est� en las tres tablas. Note que los alumnos que solamente asisten a 
-- una clase o solamente a dos, no aparecen en el resultado.

select nombre, domicilio from ingles
intersect
select nombre, domicilio from frances
intersect
select nombre, domicilio from portugues;

-- Si queremos los registros que est�n presentes en m�s de dos tablas podemos realizar una consulta combinando los operadores de intersecci�n 
-- y de uni�n:

-- En la consulta, la primera intersecci�n (ingl�s con franc�s) retorna 2 registros (Esper y Duarte); la segunda intersecci�n (ingl�s y portugues) 
-- retorna 2 registros (Caseros y Duarte); unimos estos dos resultados con "union" y obtenemos 3 registros (Caseros, Duarte y Esper); la tercera 
-- intersecci�n (franc�s y portugu�s) retorna 2 registros (Duarte y Gozalez) que al "unirlos" al resultado de la primera uni�n (Caseros, Duarte y Esper) 
-- nos devuelve 4 registros. Note que algunas consultas se encierran entre par�ntesis para especificar que la operaci�n solo se realiza entre las tablas 
-- incluidas en ellos.

select nombre, domicilio from ingles
intersect 
select nombre, domicilio from frances
union
(select nombre, domicilio from ingles
intersect
select nombre, domicilio from portugues)
union
(select nombre, domicilio from frances
intersect 
select nombre, domicilio from portugues);

-- Ejercicio 1

 drop table medicos;
 drop table pacientes;

 create table medicos(
  legajo number(3),
  documento varchar2(8) not null,
  nombre varchar2(30),
  domicilio varchar2(30),
  especialidad varchar2(30),
  primary key(legajo)
 );

 create table pacientes(
  documento varchar2(8) not null,
  nombre varchar2(30),
  domicilio varchar2(30),
  obrasocial varchar2(20),
  primary key(documento)
 );

 insert into medicos values(1,'20111222','Ana Acosta','Avellaneda 111','clinica');
 insert into medicos values(2,'21222333','Betina Bustos','Bulnes 222','clinica');
 insert into medicos values(3,'22333444','Carlos Caseros','Colon 333','pediatria');
 insert into medicos values(4,'23444555','Daniel Duarte','Duarte Quiros 444','oculista');
 insert into medicos values(5,'24555666','Estela Esper','Esmeralda 555','alergia');

 insert into pacientes values('24555666','Estela Esper','Esmeralda 555','IPAM');
 insert into pacientes values('23444555','Daniel Duarte','Duarte Quiros 444','OSDOP');
 insert into pacientes values('30111222','Fabiana Fuentes','Famatina 666','PAMI');
 insert into pacientes values('30111333','Gaston Gonzalez','Guemes 777','PAMI');
 
 
 