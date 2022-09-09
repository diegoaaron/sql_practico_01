/*
La restricci�n "check" especifica los valores que acepta un campo, evitando que se ingresen valores inapropiados.

La sintaxis b�sica es la siguiente:

 alter table NOMBRETABLA
 add constraint NOMBRECONSTRAINT
 check CONDICION;
 
 Trabajamos con la tabla "libros" de una librer�a que tiene los siguientes campos: codigo, titulo, autor, editorial, 
 preciomin (que indica el precio para los minoristas) y preciomay (que indica el precio para los mayoristas).

Los campos correspondientes a los precios (minorista y mayorista) se definen de tipo number(5,2), es decir, aceptan 
valores entre -999.99 y 999.99. Podemos controlar que no se ingresen valores negativos para dichos campos 
agregando una restricci�n "check":

alter table libros
add constraint CK_libros_precio_positivo
check (preciomin>=0 and preciomay>=0);

Este tipo de restricci�n verifica los datos cada vez que se ejecuta una sentencia "insert" o "update", es decir, 
act�a en inserciones y actualizaciones.

Si la tabla contiene registros que no cumplen con la restricci�n que se va a establecer, la restricci�n no se 
puede establecer, hasta que todos los registros cumplan con dicha restricci�n.

La condici�n puede hacer referencia a otros campos de la misma tabla. Por ejemplo, podemos controlar 
que el precio mayorista no sea mayor al precio minorista:

alter table libros
add constraint CK_libros_preciominmay
check (preciomay<=preciomin);

Por convenci�n, cuando demos el nombre a las restricciones "check" seguiremos la misma estructura: 
comenzamos con "CK", seguido del nombre de la tabla, del campo y alguna palabra con la cual podamos 
identificar f�cilmente de qu� se trata la restricci�n, por si tenemos varias restricciones "check" para el mismo campo.

Un campo puede tener varias restricciones "check" y una restricci�n "check" puede incluir varios campos.

Las condiciones para restricciones "check" tambi�n pueden incluir una lista de valores. Por ejemplo establecer 
que cierto campo asuma s�lo los valores que se listan:

check (CAMPO in ('lunes','miercoles','viernes'));
 
Si un campo permite valores nulos, "null" es un valor aceptado aunque no est� incluido en la condici�n de restricci�n.

Si intentamos establecer una restricci�n "check" para un campo que entra en conflicto con otra 
restricci�n "check" establecida al mismo campo, Oracle no lo permite. Pero si establecemos una 
restricci�n "check" para un campo que entra en conflicto con un valor "default" establecido para el mismo 
campo, Oracle lo permite; pero al intentar ingresar un registro, aparece un mensaje de error.

En las condiciones de chequeo no es posible incluir funciones (como "sysdate").

Un campo con una restricci�n "primary key" o "unique" puede tener una (o varias) restricciones "check".

En la condici�n de una restricci�n "check" se puede establecer que un campo no admita valores nulos:

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

-- Agregamos una restricci�n "primary key" para el campo "codigo":

alter table libros
add constraint PK_LIBROS_CODIGO
primary key(codigo);

-- Agregamos una restricci�n �nica, la clave �nica consta de 3 campos, "titulo", "autor" y "editorial":

alter table libros
add constraint UQ_LIBROS
unique(titulo,codigo,editorial);

-- Agregamos una restricci�n "check" para asegurar que los valores de los campos correspondientes a 
-- precios no puedan ser negativos:

alter table libros
add constraint CK_LIBROS_PRECIO_POSITIVO
check (preciomin>=0 and preciomay>=0);

-- Intentamos ingresar un valor inv�lido para alg�n campo correspondiente al precio, que vaya en contra de 
-- la restricci�n (por ejemplo el valor "-15") (muestra error)

insert into libros values(10,'Mtematico','Emece',-1h,11); 

-- Igualmente si intentamos actualizar un precio, que vaya en contra de la restricci�n:

update libros set preciomay = -20 where titulo = 'Uno';

-- Si intentamos agregar una restricci�n que no permita que el precio mayorista supere el precio minorista:

alter table libros
add constraint CK_LIBROS_PRECIOMINMAY2
check (preciomay <= preciomin);

-- corregimos el error en los registros, lo cual evitan insertar la restriccion

update libros set preciomay = 30 where titulo = 'Java en 10 minutos';

-- Veamos las restricciones de la tabla:

select * from user_constraints where table_name='LIBROS';

-- Note que en el caso de las restricciones de control, en las cuales muestra "C" en el tipo de constraint, 
-- la columna "SEARCH_CONDITION" muestra la regla que debe cumplirse; en caso de ser una 
-- restricci�n "primary key" o unique", esa columna queda vac�a.

-- Consultamos "user_cons_columns":

select * from user_cons_columns where table_name = 'LIBROS';


-- Analizamos la informaci�n: la tabla tiene 4 restricciones, 1 "primary key", 1 "unique" y 2 "check". La restricci�n 
-- "primarykey" ocupa una sola fila porque fue definida para 1 solo campo, por ello, en la columna 
-- "POSITION" aparece "1". La restricci�n �nica ocupa tres filas porque fue definida con 3 campos cuyo orden est� 
-- indicado en la columna "POSITION". La columna "POSITION" muestra informaci�n si la restricci�n es 
-- "primary key" o "unique" indicando el orden de los campos. La restricci�n de control "CK_libros_precios_positivo" 
-- ocupa 2 filas porque en su definici�n se nombran 2 campos (indicados en "COLUMN_NAME"). 
-- La restricci�n de control "CK_libros_preciominmax" ocupa 2 filas porque en su definici�n se nombran 2 campos 
-- (indicados en "COLUMN_NAME").


