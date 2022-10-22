/*
Aprendimos que los usuarios necesitan permisos para poder acceder a la base de datos y a los objetos de la misma. 
Dijimos que los privilegios pueden ser de dos tipos: a) del sistema y b) sobre objetos.

Hemos aprendido a conceder un privilegio de sistema: "create session", que es necesario para poder conectarse a la base 
de datos, es decir, para iniciar una sesión.

Pero teniendo únicamente este permiso, no podemos hacer mucho, solamente iniciar una sesión, pero no podemos crear 
tablas, ni ningún otro objeto; por ello son importantes los permisos de creación de objetos.

Aprendamos más sobre los privilegios de sistema.

Los privilegios de sistema son permisos para realizar ciertas operaciones en la base de datos.

Los siguientes son algunos de los privilegios de sistema existentes:

- create session: para conectarse a la base de datos;

- create table: crear tablas;

- create sequence: crear secuencias;

- create view: crear vistas;

- create trigger: crear disparadores en su propio esquema;

- create procedure: crear procedimientos y funciones;

- execute any procedure: ejecutar cualquier procedimiento en cualquier esquema;

- create user: crear usuarios y especificar claves;

- create role: crear roles;

- drop user: eliminar usuarios.

Se asignan privilegios de sistema a un usuario mediante la instrucción "grant":

Sintaxis básica:

 grant PERMISODESISTEMA
  to USUARIO;
  
Oracle permite conceder múltiples privilegios a múltiples usuarios en una misma sentencia, debemos separarlos por comas.

En el siguiente ejemplo se concede el permiso para crear sesión a los usuarios "juan" y "ana":

 grant create session
 to juan, ana;
 
En el siguiente ejemplo se conceden los permisos para crear tablas y vistas al usuario "ana":

 grant create table, create view
 to ana;
 
En el siguiente ejemplo se conceden 2 permisos a 2 usuarios en una sola sentencia:

 grant create trigger, create procedure
 to juan, ana;
Consultando el diccionario "dba_sys_privs" encontramos los privilegios concedidos a los distintos usuarios; y consultando 
"user_sys_privs" obtendremos la misma información pero únicamente del usuario actual.
*/

 drop user ana cascade;

 create user ana identified by anita
 default tablespace system
 quota 100M on system;
 
-- Creamos un usuario denominado "juan", con contraseña "juancito", le asignamos espacio en "system" (100M). Antes lo 
-- eliminamos por si existe:

 drop user juan cascade;

 create user juan identified by juancito
 default tablespace system
 quota 100M on system;
 
-- Concedemos a ambos usuarios permiso para conectarse:

 grant create session
  to ana, juan;

-- Concedemos permiso para crear tablas y vistas al usuario "ana":

 grant create table, create view
 to ana;

-- Concedemos permiso para crear disparadores y procedimientos a ambos usuarios:

 grant create trigger, create procedure
 to juan, ana;

-- Consultamos el diccionario "dba_sys_privs" para ver los privilegios concedidos a "ana" y "juan":

select grantee, privilege from dba_sys_privs
where grantee='ANA' or grantee='JUAN'
order by grantee; Obtenemos la siguiente información:

-- Iniciamos una nueva sesión como "ana". Como "ana" creamos una tabla:

 create table prueba(
  nombre varchar2(30),
  apellido varchar2(30)
 );
 
-- La tabla ha sido creada, porque "ana" tiene pivilegio "create table".

-- Podemos consultar el diccionario "user_sys_privs" para corroborar sus privilegios:

select privilege from user_sys_privs; -- Obtenemos la siguiente información:
PRIVILEGE

CREATE TRIGGER
CREATE TABLE
CREATE SESSION
CREATE VIEW
CREATE PROCEDURE

-- Iniciamos una nueva sesión como "juan". Como "juan" intentamos crear una tabla:

 create table prueba(
  nombre varchar2(30),
  apellido varchar2(30)
 );

-- Mensaje de error "privilegios insuficientes". Esto sucede porque "juan", no tiene permiso para crear tablas.

-- Vemos los permisos de "juan":

select privilege from user_sys_privs;

