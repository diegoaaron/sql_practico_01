-- validamos existencia de la tabla
describe usuarios;

-- agrega registros a la tabla 'usuarios'
insert into usuarios (nombre, clave) values ('Mariano','payaso');

insert into usuarios (clave, nombre) values ('color','Luis');

-- validamos los registros ingresados 
select * from usuarios;

-- Ejercicio 1

drop table agenda;

create table agenda(
    apellido varchar2(30),
    nombre varchar2(20),
    domicilio varchar2(30),
    telefono varchar2(11)
);

select * from all_tables where table_name = 'AGENDA';

describe agenda;

insert into agenda (apellido, nombre, domicilio, telefono) values ('Moreno','Alberto','Colon 123','45414845');
insert into agenda (apellido, nombre, domicilio, telefono) values('Torres','Juan','Avellaneda 135','42987456');

select * from agenda;

drop table agenda;

-- Ejercicio 2 

drop table libros;

create table libros(
    titulo varchar2(20),
    autor varchar2(30),
    editorial varchar2(15)
);

select * from all_tables where table_name = 'LIBROS';

describe libros;

insert into libros (titulo, autor, editorial) values ('El aleph', 'Borges', 'Planeta');
insert into libros (titulo, autor, editorial) values('Martin Fierro','Jose Hernandez','Emece');
insert into libros (titulo,autor, editorial) values('Aprenda PHP', 'Mario Molina', 'Emece');

select * from libros;

