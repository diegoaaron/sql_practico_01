-- palabra reservada 'in', se utiliza para averiguar si el valor de un campo está incluido en una lista de valores especificada. 
-- Los valores "null" no se consideran. 

drop table libros;

create table libros(
  codigo number (5),
  titulo varchar2(40) not null,
  autor varchar2(20),
  editorial varchar2(20),
  precio number(6,2)
);

insert into libros values(1,'El aleph','Borges','Emece',15.90);
insert into libros values(2,'Cervantes y el quijote','Borges','Paidos',null);
insert into libros values(3,'Alicia en el pais de las maravillas','Lewis Carroll',null,19.90);
insert into libros values(4,'Matematica estas ahi','Paenza','Siglo XXI',15);
insert into libros values(5,'Antología poética',default,default,32);
insert into libros values(6,'Martin Fierro','Jose Hernandez',default,40);
insert into libros values(7,'Aprenda PHP','Mario Molina',default,56.50);

-- recuperamos los libros cuyo autor es "Paenza" o "Borges":

select * from libros where autor in ('Borges','Paenza');

-- recuperamos los libros cuyo autor NO es "Paenza" ni "Borges":

select * from libros where autor not in ('Borges','Paenza');

-- recuperamos los libros cuyo código se encuentre en la siguiente lista de valores (1,3,5,7,9)

select * from libros where codigo in (1,3,5,7,9);

-- Ejercicio 1 

drop table medicamentos;

create table medicamentos(
  codigo number(5),
  nombre varchar2(20),
  laboratorio varchar2(20),
  precio number(6,2),
  cantidad number(3) not null,
  fechavencimiento date not null,
  primary key(codigo)
);

insert into medicamentos values(100,'Sertal','Roche',5.2,1,'01/02/2015');
insert into medicamentos values(230,'Buscapina',null,4.10,3,'01/03/2016');
insert into medicamentos values(280,'Amoxidal 500','Bayer',15.60,100,'01/05/2017');
insert into medicamentos values(301,'Paracetamol 500','Bago',1.90,10,'01/02/2018');
insert into medicamentos  values(400,'Bayaspirina','Bayer',2.10,150,'01/08/2019'); 
insert into medicamentos  values(560,'Amoxidal jarabe','Bayer',5.10,250,'01/10/2020'); 

-- recupere los nombres y precios de los medicamentos cuyo laboratorio sea "Bayer" o "Bago"

select * from medicamentos where laboratorio in ('Bayer','Bago');

-- recupere los nombres y precios de los medicamentos cuyo laboratorio NO sea "Bayer" o "Bago"

select * from medicamentos where laboratorio not in ('Bayer','Bago');

-- seleccione los remedios cuya cantidad se encuentre entre 1 y 5 (utilizand in y between)

select * from medicamentos where cantidad between 1 and 5;

select * from medicamentos where cantidad in (1,2,3,4,5);

-- recupere los registros cuyas fechas de vencimiento se encuentra entre enero de 2015 y enero del 2017

select * from  medicamentos where  fechavencimiento between '01/01/2015' and '31/01/2017';

-- recupere los registros cuyo año de vencimiento sea 2015 o 2016

select * from medicamentos where extract(year from fechavencimiento) in (2015,2016);


