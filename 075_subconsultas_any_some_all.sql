/*
"any" y "some" son sinónimos. Chequean si alguna fila de la lista resultado de una subconsulta se encuentra el valor 
especificado en la condición.

Compara un valor escalar con los valores de un campo y devuelven "true" si la comparación con cada valor de la lista de 
la subconsulta es verdadera, sino "false".

El tipo de datos que se comparan deben ser compatibles.

La sintaxis básica es:

 ...VALORESCALAR OPERADORDECOMPARACION
  any (SUBCONSULTA);

Queremos saber los títulos de los libros de "Borges" que pertenecen a editoriales que han publicado también libros de 
"Richard Bach", es decir, si los libros de "Borges" coinciden con ALGUNA de las editoriales que publicó libros de 
"Richard Bach":

 select titulo
  from libros
  where autor='Borges' and
  codigoeditorial = any
   (select e.codigo
    from editoriales e
    join libros l
    on codigoeditorial=e.codigo
    where l.autor='Richard Bach');

La consulta interna (subconsulta) retorna una lista de valores de un solo campo (puede ejecutar la subconsulta como una 
consulta para probarla), luego, la consulta externa compara cada valor de "codigoeditorial" con cada valor de la lista 
devolviendo los títulos de "Borges" que coinciden.

"all" también compara un valor escalar con una serie de valores. Chequea si TODOS los valores de la lista de la consulta 
externa se encuentran en la lista de valores devuelta por la consulta interna.

Sintaxis:

  VALORESCALAR OPERADORDECOMPARACION all (SUBCONSULTA);

Queremos saber si TODAS las editoriales que publicaron libros de "Borges" coinciden con TODAS las editoriales que 
publicaron libros de "Richard Bach":

 select titulo
  from libros
  where autor='Borges' and
  codigoeditorial = all
   (select e.codigo
    from editoriales e
    join libros l
    on codigoeditorial=e.codigo
    where l.autor='Richard Bach');

La consulta interna (subconsulta) retorna una lista de valores de un solo campo (puede ejecutar la subconsulta como una 
consulta para probarla), luego, la consulta externa compara cada valor de "codigoeditorial" con cada valor de la lista, si 
TODOS coinciden, devuelve los títulos.

Veamos otro ejemplo con un operador de comparación diferente:

Queremos saber si ALGUN precio de los libros de "Borges" es mayor a ALGUN precio de los libros de "Richard Bach":

 select titulo,precio
  from libros
  where autor='Borges' and
  precio > any
   (select precio
    from libros
    where autor='Bach');

El precio de cada libro de "Borges" es comparado con cada valor de la lista de valores retornada por la subconsulta; 
si ALGUNO cumple la condición, es decir, es mayor a ALGUN precio de "Richard Bach", se lista.

Veamos la diferencia si empleamos "all" en lugar de "any":

 select titulo,precio
  from libros
  where autor='borges' and
  precio > all
   (select precio
    from libros
    where autor='bach');

El precio de cada libro de "Borges" es comparado con cada valor de la lista de valores retornada por la subconsulta; si 
cumple la condición, es decir, si es mayor a TODOS los precios de "Richard Bach" (o al mayor), se lista.

Emplear "= any" es lo mismo que emplear "in".

Emplear "<> all" es lo mismo que emplear "not in".
*/

 drop table libros;
 drop table editoriales;

 create table editoriales(
  codigo number(3),
  nombre varchar2(30),
  primary key (codigo)
 );
 
 create table libros (
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  codigoeditorial number(3),
  precio number(5,2),
  primary key(codigo),
 constraint FK_libros_editorial
   foreign key (codigoeditorial)
   references editoriales(codigo)
   on delete cascade
 );

 insert into editoriales values(1,'Planeta');
 insert into editoriales values(2,'Emece');
 insert into editoriales values(3,'Paidos');
 insert into editoriales values(4,'Siglo XXI');

 insert into libros values(100,'Uno','Richard Bach',1,15);
 insert into libros values(101,'Ilusiones','Richard Bach',4,18);
 insert into libros values(102,'Puente al infinito','Richard Bach',2,20);
 insert into libros values(103,'Aprenda PHP','Mario Molina',4,40);
 insert into libros values(104,'El aleph','Borges',2,10);
 insert into libros values(105,'Antología','Borges',1,20);
 insert into libros values(106,'Cervantes y el quijote','Borges',3,25);

-- Mostramos los títulos de los libros de "Borges" de editoriales que han publicado también libros de "Richard Bach":

select titulo from libros
where autor like '%Borges%' and
codigoeditorial = any 
(select e.codigo from editoriales e
join libros l
on e.codigo = codigoeditorial
where l.autor like '%Bach%');

