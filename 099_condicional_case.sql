/*
Vimos que hay dos estructuras condicionales, aprendimos "if", nos detendremos ahora en "case".

Aprendimos que el "if" se empleaba cuando ten�amos 2 cursos de acci�n, es decir, se eval�a una condici�n y se ejecutan diferentes bloques de 
sentencias seg�n el resultado de la condici�n sea verdadero o falso.

La estructura "case" es similar a "if", s�lo que se pueden establecer varias condiciones a cumplir. Con el "if" solamente podemos obtener dos salidas, 
cuando la condici�n resulta verdadera y cuando es falsa, si queremos m�s opciones podemos usar "case".

Sintaxis:

  case VALORACOMPARAR
    when VALOR1 then SENTENCIAS;
    when VALOR2 then SENTENCIAS;
    when VALOR3 then SENTENCIAS;
    else SENTENCIAS;
  end case;
  
Entonces, se emplea "case" cuando tenemos varios cursos de acci�n; es decir, por cada valor hay un "when... then"; si encuentra un valor coincidente 
en alg�n "when" ejecuta el "then" correspondiente a ese "when", si no hay ninguna coincidencia, se ejecuta el "else". Finalmente se coloca "end case" 
para indicar que el "case" ha finalizado.

Necesitamos, dada una fecha, obtener el nombre del mes en espa�ol. Podemos utilizar la estructura condicional "case". Para ello crearemos una 
funci�n que reciba una fecha y retorne una cadena de caracteres indicando el nombre del mes de la fecha enviada como argumento:

 create or replace function f_mes(afecha date)
   return varchar2
 is
  mes varchar2(20);
 begin
   mes:='enero';
   case extract(month from afecha)
     when 1 then mes:='enero';
     when 2 then mes:='febrero';
     when 3 then mes:='marzo';
     when 4 then mes:='abril';
     when 5 then mes:='mayo';
     when 6 then mes:='junio';
     when 7 then mes:='julio';
     when 8 then mes:='agosto';
     when 9 then mes:='setiembre';
     when 10 then mes:='octubre';
     when 11 then mes:='noviembre';
     else mes:='diciembre';
   end case;
   return mes;
 end;
 /
Si probamos la funci�n anterior envi�ndole la siguiente fecha:

 select f_mes('10/10/2008') from dual;
obtendremos como resultado "octubre".

La siguiente funci�n recibe una fecha y retorna si se encuentra en el 1�, 2�, 3� � 4� trimestre del a�o:

create or replace function f_trimestre(afecha date)
   return varchar2
 is
  mes varchar2(20);
  trimestre number;
 begin
   mes:=extract(month from afecha);
   trimestre:=4;
   case mes
     when 1 then trimestre:=1;
     when 2 then trimestre:=1;
     when 3 then trimestre:=1;
     when 4 then trimestre:=2;
     when 5 then trimestre:=2;
     when 6 then trimestre:=2;
     when 7 then trimestre:=3;
     when 8 then trimestre:=3;
     when 9 then trimestre:=3;
     else trimestre:=4;
   end case;
   return trimestre;
 end;
 /
 
La cl�usula "else" puede omitirse, en caso que no se encuentre coincidencia con ninguno de los "when", se sale del "case" sin modificar el valor de 
la variable "trimestre", con lo cual, retorna el valor 4, que es que que almacenaba antes de entrar a la estructura "case".

Otra diferencia con "if" es que el "case" toma valores puntuales, no expresiones. No es posible realizar comparaciones en cada "when". La siguiente 
sintaxis provocar�a un error:

  ...
  case mes
   when >=1 then trimestre:=1;
   when >=4 then trimestre:=2;
   when >=7 then trimestre:=3;
   when >=10 then trimestre:=4;
  end case;
  
Si hay m�s de una sentencia en un "when...then" NO es necesario delimitarlas con "begin... end".

Podemos emplear "case" dentro de un "select". Veamos un ejemplo similar a la funci�n anterior:

 select nombre,fechanacimiento,
  case extract(month from fechanacimiento)
   when 1 then 1
   when 2 then 1
   when 3 then 1
   when 4 then 2
   when 5 then 2
   when 6 then 2
   when 7 then 3
   when 8 then 3
   when 9 then 3
  else  4
  end as trimestre
  from empleados
  order by trimestre;
*/

 drop table empleados;

 create table empleados (
  documento char(8),
  nombre varchar(30),
  fechanacimiento date  
 );

 insert into empleados values('20111111','Acosta Ana','10/05/1968');
 insert into empleados values('22222222','Bustos Bernardo','09/07/1970');
 insert into empleados values('22333333','Caseros Carlos','15/10/1971');
 insert into empleados values('23444444','Fuentes Fabiana','25/01/1972');
 insert into empleados values('23555555','Gomez Gaston','28/03/1979');
 insert into empleados values('24666666','Juarez Julieta','18/02/1981');
 insert into empleados values('25777777','Lopez Luis','17/09/1978');
 insert into empleados values('26888888','Morales Marta','22/12/1975');

