/*
Podemos agregar un campo a una tabla y en el mismo momento aplicarle una restricción.
Para agregar un campo y establecer una restricción, la sintaxis básica es la siguiente:

 alter table TABLA
  add CAMPO DEFINICION
  constraint NOMBRERESTRICCION TIPO;
Agregamos a la tabla "libros", el campo "titulo" de tipo varchar2(30) y una restricción "unique":

 alter table libros
  add titulo varchar2(30) 
  constraint UQ_libros_autor unique;
Agregamos a la tabla "libros", el campo "codigo" de tipo number(4) not null y una restricción "primary key":

 alter table libros
  add codigo number(4) not null
  constraint PK_libros_codigo primary key;
Agregamos a la tabla "libros", el campo "precio" de tipo number(6,2) y una restricción "check":

 alter table libros
  add precio number(6,2)
  constraint CK_libros_precio check (precio>=0);
*/