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

-- En el siguiente ejemplo se muestra la tabla del 4. Se almacena en una variable "resultado" el resultado de la multiplicación, se chequea la condición, se imprime el resultado y se va 
-- incrementando la variable "multiplicador"; el ciclo se repite hasta que la variable "resultado" llega o supera el valor 50:

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

-- Note que, cuando "resultado" cumple la condición del "exit when" (supera el valor 50), no se ejecutan las líneas de salida y de incremento de "multiplicador", se salta a "end loop" 
-- finalizando el bucle.

-- Ejercicio 1

 drop table empleados;
 
 create table empleados(
  nombre varchar2(40),
  sueldo number(6,2)
 );

 insert into empleados values('Acosta Ana',550); 
 insert into empleados values('Bustos Bernardo',850); 
 insert into empleados values('Caseros Carolina',900); 
 insert into empleados values('Dominguez Daniel',490); 
 insert into empleados values('Fuentes Fabiola',820); 
 insert into empleados values('Gomez Gaston',740); 
 insert into empleados values('Huerta Hernan',1050); 
 
 -- Muestre la suma total de todos los sueldos realizando un "select" (5400)

select sum(sueldo) from empleados;

-- Se necesita incrementar los sueldos en forma proporcional, en un 10% cada vez y controlar que la suma total de sueldos no sea menor a $7000, si lo es, el bucle debe continuar y 
-- volver a incrementar los sueldos, en caso de superarlo, se saldrá del ciclo repetitivo; es decir, este bucle continuará el incremento de sueldos hasta que la suma de los mismos llegue o 
-- supere los 7000.

declare
total number;
begin
loop
    update empleados set sueldo = sueldo + (sueldo*0.1);
    select sum(sueldo) into total from empleados;
    dbms_output.put_line('sueldo total: ' || total);
    exit when total > 7000;
end loop;
end;
/

-- Verifique que los sueldos han sido incrementados y la suma de todos los sueldos es superior a 7000

select sum(sueldo) from empleados;

-- Muestre el sueldo máximo realizando un "select"

select max(sueldo) from empleados;

-- Se necesita incrementar los sueldos en forma proporcional, en un 5% cada vez y controlar que el sueldo máximo alcance o supere los $1600, al llegar o superarlo, el bucle debe finalizar. 
-- Incluya una variable contador que cuente cuántas veces se repite el bucle

declare
maximo number;
contador number;
begin
contador := 0;
loop
    contador := contador + 1;
    update empleados set sueldo = sueldo + (sueldo*0.05);
    select max(sueldo) into maximo from empleados;
    dbms_output.put_line('sueldo total: ' || maximo || 'contador: ' || contador);
    exit when maximo > 1600;
end loop;
end;
/

-- Verifique que los sueldos han sido incrementados y el sueldo máximo es igual o superior a 1600

select * from empleados;

-- Muestre el sueldo mínimo realizando un "select"

select max(sueldo) from empleados;

-- Se necesita incrementar los sueldos en forma proporcional, en un 10% cada vez y controlar que el sueldo mínimo no supere los $900. Emplee la sintaxis "if CONDICION then exit"

 declare
  minimo number;
 begin
  loop
    select min(sueldo) into minimo from empleados;
    if (minimo+minimo*0.1>900) then exit;
    else
      update empleados set sueldo=sueldo+(sueldo*0.1);
    end if;
  end loop;
 end;
 /

-- Muestre el sueldo mínimo realizando un "select"
 
  select min(sueldo) from empleados;
 
 
 