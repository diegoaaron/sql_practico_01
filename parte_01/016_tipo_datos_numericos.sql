-- tipos de datos numeicos 

/*

number(t,d): para almacenar valores enteros o decimales, positivos o negativos. 
Su rango va de 1.0 x 10-130 hasta 9.999...(38 nueves).  El parámetro "t" indica el número total de dígitos (contando los decimales) 
que contendrá el número como máximo (es la precisión). Su rango va de 1 a 38. El parámetro "d" indica el máximo de dígitos 
decimales (escala). La escala puede ir de -84 a 127. Para definir número enteros, se puede omitir el parámetro "d" o colocar un 0.
Un campo definido "number(5,2)" puede contener cualquier número entre -999.99 y 999.99.
Si ingresamos un valor con más decimales que los definidos, el valor se carga pero con la cantidad de decimales permitidos, 
los dígitos sobrantes se omiten.

binary_float y binary_double: almacena números flotantes con mayor precisión:

Value	                                            BINARY_FLOAT                    BINARY_DOUBLE
Maximum positive finite value     3.40282E+38F                    1.79769313486231E+308
Minimum positive finite value      1.17549E-38F                     2.22507485850720E-308

Para ambos tipos numéricos:
- si ingresamos un valor con más decimales que los permitidos, redondea al más cercano.
- si intentamos ingresar un valor fuera de rango, no lo acepta.

Funcionamiento de Oracle al intentar ingresar numero como cadenas:
Si ingresamos una cadena, Oracle intenta convertirla a valor numérico, si dicha cadena consta solamente de dígitos, 
la conversión se realiza, luego verifica si está dentro del rango, si es así, la ingresa, sino, muestra un mensaje de error 
y no ejecuta la sentencia. Si la cadena contiene caracteres que Oracle no puede convertir a valor numérico, 
muestra un mensaje de error y la sentencia no se ejecuta.
Por ejemplo, definimos un campo de tipo "numberl(5,2)", si ingresamos la cadena '12,22', la convierte 
al valor numérico 12.22 y la ingresa; si intentamos ingresar la cadena '1234.56', la convierte al valor 
numérico 1234.56, pero como el máximo valor permitido es 999.99, muestra un mensaje indicando 
que está fuera de rango. Si intentamos ingresar el valor '12y.25', Oracle no puede realizar la conversión y muestra 
un mensaje de error.


*/

drop table libros;

create table libros(
    codigo number(5) not null,
    titulo varchar2(40) not null,
    autor varchar2(30),
    editorial varchar2(15),
    precio number(6,2),
    cantidad number(4)
);

commit;

describe libros;

insert into libros (codigo, titulo, autor, editorial, precio, cantidad) values(1, 'El alep', 'Borges', 'Emece', 25.60, 50000);

-- lo acepta pero solo la parte entera (trunco el valor)
insert into libros (codigo, titulo, autor, editorial, precio, cantidad) values(1, 'El alep', 'Borges', 'Emece', 25.60, 100.2); 

-- lo acepta pero solo la parte de 2 decimales y redondea el tercero
insert into libros (codigo, titulo, autor, editorial, precio, cantidad) values(3, 'El alep', 'Borges', 'Emece', 25.125, 100); 

insert into libros (codigo, titulo, autor, editorial, precio, cantidad) values(5,'Alicia en el pais...','Lewis Carroll', 'Planeta', '5000,30',20);

commit;

select * from libros;

-- Ejercicio 1 

drop table cuentas;

create table cuentas(
    numero number(4) not null,
    documento char(8) not null,
    nombre varchar2(30),
    saldo number(8,2),
    primary key(numero)
);

insert into cuentas(numero,documento,nombre,saldo) values('1234','25666777','Pedro Perez',500000.60);
insert into cuentas(numero,documento,nombre,saldo) values('2234','27888999','Juan Lopez',-250000);
insert into cuentas(numero,documento,nombre,saldo) values('3344','27888999','Juan Lopez',4000.50);
insert into cuentas(numero,documento,nombre,saldo) values('3346','32111222','Susana Molina',1000);

commit;

select * from cuentas where saldo > 4000;

select * from cuentas where nombre = 'Juan Lopez';

select * from cuentas where saldo < 0;

select * from cuentas where numero > 3000;

-- Ejercicio 2 

drop table empleados;

create table empleados(
    nombre varchar2(30),
    documento char(8),
    sexo char(1),
    domicilio varchar2(30),
    sueldobasico number(7,2),
    cantidadhijos number(2)
);

insert into empleados(nombre, documento, sexo, domicilio, sueldobasico, cantidadhijos)
 values('Juan Perez','22333444','m','Sarmiento 123',500,2);
insert into empleados (nombre,documento,sexo,domicilio,sueldobasico,cantidadhijos)
 values ('Ana Acosta','24555666','f','Colon 134',850,0);
insert into empleados (nombre,documento,sexo,domicilio,sueldobasico,cantidadhijos)
 values ('Bartolome Barrios','27888999','m','Urquiza 479',10000.80,4);

insert into empleados (nombre,documento,sexo,domicilio,sueldobasico,cantidadhijos)
 values ('Bartolome Barrios','27888999','m','Urquiza 479',800.886,4);

-- error, se superan los digitos del sueldo basico (el global) 
insert into empleados (nombre,documento,sexo,domicilio,sueldobasico,cantidadhijos)
 values ('Bartolome Barrios','27888999','m','Urquiza 479',890021.66,4);

select * from empleados where sueldobasico < 900;

select * from empleados where cantidadhijos = 2;