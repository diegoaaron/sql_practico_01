/*
La restricci�n "foreign key", que define una referencia a un campo con una restricci�n "primary key" o "unique" se puede 
definir entre distintas tablas (como hemos aprendido) o dentro de la misma tabla.

Veamos un ejemplo en el cual definimos esta restricci�n dentro de la misma tabla.

Una mutual almacena los datos de sus afiliados en una tabla llamada "afiliados". Algunos afiliados inscriben a sus familiares. 
La tabla contiene un campo que hace referencia al afiliado que lo incorpor� a la mutual, del cual dependen.

La estructura de la tabla es la siguiente:

create table afiliados(
numero number(5),
documento char(8) not null,
nombre varchar2(30),
afiliadotitular number(5),
primary key (documento),
unique (numero)
);
 
En caso que un afiliado no haya sido incorporado a la mutual por otro afiliado, el campo "afiliadotitular" almacenar� "null".

Establecemos una restricci�n "foreign key" para asegurarnos que el n�mero de afiliado que se ingrese en el campo 
"afiliadotitular" exista en la tabla "afiliados":

alter table afiliados
add constraint FK_afiliados_afiliadotitular
foreign key (afiliadotitular)
references afiliados (numero);
  
 La sintaxis es la misma, excepto que la tabla se autoreferencia.

Luego de aplicar esta restricci�n, cada vez que se ingrese un valor en el campo "afiliadotitular", Oracle controlar� que 
dicho n�mero exista en la tabla, si no existe, mostrar� un mensaje de error.

Si intentamos eliminar un afiliado que es titular de otros afiliados, no se podr� hacer, a menos que se haya especificado 
la acci�n en cascada (pr�ximo tema).

Si intentamos modificar un afiliado que es titular de otros afiliados, no se podr� hacer, a menos que se haya especificado 
la acci�n en cascada para actualizaciones (pr�ximo tema). 
*/

 drop table afiliados;

 create table afiliados(
  numero number(5),
  documento char(8) not null,
  nombre varchar2(30),
  afiliadotitular number(5),
  primary key (documento),
  unique (numero)
 );
 
 -- En caso que un afiliado no haya sido incorporado a la mutual por otro afiliado, el campo "afiliadotitular" almacenar� "null".

-- Establecemos una restricci�n "foreign key" para asegurarnos que el n�mero de afiliado que se ingrese en el campo 
-- "afiliadotitular" exista en la tabla "afiliados":

alter table afiliados
add constraint FK_AFILIADOS_AFILIADOTITULAR
foreign key (afiliadotitular)
references afiliados (numero);

 insert into afiliados values(1,'22222222','Perez Juan',null);
 insert into afiliados values(2,'23333333','Garcia Maria',null);
 insert into afiliados values(3,'24444444','Lopez Susana',null);
 insert into afiliados values(4,'30000000','Perez Marcela',1);
 insert into afiliados values(5,'31111111','Garcia Luis',2);
 insert into afiliados values(6,'32222222','Garcia Maria',2);

-- Podemos eliminar un afiliado, siempre que no haya otro afiliado que haga referencia a �l en "afiliadotitular", es decir, 
-- si el "numero" del afiliado est� presente en alg�n registro en el campo "afiliadotitular":

delete from afiliados where numero = 5;

-- Veamos la informaci�n referente a "afiliados":

select constraint_name, constraint_type, search_condition 
from user_constraints
where table_name='AFILIADOS';

-- La tabla tiene una restricci�n "check", una "primary key", una "unique" y una "foreign key".
-- Veamos sobre qu� campos est�n establecidas:

select * from user_cons_columns
where table_name = 'AFILIADOS';

-- Nos informa que la restricci�n �nica est� establecida sobre "numero"; la "primary key" sobre "documento", la restricci�n de 
-- chequeo sobre "documento" y la "foreign key" sobre "afiliadotitular".

-- Ingresamo un nuevo registro con un  valor para "afiliadotitular" existente

insert into afiliados values(7,'33333333','Lopez Juana',3);

-- Intentamos ingresar un nuevo registro con un valor para "afiliadotitular" inexistente:
-- Oracle no lo permite porque se violar�a la restricci�n "foreign key".

 insert into afiliados values(8,'34555666','Marconi Julio',9);

-- Igresamos un nuevo registro con el valor "null" para "afiliadotitular":

 insert into afiliados values(8,'34555666','Marconi Julio',null);

-- Ejercicio 1 

1- Elimine la tabla y cr�ela:

 drop table clientes;
 
 create table clientes(
  codigo number(5),
  nombre varchar2(30),
  domicilio varchar2(30),
  ciudad varchar2(20),
  referenciadopor number(5),
  primary key(codigo)
 );

 insert into clientes values (50,'Juan Perez','Sucre 123','Cordoba',null);
 insert into clientes values(90,'Marta Juarez','Colon 345','Carlos Paz',null);
 insert into clientes values(110,'Fabian Torres','San Martin 987','Cordoba',50);
 insert into clientes values(125,'Susana Garcia','Colon 122','Carlos Paz',90);
 insert into clientes values(140,'Ana Herrero','Colon 890','Carlos Paz',9);

-- Intente agregar una restricci�n "foreign key" para evitar que en el campo "referenciadopor" se ingrese un valor de c�digo de 
-- cliente que no exista. No se permite porque existe un registro que no cumple con la restricci�n que se intenta establecer.

alter table clientes
add constraint FK_CLIENTES_REFERENCIADOPOR
foreign key (referenciadopor)
references clientes(codigo);

-- Cambie el valor inv�lido de "referenciadopor" del registro que viola la restricci�n por uno v�lido:

update clientes set referenciadopor = 90 where referenciadopor = 9;

-- 