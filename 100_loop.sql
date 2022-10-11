/*
Las estructuras repetitivas permiten ejecutar una secuencia de sentencias varias veces. Hay tres estructuras repetitivas, o bucles: loop, for y while.

Comenzamos por "loop", que es la más simple. Veremos la sintaxis del bucle "loop" que combina una condición y la palabra "exit".

Sintaxis:

 loop
  SENTENCIAS;
  exit when CONDICION;
  SENTENCIAS;
 end loop;
Cuando se llega a la línea de código en la que se encuentra la condición "exit when", se evalúa dicha condición, si resulta cierta, se salta a la línea donde se encuentra "end loop", 
saliendo del bucle, omitiendo las sentencias existentes antes del "end loop"; en caso contrario, si la condición resulta falsa, se continúa con las siguientes sentencias y al 
llegar a "end loop" se repite el bucle.

La sintaxis anterior es equivalente a la siguiente:

 loop
  SENTENCIAS
  if CONDICION then
   exit;
  end if;
  SENTENCIAS
 end loop;

En este ejemplo se muestra la tabla del 3. Se va incrementando la variable "multiplicador" y se almacena en una variable "resultado"; el ciclo se repite hasta que el multiplicador llega a 
5, es decir, 6 veces.

set serveroutput on;
declare
  resultado number;
  multiplicador number:=0;
begin
  loop
    resultado:=3*multiplicador;
    dbms_output.put_line('3x'||to_char(multiplicador)||'='||to_char(resultado));
    multiplicador:=multiplicador+1;
    exit when multiplicador>5;
  end loop;
end;
/

En el siguiente ejemplo se muestra la tabla del 4. Se va incrementando la variable "multiplicador" y se almacena en una variable "resultado"; el ciclo se repite hasta que la variable resultado 
llega o supera el valor 50.

declare
  resultado number;
  multiplicador number:=0;
begin
  loop
    resultado:=4*multiplicador;
    exit when resultado>=50;
    dbms_output.put_line('4x'||to_char(multiplicador)||'='||to_char(resultado));
    multiplicador:=multiplicador+1;
  end loop;
end;
/

Cuando se cumple la condición del "exit when" (supera el valor 50), no se ejecutan las sentencias siguientes (líneas de salida y de incremento de "multiplicador"), se salta a "end loop" 
finalizando el bucle.
*/

-- Mostramos la tabla del 3.
-- En primer lugar activamos el paquete que contiene los procedimientos necesarios para la salida de datos por pantalla (set serveroutput on) y habilitamos las llamadas a tales procedimientos.
-- Declaramos dos variables, "resultado" almacenará el resultado de las multiplicaciones (le asignamos el valor cero) y "multiplicador" será la que contenga los diferentes valores por los 
-- cuales multiplicaremos 3 (asignándole el valor cero).

-- En el ciclo repetitivo se almacena en "resultado" el primer valor ("multiplicador" contiene 0 así que el resultado es cero), luego se imprime, se incrementa la variable "multiplicador" 
-- (ahora contiene 1) y se evalúa la condición, dado que "multiplicador" no es mayor a 5, el ciclo se repite.

-- Cuando la condición resulta cierta, es decir, cuando "multiplicador" sea igual a 6, el ciclo acabará:

set serveroutput on;
execute dbms_output.enable(1000000);
declare
resultado number;
multiplicador number := 0;
begin
loop 
    resultado := 3*multiplicador;
    dbms_output.put_line('3x'||to_char(multiplicador)||'='||to_char(resultado));
    multiplicador := multiplicador + 1;
    exit when multiplicador>12;
end loop;
end;

-- 

