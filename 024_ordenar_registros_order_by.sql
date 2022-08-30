-- ordenando registros

-- Podemos ordenar el resultado de un "select" para que los registros se muestren ordenados por alg�n campo, 
-- para ello usamos la cl�usula "order by". Aparecen los registros ordenados alfab�ticamente por el campo especificado.

select * from libros order by titulo;

select * from libros order by 1;

-- Por defecto, si no aclaramos en la sentencia, los ordena de manera ascendente (de menor a mayor). 
-- Podemos ordenarlos de mayor a menor, para ello agregamos la palabra clave "desc":

select * from libros order by titulo desc;

-- Tambi�n podemos ordenar por varios campos (si el primer campo de orden tiene valores repetidos, se utiliza el segundo 
-- campo definido para ordenar)

select * from libros order by titulo asc, precio asc;

-- Debe aclararse al lado de cada campo, pues estas palabras claves afectan al campo inmediatamente anterior.

-- Es posible ordenar por un campo que no se lista en la selecci�n incluso por columnas calculados.

-- Se puede emplear "order by" con campos de tipo caracter, num�rico y date.


