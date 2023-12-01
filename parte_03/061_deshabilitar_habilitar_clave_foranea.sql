/*
Aprendimos (cuando vimos los otros tipos de restricciones) que si agregamos una restricci�n a una tabla que contiene datos, 
Oracle los controla para asegurarse que cumplen con la restricci�n y que es posible deshabilitar esta comprobaci�n. 
Lo hacemos incluyendo la opci�n "novalidate" en la instrucci�n "alter table"; en tal caso, La restricci�n no se aplica en los 
datos existentes, pero si intentamos ingresar un nuevo valor que no cumpla la restricci�n (o actualizarlo), Oracle no lo permite.

En el siguiente ejemplo agregamos una restricci�n "foreign key" sobre el campo "codigoeditorial" de "libros" especificando 
que no valide los datos existentes:

 alter table libros
  add constraint FK_libros_codigoeditorial
  foreign key (codigoeditorial)
  references editoriales novalidate;
  
  La restricci�n no se aplica en los datos existentes, pero si intentamos ingresar un nuevo registro en "libros" cuyo c�digo de editorial no exista en "editoriales", Oracle no lo permitir�.

Para saber si una restricci�n est� validada o no, podemos consultar el cat�logo "user_constraints" y fijarnos lo que informa la columna "validated".

Tambi�n aprendimos que podemos deshabilitar las restricciones para agregar o actualizar datos sin comprobarla. Para evitar la comprobaci�n de datos en inserciones y actualizaciones agregamos "disable" en la instrucci�n "alter table".

En el ejemplo siguiente deshabilitamos la restricci�n "FK_libros_codigoeditorial" para poder ingresar un valor que infrija la restricci�n:

 alter table libros
  disable validate
  constraint FK_libros_codigoeditorial;
Para habilitar una restricci�n "foreign key" deshabilitada se ejecuta la misma instrucci�n pero con la cl�usula "enable".

Por defecto (si no se especifica) las opciones son "validate" (es decir, controla los datos existentes) y "enable" 
(controla futuros ingresos y actualizaciones).

Para saber si una restricci�n est� habilitada o no, podemos consultar el cat�logo "user_constraints" y fijarnos lo que informa 
la columna "status".

Podemos habilitar una restricci�n "foreign key" con "enable" y "novalidate", en tal caso Oracle habilita la restricci�n para 
futuros ingresos y actualizaciones y NO valida los datos existentes.

Entonces, "enable" o "disable" activa o desactiva la restricci�n para los nuevos datos ("enable" es la opci�n predeterminada 
si no se especifica); "validate" o "novalidate" es la opci�n para validar la restricci�n en los datos existentes ("validate" es la 
predeterminada si se omite).

La sintaxis b�sica al agregar la restriccci�n "foreign key" es la siguiente:

 alter table NOMBRETABLA1
  add constraint NOMBRECONSTRAINT
  foreign key (CAMPOCLAVEFORANEA)
  references NOMBRETABLA2 (CAMPOCLAVEPRIMARIA)
  ESTADO VALIDACION;
La sintaxis para modificar una restricci�n es:

 alter table NOMBRETABLA
  ESTADO VALIDACION
  constraint NOMBRERESTRICCION;
*/

 drop table libros;
 drop table editoriales;

 create table libros(
  codigo number(5),
  titulo varchar2(40),
  codigoeditorial number(3),
  primary key (codigo)
 );
 create table editoriales(
  codigo number(3),
  nombre varchar2(20),
  primary key (codigo)
);

 insert into editoriales values(1,'Planeta');
 insert into editoriales values(2,'Emece');
 insert into editoriales values(3,'Paidos');

 insert into libros values(1,'Uno',1);
 insert into libros values(2,'El aleph',2);
 insert into libros values(3,'Aprenda PHP',5);

-- Agregamos una restricci�n "foreign key" a la tabla "libros" para evitar que se ingresen c�digos de editoriales 
-- inexistentes en "editoriales". Incluimos la opci�n "novalidate" para evitar la comprobaci�n de la restricci�n en los 
-- datos existentes (note que hay un libro que tiene un c�digo de editorial inv�lido):

alter table libros
add constraint FK_libros_codigoeditorial
foreign key (codigoeditorial)
references editoriales(codigo) novalidate;

-- La deshabilitaci�n de la comprobaci�n de la restricci�n no afecta a los siguientes ingresos, modificaciones y 
-- actualizaciones. Para poder ingresar, modificar o eliminar datos a una tabla sin que Oracle compruebe la restricci�n 
-- debemos deshabilitarla:

alter table libros
disable novalidate
constraint FK_LIBROS_CODIGOEDITORIAL;

-- Veamos si la restricci�n est� habilitada o no

select constraint_name, constraint_type, status, validated
from user_constraints
where table_name='LIBROS';

