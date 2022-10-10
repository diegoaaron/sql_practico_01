/*
Los procedimientos almacenados pueden recibir y devolver información; para ello se emplean parámetros.

Veamos los primeros. Los parámetros de entrada posibilitan pasar información a un procedimiento. Para que un 
procedimiento almacenado admita parámetros de entrada se deben declarar al crearlo. La sintaxis es:

 create or replace procedure NOMBREPROCEDIMIENTO (PARAMETRO in TIPODEDATO)
  as 
  begin
   INSTRUCCIONES; 
  end;
  /
  
Los parámetros se definen luego del nombre del procedimiento. Pueden declararse varios parámetros por procedimiento, 
se separan por comas.

Cuando el procedimiento es ejecutado, deben explicitarse valores para cada uno de los parámetros (en el orden que fueron 
definidos), a menos que se haya definido un valor por defecto, en tal caso, pueden omitirse.

Creamos un procedimiento que recibe el nombre de una editorial como parámetro y luego lo utiliza para aumentar los 
precios de tal editorial:

 create or replace procedure pa_libros_aumentar10(aeditorial in varchar2)
 as
 begin
  update libros set precio=precio+(precio*0.1)
  where editorial=aeditorial;
 end;
 /
El procedimiento se ejecuta colocando "execute" (o "exec") seguido del nombre del procedimiento y un valor para el parámetro:

 execute pa_libros_aumentar10('Planeta');
 
Luego de definir un parámetro y su tipo, opcionalmente, se puede especificar un valor por defecto; tal valor es el que 
asume el procedimiento al ser ejecutado si no recibe parámetros. Si no se coloca valor por defecto, un procedimiento 
definido con parámetros no puede ejecutarse sin valores para ellos. El valor por defecto puede ser "null" o una constante.

Creamos otro procedimiento que recibe 2 parámetros, el nombre de una editorial y el valor de incremento (que tiene por 
defecto el valor 10):

 create or replace procedure pa_libros_aumentar(aeditorial in varchar2,aporcentaje in number default 10)
 as
 begin
  update libros set precio=precio+(precio*aporcentaje/100)
  where editorial=aeditorial;
 end;
 /
 
El procedimiento se ejecuta colocando "execute" (o "exec") seguido del nombre del procedimiento y los valores para los 
parámetros separados por comas:

 execute pa_libros_aumentar('Planeta',30);
Podemos omitir el segundo parámetro al invocar el procedimiento porque tiene establecido un valor por defecto:

 execute pa_libros_aumentar('Planeta');
En caso que un procedimiento tenga definidos varios parámetros con valores por defecto y al invocarlo colocamos uno 
solo, Oracle asume que es el primero de ellos. si son de tipos de datos diferentes, Oracle los convierte. Por ejemplo, 
definimos un procedimiento almacenado de la siguiente manera:

 create or replace procedure pa_libros_insertar
  (atitulo in varchar2 default null, aautor in varchar2 default 'desconocido',
   aeditorial in varchar2 default 'sin especificar', aprecio in number default 0)
 as
 begin
  insert into libros values (atitulo,aautor,aeditorial,aprecio);
 end;
 /
Si luego llamamos al procedimiento enviándoles solamente el primer y cuarto parámetro correspondientes al título y precio:

 execute pa_libros_insertar('Uno',100);
Oracle asume que los argumentos son el primero y segundo, el registro que se almacenará será:

 Uno,100,sin especificar,0;
*/
 drop table libros;

 create table libros(
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(5,2)
 );

 insert into libros values ('Uno','Richard Bach','Planeta',15);
 insert into libros values ('Ilusiones','Richard Bach','Planeta',12);
 insert into libros values ('El aleph','Borges','Emece',25);
 insert into libros values ('Aprenda PHP','Mario Molina','Nuevo siglo',50);
 insert into libros values ('Matematica estas ahi','Paenza','Nuevo siglo',18);
 insert into libros values ('Puente al infinito','Bach Richard','Sudamericana',14);
 insert into libros values ('Antología','J. L. Borges','Paidos',24);
 insert into libros values ('Java en 10 minutos','Mario Molina','Siglo XXI',45);
 insert into libros values ('Cervantes y el quijote','Borges- Casares','Planeta',34);

-- Creamos un procedimiento que recibe el nombre de una editorial y luego aumenta en un 10% los precios de los libros 
-- de tal editorial:

create or replace procedure pa_libros_aumentar10(aeditorial in varchar2) as 
begin 
update libros set precio = precio + (precio * 0.1)
where editorial = aeditorial;
end;
/

-- Ejecutamos el procedimiento:

execute pa_libros_aumentar10('Planeta');

-- Verificamos que los precios de los libros de la editorial "Planeta" han aumentado un 10%:

 select *from libros;
 
-- Creamos otro procedimiento que recibe 2 parámetros, el nombre de una editorial y el valor de incremento (que tiene por 
-- defecto el valor 10):

create or replace procedure pa_libros_aumentar(aeditorial in varchar2, aporcentaje in number default 10) as 
begin 
update libros set precio = precio + (precio * aporcentaje/100) 
where editorial =aeditorial;
end;
/

-- Ejecutamos el procedimiento enviando valores para ambos argumentos:

execute pa_libros_aumentar('Planeta', 30);

-- Consultamos la tabla "libros" para verificar que los precios de los libros de la editorial "Planeta" han sido aumentados 
-- en un 30%:

select * from libros;

