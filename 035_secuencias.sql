-- Una secuencia (sequence) se emplea para generar valores enteros secuenciales únicos y asignárselos a campos 
-- numéricos; se utilizan generalmente para las claves primarias de las tablas garantizando que sus valores no se repitan.

-- Una secuencia es una tabla con un campo numérico en el cual se almacena un valor y cada vez que se consulta, 
-- se incrementa tal valor para la próxima consulta.

/*
create sequence NOMBRESECUENCIA
  start with VALORENTERO
  increment by VALORENTERO
  maxvalue VALORENTERO
  minvalue VALORENTERO
  cycle | nocycle;
*/

-- La cláusula "start with" indica el valor desde el cual comenzará la generación de números secuenciales. 
-- Si no se especifica, se inicia con el valor que indique "minvalue".

-- La cláusula "increment by" especifica el incremento, es decir, la diferencia entre los números de la secuencia; 
-- debe ser un valor numérico entero positivo o negativo diferente de 0. Si no se indica, por defecto es 1.

-- "maxvalue" define el valor máximo para la secuencia. Si se omite, por defecto es 99999999999999999999999999.

-- "minvalue" establece el valor mínimo de la secuencia. Si se omite será 1.

-- La cláusula "cycle" indica que, cuando la secuencia llegue a máximo valor (valor de "maxvalue") se reinicie, 
-- comenzando con el mínimo valor ("minvalue") nuevamente, es decir, la secuencia vuelve a utilizar los números. 
-- Si se omite, por defecto la secuencia se crea "nocycle".

-- Si no se especifica ninguna cláusula, excepto el nombre de la secuencia, por defecto, comenzará 
-- en 1, se incrementará en 1, el mínimo valor será 1, el máximo será 999999999999999999999999999 y "nocycle".

-- En el siguiente ejemplo creamos una secuencia llamada "sec_codigolibros", estableciendo que 
-- comience en 1, sus valores estén entre 1 y 99999 y se incrementen en 1, por defecto, será "nocycle":

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

-- Nos muestra el propietario de la secuencia, el nombre de la misma, los valores mínimo y máximo, 
-- el valor de incremento y si es circular o no, entre otros datos que no analizaremos por el momento.

-- También podemos ver todos los objetos de la base de datos actual tipeando;

 select  * from all_objects;

-- En la tabla resultado aparecen todos los objetos de la base de datos, incluidas las secuencias; si 
-- es una secuencia en la columna OBJECT_TYPE se muestra "SEQUENCE".

-- Podemos consultar "all_objects" especificando que nos muestre el nombre de todas las secuencias:

select object_name from all_objects where object_type = 'SEQUENCE';

-- Para eliminar una secuencia empleamos "drop sequence". Sintaxis:

 drop sequence NOMBRESECUENCIA;

-- Si la secuencia no existe aparecerá un mensaje indicando tal situación.
-- En el siguiente ejemplo se elimina la secuencia "sec_codigolibros":

 drop sequence sec_codigolibros;

-- Vamos a crear una secuencia denominada "sec_codigolibros" para utilizarla en la clave primaria de la tabla "libros".

-- Primero eliminamos la secuencia "sec_codigolibros"

drop sequence sec_codigolibros;

-- Creamos la secuencia llamada "sec_codigolibros", estableciendo que comience en 1, sus valores estén entre 
-- 1 y 99999 y se incrementen en 1, por defecto, será "nocycle":

create sequence sec_codigolibros
    start with 1
    increment by 1
    maxvalue 99999
    minvalue 1;

-- Inicializamos la secuencia

select sec_codigolibros.nextval from dual;

-- Recuperamos el valor actual de nuestra secuencia

select sec_codigolibros.currval from dual;

-- Definimos una tabla libros

drop table libros;

create table libros(
  codigo number(5) not null,
  titulo varchar2(40) not null,
  autor varchar2(30),
  editorial varchar2(20),
  primary key(codigo)
);

