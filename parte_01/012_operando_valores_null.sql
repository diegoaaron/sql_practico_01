-- para recuperar registros que tengan "null" debemos utilizar los operadores "is null" o "is not null"

drop table libros;
 
create table libros(
  codigo number(4) not null,
  titulo varchar2(40) not null,
  autor varchar2(20),
  editorial varchar2(20),
  precio number(6,2)
);

insert into libros values(1,'El aleph','Borges','Emece',15.90);
insert into libros values(2,'Cervantes y el quijote','Borges','Paidos',null);
insert into libros values(3,'Alicia en el pais de las maravillas','Lewis Carroll',null,19.90);
insert into libros values(4,'Martin Fierro','Jose Hernandez','Emece',25.90);
insert into libros (codigo,titulo,autor,precio) values(5,'Antolog�a po�tica','Borges',25.50);
insert into libros (codigo,titulo,autor) values(6,'Java en 10 minutos','Mario Molina');
insert into libros (codigo,titulo,autor) values(7,'Martin Fierro','Jose Hernandez');
insert into libros (codigo,titulo,autor) values(8,'Aprenda PHP',null);

select * from libros;

select * from libros where editorial is not null;

insert into libros (codigo, titulo, autor, editorial, precio) values (9, 'Don quijote', 'Cervantes', '   ', 20);

select * from libros where editorial is null;

select * from libros where editorial = '   ';

-- Ejercicio 1

drop table medicamentos;

create table medicamentos(
  codigo number(5) not null,
  nombre varchar2(20) not null,
  laboratorio varchar2(20),
  precio number(5,2),
  cantidad number(3,0) not null
);

describe medicamentos;

insert into medicamentos (codigo,nombre,laboratorio,precio,cantidad) values(1,'Sertal gotas',null,null,100); 
insert into medicamentos (codigo,nombre,laboratorio,precio,cantidad) values(2,'Sertal compuesto',null,8.90,150);
insert into medicamentos (codigo,nombre,laboratorio,precio,cantidad) values(3,'Buscapina','Roche',null,200);

select * from medicamentos;

insert into medicamentos (codigo, nombre, laboratorio, precio, cantidad) values(4,'LD','',0,10);

insert into medicamentos(codigo, nombre, laboratorio, precio, cantidad) values(0,'','MM',1,1); -- error 

insert into medicamentos(codigo, nombre, laboratorio, precio, cantidad) values(0,null,'MM',1,1); -- error 

select * from medicamentos where laboratorio is null;

select * from medicamentos where precio is null;

select * from medicamentos where precio = 0;

select * from medicamentos where laboratorio is not null;

select * from medicamentos where precio <> 0;

select * from medicamentos where precio is not null;

insert into medicamentos(codigo, nombre, laboratorio, precio, cantidad) values(9,' ','DKD',10,22);

insert into medicamentos(codigo, nombre, laboratorio, precio, cantidad) values(9,'LIS',' ',10,22);

select * from medicamentos where laboratorio is null;

select * from medicamentos where laboratorio = ' ';

select * from medicamentos where laboratorio <> ' ';

select * from medicamentos where laboratorio is not null;

-- Ejercicio 2 

drop table peliculas;

create table peliculas(
  codigo number(4) not null,
  titulo varchar2(40) not null,
  actor varchar2(20),
  duracion number(3)
);

describe peliculas;

insert into peliculas (codigo,titulo,actor,duracion) values(1,'Mision imposible','Tom Cruise',120);
insert into peliculas (codigo,titulo,actor,duracion) values(2,'Harry Potter y la piedra filosofal',null,180);
insert into peliculas (codigo,titulo,actor,duracion) values(3,'Harry Potter y la camara secreta','Daniel R.',null);
insert into peliculas (codigo,titulo,actor,duracion) values(0,'Mision imposible 2','',150);
insert into peliculas (codigo,titulo,actor,duracion) values(4,'Titanic','L. Di Caprio',220);
insert into peliculas (codigo,titulo,actor,duracion) values(5,'Mujer bonita','R. Gere-J. Roberts',0);

select * from peliculas;

insert into peliculas(codigo, titulo, actor, duracion) values(6,'','ASD',15); -- error

select * from peliculas where actor is null;

update peliculas set duracion = 120 where duracion is null;

select * from peliculas where duracion = 120;

update peliculas set actor='Desconocido' where actor is null;

select * from peliculas where actor is null;

update peliculas set duracion = null where duracion = 0;

delete from peliculas where duracion is null;

commit;


