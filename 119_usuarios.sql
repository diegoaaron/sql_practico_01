/*
Puede haber varios usuarios diferentes de la base de datos. Cada uno es propietario de sus objetos.

Para crear un usuario debemos conectarnos a la base datos como administradores (por ejemplo "system").

Sintaxis b�sica para crear un usuario:

 create user NOMBREUSUARIO identified by CONTRASE�A
 default tablespace NOMBRETABLESPACEPORDEFECTO
 quota CANTIDAD on TABLEESPACE;
** [default role ROLE, ALL];

La cl�usula "identified by" permite indicar una contrase�a.

La cl�usula "default tablespace" ser� el tablespace (espacio de tablas) por defecto en la creaci�n de objetos del usuario. 
Si se omite se utilizar� el tablespace SYSTEM. Los tablespaces son unidades l�gicas en las cuales de divide una base 
de datos, en las cuales se almacenan los objetos (tablas, secuencias, etc.); todos los objetos est�n almacenados dentro 
de un tablespace.

La cl�usula "quota" permite configurar un espacio en bytes, Kb o Mb en la base de datos. Si no se especifica, por defecto 
es cero y no podr� crear objetos.

La cl�usula "default role" permite asignar roles de permisos durante la creaci�n del usuario.

Ejemplo:

 create user ana identified by anita;
 
Con la sentencia anterior se crea un usuario denominado "ana" con la clave "anita", el tablespace por defecto es "system" 
porque no se especific� otro.

Con la siguiente sentencia se crea un usuario denominado "juan" con la clave "juancito", se le asigna un espacio de 100 mb:

 create user juan identified by juancito
 default tablespace system
 quota 100M on system;
 
Si intentamos crear un usuario que ya existe, Oracle muestra un mensaje de error indicando tal situaci�n.

El diccionario "dba_users" muestra informaci�n sobre todos los usuarios; el nombre de usuario (username), contrase�a 
(password), estado (account_status), espacio (default_tablespace), fecha de expiraci�n (expiry_date), fecha de creaci�n 
(created), entre otros.

Luego de crear un usuario, a�n no podemos conectarnos, ya que no tenemos permiso para crear una sesi�n. Los permisos 
se aprender�n pr�ximamente.
*/