-- Nos interesa el nombre del mes en el cual cada empleado cumple a�os. Podemos utilizar la estructura condicional "case". Para ello crearemos una 
-- funci�n que reciba una fecha y retorne una cadena de caracteres indicando el nombre del mes de la fecha enviada como argumento:

create or replace function f_mes(afecha date) 
return varchar2 is
mes varchar2(20);
begin
mes:= 'enero';
case extract(month from afecha) 
    when 1 then mes:= 'enero';
    when 2 then mes:= 'febrero';
    when 3 then mes:= 'marzo';
     when 4 then mes:='abril';
     when 5 then mes:='mayo';
     when 6 then mes:='junio';
     when 7 then mes:='julio';
     when 8 then mes:='agosto';
     when 9 then mes:='setiembre';
     when 10 then mes:='octubre';
     when 11 then mes:='noviembre';
     else mes:= 'diciembre';
end case;
return mes;
end;
/

-- Recuperamos el nombre del empleado y el mes de su cumplea�os realizando un "select":

select nombre, f_mes(fechanacimiento) as cumple from empleados;

-- Podemos probar la funci�n creada anteriormente envi�ndole la siguiente fecha:

select f_mes('10/10/2022') from dual;

-- Realizamos una funci�n que reciba una fecha y retorne si se encuentra en el 1�, 2�, 3� � 4� trimestre del a�o:

create or replace function f_trimestre(afecha date)
return varchar2 is 
mes varchar2(20);
trimestre number;
begin
mes := extract(month from afecha);
trimestre := 4;
case mes
    when 1 then trimestre := 1;
    when 2 then trimestre := 1;
    when 3 then trimestre:= 1;
    when 4 then trimestre:= 2;
    when 5 then trimestre:= 2;
    when 6 then trimestre:= 2;
    when 7 then trimestre:= 3;
    when 8 then trimestre:= 3;
    when 9 then trimestre:= 3;
    else trimestre:= 4;
end case;
return trimestre;
end;
 /

-- Recuperamos el nombre del empleado y el trimestre de su cumplea�os empleando la funci�n creada anteriormente:

select nombre, f_trimestre(fechanacimiento) from empleados;

-- Vamos a emplear "case" dentro de un "select". Veamos un ejemplo similar a la funci�n anterior:

select nombre, fechanacimiento, 
case extract(month from fechanacimiento) 
    when 1 then 1
   when 2 then 1
   when 3 then 1
   when 4 then 2
   when 5 then 2
   when 6 then 2
   when 7 then 3
   when 8 then 3
   when 9 then 3
  else  4
end as trimestre 
from empleados order by trimestre;

-- Ejercicio 1 

 drop table empleados;

 create table empleados (
  documento char(8),
  nombre varchar(30),
  fechanacimiento date,
  hijos number(2),
  sueldo number(6,2),
  sexo char(1)  
 );

 insert into empleados values('20000000','Acosta Ana','10/05/1968',0,800,'f');
 insert into empleados values('21111111','Bustos Bernardo','09/07/1970',2,550,'m');
 insert into empleados values('22222222','Caseros Carlos','15/10/1971',3,500,'m');
 insert into empleados values('23333333','Fuentes Fabiana','25/08/1972',0,500,'f');
 insert into empleados values('24444444','Gomez Gaston','28/03/1979',1,850,'m');
 insert into empleados values('25555555','Juarez Javier','18/08/1981',2,600,'m');
 insert into empleados values('26666666','Lopez Luis','17/09/1978',4,690,'m');
 insert into empleados values('27777777','Morales Marta','22/08/1975',2,480,'f');
 insert into empleados values('28888888','Norberto Nores','11/08/1973',3,460,'m');
 insert into empleados values('29999999','Oscar Oviedo','19/07/1976',0,700,'m');

-- La empresa tiene por pol�tica festejar los cumplea�os de sus empleados cada mes, si es de sexo femenino se le regala un ramo de flores, sino, 
-- una lapicera. Realice un "select" mostrando el nombre del empleado, el d�a del cumplea�os y una columna extra que muestre "FLORES" o 
-- "LAPICERA" seg�n el sexo del empleado (case), de todos los empleados que cumplen a�os en el mes de agosto (where) y ordene por d�a.

create or replace function f_cumple(asexo char) 
return varchar2 is
sexo char(1);
regalo varchar2(50);
begin
sexo := asexo;
regalo := 'flores';
case sexo 
    when 'f' then regalo := 'flores';
    else regalo := 'lapicera';
end case;
return regalo;
end;
/

select nombre, sexo, f_cumple(sexo) from empleados 
where extract(month from fechanacimiento)='08';

 select nombre,extract (day from fechanacimiento) as dia,
  case sexo
   when 'f' then 'FLORES'
   else 'LAPICERA'
  end as regalo
 from empleados
 where extract(month from fechanacimiento)='08'
 order by 2;

-- 
