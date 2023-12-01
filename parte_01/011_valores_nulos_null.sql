-- "null' significa "dato desconocido" o "valor inexistente".
-- Una cadena vacía es interpretada por Oracle como valor nulo; por lo tanto, si ingresamos una cadena vacía, se almacena el valor "null".

drop table libros;

create table libros(
    titulo varchar2(30) not null, -- indicando que no acepta valores nulos
    autor varchar2(20) not null,
    editorial varchar2(15) null, -- indicando de forma explicita que soportara nulos
    precio number(5,2) -- por defecto un campo aceptara nulos
);

describe libros;

-- Si ingresamos los datos de un libro, para el cual aún no hemos definido el precio podemos colocar "null" para mostrar que este valor no existe. 
-- Note que el valor "null" no es una cadena de caracteres, NO se coloca entre comillas.

insert into libros (titulo, autor, editorial, precio) values('Alicia en el pais', 'Lewis Carroll',null,25);
insert into libros (titulo,autor,editorial,precio) values('El aleph','Borges','Emece',null);
insert into libros (titulo,autor,editorial,precio) values('', 'Borges', 'Siglo XXI', 25); -- muestra error debido a que el campo no soporta null
insert into libros (titulo,autor,editorial,precio) values('El diario', null, 'Siglo XXI', 25); -- muestra error debido a que el campo no soporta null
insert into libros (titulo,autor,editorial,precio) values('Don quijote', 'Cervantes', '   ',20); -- los 3 espacios si forman una cadena y no se puede considerar null

commit; 

select * from libros;

-- Para recuperar los registros que contengan el valor "null" en algún campo, no podemos utilizar los operadores relacionales 
-- vistos anteriormente: = (igual) y <> (distinto); debemos utilizar los operadores "is null" (es igual a null) y "is not null" (no es null).

select * from libros where editorial is null;

select * from libros where editorial is not null;

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

insert into medicamentos (codigo,nombre,laboratorio,precio,cantidad) values(4,'Vicodin','',0,10); -- cadena vacia en laboratorio y 0 en precio
insert into medicamentos (codigo,nombre,laboratorio,precio,cantidad) values(5,'','Bayer',2.2,10); -- cadena vacia en nombre (error)
insert into medicamentos (codigo,nombre,laboratorio,precio,cantidad) values(6,'Litio','Bayer',2.2,null); -- null en cantidad (error)
insert into medicamentos (codigo,nombre,laboratorio,precio,cantidad) values(7,'Fung',' ',2.2,11); -- un espacio en campo laboratorio

select * from medicamentos;

select * from medicamentos where laboratorio = ' ';

select * from medicamentos where laboratorio <> ' ';

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

insert into peliculas (codigo,titulo,actor,duracion) values(null,'','R. Gere-J. Roberts',0); -- null y cadena en blanco en los  campos codigo, titulo (error)

update peliculas set duracion=null where duracion=0;

commit;

select * from peliculas;