/*
Vimos que hay tres estructuras repetitivas, o bucles, ya estudiamos "loop". Continuamos con "for".

En la sentencia "for... loop" se especifican dos enteros, un límite inferior y un límite superior, es decir, un rango de enteros, 
las sentencias se ejecutan una vez por cada entero; en cada repetición del bucle, la variable contador del "for" se incrementa 
en uno.

Sintaxis:

 for VARIABLECONTADOR in LIMITEINFERIOR..LIMITESUPERIOR loop
  SENTENCIAS;
end loop;

"Variablecontador" debe ser una variable numérica entera; "limiteinferior" y "limitesuperior" son expresiones numéricas. 
La variable que se emplea como contador NO se define, se define automáticamente de tipo entero al iniciar el bucle y se 
liberará al finalizarlo.

En el siguiente ejemplo se muestra la tabla del 3. La variable "f" comienza en cero (límite inferior del for) y se va incrementando 
de a uno; el ciclo se repite hasta que "f" llega a 5 (límite superior del for), cuando llega a 6, el bucle finaliza.

 set serveroutput on;
 begin
  for f in 0..5 loop
   dbms_output.put_line('3x'||to_char(f)||'='||to_char(f*3));
  end loop;
 end;
 /
 
Si queremos que el contador se decremente en cada repetición, en lugar de incrementarse, debemos colocar "reverse" 
luego de "in" y antes del límite inferior; el contador comenzará por el valor del límite superior y finalizará al llegar al límite 
inferior decrementando de a uno. En este ejemplo mostramos la tabla del 3 desde el 5 hasta el cero:

 begin
  for f in reverse 0..5 loop
   dbms_output.put_line('3*'||to_char(f)||'='||to_char(f*3));
  end loop;
 end;
 /
 
Se pueden colocar "for" dentro de otro "for". Por ejemplo, con las siguientes líneas imprimimos las tablas del 2 y del 3 del 1 al 9:

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

-- En el siguiente ejemplo se muestra la tabla del 3. La variable "f" comienza en cero (límite inferior del for) y se va 
-- incrementando de a uno; el ciclo se repite hasta que "f" llega a 5 (límite superior del for), cuando llega a 6, el bucle finaliza.

set serveroutput on;
execute dbms_output.enable(20000);
begin
for f in 0..5 loop
dbms_output.put_line('3x' || to_char(f) || '=' || to_char(f*3));
end loop;
end;
/

-- Para que el contador "f" se decremente en cada repetición, colocamos "reverse"; el contador comenzará por el valor del 
-- límite superior (5) y finalizará al llegar al límite inferior (0) decrementando de a uno. En este ejemplo mostramos la tabla 
-- del 3 desde el 5 hasta el 0:

begin
for f in reverse 0..5 loop
dbms_output.put_line('3*' || to_char(f) || '=' || to_char(f*3));
end loop;
end;
/

-- Se pueden colocar "for" dentro de otro "for". Por ejemplo, con las siguientes líneas imprimimos las tablas del 2 y del 3 
-- del 1 al 9:

begin
for f in 2..3 loop
dbms_output.put_line('tabla del ' || to_char(f));
for g in 1..9 loop
dbms_output.put_line(to_char(f) || 'x' || to_char(g) || '=' || to_char(f*g));
end loop;
end loop;
end;
/

-- Ejercicio 1

-- Con la estructura repetitiva "for... loop" que vaya del 1 al 20, muestre los números pares.
-- Dentro del ciclo debe haber una estructura condicional que controle que el número sea par y si lo es, lo 
-- imprima por pantalla.

set serveroutput on;
execute dbms_output.enable(20000);
begin
for numero in 1..20 loop
if mod(numero,2) = 0 then
dbms_output.put_line(numero);
end if;
end loop;
end;
/

-- Con la estructura repetitiva "for... loop" muestre la sumatoria del número 5; la suma de todos los números del 1 al 5. 
-- Al finalizar el ciclo debe mostrarse por pantalla la sumatoria de 5 (15)

declare 
sumatoria number := 0;
begin
 for numero in 1..5 loop
 sumatoria := sumatoria + numero;
 end loop;
 dbms_output.put_line(sumatoria);
 end;
 /
 
-- Cree una función que reciba un valor entero y retorne el factorial de tal número; el factorial se obtiene multiplicando el 
-- valor que recibe por el anterior hasta llegar a multiplicarlo por uno

create or replace function f_factorial(avalor number)
return number is
valorretornado number := 1;
begin
for f in reverse 1..avalor loop
valorretornado := valorretornado*f;
end loop;
return valorretornado;
end;
/

-- Llame a la función creada anteriormente y obtenga el factorial de 5 y de 4 (120 y 24)

select f_factorial(5) from dual;

select f_factorial(4) from dual;

-- Cree un procedimiento que reciba dos parámetros numéricos; el procedimiento debe mostrar la tabla de multiplicar del 
-- número enviado como primer argumento, desde el 1 hasta el númeo enviado como segundo argumento. Emplee "for"

create or replace procedure pa_tabla(anumero number, alimite number) as
begin 
dbms_output.put_line('Tabla del ' || to_char(anumero));
for f in 1..alimite loop
dbms_output.put_line(to_char(anumero) || 'x' || to_char(f) || '=' || to_char(f*anumero));
end loop;
end;
/

-- Ejecute el procedimiento creado anteriormente enviándole los valores necesarios para que muestre la tabla del 6 hasta el 20

execute pa_tabla(6,20);

-- Ejecute el procedimiento creado anteriormente enviándole los valores necesarios para que muestre la tabla del 9 hasta el 10

execute pa_tabla(9,10);