-- En la columna "status" de la restricci�n "foreign key" aparece "Disabled" y en "Validated" muestra "not validated".
-- Ahora podemos ingresar un registro en "libros" con c�digo de editorial inv�lido:

insert into libros values(4,'Ilusiones',6);

-- Habilitamos la restricci�n:

alter table libros
enable novalidate constraint FK_LIBROS_CODIGOEDITORIAL;

-- Veamos si la restricci�n est� habilitada o no y si valida los datos existentes:

select constraint_name, constraint_type, status, validated
from user_constraints
where table_name='LIBROS';

-- En la columna "status" aparece "Enabled" y en "Validated" "not validate".

-- Intentamos alterar la restricci�n para que se validen los datos existentes:

alter table libros
enable validate constraint FK_LIBROS_CODIGOEDITORIAL;

-- Oracle mostrar� un mensaje indicando que no se pueden validar los datos existentes porque existen valores inv�lidos.

-- Truncamos la tabla y alteramos la restricci�n:

truncate table libros;

alter table libros
enable validate constraint FK_LIBROS_CODIGOEDITORIAL;

-- Solicitamos informaci�n sobre la restricci�n:

select constraint_name, constraint_type, status, validated
from user_constraints where table_name='LIBROS';

-- En la columna "status" aparece "Enabled" y en "Validated" "Validate".

-- Ejercicio 1

 drop table clientes;
 drop table provincias;

 create table clientes (
  codigo number(5),
  nombre varchar2(30),
  domicilio varchar2(30),
  ciudad varchar2(20),
  codigoprovincia number(2),
  primary key(codigo)
 );

 create table provincias(
  codigo number(2),
  nombre varchar2(20),
  primary key (codigo)
 );

 insert into provincias values(1,'Cordoba');
 insert into provincias values(2,'Santa Fe');
 insert into provincias values(3,'Misiones');
 insert into provincias values(4,'Rio Negro');

 insert into clientes values(100,'Perez Juan','San Martin 123','Carlos Paz',1);
 insert into clientes values(101,'Moreno Marcos','Colon 234','Rosario',2);
 insert into clientes values(102,'Garcia Juan','Sucre 345','Cordoba',1);
 insert into clientes values(103,'Lopez Susana','Caseros 998','Posadas',3);
 insert into clientes values(104,'Marcelo Moreno','Peru 876','Viedma',4);
 insert into clientes values(105,'Lopez Sergio','Avellaneda 333','La Plata',5);

-- Intente agregar una restricci�n "foreign key" para que los c�digos de provincia de "clientes" existan en "provincias" sin 
-- especificar la opci�n de comprobaci�n de datos
-- No se puede porque al no especificar opci�n para la comprobaci�n de datos, por defecto es "validate" y hay un registro 
-- que no cumple con la restricci�n.

alter table clientes
add constraint FK_CLIENTES_CODIGOPROVINCIA
foreign key (codigoprovincia)
references provincias(codigo);

-- Agregue la restricci�n anterior pero deshabilitando la comprobaci�n de datos existentes

alter table clientes
add constraint FK_CLIENTES_CODIGOPROVINCIA
foreign key (codigoprovincia)
references provincias(codigo) novalidate;

-- Vea las restricciones de "clientes"

select constraint_name, constraint_type, status, validated
from user_constraints
where table_name='CLIENTES';

-- Deshabilite la restricci�n "foreign key" de "clientes"

alter table clientes
disable constraint FK_CLIENTES_CODIGOPROVINCIA;

-- Vea las restricciones de "clientes"

select constraint_name, constraint_type, status, validated
from user_constraints
where table_name='CLIENTES';

-- Agregue un registro que no cumpla la restricci�n "foreign key"
-- Se permite porque la restricci�n est� deshabilitada.

 insert into clientes values(111,'Lopez Susana','Caseros 998','Posadas',5);

-- Modifique el c�digo de provincia del cliente c�digo 104 por 9
-- Oracle lo permite porque la restricci�n est� deshabilitada.

update clientes set codigo=9 where codigo=104;

-- Habilite la restricci�n "foreign key"

alter table clientes
enable novalidate constraint FK_CLIENTES_CODIGOPROVINCIA;

-- Intente modificar un c�digo de provincia existente por uno inexistente.

update provincias set codigo = 10 where codigo = 1;

-- Intente alterar la restricci�n "foreign key" para que valide los datos existentes

alter table clientes
enable validate constraint FK_CLIENTES_CODIGOPROVINCIA;

-- Elimine los registros que no cumplen la restricci�n y modifique la restricci�n a "enable" y "validate"

delete from clientes where codigo = 105;
delete from clientes where codigo = 111;

alter table clientes
enable validate constraint FK_CLIENTES_CODIGOPROVINCIA;

-- Obtenga informaci�n sobre la restricci�n "foreign key" de "clientes"

select constraint_name, constraint_type, status, validated
from user_constraints where table_name='CLIENTES';


