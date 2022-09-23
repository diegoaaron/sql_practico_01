/*
Hasta el momento hemos agregado restricciones a tablas existentes con "alter table"; también pueden 
establecerse al momento de crear una tabla (en la instrucción "create table").

En el siguiente ejemplo creamos la tabla "libros" con varias restricciones:

 create table libros(
  codigo number(5),
  titulo varchar2(40),
  codigoautor number(4),
  codigoeditorial number(3),
  precio number(5,2) default 0,
  constraint PK_libros_codigo
   primary key (codigo),
  constraint UQ_libros_tituloautor
    unique (titulo,codigoautor),
  constraint CK_libros_codigoeditorial
   check (codigoeditorial is not null),
  constraint FK_libros_editorial
   foreign key (codigoeditorial)
   references editoriales(codigo)
   on delete cascade,
  constraint FK_libros_autores
   foreign key (codigoautor)
   references autores(codigo)
   on delete set null,
  constraint CK_libros_preciononulo
   check (precio is not null) disable,
  constraint CK_precio_positivo
   check (precio>=0)
);
En el ejemplo definimos las siguientes restricciones:

- "primary key" sobre el campo "codigo";

- "unique" para los campos "titulo" y "codigoautor";

- de control sobre "codigoeditorial" que no permite valores nulos;

- "foreign key" para establecer el campo "codigoeditorial" como clave externa que haga referencia al campo "codigo" de 
"editoriales y permita eliminaciones en cascada;

- "foreign key" para establecer el campo "codigoautor" como clave externa que haga referencia al campo "codigo" de 
"autores" y permita eliminaciones "set null";

- de control sobre "precio" para que no admita valores nulos, deshabilitada;

- "check" para el campo "precio" que no admita valores negativos.

Las restricciones se agregan a la tabla, separadas por comas; colocando "constraint" seguido del nombre de la restricción, 
el tipo y los campos (si es una "primary key", "unique" o "foreign key") o la condición (si es de control); también puede 
especificarse el estado y la validación de datos (por defecto es "enable" y "validate"); y en el caso de las "foreign key", 
la opción para eliminaciones.

Si definimos una restricción "foreign key" al crear una tabla, la tabla referenciada debe existir y debe tener definida la clave 
primaria o única a la cual hace referencia la "foreign key".
*/



