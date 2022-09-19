/*
Hemos aprendido que existen varios tipos de combinaciones en Oracle:

1) combinaciones internas (inner join o simplemente join),
2) combinaciones externas (left join, right join y full join)
3) combinaciones cruzadas (cross join).

Tambi�n vimos que es posible emplear varios tipos de combinaciones en una consulta, incluso puede combinarse una tabla 
consigo misma.

Existen otros tipos de "join" en Oracle, que veremos r�pidamente, ya que se resuelven con los que vimos anteriormente, 
b�sicamente lo que cambia es la sintaxis.

1) combinaci�n natural: realiza un join entre dos tablas cuando los campos por los cuales se enlazan tienen el mismo nombre. 
Involucra claves primarias y for�neas.

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
La cl�usula "on" no aparece, este "join" no necesita condici�n de enlace porque Oracle busca los campos con nombres 
iguales de ambas tablas (ambas tablas deben tener un �nico campo con id�ntico nombre, si tiene m�s de un campo con igual 
nombre, Oracle no podr� realizar el enlace y mostrar� un mensaje de error).

2) combinaci�n empleando la cl�usula "using": permite especificar el campo (o los campos) por el cual se enlazar�n las 
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
La cl�usula "on" no aparece, es reemplazada por "using" seguido del nombre del campo en com�n por el cual se enlazan.

3) combinaci�n izquierda empleando "join" y el operador o modificador "(+)": Podemos obtener el mismo resultado que 
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

Ambas mostrar�n el t�tulo y nombre de la editorial; los libros cuyo c�digo de editorial no est� presente en "editoriales" 
aparecer�n con el valor "null" en la columna "editorial".

4) combinaci�n derecha empleando "join" y el modificador "(+)": de modo similar al anterior, podemos obtener el mismo 
resultado que un "right join" empleando "join" y el modificador "(+)", con lo cual se indica que se consideren los registros 
con valor nulo. La sintaxis es la siguiente:

select CAMPOS
from TABLA1
join TABLA2
on CAMPOTABLA1(+)=CAMPOTABLA2;

Entonces, se coloca el modificador "(+)" luego del campo de la tabla de la izquierda para indicar que se incluyan los que 
tienen valor nulo.

Las siguientes consultas retornan el mismo resultado. Una de ellas emplea "right join"� y la otra un "join" con el modificador "(+)":

select titulo,nombre as editorial
from editoriales e
right join libros l
on e.codigoeditorial = l.codigoeditorial;

select titulo,nombre as editorial
from editoriales e
join libros l
on e.codigoeditorial(+) = l.codigoeditorial;

Ambas mostrar�n el t�tulo y nombre de la editorial; las editoriales que no encuentran coincidencia en "libros", aparecen 
con el valor "null" en la columna "titulo".

Si la condici�n de combinaci�n es compuesta (m�s de un campo), DEBE colocarse el modificador "(+)" en todos los campos 
que forman parte del enlace.

No se puede colocar el modificador en campos de distintas tablas. La siguiente combinaci�n producir� un mensaje de error:

select titulo,nombre as editorial
from libros l
join editoriales e
on l.codigoeditorial(+)= e.codigoeditorial(+);
*/







