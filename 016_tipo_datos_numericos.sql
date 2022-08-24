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
Por ejemplo, definimos un campo de tipo "numberl(5,2)", si ingresamos la cadena '12.22', la convierte 
al valor numérico 12.22 y la ingresa; si intentamos ingresar la cadena '1234.56', la convierte al valor 
numérico 1234.56, pero como el máximo valor permitido es 999.99, muestra un mensaje indicando 
que está fuera de rango. Si intentamos ingresar el valor '12y.25', Oracle no puede realizar la conversión y muestra 
un mensaje de error.


*/