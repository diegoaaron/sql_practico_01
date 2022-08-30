-- operador logico

-- Podemos establecer m�s de una condici�n con la cl�usula "where", para ello aprenderemos los operadores l�gicos.

/*
and, significa "y",
or, significa "y/o",
not, significa "no", invierte el resultado
(), par�ntesis
*/

-- mostrar libros con autor igual a "Borges" y precio menor a 20

select * from libros where (autor='Borges') and (precio<=20);

-- mostrar libros con autor igual a "Borges" o editorial sea "Planeta"

select * from libros where (autor='Borges') or (editorial = 'Planeta');

-- mostrar libros que no sean de la editorial Planeta

select * from libros where not editorial = 'Planeta';

-- Los par�ntesis se usan para encerrar condiciones, para que se eval�en como una sola expresi�n. Por ejemplo la siguientes
-- sentencias, devuelven valores diferentes.

select * from libros where (autor = 'Borges') or (editorial='Paidos' and precio < 20);

select * from libros where (autor='Borges' or editorial='Paidos') and (precio < 20);

-- El orden de prioridad de los operadores l�gicos es el siguiente: "not" se aplica antes que "and" y "and" antes que "or", 
-- si no se especifica un orden de evaluaci�n mediante el uso de par�ntesis. El orden en el que se eval�an los 
-- operadores con igual nivel de precedencia es indefinido, por ello se recomienda usar los par�ntesis.