-- Ingresamos un registro en "libros", almacenando en el campo "codigo" el valor actual de la secuencia

insert into libros values(sec_codigolibros.nextval,'Matematica estas ahi', 'Paenza','Nuevo siglo');

-- validamos los objetos registrados en libros

select * from libros;

-- Veamos todos los objetos de la base de datos actual que contengan en su nombre la cadena "LIBROS"

select object_name, object_type from all_objects where object_name like '%LIBROS%';

-- Eliminamos las secuencias creadas

drop sequence sec_codigolibros;

-- Ejercicio 1 

-- eliminamos la tabla empleados

drop table empleados;

-- creamos la tabla empleados

create table empleados(
  legajo number(3),
  documento char(8) not null,
  nombre varchar2(30) not null,
  primary key(legajo)
);

-- Elimine la secuencia "sec_legajoempleados" y luego créela estableciendo el valor mínimo (1), máximo (999), 
-- valor inicial (100), valor de incremento (2) y no circular. Finalmente inicialice la secuencia.

drop sequence sec_legajoempleados;

create sequence sec_legajoempleados
    start with 100
    increment by 2
    maxvalue 999
    minvalue 100;

select sec_legajoempleados.nextval from dual;

select sec_legajoempleados.currval from dual;

-- Ingrese algunos registros, empleando la secuencia creada para los valores de la clave primaria:

insert into empleados values (sec_legajoempleados.currval,'22333444','Ana Acosta');
insert into empleados values (sec_legajoempleados.nextval,'23444555','Betina Bustamante');
insert into empleados values (sec_legajoempleados.nextval,'24555666','Carlos Caseros');
insert into empleados values (sec_legajoempleados.nextval,'25666777','Diana Dominguez');
insert into empleados values (sec_legajoempleados.nextval,'26777888','Estela Esper');

-- Recupere los registros de "empleados" para ver los valores de clave primaria.

select * from empleados;

-- Vea el valor actual de la secuencia empleando la tabla "dual".

select sec_legajoempleados.currval from dual;

-- Recupere el valor siguiente de la secuencia empleando la tabla "dual" 

select sec_legajoempleados.nextval from dual;

-- Ingrese un nuevo empleado (recuerde que la secuencia ya tiene el próximo valor, emplee "currval" 
-- para almacenar el valor de legajo)

insert into empleados values(sec_legajoempleados.currval,'26444888','Estela Esper');

-- Recupere los registros de "empleados" para ver el valor de clave primaria ingresado anteriormente.

select * from empleados;

-- Incremente el valor de la secuencia empleando la tabla "dual" (retorna 112)

select sec_legajoempleados.nextval from dual;

-- Ingrese un empleado con valor de legajo "112".

insert into empleados values(sec_legajoempleados.currval,'33334444','Luis Quiroz');

-- Intente ingresar un registro empleando "currval" (error porque ya utilizo el valor actual)

insert into empleados values(sec_legajoempleados.currval,'55556666','Maria Perez');

-- Incremente el valor de la secuencia. Retorna 114.

select sec_legajoempleados.nextval from dual;

-- intente ingresar el registro del enunciado anterior

insert into empleados values(sec_legajoempleados.currval,'55556666','Maria Perez');

-- Recupere los registros.

select * from empleados;

-- Vea las secuencias existentes y analice la información retornada

select object_name from all_objects where object_type = 'SEQUENCE';

-- Vea todos los objetos de la base de datos actual que contengan en su nombre la cadena "EMPLEADOS".

select object_name, object_type from all_objects where object_name like '%EMPLEADOS%';

-- Elimine la secuencia creada.

drop sequence sec_legajoempleados;

-- Consulte todos los objetos de la base de datos que sean secuencias y verifique que "sec_legajoempleados" ya no existe.

select object_name, object_type from all_objects where object_name like '%EMPLEADOS%';


