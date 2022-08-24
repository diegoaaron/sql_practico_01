-- Tipos de datos

-- varchar2 : almancena cadena de caracteres  ejemplo: "nombre varchar(30)" significa que el campo nombre tendra como máximo
-- 30 caracteres. 

-- number(p,s) : almacena números con decimales. El parámetro "p" indica la precisión, es decir, el número de dígitos en total (contando los decimales) 
-- que contendrá el número como máximo.  El parámetro "s" especifica la escala, es decir, el máximo de dígitos decimales.
-- ejemplo: "precio number(3,2)" significa que soportara los numeros con 5 digitos en total (incluido los decimiales) como 999.98 o -333.22

drop table libros;

create table libros(
    titulo varchar(20),
    autor varchar(15),
    editorial varchar(10),
    precio number(6,2),
    cantidad number(3,0)
);

describe libros;

insert into libros (titulo, autor, editorial, precio, cantidad) values ('El Aleph', 'Borges', 'Emece', 25.50, 100);
insert into libros (titulo, autor, editorial, precio, cantidad) values ('Matematica estas ahi', 'Paenza', 'Siglo XXI', 18.8, 200);

select * from libros;

insert into libros (titulo,autor,editorial,precio,cantidad) values ('Alicia en el pais','Lewis Carroll','Atlantida',10,200);
 
 -- Ejercicios 1
 
 drop table peliculas;
 
 create table peliculas(
    nombre varchar(20),
    actor varchar(20),
    duracion number(3,0),
    cantidad number(1,0)
);

insert into peliculas (nombre, actor, duracion, cantidad) values ('Mision imposible','Tom Cruise',128,3);
insert into peliculas (nombre, actor, duracion, cantidad) values ('Mision imposible 2','Tom Cruise',130,2);
insert into peliculas (nombre, actor, duracion, cantidad) values ('Mujer bonita','Julia Roberts',118,3);
insert into peliculas (nombre, actor, duracion, cantidad) values ('Elsa y Fred','China zorrilla',110,2);
insert into peliculas (nombre, actor, duracion, cantidad) values ('Mujer bonita','Richard Gere',120,9);
 
select * from peliculas;

-- Ejercicio 2 
 
 drop table empleados;
 
 create table empleados(
    nombre varchar2(20),
    documento varchar2(8),
    sexo varchar2(1),
    domicilio varchar2(30),
    sueldobasico number(6,2)
);

select * from all_tables where table_name = 'EMPLEADOS';

describe empleados;

insert into empleados (nombre, documento, sexo, domicilio, sueldobasico) values ('Juan Perez','22333444','m','Sarmiento 123',500);
insert into empleados (nombre, documento, sexo, domicilio, sueldobasico) values ('Ana Acosta','24555666','f','Colon 134',650);
insert into empleados (nombre, documento, sexo, domicilio, sueldobasico) values ('Bartolome Barrios','27888999','m','Urquiza 479',800);
insert into empleados (nombre, documento, sexo, domicilio, sueldobasico) values ('Bartolome Barrios','27888999','m','Urquiza 479',8000.15);

select * from empleados;

