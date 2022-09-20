/*
Hemos visto que una de las alternativas que Oracle ofrece para asegurar la integridad de datos es el uso de restricciones
(constraints). Aprendimos que las restricciones se establecen en tablas y campos asegurando que los datos sean válidos y 
que las relaciones entre las tablas se mantengan.

Vimos tres tipos de restricciones:

primary key, unique y check. Ahora veremos "foreign key".
Con la restricción "foreign key" se define un campo (o varios) cuyos valores coinciden con la clave primaria de la misma tabla 
o de otra, es decir, se define una referencia a un campo con una restricción "primary key" o "unique" de la misma tabla o de otra.

La integridad referencial asegura que se mantengan las referencias entre las claves primarias y las externas. Por ejemplo, 
controla que si se agrega un código de editorial en la tabla "libros", tal código exista en la tabla "editoriales".

También controla que no pueda eliminarse un registro de una tabla ni modificar la clave primaria si una clave externa hace 
referencia al registro. Por ejemplo, que no se pueda eliminar o modificar un código de "editoriales" si existen libros 
con dicho código.

La siguiente es la sintaxis parcial general para agregar una restricción "foreign key":

alter table NOMBRETABLA1
add constraint NOMBRERESTRICCION
foreign key (CAMPOCLAVEFORANEA)
references NOMBRETABLA2 (CAMPOCLAVEPRIMARIA);

Analicémosla:

- NOMBRETABLA1 referencia el nombre de la tabla a la cual le aplicamos la restricción,

- NOMBRERESTRICCION es el nombre que le damos a la misma,

- luego de "foreign key", entre paréntesis se coloca el campo de la tabla a la que le aplicamos la restricción que será 
establecida como clave foránea,

- luego de "references" indicamos el nombre de la tabla referenciada y el campo que es clave primaria en la misma, a la 
cual hace referencia la clave foránea. El campo de la tabla referenciada debe tener definida una restricción "primary key" 
o "unique"; si no la tiene, aparece un mensaje de error.

Para agregar una restricción "foreign key" al campo "codigoeditorial" de "libros", tipeamos:

alter table libros
add constraint FK_libros_codigoeditorial
foreign key (codigoeditorial)
references editoriales(codigo);

En el ejemplo implementamos una restricción "foreign key" para asegurarnos que el código de la editorial de la de la 
tabla "libros" ("codigoeditorial") esté asociada con un código válido en la tabla "editoriales" ("codigo").

Cuando agregamos cualquier restricción a una tabla que contiene información, Oracle controla los datos existentes para 
confirmar que cumplen con la restricción, si no los cumple, la restricción no se aplica y aparece un mensaje de error. Por 
ejemplo, si intentamos agregar una restricción "foreign key" a la tabla "libros" y existe un libro con un valor de código para 
editorial que no existe en la tabla "editoriales", la restricción no se agrega.

Actúa en inserciones. Si intentamos ingresar un registro (un libro) con un valor de clave foránea (codigoeditorial) que no 
existe en la tabla referenciada (editoriales), Oracle muestra un mensaje de error. Si al ingresar un registro (un libro), 
no colocamos el valor para el campo clave foránea (codigoeditorial), almacenará "null", porque esta restricción permite 
valores nulos (a menos que se haya especificado lo contrario al definir el campo).

Actúa en eliminaciones y actualizaciones. Si intentamos eliminar un registro o modificar un valor de clave primaria de unan 
tabla si una clave foránea hace referencia a dicho registro, Oracle no lo permite (excepto si se permite la acción en cascada, 
tema que veremos posteriormente). Por ejemplo, si intentamos eliminar una editorial a la que se hace referencia en "libros", 
aparece un mensaje de error.

Esta restricción (a diferencia de "primary key" y "unique") no crea índice automáticamente.

La cantidad y tipo de datos de los campos especificados luego de "foreign key" DEBEN coincidir con la cantidad y tipo de 
datos de los campos de la cláusula "references".

Esta restricción se puede definir dentro de la misma tabla (lo veremos más adelante) o entre distintas tablas.

Una tabla puede tener varias restricciones "foreign key".

No se puede eliminar una tabla referenciada en una restricción "foreign key", aparece un mensaje de error.

Una restriccion "foreign key" no puede modificarse, debe eliminarse (con "alter table" y "drop constraint") y volverse a crear.

Las restricciones "foreign key" se eliminan automáticamente al eliminar la tabla en la que fueron definidas.

Para ver información acerca de esta restricción podemos consultar los diccionarios "user_constraints" y "user_cons_columns".
*/