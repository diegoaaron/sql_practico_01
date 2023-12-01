/*
"alter table" permite modificar la estructura de una tabla. Podemos utilizarla para agregar, modificar y eliminar campos de una tabla.

Para agregar un nuevo campo a una tabla empleamos la siguiente sintaxis básica:

 alter table NOMBRETABLA
  add NOMBRENUEVOCAMPO DEFINICION;
  
En el siguiente ejemplo agregamos el campo "cantidad" a la tabla "libros", de tipo number(4), con el valor por defecto 
cero y que NO acepta valores nulos:

 alter table libros
  add cantidad number(4) default 0 not null;
Puede verificarse la alteración de la estructura de la tabla tipeando:

 describe libros;
 
Para agregar un campo "not null", la tabla debe estar vacía o debe especificarse un valor por defecto. Esto es sencillo de 
entender, ya que si la tabla tiene registros, el nuevo campo se llenaría con valores nulos; si no los admite, debe tener un valor 
por defecto para llenar tal campo en los registros existentes.
*/

 drop table libros;
 
  create table libros(
  titulo varchar2(30),
  editorial varchar2(20)
 );

 -- Agregamos el campo "cantidad" a la tabla "libros", de tipo number(4), con el valor por defecto cero y que NO acepta 
 -- valores nulos:

alter table libros
add cantidad number(4) default 0 not null;
 
 -- verificamos la estructura de la tabla
 
 describe libros;
 
 -- Agregamos un nuevo campo "precio" a la tabla "libros", de tipo number(4) que acepta valores nulos:

alter table libros
add precio number(4);
 
-- verificamos la estructura de la tabla

describe libros;

-- Ingresamos registros

insert into libros values('El aleph','Emece',100,25.5);
 insert into libros values('Uno','Planeta',150,null);

-- Intentamos agregar un nuevo campo "autor" de tipo varchar2(30) que no admita valores nulos:

alter table libros
add autor varchar2(30) not null;

-- Mensaje de error. Si el campo no aceptará valores nulos y no tiene definido un valor por defecto, no se pueden llenar los 
-- registros existentes con ningún valor. Por ello, debemos definirlo con un valor por defecto:

alter table libros
add autor varchar2(30) default 'Desconocido' not null;

-- validemos los registros actuales respecto al campo 'autor'

select * from libros;

-- Ejercicio 1

 drop table empleados;

 create table empleados(
  apellido varchar2(20),
  nombre varchar2(20) not null,
  domicilio varchar2(30)
 );
 
 -- Agregue un campo "fechaingreso" de tipo date que acepte valores nulos

alter table empleados
add fechaingreso date not null;

-- Verifique que la estructura de la tabla ha cambiado

describe empleados;

-- Agregue un campo "seccion" de tipo caracter que no permita valores nulos y verifique que el nuevo campo existe

alter table empleados
add seccion varchar2(30) not null;

describe empleados;

-- Ingrese algunos registros:

 insert into empleados values('Lopez','Juan','Colon 123','10/10/1980','Contaduria');
 insert into empleados values('Gonzalez','Juana','Avellaneda 222','01/05/1990','Sistemas');
 insert into empleados values('Perez','Luis','Caseros 987','12/09/2000','Secretaria');

-- Intente agregar un campo "sueldo" que no admita valores nulos.
-- Agregue el campo "sueldo" no nulo y con el valor 0 por defecto.

alter table empleados
add sueldo number(4) default 0 not null;

-- Verifique que la estructura de la tabla ha cambiado.

describe empleados;

