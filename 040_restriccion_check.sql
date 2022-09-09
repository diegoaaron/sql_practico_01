/*
La restricción "check" especifica los valores que acepta un campo, evitando que se ingresen valores inapropiados.

La sintaxis básica es la siguiente:

 alter table NOMBRETABLA
 add constraint NOMBRECONSTRAINT
 check CONDICION;
 
 Trabajamos con la tabla "libros" de una librería que tiene los siguientes campos: codigo, titulo, autor, editorial, 
 preciomin (que indica el precio para los minoristas) y preciomay (que indica el precio para los mayoristas).

Los campos correspondientes a los precios (minorista y mayorista) se definen de tipo number(5,2), es decir, aceptan 
valores entre -999.99 y 999.99. Podemos controlar que no se ingresen valores negativos para dichos campos 
agregando una restricción "check":

alter table libros
add constraint CK_libros_precio_positivo
check (preciomin>=0 and preciomay>=0);

Este tipo de restricción verifica los datos cada vez que se ejecuta una sentencia "insert" o "update", es decir, 
actúa en inserciones y actualizaciones.

Si la tabla contiene registros que no cumplen con la restricción que se va a establecer, la restricción no se 
puede establecer, hasta que todos los registros cumplan con dicha restricción.

La condición puede hacer referencia a otros campos de la misma tabla. Por ejemplo, podemos controlar 
que el precio mayorista no sea mayor al precio minorista:

alter table libros
add constraint CK_libros_preciominmay
check (preciomay<=preciomin);

Por convención, cuando demos el nombre a las restricciones "check" seguiremos la misma estructura: 
comenzamos con "CK", seguido del nombre de la tabla, del campo y alguna palabra con la cual podamos 
identificar fácilmente de qué se trata la restricción, por si tenemos varias restricciones "check" para el mismo campo.

Un campo puede tener varias restricciones "check" y una restricción "check" puede incluir varios campos.

Las condiciones para restricciones "check" también pueden incluir una lista de valores. Por ejemplo establecer 
que cierto campo asuma sólo los valores que se listan:

check (CAMPO in ('lunes','miercoles','viernes'));
 
Si un campo permite valores nulos, "null" es un valor aceptado aunque no esté incluido en la condición de restricción.

Si intentamos establecer una restricción "check" para un campo que entra en conflicto con otra 
restricción "check" establecida al mismo campo, Oracle no lo permite. Pero si establecemos una 
restricción "check" para un campo que entra en conflicto con un valor "default" establecido para el mismo 
campo, Oracle lo permite; pero al intentar ingresar un registro, aparece un mensaje de error.

En las condiciones de chequeo no es posible incluir funciones (como "sysdate").

Un campo con una restricción "primary key" o "unique" puede tener una (o varias) restricciones "check".

En la condición de una restricción "check" se puede establecer que un campo no admita valores nulos:

alter table libros
add constraint CK_libros_titulo
check (titulo is not null);
 
*/

drop table libros;

create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(15),
  preciomin number(5,2),
  preciomay number(5,2)
);

insert into libros values (1,'Uno','Bach','Planeta',22,20);
insert into libros values (2,'El quijote','Cervantes','Emece',15,13);
insert into libros values (3,'Aprenda PHP','Mario Molina','Siglo XXI',53,48);
insert into libros values (4,'Java en 10 minutos','Garcia','Siglo XXI',35,40);

-- Agregamos una restricción "primary key" para el campo "codigo":

alter table libros
add constraint PK_LIBROS_CODIGO
primary key(codigo);

-- Agregamos una restricción única, la clave única consta de 3 campos, "titulo", "autor" y "editorial":

alter table libros
add constraint UQ_LIBROS
unique(titulo,codigo,editorial);

-- Agregamos una restricción "check" para asegurar que los valores de los campos correspondientes a 
-- precios no puedan ser negativos:

alter table libros
add constraint CK_LIBROS_PRECIO_POSITIVO
check (preciomin>=0 and preciomay>=0);

-- Intentamos ingresar un valor inválido para algún campo correspondiente al precio, que vaya en contra de 
-- la restricción (por ejemplo el valor "-15") (muestra error)

insert into libros values(10,'Mtematico','Emece',-1h,11); 

-- Igualmente si intentamos actualizar un precio, que vaya en contra de la restricción:

update libros set preciomay = -20 where titulo = 'Uno';

-- Si intentamos agregar una restricción que no permita que el precio mayorista supere el precio minorista:

alter table libros
add constraint CK_LIBROS_PRECIOMINMAY2
check (preciomay <= preciomin);

-- corregimos el error en los registros, lo cual evitan insertar la restriccion

update libros set preciomay = 30 where titulo = 'Java en 10 minutos';

-- Veamos las restricciones de la tabla:

select * from user_constraints where table_name='LIBROS';

-- Note que en el caso de las restricciones de control, en las cuales muestra "C" en el tipo de constraint, 
-- la columna "SEARCH_CONDITION" muestra la regla que debe cumplirse; en caso de ser una 
-- restricción "primary key" o unique", esa columna queda vacía.

-- Consultamos "user_cons_columns":

select * from user_cons_columns where table_name = 'LIBROS';


-- Analizamos la información: la tabla tiene 4 restricciones, 1 "primary key", 1 "unique" y 2 "check". La restricción 
-- "primarykey" ocupa una sola fila porque fue definida para 1 solo campo, por ello, en la columna 
-- "POSITION" aparece "1". La restricción única ocupa tres filas porque fue definida con 3 campos cuyo orden está 
-- indicado en la columna "POSITION". La columna "POSITION" muestra información si la restricción es 
-- "primary key" o "unique" indicando el orden de los campos. La restricción de control "CK_libros_precios_positivo" 
-- ocupa 2 filas porque en su definición se nombran 2 campos (indicados en "COLUMN_NAME"). 
-- La restricción de control "CK_libros_preciominmax" ocupa 2 filas porque en su definición se nombran 2 campos 
-- (indicados en "COLUMN_NAME").


