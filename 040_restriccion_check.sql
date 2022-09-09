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

