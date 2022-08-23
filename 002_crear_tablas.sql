-- Una tabla es una estructura de datos que organiza los datos en columnas y filas; cada columna es un campo (o atributo) y cada fila, un registro.

-- ver todas las tablas
select * from all_tables;

-- crear un tabla 
create table usuarios(
    nombre varchar2(30),
    clave varchar2(10)
);

-- ver la informacion de una tabla
describe usuarios;

-- eliminar un tabla
drop table usuarios;

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

-- Ejercicio 2

drop table libros;

create table libros(
    titulo varchar2(20),
    autor varchar2(30),
    editorial varchar2(15)
);

select * from all_tables where table_name = 'LIBROS';

describe libros;