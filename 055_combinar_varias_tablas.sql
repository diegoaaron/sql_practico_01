/*
Podemos hacer un "join" con más de dos tablas.

La librería almacena los datos de sus libros en tres tablas: libros, editoriales y autores.

En la tabla "libros" un campo "codigoautor" hace referencia al autor y un campo "codigoeditorial" referencia la editorial.

Para recuperar todos los datos de los libros empleamos la siguiente consulta:

select titulo,a.nombre,e.nombre
from autores a
join libros l
on codigoautor=a.codigo
join editoriales e 
on codigoeditorial=e.codigo;
  
Analicemos la consulta anterior. Indicamos el nombre de la tabla luego del "from" ("autores"), combinamos esa tabla con la 
tabla "libros" especificando con "on" el campo por el cual se combinarán; luego debemos hacer coincidir los valores para el 
enlace con la tabla "editoriales" enlazándolas por los campos correspondientes. Utilizamos alias para una sentencia más 
sencilla y comprensible.

Note que especificamos a qué tabla pertenecen los campos cuyo nombre se repiten en las tablas, esto es necesario para 
evitar confusiones y ambiguedades al momento de referenciar un campo.
Los libros cuyo código de autor no se encuentra en "autores" y cuya editorial no existe en "editoriales", no aparecen porque 
realizamos una combinación interna.

Podemos combinar varios tipos de join en una misma sentencia:

select titulo,a.nombre,e.nombre
from autores a
right join libros l
on codigoautor=a.codigo
left join editoriales e
on codigoeditorial=e.codigo;

En la consulta anterior solicitamos el título, autor y editorial de todos los libros que encuentren o no coincidencia con 
"autores" ("right join") y a ese resultado lo combinamos con "editoriales", encuentren o no coincidencia.

Es posible realizar varias combinaciones para obtener información de varias tablas. Las tablas deben tener claves externas 
relacionadas con las tablas a combinar.

En consultas en las cuales empleamos varios "join" es importante tener en cuenta el orden de las tablas y los tipos de "join".
*/

drop table libros;
drop table autores;
drop table editoriales;

create table libros(
codigo number(5),
titulo varchar2(40),
codigoautor number(4) not null,
codigoeditorial number(3),
primary key(codigo)
);

create table autores(
codigo number(4),
nombre varchar2(20),
primary key (codigo)
);

create table editoriales(
codigo number(3),
nombre varchar2(20),
primary key (codigo)
);

insert into editoriales values(1,'Planeta');
insert into editoriales values(2,'Emece');
insert into editoriales values(3,'Siglo XXI');
insert into editoriales values(4,'Norma');
 
insert into autores values (1,'Richard Bach');
insert into autores values (2,'Borges');
insert into autores values (3,'Jose Hernandez');
insert into autores values (4,'Mario Molina');
insert into autores values (5,'Paenza');
 
insert into libros values(100,'El aleph',2,2);
insert into libros values(101,'Martin Fierro',3,1);
insert into libros values(102,'Aprenda PHP',4,3);
insert into libros values(103,'Uno',1,1);
insert into libros values(104,'Java en 10 minutos',0,3);
insert into libros values(105,'Matematica estas ahi',10,null);
insert into libros values(106,'Java de la A a la Z',4,0);

-- Recuperamos todos los datos de los libros consultando las tres tablas
-- Note que no aparecen los libros cuyo código de autor no se encuentra en "autores" (caso de "Java en 10 minutos" 
-- y "Matematica estas ahi") y cuya editorial no existe en "editoriales" (caso de "Matematica estas ahi" y "Java de la A a la Z"), 
-- esto es porque realizamos una combinación interna.

select titulo, a.nombre as autor, e.nombre as editorial
from autores a 
join libros l
on codigoautor = a.codigo
join editoriales e
on codigoeditorial = e.codigo;

-- Podemos combinar varios tipos de join en una misma sentencia:

