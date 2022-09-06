-- Una secuencia (sequence) se emplea para generar valores enteros secuenciales �nicos y asign�rselos a campos 
-- num�ricos; se utilizan generalmente para las claves primarias de las tablas garantizando que sus valores no se repitan.

-- Una secuencia es una tabla con un campo num�rico en el cual se almacena un valor y cada vez que se consulta, 
-- se incrementa tal valor para la pr�xima consulta.

/*
create sequence NOMBRESECUENCIA
  start with VALORENTERO
  increment by VALORENTERO
  maxvalue VALORENTERO
  minvalue VALORENTERO
  cycle | nocycle;
*/

-- La cl�usula "start with" indica el valor desde el cual comenzar� la generaci�n de n�meros secuenciales. 
-- Si no se especifica, se inicia con el valor que indique "minvalue".

-- La cl�usula "increment by" especifica el incremento, es decir, la diferencia entre los n�meros de la secuencia; 
-- debe ser un valor num�rico entero positivo o negativo diferente de 0. Si no se indica, por defecto es 1.

-- "maxvalue" define el valor m�ximo para la secuencia. Si se omite, por defecto es 99999999999999999999999999.

-- "minvalue" establece el valor m�nimo de la secuencia. Si se omite ser� 1.

-- La cl�usula "cycle" indica que, cuando la secuencia llegue a m�ximo valor (valor de "maxvalue") se reinicie, 
-- comenzando con el m�nimo valor ("minvalue") nuevamente, es decir, la secuencia vuelve a utilizar los n�meros. 
-- Si se omite, por defecto la secuencia se crea "nocycle".

-- Si no se especifica ninguna cl�usula, excepto el nombre de la secuencia, por defecto, comenzar� 
-- en 1, se incrementar� en 1, el m�nimo valor ser� 1, el m�ximo ser� 999999999999999999999999999 y "nocycle".

-- En el siguiente ejemplo creamos una secuencia llamada "sec_codigolibros", estableciendo que 
-- comience en 1, sus valores est�n entre 1 y 99999 y se incrementen en 1, por defecto, ser� "nocycle":

create sequence sec_codigolibros
    start with 1
    increment by 1
    maxvalue 99999
    minvalue 1;

-- Dijimos que las secuencias son tablas; por lo tanto se accede a ellas mediante consultas, empleando "select". 
-- La diferencia es que utilizamos pseudocolumnas para recuperar el valor actual y el siguiente de la secuencia. 
-- Estas pseudocolumnas pueden incluirse en el "from" de una consulta a otra tabla o de la tabla "dual".

-- Para recuperar los valores de una secuencia empleamos las pseudocolumnas "currval" y "nextval".
-- Primero debe inicializarse la secuencia con "nextval". La primera vez que se referencia "nextval" 
-- retorna el valor de inicio de la secuencia; las siguientes veces, incrementa la secuencia y nos retorna el nuevo valor:

-- NOMBRESECUENCIA.NEXTVAL;

-- Para recuperar el valor actual de una secuencia usamos:

-- NOMBRESECUENCIA.CURRVAL;

-- Los valores retornados por "currval" y "nextval" pueden usarse en sentencias "insert" y "update".

-- Ejemplo: creamos una secuencia para el codigo de los libros, especificando el valor maximo, el incremento
-- y que no sea circular.

create sequence sec_dodigolibros
    maxvalue 999999
    increment by 1
    nocycle;

-- Inicializamos la secuencia

select sec_dodigolibros.nextval from dual;

-- Ingrese un registro en la tabla libros

insert into libros values(sec_dodigolibros.currval, 'El Alep', 'Borges', 'Emece');

insert into libros values(sec_dodigolibros.nextval, 'Matematica estas ahi', 'Paenza','Nuevo siglo');

-- Para ver todas las secuencias de la base de datos actual realizamos la siguiente consulta:

select * from all_sequences;

-- Nos muestra el propietario de la secuencia, el nombre de la misma, los valores m�nimo y m�ximo, 
-- el valor de incremento y si es circular o no, entre otros datos que no analizaremos por el momento.

-- Tambi�n podemos ver todos los objetos de la base de datos actual tipeando;

 select  * from all_objects;

-- En la tabla resultado aparecen todos los objetos de la base de datos, incluidas las secuencias; si 
-- es una secuencia en la columna OBJECT_TYPE se muestra "SEQUENCE".

-- Podemos consultar "all_objects" especificando que nos muestre el nombre de todas las secuencias:

select object_name from all_objects where object_type = 'SEQUENCE';

-- Para eliminar una secuencia empleamos "drop sequence". Sintaxis:

 drop sequence NOMBRESECUENCIA;

-- Si la secuencia no existe aparecer� un mensaje indicando tal situaci�n.
-- En el siguiente ejemplo se elimina la secuencia "sec_codigolibros":

 drop sequence sec_codigolibros;

