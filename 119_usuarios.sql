/*
Puede haber varios usuarios diferentes de la base de datos. Cada uno es propietario de sus objetos.

Para crear un usuario debemos conectarnos a la base datos como administradores (por ejemplo "system").

Sintaxis básica para crear un usuario:

 create user NOMBREUSUARIO identified by CONTRASEÑA
 default tablespace NOMBRETABLESPACEPORDEFECTO
 quota CANTIDAD on TABLEESPACE;
** [default role ROLE, ALL];

La cláusula "identified by" permite indicar una contraseña.

La cláusula "default tablespace" será el tablespace (espacio de tablas) por defecto en la creación de objetos del usuario. 
Si se omite se utilizará el tablespace SYSTEM. Los tablespaces son unidades lógicas en las cuales de divide una base 
de datos, en las cuales se almacenan los objetos (tablas, secuencias, etc.); todos los objetos están almacenados dentro 
de un tablespace.

La cláusula "quota" permite configurar un espacio en bytes, Kb o Mb en la base de datos. Si no se especifica, por defecto 
es cero y no podrá crear objetos.

La cláusula "default role" permite asignar roles de permisos durante la creación del usuario.

Ejemplo:

 create user ana identified by anita;
 
Con la sentencia anterior se crea un usuario denominado "ana" con la clave "anita", el tablespace por defecto es "system" 
porque no se especificó otro.

Con la siguiente sentencia se crea un usuario denominado "juan" con la clave "juancito", se le asigna un espacio de 100 mb:

 create user juan identified by juancito
 default tablespace system
 quota 100M on system;
 
Si intentamos crear un usuario que ya existe, Oracle muestra un mensaje de error indicando tal situación.

El diccionario "dba_users" muestra información sobre todos los usuarios; el nombre de usuario (username), contraseña 
(password), estado (account_status), espacio (default_tablespace), fecha de expiración (expiry_date), fecha de creación 
(created), entre otros.

Luego de crear un usuario, aún no podemos conectarnos, ya que no tenemos permiso para crear una sesión. Los permisos 
se aprenderán próximamente.
*/