-- Ejecutamos el procedimiento "pa_libros_aumentar" omitiendo el segundo parámetro porque tiene establecido un valor 
-- por defecto:

execute pa_libros_aumentar('Paidos');

-- Consultamos la tabla "libros" para verificar que los precios de los libros de la editorial "Paidos" han sido aumentados en 
-- un 10% (valor por defecto):

select * from libros;

-- Definimos un procedimiento almacenado que ingrese un nuevo libro en la tabla "libros":

create or replace procedure pa_libros_insertar 
( atitulo in varchar2 default null, aautor in varchar2 default 'desconocido', aeditorial in varchar2 default 'sin especificar', 
aprecio in number default 0) as
begin 
insert into libros values (atitulo, aautor, aeditorial, aprecio);
end;
/

-- Llamamos al procedimiento sin enviarle valores para los parámetros:

execute pa_libros_insertar;

-- Veamos cómo se almacenó el registro:

select * from libros;

-- Llamamos al procedimiento enviándole valores solamente para el primer y cuarto parámetros correspondientes al título y 
-- precio:

execute pa_libros_insertar('Uno', 100);

-- Oracle asume que los argumentos son el primero y segundo, vea cómo se almacenó el nuevo registro:

select * from libros;

-- Ejercicio 1 

 drop table empleados;

 create table empleados(
  documento char(8),
  nombre varchar2(20),
  apellido varchar2(20),
  sueldo number(6,2),
  fechaingreso date
 );

 insert into empleados values('22222222','Juan','Perez',300,'10/10/1980');
 insert into empleados values('22333333','Luis','Lopez',300,'12/05/1998');
 insert into empleados values('22444444','Marta','Perez',500,'25/08/1990');
 insert into empleados values('22555555','Susana','Garcia',400,'05/05/2000');
 insert into empleados values('22666666','Jose Maria','Morales',400,'24/10/2005');
 
-- Cree un procedimiento almacenado llamado "pa_empleados_aumentarsueldo". Debe incrementar el sueldo de los 
-- empleados con cierta cantidad de años en la empresa (parámetro "ayear" de tipo numérico) en un porcentaje (parámetro 
-- "aporcentaje" de tipo numerico); es decir, recibe 2 parámetros.

create or replace procedure pa_empleados_aumentarsueldo (ayear in number, aporcentaje in number) as 
begin 
update empleados set sueldo = sueldo + (sueldo * aporcentaje/100) 
where (extract(year from current_date) - extract(year from fechaingreso)) > ayear;
end;
/

-- Ejecute el procedimiento creado anteriormente.

execute pa_empleados_aumentarsueldo(10, 20);

-- Verifique que los sueldos de los empleados con más de 10 años en la empresa han aumentado un 20%

select * from empleados;

-- Ejecute el procedimiento creado anteriormente enviando otros valores como parámetros (por ejemplo, 8 y 10)

execute pa_empleados_aumentarsueldo(8, 10);

-- Verifique que los sueldos de los empleados con más de 8 años en la empresa han aumentado un 10%

select * from empleados;

-- Ejecute el procedimiento almacenado "pa_empleados_aumentarsueldo" sin parámetros

 execute pa_empleados_aumentarsueldo;

-- Cree un procedimiento almacenado llamado "pa_empleados_ingresar" que ingrese un empleado en la tabla 
-- "empleados", debe recibir valor para el documento, el nombre, apellido y almacenar valores nulos en los campos "sueldo" 
-- y "fechaingreso"

create or replace procedure pa_empleados_ingresar 
(adocumento in char, anombre in varchar2, aapellido in varchar2) as 
begin 
insert into empleados values(adocumento, anombre, aapellido, null, null);
end;
/

-- Ejecute el procedimiento creado anteriormente y verifique si se ha ingresado en "empleados" un nuevo registro

execute pa_empleados_ingresar('30000000', 'Ana', 'Acosta');

select * from empleados;

-- Reemplace el procedimiento almacenado llamado "pa_empleados_ingresar" para que ingrese un empleado en la 
-- tabla "empleados", debe recibir valor para el documento (con valor por defecto nulo) y fechaingreso (con la fecha actual 
-- como valor por defecto), los demás campos se llenan con valor nulo

create or replace procedure pa_empleados_ingresar 
(adocumento in char default null, afecha in date default current_date) as 
begin 
insert into empleados values(adocumento, null, null, null, afecha);
end;
/

-- Ejecute el procedimiento creado anteriormente enviándole valores para los 2 parámetros y verifique si se ha ingresado 
-- en "empleados" un nuevo registro

 execute pa_empleados_ingresar('32222222','10/10/2007');
 
 select *from empleados;

-- Ejecute el procedimiento creado anteriormente enviando solamente la fecha de ingreso y vea el resultado
-- Oracle toma el valor enviado como primer argumento e intenta ingresarlo en el campo "documento", muestra un mensaje 
-- de error indicando que el valor es muy grande, ya que tal campo admite 8 caracteres.

 execute pa_empleados_ingresar ('15/12/2000');

-- Cree (o reemplace) un procedimiento almacenado que reciba un documento y elimine de la tabla "empleados" el empleado 
-- que coincida con dicho documento

create or replace procedure pa_empleado_eliminar (adocumento in varchar2) as
begin 
delete from empleados where documento = adocumento;
end;
/

-- Elimine un empleado empleando el procedimiento del punto anterior

execute pa_empleado_eliminar('30000000');

-- Verifique la eliminación
 
 select * from empleados;
 