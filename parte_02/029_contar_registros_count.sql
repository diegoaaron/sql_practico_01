-- La función "count()" cuenta la cantidad de registros de una tabla, incluyendo los que tienen valor nulo.
-- Para que no concidere los registros con valores nulos debemos de especificar un campo.

drop table libros;

create table libros(
  titulo varchar2(40) not null,
  autor varchar2(20) default 'Desconocido',
  editorial varchar(20),
  precio number(6,2)
);

insert into libros values('El aleph','Borges','Emece',15.90);
insert into libros values('Antología poética',null,'Planeta',null);
insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll',null,19.90);
insert into libros values('Matematica estas ahi','Paenza','Siglo XXI',15);
insert into libros values('Martin Fierro','Jose Hernandez',default,40);
insert into libros values('Aprenda PHP',default,'Nuevo siglo',null);
insert into libros values('Uno','Richard Bach','Planeta',20);

-- contar todo los registros de la tabla libros (incluira registros que tengan valores nulos)

select count(*) from libros;

-- contamos libros de la editorial Planeta

select count(editorial) from libros where editorial like 'Planeta';

-- contamos los registros que tienen precio (sin tener en cuenta los que tienen valor nulo)

select count(precio) from libros;  -- no considera los libros con precio "null"

-- Contamos los registros que tienen valor diferente de "null" en "editorial":

select count(editorial) from libros;

-- Ejercicio 1

drop table medicamentos;

create table medicamentos(
  codigo number(5),
  nombre varchar2(20),
  laboratorio varchar2(20),
  precio number(6,2),
  cantidad number(3),
  fechavencimiento date not null,
  numerolote number(6) default null,
  primary key(codigo)
);

insert into medicamentos values(120,'Sertal','Roche',5.2,1,'01/02/2015',123456);
insert into medicamentos values(220,'Buscapina','Roche',4.10,3,'01/02/2016',null);
insert into medicamentos values(228,'Amoxidal 500','Bayer',15.60,100,'01/05/2017',null);
insert into medicamentos values(324,'Paracetamol 500','Bago',1.90,20,'01/02/2018',null);
insert into medicamentos values(587,'Bayaspirina',null,2.10,null,'01/12/2019',null); 
insert into medicamentos values(789,'Amoxidal jarabe','Bayer',null,null,'15/12/2019',null); 

-- mostrar la cantidad de registros de la tabla medicamentos

select count(*) from medicamentos;

-- cuente la cantidad de medicamentos que tienen laboratorio conocido

select count(laboratorio) from medicamentos;

-- cuente la cantidad de medicamentos que tienen precio y cantidad, con alias

select count(precio) as "med. con precio", count(cantidad) as "med. con stock" from medicamentos;

-- cuente la cantidad de remedios con precio conocido, cuyo laboratorio comience con "B"

select count(precio) from medicamentos where laboratorio like 'B%';

-- cuente la cantidad de medicamentos con número de lote distinto de "null"

select count(numerolote) from medicamentos;

-- cuente la cantidad de medicamentos con fecha de vencimiento conocida

select count(fechavencimiento) from medicamentos;