select titulo, a.nombre as autor, e.nombre as editorial
from autores a
right join libros l
on codigoautor =a.codigo
left join editoriales e
on codigoeditorial = e.codigo;

-- Ejercicio 1
-- Un club dicta clases de distintos deportes. En una tabla llamada "socios" guarda los datos de los socios, en una tabla 
-- llamada "deportes" la información referente a los diferentes deportes que se dictan y en una tabla denominada "inscriptos",
-- las inscripciones de los socios a los distintos deportes.
-- Un socio puede inscribirse en varios deportes el mismo año. Un socio no puede inscribirse en el mismo deporte el mismo 
-- año. Distintos socios se inscriben en un mismo deporte en el mismo año.

drop table socios;
drop table deportes;
drop table inscriptos;

create table socios(
documento char(8) not null, 
nombre varchar2(30),
domicilio varchar2(30),
primary key(documento)
);

create table deportes(
codigo number(2),
nombre varchar2(20),
profesor varchar2(15),
primary key(codigo)
);

create table inscriptos(
documento char(8) not null, 
codigodeporte number(2) not null,
año char(4),
matricula char(1),--'s'=paga, 'n'=impaga
primary key(documento,codigodeporte,año)
);
 
-- Ingrese algunos registros en "socios":

insert into socios values('22222222','Ana Acosta','Avellaneda 111');
insert into socios values('23333333','Betina Bustos','Bulnes 222');
insert into socios values('24444444','Carlos Castro','Caseros 333');
insert into socios values('25555555','Daniel Duarte','Dinamarca 44');

-- Ingrese algunos registros en "deportes":

insert into deportes values(1,'basquet','Juan Juarez');
insert into deportes values(2,'futbol','Pedro Perez');
insert into deportes values(3,'natacion','Marina Morales');
insert into deportes values(4,'tenis','Marina Morales');

-- Inscriba a varios socios en el mismo deporte en el mismo año:

insert into inscriptos values ('22222222',3,'2016','s');
insert into inscriptos values ('23333333',3,'2016','s');
insert into inscriptos values ('24444444',3,'2016','n');

-- Inscriba a un mismo socio en el mismo deporte en distintos años:

insert into inscriptos values ('22222222',3,'2015','s');
insert into inscriptos values ('22222222',3,'2017','n');

-- Inscriba a un mismo socio en distintos deportes el mismo año:

insert into inscriptos values ('24444444',1,'2016','s');
insert into inscriptos values ('24444444',2,'2016','s');
 
 -- Ingrese una inscripción con un código de deporte inexistente y un documento de socio que no exista en "socios"
 
 insert into inscriptos values ('26666666',0,'2016','s');
 
 -- Muestre el nombre del socio, el nombre del deporte en que se inscribió y el año empleando diferentes tipos de join 
 
  select s.nombre, d.nombre, i.año 
 from socios s
 join inscriptos i
 on s.documento = i.documento
 join deportes d
 on i.codigodeporte = d.codigo;
 
 -- solución alternativa a la anterior en la cual se considera al inscrito con un codigo de deporte inexistente. 
 select s.nombre, d.nombre, i.año
 from deportes d
 right join inscriptos i
 on codigodeporte = d.codigo
 left join socios s
 on i.documento =s.documento;
 
-- Muestre todos los datos de las inscripciones (excepto los códigos) incluyendo aquellas inscripciones cuyo código de 
-- deporte no existe en "deportes" y cuyo documento de socio no se encuentra en "socios" (10 filas)

select s.nombre, s.domicilio, d.nombre, d.profesor, i.documento, i.año, i.matricula
from socios s
full join inscriptos i
on s.documento = i.documento
full join deportes d
on i.codigodeporte = d.codigo;

-- Muestre todas las inscripciones del socio con documento "22222222" (3 filas)

 select s.nombre, d.nombre, i.año 
 from socios s
 join inscriptos i
 on s.documento = i.documento
 join deportes d
 on i.codigodeporte = d.codigo
 where s.documento = '22222222';

