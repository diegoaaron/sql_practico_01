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