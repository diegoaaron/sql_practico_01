/*
Vimos que hay tres estructuras repetitivas, o bucles, ya estudiamos "loop". Continuamos con "for".

En la sentencia "for... loop" se especifican dos enteros, un l�mite inferior y un l�mite superior, es decir, un rango de enteros, 
las sentencias se ejecutan una vez por cada entero; en cada repetici�n del bucle, la variable contador del "for" se incrementa 
en uno.

Sintaxis:

 for VARIABLECONTADOR in LIMITEINFERIOR..LIMITESUPERIOR loop
  SENTENCIAS;
end loop;

"Variablecontador" debe ser una variable num�rica entera; "limiteinferior" y "limitesuperior" son expresiones num�ricas. 
La variable que se emplea como contador NO se define, se define autom�ticamente de tipo entero al iniciar el bucle y se 
liberar� al finalizarlo.

En el siguiente ejemplo se muestra la tabla del 3. La variable "f" comienza en cero (l�mite inferior del for) y se va incrementando 
de a uno; el ciclo se repite hasta que "f" llega a 5 (l�mite superior del for), cuando llega a 6, el bucle finaliza.

 set serveroutput on;
 begin
  for f in 0..5 loop
   dbms_output.put_line('3x'||to_char(f)||'='||to_char(f*3));
  end loop;
 end;
 /
 
Si queremos que el contador se decremente en cada repetici�n, en lugar de incrementarse, debemos colocar "reverse" 
luego de "in" y antes del l�mite inferior; el contador comenzar� por el valor del l�mite superior y finalizar� al llegar al l�mite 
inferior decrementando de a uno. En este ejemplo mostramos la tabla del 3 desde el 5 hasta el cero:

 begin
  for f in reverse 0..5 loop
   dbms_output.put_line('3*'||to_char(f)||'='||to_char(f*3));
  end loop;
 end;
 /
 
Se pueden colocar "for" dentro de otro "for". Por ejemplo, con las siguientes l�neas imprimimos las tablas del 2 y del 3 del 1 al 9:

begin
  for f in 2..3 loop
   dbms_output.put_line('tabla del '||to_char(f));
   for g in 1..9 loop
     dbms_output.put_line(to_char(f)||'x'||to_char(g)||'='||to_char(f*g));
   end loop;--fin del for g
  end loop;--fin del for f
end;
/

*/




