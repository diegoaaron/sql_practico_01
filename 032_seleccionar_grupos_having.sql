-- As� como la cl�usula "where" permite seleccionar (o rechazar) registros individuales; la cl�usula "having" 
-- permite seleccionar (o rechazar) un grupo de registros.

-- Se utiliza "having", seguido de la condici�n de b�squeda, para seleccionar ciertas filas retornadas por la cl�usula "group by".

-- En algunos casos es posible confundir las cl�usulas "where" y "having". 
-- Queremos contar los registros agrupados por editorial sin tener en cuenta a la editorial "Planeta".

select editorial, count(*) from libros  where editorial<>'Planeta' group by editorial;

select editorial, count(*) from libros group by editorial having editorial<>'Planeta';

-- Ambas devuelven el mismo resultado, pero son diferentes. La primera, selecciona todos los registros rechazando los 
-- de editorial "Planeta" y luego los agrupa para contarlos. La segunda, selecciona todos los registros, los agrupa para 
-- contarlos y finalmente rechaza fila con la cuenta correspondiente a la editorial "Planeta".

-- Veamos la conbinacion de "where" y "having". Queremos la cantidad de libros, sin considerar los que tienen precio nulo, 
-- agrupados por editorial, sin considerar la editorial "Planeta":

select editorial, count(*) from libros where precio is not null group by editorial having editorial<>'Planeta';

-- Aqu�, selecciona los registros rechazando los que no cumplan con la condici�n dada en "where", luego los agrupa 
-- por "editorial" y finalmente rechaza los grupos que no cumplan con la condici�n dada en el "having".

-- En una cl�usula "having" puede haber varias condiciones. Cuando utilice varias condiciones, tiene que combinarlas 
-- con operadores l�gicos (and, or, not).

-- Podemos encontrar el mayor valor de los libros agrupados y ordenados por editorial y seleccionar las filas que tengan un 
-- valor menor a 100 y mayor a 30:

 select editorial, max(precio) as mayor from libros group by editorial having min(precio)<100 
 and min(precio)>30 order by editorial; 
 












