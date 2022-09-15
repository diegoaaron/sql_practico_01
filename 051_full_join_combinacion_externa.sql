/*
Vimos que un "left join" encuentra registros de la tabla izquierda que se correspondan con los registros de la tabla derecha 
y si un valor de la tabla izquierda no se encuentra en la tabla derecha, el registro muestra los campos correspondientes a 
la tabla de la derecha seteados a "null". Aprendimos también que un "right join" opera del mismo modo sólo que la tabla 
derecha es la que localiza los registros en la tabla izquierda.

Una combinación externa completa ("full outer join" o "full join") retorna todos los registros de ambas tablas. Si un registro de 
una tabla izquierda no encuentra coincidencia en la tabla derecha, las columnas correspondientes a campos de la tabla 
derecha aparecen seteadas a "null", y si la tabla de la derecha no encuentra correspondencia en la tabla izquierda, los campos 
de esta última aparecen conteniendo "null".

Veamos un ejemplo:

select titulo,nombre
from editoriales e
full join libros l
on codigoeditorial = e.codigo;

La salida del "full join" precedente muestra todos los registros de ambas tablas, incluyendo los libros cuyo código de 
editorial no existe en la tabla "editoriales" y las editoriales de las cuales no hay correspondencia en "libros".
*/

 drop table libros;
 drop table editoriales;

 create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  codigoeditorial number(3)
 );
 create table editoriales(
  codigo number(3),
  nombre varchar2(20)
 );
 
 alter table libros
  add constraint UQ_libros_codigo
  unique (codigo);

 alter table editoriales
  add constraint UQ_editoriales_codigo
  unique (codigo);  

 insert into editoriales values(1,'Alfaragua');
 insert into editoriales values(2,'Emece');
 insert into editoriales values(3,'Siglo XXI');
 insert into editoriales values(4,'Norma');
 insert into editoriales values(null,'Sudamericana');
 
 insert into libros values(100,'El aleph','Borges',null);
 insert into libros values(101,'Martin Fierro','Jose Hernandez',1);
 insert into libros values(102,'Aprenda PHP','Mario Molina',2);
 insert into libros values(103,'Java en 10 minutos',default,4);
 insert into libros values(104,'El anillo del hechicero','Carol Gaskin',1);
 
 -- Realizamos una combinación externa completa para obtener todos los registros de ambas tablas, 
 -- incluyendo los libros cuyo código de editorial no existe en la tabla "editoriales" y las editoriales de las cuales no 
 -- hay correspondencia en "libros":

select titulo, nombre as editorial
from editoriales e
full join libros l
on codigoeditorial = e.codigo;

-- Note que el libro "El aleph" cuyo valor de "codigoeditorial" es null, muestra "null" en la columna "editorial" y las 
-- editoriales "Sudamericana" y "Siglo XXI" muestran "null" en el campo "titulo".

-- Ejercicio 1 

drop table deportes;
drop table inscriptos;

create table deportes(
  codigo number(2),
  nombre varchar2(30),
  profesor varchar2(30)
);

create table inscriptos(
  documento char(8),
  codigodeporte number(2),
  matricula char(1) --'s'=paga; 'n'=impaga
);

alter table deportes
add constraint PK_deportes
primary key(codigo);

alter table inscriptos
add constraint PK_inscriptos
primary key(documento,codigodeporte);

 insert into deportes values(1,'tenis','Marcelo Roca');
 insert into deportes values(2,'natacion','Marta Torres');
 insert into deportes values(3,'basquet','Luis Garcia');
 insert into deportes values(4,'futbol','Marcelo Roca');
 
 insert into inscriptos values('22222222',3,'s');
 insert into inscriptos values('23333333',3,'s');
 insert into inscriptos values('24444444',3,'n');
 insert into inscriptos values('22222222',2,'s');
 insert into inscriptos values('23333333',2,'s');
 insert into inscriptos values('22222222',4,'n'); 
 insert into inscriptos values('22222222',5,'n'); 
 
 -- Muestre todos la información de la tabla "inscriptos", y consulte la tabla "deportes" 
 -- para obtener el nombre de cada deporte (6 registros). Note que uno de los registros tiene seteado a null la columna "deporte".
 
select documento, matricula, nombre, profesor 
from inscriptos i
inner join deportes d
on i.codigodeporte = d.codigo;
 
--  Empleando un "left join" con "deportes" obtenga todos los datos de los inscriptos (7 registros)

select documento, matricula, nombre, profesor
from inscriptos i
left join deportes d
on i.codigodeporte = d.codigo;

-- Obtenga la misma salida anterior empleando un "rigth join"
-- Note que se cambia el orden de las tablas y "right" por "left".

select documento, matricula, nombre, profesor
from deportes d
right join inscriptos i 
on d.codigo = i.codigodeporte;

-- Muestre los deportes para los cuales no hay inscriptos, empleando un "left join" (1 registro)

select documento, matricula, nombre, profesor
from deportes d 
left join inscriptos i
on i.codigodeporte = d.codigo
where i.codigodeporte is null;


-- Muestre los documentos de los inscriptos a deportes que no existen en la tabla "deportes" (1 registro)

select documento, matricula, nombre, profesor
from inscriptos i  
left join deportes d
on i.codigodeporte = d.codigo
where d.codigo is null;

-- Emplee un "full join" para obtener todos los datos de ambas tablas, incluyendo las inscripciones a deportes inexistentes 
-- en "deportes" y los deportes que no tienen inscriptos (8 registros)
-- Note que uno de los registros con documento "22222222" tiene seteado a "null" los campos correspondientes a "deportes" 
-- porque el código "5" no está presente en "deportes"; otro registro, que muestra "tenis" y "Marcelo Roca", tiene valores 
-- nulos en los campos correspondientes a la tabla "inscriptos", ya que, para el deporte con código 1, no hay inscriptos.






