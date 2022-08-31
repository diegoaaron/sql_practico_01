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



