/*
En los triggers a nivel de fila, se puede incluir una restricci�n adicional, agregando la clausula "when" con una condici�n 
que se eval�a para cada fila que afecte el disparador; si resulta cierta, se ejecutan las sentencias del trigger para ese 
registro; si resulta falsa, el trigger no se dispara para ese registro.

Limitaciones de "when":

- no puede contener subconsultas, funciones agregadas ni funciones definidas por el usuario;

- s�lo se puede hacer referencia a los par�metros del evento;

- no se puede especificar en los trigers "instead of" ni en trigger a nivel de sentencia.

Creamos el siguiente disparador:

create or replace trigger tr_precio_libros
 before insert or update of precio
 on libros
 for each row when(new.precio>50)
 begin
  :new.precio := round(:new.precio);
 end tr_precio_libros;
 /
 
El disparador anterior se dispara ANTES (before) que se ejecute un "insert" sobre "libros" o un "update" sobre "precio" de 
"libros". Se ejecuta una vez por cada fila afectada (for each row) y solamente si cumple con la condici�n del "when", 
es decir, si el nuevo precio que se ingresa o modifica es superior a 50. Si el precio es menor o igual a 50, el trigger no 
se dispara. Si el precio es mayor a 50, se modifica el valor ingresado redonde�ndolo a entero.

Note que cuando hacemos referencia a "new" (igualmente con "old") en la condici�n "when", no se colocan los dos puntos
precedi�ndolo; pero en el cuerpo del trigger si.

Si ingresamos un registro con el valor 30.80 para "precio", el trigger no se dispara.

Si ingresamos un registro con el valor "55.6" para "precio", el trigger se dispara modificando tal valor a "56".

Si actualizamos el precio de un libro a "40.30", el trigger no se activa.

Si actualizamos el precio de un libro a "50.30", el trigger se activa y modifica el valor a "50".

Si actualizamos el precio de 2 registros a valores que superen los "50", el trigger se activa 2 veces redondeando los valores 
a entero.

Si actualizamos en una sola sentencia el precio de 2 registros y solamente uno de ellos supera los "50", el trigger se activa 
1 sola vez.

El trigger anterior podr�a haberse creado de la siguiente manera:

create or replace trigger tr_precio_libros
 before insert or update of precio
 on libros
 for each row
 begin
  if :new.precio>50 then
   :new.precio := round(:new.precio);
  end if;
 end tr_precio_libros;
 /
 
En este caso, la condici�n se chequea en un "if" dentro del cuerpo del trigger. La diferencia con el primer trigger que
contiene "when" es que la condici�n establecida en el "when" se testea antes que el trigger se dispare y si resulta 
verdadera, se dispara el trigger, sino no. En cambio, si la condici�n est� dentro del cuerpo del disparador, el trigger se 
dispara y luego se controla el precio, si cumple la condici�n, se modifica el precio, sino no.

Por ejemplo, la siguiente sentencia:

 update libros set precio=40 where...;
no dispara el primer trigger, ya que no cumple con la condici�n del "when"; pero si dispara el segundo trigger, que no realiza
ninguna acci�n ya que al evaluarse la condici�n del "if", resulta falsa.
*/







