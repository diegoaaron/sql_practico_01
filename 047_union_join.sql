/*
Hasta el momento hemos trabajado con una sola tabla, pero generalmente, se trabaja con m�s de una.

Para evitar la repetici�n de datos y ocupar menos espacio, se separa la informaci�n en varias tablas. 
Cada tabla almacena parte de la informaci�n que necesitamos registrar.

Por ejemplo, los datos de nuestra tabla "libros" podr�an separarse en 2 tablas, una llamada "libros" y otra "editoriales" 
que guardar� la informaci�n de las editoriales. En nuestra tabla "libros" haremos referencia a la editorial colocando un 
c�digo que la identifique. Veamos:

*/

drop table libros;

create table libros(
  codigo number(4),
  titulo varchar2(40) not null,
  autor varchar2(30),
  codigoeditorial number(3) not null,
  precio number(5,2),
  primary key (codigo)
);

drop table editoriales;

create table editoriales(
  codigo number(3),
  nombre varchar2(20) not null,
  direccion varchar2(40),
  primary key(codigo)
);

/*
De esta manera, evitamos almacenar tantas veces los nombres de las editoriales y su direcci�n en la tabla "libros" y 
guardamos el nombre y direcci�n en la tabla "editoriales"; para indicar la editorial de cada libro agregamos un 
campo que hace referencia al c�digo de la editorial en la tabla "libros" y en "editoriales".

Al recuperar los datos de los libros con la siguiente instrucci�n:

select* from libros;
 
vemos que en el campo "editorial" aparece el c�digo, pero no sabemos el nombre de la editorial. Para obtener los 
datos de cada libro, incluyendo el nombre de la editorial y su direcci�n, necesitamos consultar ambas tablas, 
traer informaci�n de las dos.

Cuando obtenemos informaci�n de m�s de una tabla decimos que hacemos un "join" (combinaci�n).

Veamos un ejemplo:

select * from libros
join editoriales
on libros.codigoeditorial=editoriales.codigo;

Resumiendo: si distribuimos la informaci�n en varias tablas evitamos la redundancia de datos y ocupamos 
menos espacio f�sico en el disco. Un join es una operaci�n que relaciona dos o m�s tablas para obtener un 
resultado que incluya datos (campos y registros) de ambas; las tablas participantes se combinan seg�n los 
campos comunes a ambas tablas.

Hay tres tipos de combinaciones. En los siguientes cap�tulos explicamos cada una de ellas.


*/



