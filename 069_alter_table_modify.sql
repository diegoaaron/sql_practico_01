/*
"alter table" permite modificar la estructura de una tabla. Hemos aprendido a agregar campos, también podemos modificarlos.

Para modificar un campo empleamos la siguiente sintaxis:

 alter table NOMBRETABLA
  modify NOMBRECAMPO NUEVADEFINICION;
  
En el siguiente ejemplo modificamos el campo "precio" de la tabla "libros" para que tome valores de 6 dígitos incluyendo 
2 decimales y no acepte valores nulos:

 alter table libros
  modify precio number(6,2) not null;
  
Puede verificarse la alteración de la estructura de la tabla tipeando:

describe libros;

Podemos modificar de un campo: el tipo de dato, la escala y/o precisión, la longitud, la aceptación de valores nulos, el 
valor por defecto.

Se pueden modificar todos los atributos o algunos; los que no se especifican, no cambian.

Algunas consideraciones para tener en cuenta al modificar los campos de una tabla:

a) si se cambia el tipo de dato de un campo, la tabla debe estar vacía. Por ejemplo, de number a caracteres o viceversa.

b) no puede modificarse el tipo de dato de un campo "foreign key" o referenciado por una "foreign key", a menos que el 
cambio no afecte la restricción.

c) no se puede cambiar el tipo de dato de un campo que es "foreign key" o que es referenciado por una "foreign key".

d) para modificar un campo disminuyendo la longitud (precisión o escala) del tipo de dato, la tabla DEBE estar vacía, los 
registros DEBEN tener valores nulos en tal campo o los datos existentes deben ser inferiores o iguales a la nueva longitud. 
Para alterar la longitud (escala o precisión) aumentándola, no es necesario que la tabla esté vacía.

e) se puede modificar un campo definido "null" a "not null", siempre que la tabla esté vacía o no contenga valores nulos.

f) no puede redefinirse como "not null" un campo que es clave primaria.

g) si un campo tiene un valor por defecto y se modifica el tipo de dato de tal campo, Oracle analiza que el valor por defecto 
pueda convertirse al nuevo tipo de dato cuando sea necesario insertarlo; si el valor por defecto no se puede convertir al 
nuevo tipo de dato que se intenta modificar, la modificación del campo no se realiza. Por ejemplo, si un campo definido 
char(8) tiene un valor por defecto '00000000' y se modifica tal campo a tipo number(8), Oracle permite el cambio ya que 
al insertar el valor por defecto, lo convierte a número (0) automáticamente; si el valor por defecto no se puede convertir 
(por ejemplo 'a000000') a valor numérico, la modificación del campo no se realiza.

*/

 drop table libros;
 drop table editoriales;

 create table editoriales(
  codigo number(3),
  nombre varchar2(30),
  primary key(codigo)
 );

 create table libros(
  titulo varchar2(40),
  editorial number(3),
  autor varchar2(30),
  precio number(4),
  constraint FK_libros_editorial
   foreign key(editorial)
   references editoriales(codigo)
 );

-- Modificamos el campo precio para que tome valores de 6 dígitos incluyendo 2 decimales y acepte valores nulos:

alter table libros
modify precio number(6,2);

-- Verificamos el cambio viendo la estructura de la tabla:

describe libros;

-- Ingresamos algunos registros:

insert into editoriales values(1, 'Emece');
 insert into libros values('Uno',1,'Richard Bach',24.6);

-- Intentamos modificar el campo "precio" a "varchar(8)":
-- No lo permite, porque existe un registro con un valor numérico en tal campo.

alter table libros modify precio varchar(8);

-- Actualizamos el registro de "libros" con precio no nulo a nulo:

update libros set precio = null;

-- Ahora si podemos cambiar el tipo de dato de "precio", los registros existentes contienen "null" en tal campo:

alter table libros
modify precio varchar2(8);

-- Verificamos el cambio:

describe libros;

-- Intentamos modificar el campo "codigo" de "editoriales" a "char(3)":
-- No lo permite porque tal campo es referenciado por una clave externa.

alter table editoriales
modify codigo char(3);

-- Modificamos un atributo del campo "codigo" de "editoriales":
-- Oracle permite el cambio pues no afecta a la restricción.

alter table editoriales
modify codigo number(4);

-- Intentamos redefinir "precio" para que no acepte valores nulos:
-- No lo permite porque existe un registro con valor nulo en "precio".

alter table libros
modify precio not null;

-- Eliminamos el registro y modificamos el campo "precio" a "no nulo":

delete from libros;

alter table libros
modify precio not null;

-- Intentamos redefinir como no nulo el campo "codigo" de "editoriales":

alter table editoriales
modify codigo not null;

-- No aparece mensaje de error, pero si verificamos la estructura de la tabla veremos que continua siendo "not null", ya que 
-- es clave primaria:

describe editoriales;

-- Redefinimos el campo "precio" como number(6,2), con un valor por defecto 0:

alter table libros
modify precio number(6,2) default 0;

-- Oracle permite modificar el campo "precio" a "char(8)". Si luego ingresamos un registro sin valor para "precio", guardará 
-- el valor por defecto (0) convertido a cadena ('0'):

alter table libros
modify precio char(8) default 0;

 insert into libros values('El aleph',1,'Borges',default);

 select *from libros;

-- Redefinimos el valor por defecto del campo "precio" (que ahora es de tipo char) a "cero":

alter table libros
modify precio default 'cero';

-- Oracle no permite modificar el campo "precio" a "number(8,2)" porque si luego ingresamos un registro sin valor para tal 
-- campo, el valor por defecto ('cero') no podrá convertirse a número:

alter table libros
modify precio number(8,2);

-- Modificamos el valor por defecto para que luego pueda ser  convertido

alter table libros
modify precio default '0';

-- vaciamos la tabla

truncate table libros;

-- Oracle permite modificar el campo "precio" a "number(8,2)" porque si luego ingresamos un registro sin valor para tal 
-- campo, el valor por defecto ('0') podrá convertirse a número (0):

alter table libros
modify precio number(8,2);

-- Oracle permite modificar el campo "precio" a "char(8)". Si luego ingresamos un registro sin valor para "precio", guardará 
-- el valor por defecto (0) convertido a cadena ('0'):

alter table libros
modify precio char(8) default 0;

insert into libros values('El aleph', 1, 'Borges', default);

select * from libros;

-- Ejercicio 1




