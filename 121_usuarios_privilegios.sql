/*
Aprendimos que los usuarios necesitan permisos para poder acceder a la base de datos y a los objetos de la misma. 
Dijimos que los privilegios pueden ser de dos tipos: a) del sistema y b) sobre objetos.

Hemos aprendido a conceder un privilegio de sistema: "create session", que es necesario para poder conectarse a la base 
de datos, es decir, para iniciar una sesi�n.

Pero teniendo �nicamente este permiso, no podemos hacer mucho, solamente iniciar una sesi�n, pero no podemos crear 
tablas, ni ning�n otro objeto; por ello son importantes los permisos de creaci�n de objetos.

Aprendamos m�s sobre los privilegios de sistema.

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

Se asignan privilegios de sistema a un usuario mediante la instrucci�n "grant":

Sintaxis b�sica:

 grant PERMISODESISTEMA
  to USUARIO;
  
Oracle permite conceder m�ltiples privilegios a m�ltiples usuarios en una misma sentencia, debemos separarlos por comas.

En el siguiente ejemplo se concede el permiso para crear sesi�n a los usuarios "juan" y "ana":

 grant create session
 to juan, ana;
 
En el siguiente ejemplo se conceden los permisos para crear tablas y vistas al usuario "ana":

 grant create table, create view
 to ana;
 
En el siguiente ejemplo se conceden 2 permisos a 2 usuarios en una sola sentencia:

 grant create trigger, create procedure
 to juan, ana;
Consultando el diccionario "dba_sys_privs" encontramos los privilegios concedidos a los distintos usuarios; y consultando 
"user_sys_privs" obtendremos la misma informaci�n pero �nicamente del usuario actual.
*/




