/*
Hemos aprendido que existen varios tipos de combinaciones en Oracle:

1) combinaciones internas (inner join o simplemente join),
2) combinaciones externas (left join, right join y full join)
3) combinaciones cruzadas (cross join).

También vimos que es posible emplear varios tipos de combinaciones en una consulta, incluso puede combinarse una tabla 
consigo misma.

Existen otros tipos de "join" en Oracle, que veremos rápidamente, ya que se resuelven con los que vimos anteriormente, 
básicamente lo que cambia es la sintaxis.

1) combinación natural: realiza un join entre dos tablas cuando los campos por los cuales se enlazan tienen el mismo nombre. 
Involucra claves primarias y foráneas.

Sintaxis:

select CAMPOS 
from TABLA1
natural join TABLA2; 

Ejemplo:

select titulo,nombre as editorial
from libros
natural join
editoriales;

En el ejemplo anterior la tabla "libros" combina su campo "codigoeditorial" con el campo "codigoeditorial" de "editoriales". 
La cláusula "on" no aparece, este "join" no necesita condición de enlace porque Oracle busca los campos con nombres 
iguales de ambas tablas (ambas tablas deben tener un único campo con idéntico nombre, si tiene más de un campo con igual 
nombre, Oracle no podrá realizar el enlace y mostrará un mensaje de error).

2) combinación empleando la cláusula "using": permite especificar el campo (o los campos) por el cual se enlazarán las 
tablas; los campos de ambas tablas DEBEN tener el mismo nombre y ser de tipos compatibles.

Sintaxis:

select CAMPOS
from TABLA1
join TABLA2
using (CAMPOenCOMUN);

Ejemplo:

 select titulo,nombre as editorial
  from libros
  join editoriales
  using (codigoeditorial);

En el ejemplo anterior la tabla "libros" combina su campo "codigoeditorial" con el campo "codigoeditorial" de "editoriales". 
La cláusula "on" no aparece, es reemplazada por "using" seguido del nombre del campo en común por el cual se enlazan.

3) combinación izquierda empleando "join" y el operador o modificador "(+)": Podemos obtener el mismo resultado que 
un "left join" empleando "join" y el modificador "(+)", con lo cual se indica que se consideran los registros con valor nulo. 
La sintaxis es la siguiente:

select CAMPOS
from TABLA1
join TABLA2
on CAMPOTABLA1=CAMPOTABLA2(+);

Es decir, se coloca el modificador "(+)" luego del campo de la tabla de la derecha para indicar que se incluyan los que tienen
valor nulo.

Las siguientes consultas retornan el mismo resultado. Una de ellas emplea "left join" y la otra un "join" con el modificador "(+)":

select titulo,nombre as editorial
from libros l
left join editoriales l
on l.codigoeditorial = e.codigoeditorial;

select titulo,nombre as editorial
from libros l
join editoriales e
on l.codigoeditorial = e.codigoeditorial(+);

Ambas mostrarán el título y nombre de la editorial; los libros cuyo código de editorial no esté presente en "editoriales" 
aparecerán con el valor "null" en la columna "editorial".

4) combinación derecha empleando "join" y el modificador "(+)": de modo similar al anterior, podemos obtener el mismo 
resultado que un "right join" empleando "join" y el modificador "(+)", con lo cual se indica que se consideren los registros 
con valor nulo. La sintaxis es la siguiente:

select CAMPOS
from TABLA1
join TABLA2
on CAMPOTABLA1(+)=CAMPOTABLA2;

Entonces, se coloca el modificador "(+)" luego del campo de la tabla de la izquierda para indicar que se incluyan los que 
tienen valor nulo.

Las siguientes consultas retornan el mismo resultado. Una de ellas emplea "right join"· y la otra un "join" con el modificador "(+)":

select titulo,nombre as editorial
from editoriales e
right join libros l
on e.codigoeditorial = l.codigoeditorial;

select titulo,nombre as editorial
from editoriales e
join libros l
on e.codigoeditorial(+) = l.codigoeditorial;

Ambas mostrarán el título y nombre de la editorial; las editoriales que no encuentran coincidencia en "libros", aparecen 
con el valor "null" en la columna "titulo".

Si la condición de combinación es compuesta (más de un campo), DEBE colocarse el modificador "(+)" en todos los campos 
que forman parte del enlace.

No se puede colocar el modificador en campos de distintas tablas. La siguiente combinación producirá un mensaje de error:

select titulo,nombre as editorial
from libros l
join editoriales e
on l.codigoeditorial(+)= e.codigoeditorial(+);
*/







