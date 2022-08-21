-- PRIMARY KEY, el campo definido para este rol debe de no aceptar valores nulos ni duplicados.

-- esta query valida la clave primaria de una tabla (se debe indicar el nombre de la tabla en mayusculas) 
 select uc.table_name, column_name from user_cons_columns ucc
  join user_constraints uc
  on ucc.constraint_name=uc.constraint_name
  where uc.constraint_type='P' and
  uc.table_name='ALUMNOS';
  
drop table usuarios;
  
create table usuarios(
    nombre varchar2(20),
    clave varchar2(10),
    primary key(nombre)
);

describe usuarios;

insert into usuarios(nombre, clave) values('juanperez', 'Boca');
insert into usuarios(nombre, clave) values ('raulgarcia','River');

insert into usuarios (nombre, clave) values (null,'payaso'); -- error

-- Ejercicio 1

drop table libros;

create table libros(
    codigo number(4) not null,
    titulo varchar2(40) not null,
    autor varchar2(20),
    editorial varchar2(15),
    primary key(codigo)
);

insert into libros (codigo,titulo,autor,editorial) values (1,'El aleph','Borges','Emece');
insert into libros (codigo,titulo,autor,editorial) values (2,'Martin Fierro','Jose Hernandez','Planeta');
insert into libros (codigo,titulo,autor,editorial) values (3,'Aprenda PHP','Mario Molina','Nuevo Siglo');

insert into libros(codigo, titulo, autor, editorial) values(3,'slsls','asdasd','xyz'); -- error

insert into libros(codigo, titulo, autor, editorial) values(null,'slsls','asdasd','xyz'); -- error

update libros set codigo=1 where titulo = 'Martin Fierro';

update libros set codigo = 10 where titulo = 'Martin Fierro';

-- Ejercicio 2

drop table alumnos;

create table alumnos(
  legajo varchar2(4) not null,
  documento varchar2(8),
  nombre varchar2(30),
  domicilio varchar2(30),
  primary key(documento)
);

insert into alumnos (legajo,documento,nombre,domicilio) values('A233','22345345','Perez Mariana','Colon 234');
insert into alumnos (legajo,documento,nombre,domicilio) values('A567','23545345','Morales Marcos','Avellaneda 348');

insert into alumnos(legajo,documento,nombre,domicilio) values('A333','23545345','Marcos LS','Avellaneda 348'); -- error 

insert into alumnos(legajo,documento,nombre,domicilio) values('A333',null,'Marcos LS','Avellaneda 348'); -- error 



