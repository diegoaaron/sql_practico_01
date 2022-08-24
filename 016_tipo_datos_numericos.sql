-- tipos de datos numeicos 

/*

number(t,d): para almacenar valores enteros o decimales, positivos o negativos. 
Su rango va de 1.0 x 10-130 hasta 9.999...(38 nueves).  El par�metro "t" indica el n�mero total de d�gitos (contando los decimales) 
que contendr� el n�mero como m�ximo (es la precisi�n). Su rango va de 1 a 38. El par�metro "d" indica el m�ximo de d�gitos 
decimales (escala). La escala puede ir de -84 a 127. Para definir n�mero enteros, se puede omitir el par�metro "d" o colocar un 0.
Un campo definido "number(5,2)" puede contener cualquier n�mero entre -999.99 y 999.99.
Si ingresamos un valor con m�s decimales que los definidos, el valor se carga pero con la cantidad de decimales permitidos, 
los d�gitos sobrantes se omiten.

binary_float y binary_double: almacena n�meros flotantes con mayor precisi�n:

Value	                                            BINARY_FLOAT                    BINARY_DOUBLE
Maximum positive finite value     3.40282E+38F                    1.79769313486231E+308
Minimum positive finite value      1.17549E-38F                     2.22507485850720E-308

Para ambos tipos num�ricos:
- si ingresamos un valor con m�s decimales que los permitidos, redondea al m�s cercano.
- si intentamos ingresar un valor fuera de rango, no lo acepta.

Funcionamiento de Oracle al intentar ingresar numero como cadenas:

Si ingresamos una cadena, Oracle intenta convertirla a valor num�rico, si dicha cadena consta solamente de d�gitos, 
la conversi�n se realiza, luego verifica si est� dentro del rango, si es as�, la ingresa, sino, muestra un mensaje de error 
y no ejecuta la sentencia. Si la cadena contiene caracteres que Oracle no puede convertir a valor num�rico, 
muestra un mensaje de error y la sentencia no se ejecuta.
Por ejemplo, definimos un campo de tipo "numberl(5,2)", si ingresamos la cadena '12.22', la convierte 
al valor num�rico 12.22 y la ingresa; si intentamos ingresar la cadena '1234.56', la convierte al valor 
num�rico 1234.56, pero como el m�ximo valor permitido es 999.99, muestra un mensaje indicando 
que est� fuera de rango. Si intentamos ingresar el valor '12y.25', Oracle no puede realizar la conversi�n y muestra 
un mensaje de error.


*/