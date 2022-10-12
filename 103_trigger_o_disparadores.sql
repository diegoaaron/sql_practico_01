/*
Un "trigger" (disparador o desencadenador) es un bloque de c�digo que se ejecuta autom�ticamente cuando ocurre alg�n 
evento (como inserci�n, actualizaci�n o borrado) sobre una determinada tabla (o vista); es decir, cuando se intenta modificar 
los datos de una tabla (o vista) asociada al disparador.

Se crean para conservar la integridad referencial y la coherencia entre los datos entre distintas tablas; para registrar los 
cambios que se efect�an sobre las tablas y la identidad de quien los realiz�; para realizar cualquier acci�n cuando una 
tabla es modificada; etc.

Si se intenta modificar (agregar, actualizar o eliminar) datos de una tabla asociada a un disparador, el disparador se 
ejecuta (se dispara) en forma autom�tica.

La diferencia con los procedimientos almacenados del sistema es que los triggers:

- no pueden ser invocados directamente; al intentar modificar los datos de una tabla asociada a un disparador, el disparador 
se ejecuta autom�ticamente.

- no reciben y retornan par�metros.

- son apropiados para mantener la integridad de los datos, no para obtener resultados de consultas.

Sintaxis general para crear un disparador:

 create or replace trigger NOMBREDISPARADOR
 MOMENTO-- before, after o instead of
 EVENTO-- insert, update o delete
 of CAMPOS-- solo para update
 on NOMBRETABLA
 NIVEL--puede ser a nivel de sentencia (statement) o de fila (for each row)
 when CONDICION--opcional
 begin
  CUERPO DEL DISPARADOR--sentencias
 end NOMBREDISPARADOR;
 /
 
Los triggers se crean con la instrucci�n "create trigger" seguido del nombre del disparador. Si se agrega "or replace" 
al momento de crearlo y ya existe un trigger con el mismo nombre, tal disparador ser� borrado y vuelto a crear.

"MOMENTO" indica cuando se disparar� el trigger en relaci�n al evento, puede ser BEFORE (antes), AFTER (despu�s) o 
INSTEAD OF (en lugar de). "before" significa que el disparador se activar� antes que se ejecute la operaci�n (insert, update 
o delete) sobre la tabla, que caus� el disparo del mismo. "after" significa que el trigger se activar� despu�s que se ejecute 
la operaci�n que caus� el disparo. "instead of" s�lo puede definirse sobre vistas, anula la sentencia disparadora, se ejecuta 
en lugar de tal sentencia (ni antes ni despu�s).

"EVENTO" especifica la operaci�n (acci�n, tipo de modificaci�n) que causa que el trigger se dispare (se active), puede 
ser "insert", "update" o "delete"; DEBE colocarse al menos una acci�n, puede ser m�s de una, en tal caso se separan 
con "or". Si "update" lleva una lista de atributos, el trigger s�lo se ejecuta si se actualiza alg�n atributo de la lista.

"on NOMBRETABLA" indica la tabla (o vista) asociada al disparador;

"NIVEL" puede ser a nivel de sentencia o de fila. "for each row" indica que el trigger es a nivel de fila, es decir, se activa una 
vez por cada registro afectado por la operaci�n sobre la tabla, cuando una sola operaci�n afecta a varios registros. 
Los triggers a nivel de sentencia, se activan una sola vez (antes o despu�s de ejecutar la operaci�n sobre la tabla). Si no 
se especifica, o se especifica "statement", es a nivel de sentencia.

"CUERPO DEL DISPARADOR" son las acciones que se ejecutan al dispararse el trigger, las condiciones que determinan 
cuando un intento de inserci�n, actualizaci�n o borrado provoca las acciones que el trigger realizar�. El bloque se delimita 
con "begin... end".

Entonces, un disparador es un bloque de c�digo asociado a una tabla que se dispara autom�ticamente antes o despu�s 
de una sentencia "insert", "update" o "delete" sobre la tabla.

Se crean con la instrucci�n "create trigger" especificando el momento en que se disparar�, qu� evento lo desencadenar� 
(inserci�n, actualizaci�n o borrado), sobre qu� tabla (o vista) y las instrucciones que se ejecutar�n.

Los disparadores pueden clasificarse seg�n tres par�metros:

- el momento en que se dispara: si se ejecutan antes (before) o despu�s (after) de la sentencia.

- el evento que los dispara: insert, update o delete, seg�n se ejecute una de estas sentencias sobre la tabla.

- nivel: dependiendo si se ejecuta para cada fila afectada en la sentencia (por cada fila) o bien una �nica vez por sentencia 
independientemente de la filas afectadas (nivel de sentencia).

Consideraciones generales:

- Las siguientes instrucciones no est�n permitidas en un desencadenador: create database, alter database, drop database, 
load database, restore database, load log, reconfigure, restore log, disk init, disk resize.

- Se pueden crear varios triggers para cada evento, es decir, para cada tipo de modificaci�n (inserci�n, actualizaci�n o 
borrado) para una misma tabla. Por ejemplo, se puede crear un "insert trigger" para una tabla que ya tiene otro "insert trigger".
*/




