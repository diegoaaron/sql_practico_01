-- operador logico

-- Podemos establecer más de una condición con la cláusula "where", para ello aprenderemos los operadores lógicos.

/*
and, significa "y",
or, significa "y/o",
not, significa "no", invierte el resultado
(), paréntesis
*/

-- mostrar libros con autor igual a "Borges" y precio menor a 20

select * from libros where (autor='Borges') and (precio<=20);

-- mostrar libros con autor igual a "Borges" o editorial sea "Planeta"

select * from libros where (autor='Borges') or (editorial = 'Planeta');

-- mostrar libros que no sean de la editorial Planeta

select * from libros where not editorial = 'Planeta';

-- Los paréntesis se usan para encerrar condiciones, para que se evalúen como una sola expresión. Por ejemplo la siguientes
-- sentencias, devuelven valores diferentes.

select * from libros where (autor = 'Borges') or (editorial='Paidos' and precio < 20);

select * from libros where (autor='Borges' or editorial='Paidos') and (precio < 20);

-- El orden de prioridad de los operadores lógicos es el siguiente: "not" se aplica antes que "and" y "and" antes que "or", 
-- si no se especifica un orden de evaluación mediante el uso de paréntesis. El orden en el que se evalúan los 
-- operadores con igual nivel de precedencia es indefinido, por ello se recomienda usar los paréntesis.

