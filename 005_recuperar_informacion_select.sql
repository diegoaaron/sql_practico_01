drop table libros;

create table libros(
    titulo varchar2(40),
    autor varchar2(30),
    editorial varchar2(15),
    precio number(6,2),
    cantidad number(3,0)
);

describe libros;

insert into libros (titulo, autor, editorial, precio, cantidad) values ('El aleph', 'Borges', 'Emece', 25.50, 100);
insert into libros (titulo, autor, editorial, precio, cantidad) values ('Alicia en el país de las maravillas', 'Lewis Carroll', 'Atlantida', 10, 200);
insert into libros (titulo, autor, editorial, precio, cantidad) values ('Matematica estas ahi', 'Paenza', 'Siglo XXI', 18.80, 200);

commit;

select * from libros;

select titulo, autor, editorial from libros;

select titulo, precio from libros;

select editorial, cantidad from libros;


-- Ejercicio 1 

drop table peliculas;

create table peliculas(
    titulo varchar2(20),
    actor varchar2(20),
    duracion number(3),
    cantidad number(1)
);

insert into peliculas (titulo, actor, duracion, cantidad) values ('Mision Imposible', 'Tom Cruise', 180, 3);
insert into peliculas (titulo, actor, duracion, cantidad) values ('Mision Imposible 2', 'Tom Cruise', 190, 2);
insert into peliculas (titulo, actor, duracion, cantidad) values ('Mujer bonita', 'Julia Roberts', 118, 3);
insert into peliculas (titulo, actor, duracion, cantidad) values ('Elsa y Fred', 'China Zorrilla', 110, 2);

commit;

select titulo, actor from peliculas;

select titulo, duracion from peliculas;

select titulo, cantidad from peliculas;

-- Ejercicio 2 

drop table empleados;

create table empleados(
    nombre varchar2(20),
    documento varchar2(8),
    sexo varchar2(1),
    domicilio varchar2(30),
    sueldobasico number(6,2)
);

describe empleados;

insert into empleados (nombre, documento, sexo, domicilio, sueldobasico) values ('Juan Juarez', '22333444', 'm', 'Sarmiento 123', 500);
insert into empleados (nombre, documento, sexo, domicilio, sueldobasico) values ('Ana Acosta', '27888999', 'f', 'Colon 134', 700);
insert into empleados (nombre, documento, sexo, domicilio, sueldobasico) values ('Carlos Caceres', '31222333', 'm', 'Urquiza 479', 850);

commit;

select * from empleados;

select nombre, documento, domicilio from empleados;

select documento, sexo, sueldobasico from empleados;

