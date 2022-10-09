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

