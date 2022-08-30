-- operador logico

-- Podemos establecer más de una condición con la cláusula "where", para ello aprenderemos los operadores lógicos.

/*
and, significa "y",
or, significa "y/o",
not, significa "no", invierte el resultado
(), paréntesis
*/

-- mostrar libros con autor igual a "Borges" y precio menor a 20

select * from libros where (autor='Borges') and (precio<=20);

-- mostrar libros con autor igual a "Borges" o editorial sea "Planeta"

select * from libros where (autor='Borges') or (editorial = 'Planeta');

-- mostrar libros que no sean de la editorial Planeta

select * from libros where not editorial = 'Planeta';

-- Los paréntesis se usan para encerrar condiciones, para que se evalúen como una sola expresión. Por ejemplo la siguientes
-- sentencias, devuelven valores diferentes.

select * from libros where (autor = 'Borges') or (editorial='Paidos' and precio < 20);

select * from libros where (autor='Borges' or editorial='Paidos') and (precio < 20);

-- El orden de prioridad de los operadores lógicos es el siguiente: "not" se aplica antes que "and" y "and" antes que "or", 
-- si no se especifica un orden de evaluación mediante el uso de paréntesis. El orden en el que se evalúan los 
-- operadores con igual nivel de precedencia es indefinido, por ello se recomienda usar los paréntesis.

-- Ejercicio 1

drop table libros;

create table libros(
  codigo number(5),
  titulo varchar2(40) not null,
  autor varchar2(20) default 'Desconocido',
  editorial varchar2(20),
  precio number(6,2)
);

insert into libros  values(1,'El aleph','Borges','Emece',15.90);
insert into libros  values(2,'Antología poética','Borges','Planeta',39.50);
insert into libros  values(3,'Java en 10 minutos','Mario Molina','Planeta',50.50);
insert into libros  values(4,'Alicia en el pais de las maravillas','Lewis Carroll','Emece',19.90);
insert into libros  values(5,'Martin Fierro','Jose Hernandez','Emece',25.90);
insert into libros  values(6,'Martin Fierro','Jose Hernandez','Paidos',16.80);
insert into libros  values(7,'Aprenda PHP','Mario Molina','Emece',19.50);
insert into libros  values(8,'Cervantes y el quijote','Borges','Paidos',18.40);

-- Recuperamos los libros cuyo autor sea igual a "Borges" y cuyo precio no supere los 20 pesos

select * from libros where (autor='Borges') and (precio <=20);

-- Recuperamos los libros cuya editorial NO es "Planeta"

select * from libros where not editorial = 'Planeta';

-- Utilizando los parentesis de forma diferente 

select * from libros where (autor='Borges') or (editorial='Paidos' and precio<20);

select * from libros where (autor='Borges' or editorial='Paidos') and (precio<20);

-- Ejercicio 2

drop table medicamentos;

create table medicamentos(
  codigo number(5),
  nombre varchar2(20),
  laboratorio varchar2(20),
  precio number(5,2),
  cantidad number(3),
  primary key(codigo)
);

insert into medicamentos values(100,'Sertal','Roche',5.2,100);
insert into medicamentos values(102,'Buscapina','Roche',4.10,200);
insert into medicamentos values(205,'Amoxidal 500','Bayer',15.60,100);
insert into medicamentos values(230,'Paracetamol 500','Bago',1.90,200);
insert into medicamentos values(345,'Bayaspirina','Bayer',2.10,150); 
insert into medicamentos values(347,'Amoxidal jarabe','Bayer',5.10,250); 

-- Recupere los códigos y nombres de los medicamentos cuyo laboratorio sea "Roche' y cuyo precio sea menor a 5

select codigo, nombre from medicamentos where (laboratorio='Roche') and (precio <5);

-- Recupere los medicamentos cuyo laboratorio sea "Roche" o cuyo precio sea menor a 5 

select codigo, nombre from medicamentos where (laboratorio='Roche') or (precio <5);

-- Muestre todos los medicamentos cuyo laboratorio NO sea "Bayer" y cuya cantidad sea=100. 

select * from medicamentos where (not laboratorio='Bayer') and (cantidad = 100);

-- Luego muestre todos los medicamentos cuyo laboratorio sea "Bayer" y cuya cantidad NO sea=100

select * from medicamentos where (laboratorio='Bayer') and (not cantidad = 100);

-- Recupere los nombres de los medicamentos cuyo precio esté entre 2 y 5 inclusive

select nombre from medicamentos where (precio>=2) and (precio <=5);

-- Elimine todos los registros cuyo laboratorio sea igual a "Bayer" y su precio sea mayor a 10

delete from medicamentos where laboratorio = 'Bayer' and precio > 10;

-- Cambie la cantidad por 200, de todos los medicamentos de "Roche" cuyo precio sea mayor a 5

update medicamentos set cantidad=200 where laboratorio = 'Roche' and precio > 5;

-- Borre los medicamentos cuyo laboratorio sea "Bayer" o cuyo precio sea menor a 3

delete from medicamentos where (laboratorio = 'Bayer') or (precio < 3);

-- Ejercicios 3

drop table peliculas;

create table peliculas(
  codigo number(4),
  titulo varchar2(40) not null,
  actor varchar2(20),
  duracion number(3),
  primary key (codigo)
);

insert into peliculas  values(1020,'Mision imposible','Tom Cruise',120);
insert into peliculas  values(1021,'Harry Potter y la piedra filosofal','Daniel R.',180);
insert into peliculas  values(1022,'Harry Potter y la camara secreta','Daniel R.',190);
insert into peliculas  values(1200,'Mision imposible 2','Tom Cruise',120);
insert into peliculas  values(1234,'Mujer bonita','Richard Gere',120);
insert into peliculas  values(900,'Tootsie','D. Hoffman',90);
insert into peliculas  values(1300,'Un oso rojo','Julio Chavez',100);
insert into peliculas  values(1301,'Elsa y Fred','China Zorrilla',110);

-- Recupere los registros cuyo actor sea "Tom Cruise" o "Richard Gere" 

select * from peliculas where (actor = 'Tom Cruise') or (actor = 'Richard Gere');

-- Recupere los registros cuyo actor sea "Tom Cruise" y duración menor a 100

select * from peliculas where (actor = 'Tom Cruise') and (duracion < 100); 

-- Recupere los nombres de las películas cuya duración se encuentre entre 100 y 120 minutos

select * from peliculas where (duracion >= 100) and (duracion <= 120); 

-- Cambie la duración a 200, de las películas cuyo actor sea "Daniel R." y cuya duración sea 180

update peliculas set duracion = 200 where actor = 'Daniel R.' and duracion = 180;

-- Borre todas las películas donde el actor NO sea "Tom Cruise" y cuya duración sea mayor o igual a 100

delete from peliculas where (not actor = 'Tom Cruise') and (duracion >= 100);

commit;



