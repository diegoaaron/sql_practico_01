/*
Hemos visto que una de las alternativas que Oracle ofrece para asegurar la integridad de datos es el uso de restricciones
(constraints). Aprendimos que las restricciones se establecen en tablas y campos asegurando que los datos sean v�lidos y 
que las relaciones entre las tablas se mantengan.

Vimos tres tipos de restricciones:

primary key, unique y check. Ahora veremos "foreign key".
Con la restricci�n "foreign key" se define un campo (o varios) cuyos valores coinciden con la clave primaria de la misma tabla 
o de otra, es decir, se define una referencia a un campo con una restricci�n "primary key" o "unique" de la misma tabla o de otra.

La integridad referencial asegura que se mantengan las referencias entre las claves primarias y las externas. Por ejemplo, 
controla que si se agrega un c�digo de editorial en la tabla "libros", tal c�digo exista en la tabla "editoriales".

Tambi�n controla que no pueda eliminarse un registro de una tabla ni modificar la clave primaria si una clave externa hace 
referencia al registro. Por ejemplo, que no se pueda eliminar o modificar un c�digo de "editoriales" si existen libros 
con dicho c�digo.

La siguiente es la sintaxis parcial general para agregar una restricci�n "foreign key":

alter table NOMBRETABLA1
add constraint NOMBRERESTRICCION
foreign key (CAMPOCLAVEFORANEA)
references NOMBRETABLA2 (CAMPOCLAVEPRIMARIA);

Analic�mosla:

- NOMBRETABLA1 referencia el nombre de la tabla a la cual le aplicamos la restricci�n,

- NOMBRERESTRICCION es el nombre que le damos a la misma,

- luego de "foreign key", entre par�ntesis se coloca el campo de la tabla a la que le aplicamos la restricci�n que ser� 
establecida como clave for�nea,

- luego de "references" indicamos el nombre de la tabla referenciada y el campo que es clave primaria en la misma, a la 
cual hace referencia la clave for�nea. El campo de la tabla referenciada debe tener definida una restricci�n "primary key" 
o "unique"; si no la tiene, aparece un mensaje de error.

Para agregar una restricci�n "foreign key" al campo "codigoeditorial" de "libros", tipeamos:

alter table libros
add constraint FK_libros_codigoeditorial
foreign key (codigoeditorial)
references editoriales(codigo);

En el ejemplo implementamos una restricci�n "foreign key" para asegurarnos que el c�digo de la editorial de la de la 
tabla "libros" ("codigoeditorial") est� asociada con un c�digo v�lido en la tabla "editoriales" ("codigo").

Cuando agregamos cualquier restricci�n a una tabla que contiene informaci�n, Oracle controla los datos existentes para 
confirmar que cumplen con la restricci�n, si no los cumple, la restricci�n no se aplica y aparece un mensaje de error. Por 
ejemplo, si intentamos agregar una restricci�n "foreign key" a la tabla "libros" y existe un libro con un valor de c�digo para 
editorial que no existe en la tabla "editoriales", la restricci�n no se agrega.

Act�a en inserciones. Si intentamos ingresar un registro (un libro) con un valor de clave for�nea (codigoeditorial) que no 
existe en la tabla referenciada (editoriales), Oracle muestra un mensaje de error. Si al ingresar un registro (un libro), 
no colocamos el valor para el campo clave for�nea (codigoeditorial), almacenar� "null", porque esta restricci�n permite 
valores nulos (a menos que se haya especificado lo contrario al definir el campo).

Act�a en eliminaciones y actualizaciones. Si intentamos eliminar un registro o modificar un valor de clave primaria de unan 
tabla si una clave for�nea hace referencia a dicho registro, Oracle no lo permite (excepto si se permite la acci�n en cascada, 
tema que veremos posteriormente). Por ejemplo, si intentamos eliminar una editorial a la que se hace referencia en "libros", 
aparece un mensaje de error.

Esta restricci�n (a diferencia de "primary key" y "unique") no crea �ndice autom�ticamente.

La cantidad y tipo de datos de los campos especificados luego de "foreign key" DEBEN coincidir con la cantidad y tipo de 
datos de los campos de la cl�usula "references".

Esta restricci�n se puede definir dentro de la misma tabla (lo veremos m�s adelante) o entre distintas tablas.

Una tabla puede tener varias restricciones "foreign key".

No se puede eliminar una tabla referenciada en una restricci�n "foreign key", aparece un mensaje de error.

Una restriccion "foreign key" no puede modificarse, debe eliminarse (con "alter table" y "drop constraint") y volverse a crear.

Las restricciones "foreign key" se eliminan autom�ticamente al eliminar la tabla en la que fueron definidas.

Para ver informaci�n acerca de esta restricci�n podemos consultar los diccionarios "user_constraints" y "user_cons_columns".
*/