/*
Ya estudiamos dos de las tres estructuras repetitivas. Continuamos con "while".

Vimos que las sentencias repetitivas permiten ejecutar una secuencia de sentencias varias veces.

Se coloca la palabra "while" antes de las sentencias y al final "end loop".

"while...loop" (mientras) ejecuta repetidamente una instrucci�n (o bloque de instrucciones) siempre que la condici�n sea 
verdadera.

Sintaxis b�sica:

 while CONDICION loop
  SENTENCIAS
 end loop;
La diferencia entre "while...loop" y "for...loop" es que en la segunda se puede establecer la cantidad de repeticiones del 
bucle con el valor inicial y final. Adem�s, el segundo siempre se ejecuta, al menos una vez, en cambio el primero puede no 
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

La condici�n establece que se multiplique la variable "numero" por 3 mientras "numero" sea menor o igual a 5. En el bloque 
de sentencias se almacena en "resultado" la multiplicaci�n, luego se escribe tal valor y finalmente se incrementa la variable 
"numero" en 1.
*/

-- Mostramos la tabla del 3 hasta el 5. En primer lugar activamos el paquete "dbms_output" para poder emplear los 
-- procedimientos de dicho paquete, luego ejecutamos el procedimiento "dbms_output.enable" para habilitar las llamadas 
-- a los procedimientos y funciones de tal paquete, as� podremos emplear la funci�n de salida "dbms_output.put_line".

set serveroutput on;
execute dbms_output.enable (1000000);

-- Luego, declaramos la variable num�rica "numero" y le asignamos el valor cero; tal variable contendr� el multiplicando. 
-- Tambi�n declaramos la variable "resultado" de tipo num�rico que almacenar� el resultado de cada multiplicaci�n. 
-- Comenzamos el bloque "begin... end" con la estructura repetitiva "while... loop". La condici�n chequea si el valor de la 
-- variable "numero" es menmor o igual a 5; las sentencias que se repetir�n ser�n:

-- multiplicar "numero" por 3 y asign�rselo a "resultado",

-- imprimir "resultado" y

-- incrementar la variable "numero" para que la siguiente vez que se entre al bucle repetitivo se multiplique 3 por otro n�mero.

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

















