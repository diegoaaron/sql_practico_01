-- funciones matemáticas 

-- abs(x): retorna el valor absoluto del argumento "x".

select abs(-20) from dual;

-- ceil(x): redondea a entero, hacia arriba, el argumento "x".

select ceil(12.34) from dual;

-- floor(x): redondea a entero, hacia abajo, el argumento "x".

select floor(12.34) from dual;

-- mod(x,y): devuelve el resto de la división x/y.

select mod(10,3) from dual;

select mod(10,2) from dual;

-- power(x,y): retorna el valor de "x" elevado a la "y" potencia.

select power(2,3) from dual;

-- round(n,d): retorna "n" redondeado a "d" decimales; si se omite el segundo argumento, redondea todos los decimales. 
-- Si el segundo argumento es positivo, el número de decimales es redondeado según "d"; si es negativo, el número es 
-- redondeado desde la parte entera según el valor de "d".

select round(123.456,2) from dual; 

select round(123.456,1) from dual;

select round(123.456, -1) from dual;

select round(123.456, -2) from dual;

select round(123.456) from dual;

-- sign(x): devuelve el signo del valor ingresado.  Si el argumento es un valor positivo, retorna 1, 
-- si es negativo, devuelve -1 y 0 si es 0.

select sign(-120) from dual;

select sign(120) from dual;

select sign(0) from dual;

-- trunc(n,d): trunca un número a la cantidad de decimales especificada por el segundo argumento. Si se omite el segundo 
-- argumento, se truncan todos los decimales. Si "d" es negativo, el número es truncado desde la parte entera.

select trunc(1234.5678, 2) from dual;

select trunc(1234.45678, -2) from dual;

select trunc(1234.5678, -1) from dual;

select trunc(1234.5678) from dual;

-- sqrt(x): devuelve la raiz cuadrada del valor enviado como argumento.

select sqrt(9) from dual;

-- oracle tambien dispone de funciones trigonométricas

-- Ejercicio 1

drop table empleados;

create table empleados(
    legajo number(5),
    documento char(8) not null,
    nombre varchar2(30) not null,
    domicilio varchar2(30),
    sueldo number(6,2),
    hijos number(2),
    primary key(legajo)
);

insert into empleados values(1,'22333444','Ana Acosta','Avellaneda 213',870.79,2); 
insert into empleados values(20,'27888999','Betina Bustos','Bulnes 345',950.85,1);
insert into empleados values(31,'30111222','Carlos Caseres','Caseros 985',1190,0);
insert into empleados values(39,'33444555','Daniel Duarte','Dominicana 345',1250.56,3);

-- mostrar sueldo redondeado hacia abajo y luego hacia arriba

select floor(sueldo) as "sueldo hacia abajo", ceil(sueldo) as "sueldo hacia arriba" from empleados;

-- mostrar nombres, sueldo, sueldo redoando a su valor entero y truncado a entero

select nombre, sueldo, round(sueldo) as "sueldo redondeado", trunc(sueldo) as "sueldo truncado" from empleados;

-- mostrar la potencia de 2 a la 5

select power(2,5) from dual;

-- mostramos el resto de la division "1234 / 5"

select mod(1234,5) from dual;

-- calculamos la raiz cuadrada de 81

select sqrt(81) from dual;


