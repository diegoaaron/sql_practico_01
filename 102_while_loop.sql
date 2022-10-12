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