-- No tiene permiso para crear tablas.
-- Cambiamos a la conexión "system" y concedemos a "juan" permiso para crear tablas:

 grant create table
 to juan;
 
-- Cambiamos a la solapa "juan" y creamos una tabla:

 create table prueba(
  nombre varchar2(30),
  apellido varchar2(30)
 );

-- Podemos hacerlo porque "juan" ahora tiene el permiso.

-- Vemos los permisos de "juan":

 select privilege from user_sys_privs;

-- Cambiamos a la conexión "system". Veamos todas las tablas denominadas "PRUEBA":

 select *from dba_objects where object_name='PRUEBA';

-- Note que hay una tabla propiedad de "ana" y otra que pertenece a "juan".

-- Cree un usuario denominado "director", con contraseña "escuela", asignándole 100M de espacio en "system" (100M).  
-- Antes elimínelo por si existe:

 drop user director cascade;

-- Intente iniciar una sesión como "director".
-- No es posible, no hemos concedido el permiso correspondiente. Aparece un mensaje indicando que el usuario "director" 
-- no tiene permiso "create session" por lo tanto no puede conectarse.

 create user director identified by escuela
 default tablespace system
 quota 100M on system;

-- Vea los permisos de "director". No tiene ningún permiso.

 select *from dba_sys_privs where grantee='DIRECTOR';

-- Conceda a "director" permiso para iniciar sesion y para crear tablas

 grant create session, create table
  to director;

-- Vea los permisos de "director". Tiene permiso "create session" y para crear tablas.

 select *from dba_sys_privs where grantee='DIRECTOR';

-- Inicie una sesión como "director".
-- Como "administrador", elimine los usuarios "profesor" y "alumno", por si existen

drop user profesor cascade;
 drop user alumno cascade;

-- Cree un usuario denominado "profesor", con contraseña "maestro", asigne espacio en "system" (100M)

 create user profesor identified by maestro
 default tablespace system
 quota 100M on system;

-- Cree un usuario denominado "estudiante", con contraseña "alumno" y tablespace "system" (no asigne "quota")

create user estudiante identified by alumno
 default tablespace system;

-- Consulte el diccionario de datos correspondiente para ver si existen los 3 usuarios creados



-- Conceda a "profesor" y a "estudiante" permiso para conectarse

-- Conceda a "estudiante" permiso para crear tablas

-- Consulte el diccionario de datos "sys_privs" para ver los permisos de los 3 usuarios creados
-- "director" y "estudiante" tienen permisos para conectarse y para crear tablas, "profesor" tiene permiso para conectarse.

-- Retome su sesión como "director" y cree una tabla:

 create table prueba(
  nombre varchar2(30),
  apellido varchar2(30)
 );

-- Podemos hacerlo poque "director" tiene el permiso necesario y espacio en "system".

-- Inicie una sesión como "profesor" e intente crear una tabla:

 create table prueba(
  nombre varchar2(30),
  apellido varchar2(30)
 );

-- Mensaje de error "privilegios insuficientes". Esto sucede porque "profesor" NO tiene permiso para crear tablas.

-- Consulte los permisos de "profesor"
-- No tiene permiso para crear tablas, únicamente para crear sesión.

-- Cambie a la conexión de administrador y conceda a "profesor" permiso para crear tablas

-- Cambie a la sesión de "profesor" y cree una tabla
-- Ahora si podemos hacerlo, "profesor" tiene permiso "create table".

-- Consulte nuevamente los permisos de "profesor"
-- Tiene permiso para crear tablas y para crear sesión.

-- Inicie una sesión como "estudiante" e intente crear una tabla:

 create table prueba(
  nombre varchar2(30),
  apellido varchar2(30)
 );


-- Mensaje de error "no existen privilegios en tablespace SYSTEM". Esto sucede porque "estudiante", si bien tiene permiso 
-- para crear tablas, no tiene asignado espacio (recuerde que al crearlo no especificamos "quota", por lo tanto, por defecto 
-- es cero).


-- Vuelva a la conexión de "administrador" y consulte todas las tablas denominadas "PRUEBA"
-- Note que hay una tabla propiedad de "director" y otra que pertenece a "profesor".