-- Realizamos la misma consulta pero empleando "all" en lugar de "any":

 select titulo from libros
where autor like '%Borges%' and
codigoeditorial = all
(select e.codigo
from editoriales e
join libros l
on codigoeditorial=e.codigo
where l.autor like '%Bach%');

-- Mostramos los títulos y precios de los libros "Borges" cuyo precio supera a ALGUN precio de los libros de "Richard Bach":

select titulo, precio from libros
where autor like '%Borges%' and
precio > any
(select precio from libros
where autor like '%Bach%');

-- Veamos la diferencia si empleamos "all" en lugar de "any":

select titulo, precio from libros
where autor like '%Borges%' and
precio > all 
(select precio from libros
where autor like '%Bach%');

-- Empleamos la misma subconsulta para eliminación:

delete from libros
where autor like '%Borges%' and
precio > all 
(select precio from libros 
where autor like '%Bach%');

-- Ejercicio 1

 drop table inscriptos;
 drop table socios;

 create table socios(
  numero number(5),
  documento char(8),
  nombre varchar2(30),
  domicilio varchar2(30),
  primary key (numero)
 );
 
 create table inscriptos (
  numerosocio number(5),
  deporte varchar2(20) not null,
  cuotas number(2) default 0,
  constraint CK_inscriptos_cuotas
   check (cuotas>=0 and cuotas<=10),
  primary key(numerosocio,deporte),
  constraint FK_inscriptos_socio
   foreign key (numerosocio)
   references socios(numero)
   on delete cascade
 );

 insert into socios values(1,'23333333','Alberto Paredes','Colon 111');
 insert into socios values(2,'24444444','Carlos Conte','Sarmiento 755');
 insert into socios values(3,'25555555','Fabian Fuentes','Caseros 987');
 insert into socios values(4,'26666666','Hector Lopez','Sucre 344');

 insert into inscriptos values(1,'tenis',1);
 insert into inscriptos values(1,'basquet',2);
 insert into inscriptos values(1,'natacion',1);
 insert into inscriptos values(2,'tenis',9);
 insert into inscriptos values(2,'natacion',1);
 insert into inscriptos values(2,'basquet',default);
 insert into inscriptos values(2,'futbol',2);
 insert into inscriptos values(3,'tenis',8);
 insert into inscriptos values(3,'basquet',9);
 insert into inscriptos values(3,'natacion',0);
 insert into inscriptos values(4,'basquet',10);
 
 -- Muestre el número de socio, el nombre del socio y el deporte en que está inscripto con un join de ambas tablas

select s.numero, s.nombre, i.deporte from socios s
join inscriptos i
on s.numero = i.numerosocio;

-- Muestre los socios que se serán compañeros en tenis y también en natación (empleando subconsulta)

select nombre from socios
where numero in (select numerosocio from inscriptos where deporte = 'natacion');

-- Vea si el socio 1 se ha inscripto en algún deporte en el cual se haya inscripto el socio 2

select deporte from inscriptos
where numerosocio = 1 and 
deporte = any (select deporte from inscriptos where numerosocio = 2);

-- Realice la misma consulta anterior pero empleando "in" en lugar de "=any"

select deporte from inscriptos
where numerosocio = 1 and 
deporte in (select deporte from inscriptos where numerosocio = 2);

-- Obtenga el mismo resultado anterior pero empleando join

 select i1.deporte
  from inscriptos i1
  join inscriptos i2
  on i1.deporte=i2.deporte
  where i1.numerosocio=1 and
  i2.numerosocio=2;

-- Muestre los deportes en los cuales el socio 2 pagó más cuotas que ALGUN deporte en los que se inscribió el socio 1

select deporte from inscriptos i 
where numerosocio=2 and 
cuotas > any (select cuotas from inscriptos where numerosocio=1);

-- Realice la misma consulta anterior pero empleando "some" en lugar de "any"

select deporte from inscriptos i 
where numerosocio=2 and 
cuotas > some (select cuotas from inscriptos where numerosocio=1);

-- Muestre los deportes en los cuales el socio 2 pagó más cuotas que TODOS los deportes en que se inscribió el socio 1

select deporte from inscriptos i 
where numerosocio=2 and 
cuotas > all (select cuotas from inscriptos where numerosocio=1);

-- Cuando un socio no ha pagado la matrícula de alguno de los deportes en que se ha inscripto, se lo borra de la inscripción 
-- de todos los deportes. Elimine todos los socios que no pagaron ninguna cuota en algún deporte (cuota=0)
 
delete from inscriptos
where numerosocio in (select numerosocio from inscriptos where cuotas = 0);
 
