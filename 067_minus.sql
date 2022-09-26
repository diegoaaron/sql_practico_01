/*
Continuamos aprendiendo las operaciones de conjuntos. Aprendimos "union", "union all", "intersect", nos resta ver "minus" 
(resta, diferencia).

Como cualquier otra operación de conjuntos, "minus" se emplea cuando los datos que se quieren obtener pertenecen a 
distintas tablas y no se puede acceder a ellos con una sola consulta. Del mismo modo, las tablas referenciadas DEBEN 
tener tipos de datos similares, la misma cantidad de campos y el mismo orden de campos en la lista de selección de cada 
consulta que intervenga en la operación de resta.

"minus" (diferencia) devuelve los registros de la primera consulta que no se encuentran en segunda consulta, es decir, 
aquellos registros que no coinciden. Es el equivalente a "except" en SQL.

Sintaxis:

 SENTENCIASELECT1
  minus
  SENTENCIASELECT2;
  
No olvide que las consultas DEBEN tener el mismo numero de valores retornados y los valores deben ser del mismo tipo.

Una academia de enseñanza de idiomas da clases de inglés y frances; almacena los datos de los alumnos que estudian 
inglés en una tabla llamada "ingles" y los que están inscriptos en "francés" en una tabla denominada "frances".

La academia necesita el nombre y domicilio de todos los alumnos que cursan solamente inglés (no presentes en la 
tabla "frances") para enviarles publicidad referente al curso de francés. Empleamos el operador "minus" para obtener 
dicha información:

 select nombre, domicilio from ingles
  minus 
 select nombre,domicilio from frances;
Obtenemos los registros de la primer consulta que NO coinciden con ningún registro de la segunda consulta.

"minus" puede combinarse con la cláusula "order by".

Se pueden combinar más de dos sentencias con "minus".
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

-- La academia necesita el nombre y domicilio de todos los alumnos que cursan solamente inglés (no presentes en la 
-- tabla "frances") para enviarles publicidad referida al curso de francés. Empleamos el operador "minus" para obtener 
-- dicha información:
-- El resultado muestra los registros de la primer consulta que NO coinciden con ningún registro de la segunda consulta.
-- Los registros presentes en ambas tablas (Daniel Duarte y Estela Esper), no aparecen en el resultado final.

select nombre, domicilio from ingles
minus 
select nombre, domicilio from frances;

-- La academia necesita el nombre y domicilio de todos los alumnos que cursan solamente francés (no presentes en la tablab 
-- "ingles") para enviarles publicidad referida al curso de inglés. Empleamos el operador "minus" para obtener dicha información:
-- El resultado muestra los registros de la primer consulta que NO coinciden con ningún registro de la segunda consulta. 
-- Los registros presentes en ambas tablas (Daniel Duarte y Estela Esper), no aparecen en el resultado final.

select nombre, domicilio from frances
minus
select nombre, domicilio from ingles;

-- Si queremos los alumnos que cursan un solo idioma (registros de "ingles" y de "frances" que no coinciden), podemos 
-- unir ambas tablas y luego restarle la intersección:

select nombre, domicilio from ingles
union
select nombre, domicilio from frances
minus
(select nombre, domicilio from ingles
intersect
select nombre, domicilio from frances);

-- Podemos obtener el mismo resultado anterior con la siguiente consulta en la cual se buscan los registros de "ingles" 
-- que no coinciden con "frances" y los registros de "frances" que no coinciden con "ingles" y luego se unen ambos resultados:

select nombre, domicilio from ingles
minus 
select nombre, domicilio from frances
union
(select nombre, domicilio from frances
minus
select nombre, domicilio from ingles);

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
 
-- La clínica necesita el nombre y domicilio de médicos y pacientes para enviarles una tarjeta de invitación a la inauguración 
-- de un nuevo establecimiento. Emplee el operador "union" para obtener dicha información de ambas tablas (7 registros)

select nombre, domicilio from medicos 
union
select nombre, domicilio from pacientes;

-- Se necesitan los nombres de los médicos que también son pacientes de la clínica. Realice una intersección entre las tablas.

select nombre, domicilio from medicos 
intersect
select nombre, domicilio from pacientes;

-- La clínica necesita los nombres de los pacientes que no son médicos. Realice una operación de resta.

select nombre from pacientes
minus
select nombre from medicos;

-- Se necesitan los registros que no coinciden en ambas tablas. Realice la operación necesaria.

select nombre, domicilio from medicos
minus
select nombre, domicilio from pacientes
union
(select nombre, domicilio from pacientes
minus
select nombre, domicilio from medicos);

-- Ejercicio 2

