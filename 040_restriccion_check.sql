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

-- Ejercicio 1

drop table empleados;

create table empleados (
  documento char(8),
  nombre varchar2(30),
  cantidadhijos number(2),
  seccion varchar2(20),
  sueldo number(6,2) default -1
);

-- Agregue una restricci�n "check" para asegurarse que no se ingresen valores negativos para el sueldo.
-- Note que el campo "sueldo" tiene establecido un valor por defecto (el valor -1) que va contra la restricci�n; 
-- Oracle no controla esto, permite establecer la restricci�n, pero al intentar ingresar un registro con el valor por 
-- defecto en tal campo, muestra un mensaje de error.

alter table empleados
add constraint CK_EMPLEADOS_SUELDO
check(sueldo > 0);

-- Intente ingresar un registro con la palabra clave "default" en el campo "sueldo" 

insert into empleados values('88822222','Alberto Lopez',1,'Sistemas',default);

-- Ingrese registros validos

insert into empleados values ('22222222','Alberto Lopez',1,'Sistemas',1000);
insert into empleados values ('33333333','Beatriz Garcia',2,'Administracion',3000);
insert into empleados values ('34444444','Carlos Caseres',0,'Contadur�a',6000);

-- Intente agregar otra restricci�n "check" al campo sueldo para asegurar que ninguno supere el valor 5000.
-- La sentencia no se ejecuta porque hay un sueldo que no cumple la restricci�n.

delete from empleados where documento = '34444444';

alter table empleados
add constraint CK_EMPLEADOS_SUELDO2
check(sueldo < 5000);

-- Establezca una restricci�n "check" para "seccion" que permita solamente los valores "Sistemas", "Administracion" y 
-- "Contadur�a".

alter table empleados
add constraint CK_EMPLEADOS_SECCION
check (seccion in ('Sistemas','Administracion','Contadur�a'));

-- Ingrese un registro con valor "null" en el campo "seccion".

insert into empleados values ('34554444','Carlos Caseres',0,null,2000);

-- Establezca una restricci�n "check" para "cantidadhijos" que permita solamente valores entre 0 y 15.

alter table empleados
add constraint CK_EMPLEADOS_HIJOS
check(cantidadhijos between 0 and 15);

-- Vea todas las restricciones de la tabla (4 filas)

select * from user_constraints where table_name='EMPLEADOS';

-- Intente agregar un registro que vaya contra alguna de las restricciones al campo "sueldo".
-- Mensaje de error porque se infringe la restricci�n "CK_empleados_sueldo_positivo".

insert into empleados values('34559944','Carlos Caseres',0,'Sistemas',-800);

-- Intente modificar un registro colocando en "cantidadhijos" el valor "21".

update empleados set cantidadhijos = 21 where documento = '33333333';

-- Intente modificar el valor de alg�n registro en el campo "seccion" cambi�ndolo por uno que no est� 
-- incluido en la lista de permitidos.

update empleados set seccion = 'Quimica' where documento = '33333333';

-- Intente agregar una restricci�n al campo secci�n para aceptar solamente valores que comiencen con la letra "B".
-- Note que NO se puede establecer esta restricci�n porque va en contra de la establecida anteriormente para 
-- el mismo campo, si lo permitiera, no podr�amos ingresar ning�n valor para "seccion".

alter table empleados
add constraint CK_EMPLEADOS_SECCION
check(seccion like '%B');

-- Agregue un registro con documento nulo.

insert into empleados values(null,'Beatriz Garcia',2,'Administracion',1500);

-- Intente agregar una restricci�n "primary key" para el campo "documento".
-- No lo permite porque existe un registro con valor nulo en tal campo.

alter table empleados
add constraint PK_EMPLEADOS_DOCUMENTO
primary key(documento);

-- Elimine el registro que infringe la restricci�n y establezca la restricci�n del punto 17.

delete from empleados where documento is null;

-- 

select * from empleados;


insert into empleados values ('33333333','Beatriz Garcia',2,'Administracion',3000);

alter table libros
add constraint CK_LIBROS_PRECIOMINMAY2
check (preciomay <= preciomin);





