/*
Los usuarios necesitan permisos para poder acceder a la base de datos y a los objetos de la misma.

Los privilegios pueden ser de dos tipos: del sistema y sobre objetos.

Como mínimo, un usuario debe tener permiso para conectarse.

El permiso "create session" es un privilegio de sistema.

Para conceder permiso de conexión a un usuario empleamos la instrucción "grant".

Sintaxis básica:

 grant create session
  to USUARIO;
En el siguiente ejemplo concedemos al usuario "juan" permiso para conectarse:

 grant create session to juan;
Podemos consultar el diccionario "dba_sys_privs" para encontrar los privilegios concedidos a los usuarios. Nos mostrará 
el nombre del usuario (grantee) y el permiso (privilege), entre otra información que analizaremos próximamente.

Luego de tener permiso para crear sesión, puede crear una sesión presionando el ícono "new connection" en la solapa "
connections"; se abrirá una ventana en la cual deberá colocar un nombre de conexión ("connection name", puede ser el 
mismo nombre de usuario), el nombre del usuario ("username") y la contraseña ("password"), luego presionar el botón 
"connect"; se abrirá una nueva solapa (nueva conexión) con el nombre del usuario; no se abrirá la nueva conexión si:

a) el usuario para quien quiere abrir una nueva sesión no existe,

b) la contraseña es incorrecta o

c) el usuario existe pero no tiene permiso "create session".

Si consultamos el diccionario "user_sys_privs" obtendremos la misma información que "dba_sys_privs" pero únicamente 
del usuario actual.

Podemos averiguar el nombre del usuario conectado con la siguiente sentencia:

 select user from dual;
*/

select user from dual;

Creamos un usuario denominado "ana", con contraseña "anita", le asignamos espacio en "system" (100M). Antes lo eliminamos por si existe:

 drop user ana cascade;

 create user ana identified by anita
 default tablespace system
 quota 100M on system;
Creamos un usuario denominado "juan", con contraseña "juancito", le asignamos espacio en "system" (100M). Antes lo eliminamos por si existe:

 drop user juan cascade;

 create user juan identified by juancito
 default tablespace system
 quota 100M on system;
Consultamos el diccionario "dba_users" y analizamos la información que nos muestra:

 select username, password, default_tablespace, created from dba_users;
Verificamos que los usuarios "ana" y "juan" existen.

Consultamos el diccionario "dba_sys_privs" para encontrar los privilegios concedidos a nuestros usuarios. Nos mostrará el nombre del usuario (grantee) y el permiso (si lo tiene):

select grantee, privilege from dba_sys_privs where GRANTEE='ANA' or grantee='JUAN';
Nos muestra que estos usuarios no tienen ningún privilegio concedido.

Concedemos a "juan" permiso para conectarse:

 grant create session
  to juan;
Consultamos el diccionario "dba_sys_privs" para encontrar los privilegios concedidos a "juan":

 select grantee,privilege from dba_sys_privs 
  where grantee='JUAN';
Tiene permiso "create session".

Abrimos una nueva conexión para "juan":

Presionamos el ícono "new connection" en la solapa "connections"; se abre una ventana en la cual colocamos:

- "connection name" (nombre de la conexión): juan;

- "username" (nombre del usuario): juan y

- "password" (contraseña): juancito.

Luego presionamos "connect"; se abre una nueva solapa (nueva conexión) con el nombre del usuario (juan).

En la conexión de "juan" podemos consultar sus privilegios:

 select username, privilege from user_sys_privs;
Note que únicamente aparecen los permisos del usuario actual.

Para obtener el nombre del usuario conectado, empleamos la siguiente sentencia:

 select user from dual;
Aparece Juan.

Volvemos a la conexión "system" (la otra solapa).

Comprobamos el usuario actual:

 select user from dual;
Aparece System.

Ya sabemos abrir una nueva sessión de usuario. Aprendimos que existen 3 razones por las cuales una nueva sesión no se pueda iniciar; una de ellas es que el usuario no exista. Intentemos abrir una nueva conexión para un usuario inexistente:

Presionamos el ícono "new connection" en la solapa "connections"; se abre una ventana en la cual colocamos:

- "connection name" (nombre de la conexión): pedro;

- "username" (nombre del usuario): pedro y

- "password" (contraseña): pedrito.

Luego presionamos "connect"; la sessión no se abre, un mensaje de error indica que el nombre de usuario o la contraseña son inválidas y que la conexión se deniega.

Cancelamos.

Otra razón por la cual la apertura de una nueva sesión puede fallar es que el usuario no tenga permiso de conexión. Intentemos abrir una nueva conexión para un usuario que no tenga tal permiso, caso de "ana":

Presionamos el ícono "new connection" en la solapa "connections"; se abre una ventana en la cual colocamos:

- "connection name" (nombre de la conexión): ana;

- "username" (nombre del usuario): ana y

- "password" (contraseña): anita.

Luego presionamos "connect"; la sessión no se abre, un mensaje de error indica que el usuario "ana" no tiene permiso "create session" por lo cual se deniega la conexión. Cancelamos.

Concedemos a "ana" permiso de conexión:

 grant create session
  to ana;
Consultamos el diccionario "dba_sys_privs" para encontrar los privilegios concedidos a "ana":

 select grantee,privilege from dba_sys_privs 
  where grantee='ANA';
Tiene permiso "create session".

La tercera razón por la cual puede no iniciarse una nueva sesión es que coloquemos la contraseña incorrecta. Intentemos abrir una nueva conexión para un usuario que tenga permiso, pero le demos una contraseña incorrecta:

Presionamos el ícono "new connection" en la solapa "connections"; se abre una ventana en la cual colocamos:

- "connection name" (nombre de la conexión): ana;

- "username" (nombre del usuario): ana y

- "password" (contraseña): ana.

Luego presionamos "connect"; la sessión no se abre, un mensaje de error indica que el nombre de usuario o la contraseña son inválidas y que la conexión se deniega.

Abramos una nueva conexión para "ana" colocando los datos correctos:

Presionamos el ícono "new connection" en la solapa "connections"; se abre una ventana en la cual colocamos:

- "connection name" (nombre de la conexión): ana;

- "username" (nombre del usuario): ana y

- "password" (contraseña): anita.

Presionamos "connect"; se abre una nueva solapa (nueva conexión) con el nombre del usuario (ana).

Consultamos el diccionario "user_sys_privs":

 select username,privilege from user_sys_privs;
Note que únicamente aparecen los permisos del usuario actual.

Comprobamos que estamos en la sesión de "ana":

 select user from dual;