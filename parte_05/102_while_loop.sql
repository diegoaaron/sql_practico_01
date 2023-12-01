/*
Ya estudiamos dos de las tres estructuras repetitivas. Continuamos con "while".

Vimos que las sentencias repetitivas permiten ejecutar una secuencia de sentencias varias veces.

Se coloca la palabra "while" antes de las sentencias y al final "end loop".

"while...loop" (mientras) ejecuta repetidamente una instrucción (o bloque de instrucciones) siempre que la condición sea 
verdadera.

Sintaxis básica:

 while CONDICION loop
  SENTENCIAS
 end loop;
La diferencia entre "while...loop" y "for...loop" es que en la segunda se puede establecer la cantidad de repeticiones del 
bucle con el valor inicial y final. Además, el segundo siempre se ejecuta, al menos una vez, en cambio el primero puede no 
ejecutarse nunca, caso en el cual al evaluar la condicion por primera vez resulte falsa.

En el siguiente ejemplo se muestra la tabla del 3 hasta el 5:

 set serveroutput on;
 execute dbms_output.enable (20000);
declare
 numero number:=0;
 resultado number;
begin
  while numero<=5 loop
   resultado:=3*numero;
   dbms_output.put_line('3*'||to_char(numero)||'='||to_char(resultado));
   numero:=numero+1;
  end loop;
end;
/

La condición establece que se multiplique la variable "numero" por 3 mientras "numero" sea menor o igual a 5. En el bloque 
de sentencias se almacena en "resultado" la multiplicación, luego se escribe tal valor y finalmente se incrementa la variable 
"numero" en 1.
*/

-- Mostramos la tabla del 3 hasta el 5. En primer lugar activamos el paquete "dbms_output" para poder emplear los 
-- procedimientos de dicho paquete, luego ejecutamos el procedimiento "dbms_output.enable" para habilitar las llamadas 
-- a los procedimientos y funciones de tal paquete, así podremos emplear la función de salida "dbms_output.put_line".

set serveroutput on;
execute dbms_output.enable (1000000);

-- Luego, declaramos la variable numérica "numero" y le asignamos el valor cero; tal variable contendrá el multiplicando. 
-- También declaramos la variable "resultado" de tipo numérico que almacenará el resultado de cada multiplicación. 
-- Comenzamos el bloque "begin... end" con la estructura repetitiva "while... loop". La condición chequea si el valor de la 
-- variable "numero" es menmor o igual a 5; las sentencias que se repetirán serán:

-- multiplicar "numero" por 3 y asignárselo a "resultado",

-- imprimir "resultado" y

-- incrementar la variable "numero" para que la siguiente vez que se entre al bucle repetitivo se multiplique 3 por otro número.

declare 
numero number := 0;
resultado number;
begin
while numero <= 5 loop
resultado := 3*numero;
dbms_output.put_line('3*' || to_char(numero) || '=' || to_char(resultado));
numero := numero + 1;
end loop;
end;
/

















