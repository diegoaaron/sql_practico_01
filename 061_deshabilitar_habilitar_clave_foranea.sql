/*
Aprendimos (cuando vimos los otros tipos de restricciones) que si agregamos una restricción a una tabla que contiene datos, 
Oracle los controla para asegurarse que cumplen con la restricción y que es posible deshabilitar esta comprobación. 
Lo hacemos incluyendo la opción "novalidate" en la instrucción "alter table"; en tal caso, La restricción no se aplica en los 
datos existentes, pero si intentamos ingresar un nuevo valor que no cumpla la restricción (o actualizarlo), Oracle no lo permite.

En el siguiente ejemplo agregamos una restricción "foreign key" sobre el campo "codigoeditorial" de "libros" especificando 
que no valide los datos existentes:

 alter table libros
  add constraint FK_libros_codigoeditorial
  foreign key (codigoeditorial)
  references editoriales novalidate;
  
  La restricción no se aplica en los datos existentes, pero si intentamos ingresar un nuevo registro en "libros" cuyo código de editorial no exista en "editoriales", Oracle no lo permitirá.

Para saber si una restricción está validada o no, podemos consultar el catálogo "user_constraints" y fijarnos lo que informa la columna "validated".

También aprendimos que podemos deshabilitar las restricciones para agregar o actualizar datos sin comprobarla. Para evitar la comprobación de datos en inserciones y actualizaciones agregamos "disable" en la instrucción "alter table".

En el ejemplo siguiente deshabilitamos la restricción "FK_libros_codigoeditorial" para poder ingresar un valor que infrija la restricción:

 alter table libros
  disable validate
  constraint FK_libros_codigoeditorial;
Para habilitar una restricción "foreign key" deshabilitada se ejecuta la misma instrucción pero con la cláusula "enable".

Por defecto (si no se especifica) las opciones son "validate" (es decir, controla los datos existentes) y "enable" 
(controla futuros ingresos y actualizaciones).

Para saber si una restricción está habilitada o no, podemos consultar el catálogo "user_constraints" y fijarnos lo que informa 
la columna "status".

Podemos habilitar una restricción "foreign key" con "enable" y "novalidate", en tal caso Oracle habilita la restricción para 
futuros ingresos y actualizaciones y NO valida los datos existentes.

Entonces, "enable" o "disable" activa o desactiva la restricción para los nuevos datos ("enable" es la opción predeterminada 
si no se especifica); "validate" o "novalidate" es la opción para validar la restricción en los datos existentes ("validate" es la 
predeterminada si se omite).

La sintaxis básica al agregar la restriccción "foreign key" es la siguiente:

 alter table NOMBRETABLA1
  add constraint NOMBRECONSTRAINT
  foreign key (CAMPOCLAVEFORANEA)
  references NOMBRETABLA2 (CAMPOCLAVEPRIMARIA)
  ESTADO VALIDACION;
La sintaxis para modificar una restricción es:

 alter table NOMBRETABLA
  ESTADO VALIDACION
  constraint NOMBRERESTRICCION;
*/

 drop table libros;
 drop table editoriales;

 create table libros(
  codigo number(5),
  titulo varchar2(40),
  codigoeditorial number(3),
  primary key (codigo)
 );
 create table editoriales(
  codigo number(3),
  nombre varchar2(20),
  primary key (codigo)
);

 insert into editoriales values(1,'Planeta');
 insert into editoriales values(2,'Emece');
 insert into editoriales values(3,'Paidos');

 insert into libros values(1,'Uno',1);
 insert into libros values(2,'El aleph',2);
 insert into libros values(3,'Aprenda PHP',5);











