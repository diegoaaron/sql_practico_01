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

 drop table libros;
 drop table editoriales;
 drop table autores;
 
  create table editoriales(
  codigo number(3) not null,
  nombre varchar2(30),
  constraint PK_editoriales
   primary key (codigo)
);
 
create table autores(
codigo number(4) not null
constraint CK_autores_codigo
check (codigo>=0),
nombre varchar2(30) not null,
constraint PK_autores_codigo
primary key(codigo),
constraint UQ_autores_nombre
unique(nombre)
);
 
 create table libros(
 codigo number(5),
 titulo varchar2(40),
 codigoautor number(4),
 codigoeditorial number(3),
 precio number(5,2) default 0,
 constraint PK_libros_codigo
 primary key(codigo),
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
check(precio >= 0)
);
 
 -- Recuerde que si definimos una restricción "foreign key" al crear una tabla, la tabla referenciada debe existir, por ello 
 -- creamos las tablas "editoriales" y "autores" antes que "libros".

-- Veamos las restricciones de "editoriales":
-- Una tabla nos informa que hay una restricción de control y una "primary key", ambas habilitadas y validan los datos existentes.

 select constraint_name, constraint_type, search_condition, status, validated
  from user_constraints
  where table_name='EDITORIALES';
 
 -- Veamos las restricciones de "autores":
-- Oracle nos informa que hay 3 restricciones de control, una "primary key" y una única.

 select constraint_name, constraint_type, search_condition, status, validated
  from user_constraints
  where table_name='AUTORES';
 
--  Veamos las restricciones de "libros":
-- la tabla tiene 7 restricciones: 3 de control (2 "enabled" y "validated" y 1 "disabled" y "not validated"), 1 "primary key" 
-- ("enabled" "validated"), 1 "unique" ("enabled" "validated") y 2 "foreign key" ("enabled" "validated").

  select constraint_name, constraint_type, search_condition, status, validated
  from user_constraints
  where table_name='LIBROS';
 
 -- Ingresamos algunos registros en las tres tablas.
-- Recuerde que debemos ingresar registros en las tablas "autores" y "editoriales" antes que en "libros", a menos que 
-- deshabilitemos las restricciones "foreign key".

-- Note que un libro tiene precio nulo, la tabla "libros" tiene una restricción de control que no admite precios nulos, 
--pero está deshabilitada.

 insert into editoriales values(1,'Emece');
 insert into editoriales values(2,'Planeta');
 insert into editoriales values(3,'Norma');

 insert into autores values(100,'Borges');
 insert into autores values(101,'Bach Richard');
 insert into autores values(102,'Cervantes');
 insert into autores values(103,'Gaskin');

 insert into libros values(200,'El aleph',100,1,40);
 insert into libros values(300,'Uno',101,2,20);
 insert into libros values(400,'El quijote',102,3,20);
 insert into libros values(500,'El experto en laberintos',103,3,null);

 -- Realizamos un "join" para mostrar todos los datos de los libros:

select l.codigo, a.nombre as autor, e.nombre as editorial, precio
from libros l
join autores a
on codigoautor = a.codigo
join editoriales e
on codigoeditorial = e.codigo;

-- Habilitamos la restricción de control deshabilitada sin controlar los datos ya cargados:

alter table libros
enable novalidate
constraint CK_libros_preciononulo;

-- Intentamos ingresar un libro con precio nulo:
-- Oracle no lo permite, la restricción está habilitada.

 insert into libros values(600,'El anillo del hechicero',103,3,null);

-- Eliminamos un autor:

delete autores where codigo = 100;

-- Veamos si se setearon a "null" los libros de tal autor (la restricción "FK_LIBROS_AUTORES" así lo especifica):
-- El libro con código 200 tiene el valor "null" en "autor".

select * from libros;

-- Eliminamos una editorial:

delete editoriales where codigo = 1;

-- Veamos si se eliminaron los libros de tal editorial (la restricción "FK_LIBROS_EDITORIALES" fue establecida "cascade"):
-- Ya no está el libro "200".

select * from libros;



