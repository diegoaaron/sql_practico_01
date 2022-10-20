/*
Los usuarios necesitan permisos para poder acceder a la base de datos y a los objetos de la misma.

Los privilegios pueden ser de dos tipos: del sistema y sobre objetos.

Como m�nimo, un usuario debe tener permiso para conectarse.

El permiso "create session" es un privilegio de sistema.

Para conceder permiso de conexi�n a un usuario empleamos la instrucci�n "grant".

Sintaxis b�sica:

 grant create session
  to USUARIO;
En el siguiente ejemplo concedemos al usuario "juan" permiso para conectarse:

 grant create session to juan;
Podemos consultar el diccionario "dba_sys_privs" para encontrar los privilegios concedidos a los usuarios. Nos mostrar� 
el nombre del usuario (grantee) y el permiso (privilege), entre otra informaci�n que analizaremos pr�ximamente.

Luego de tener permiso para crear sesi�n, puede crear una sesi�n presionando el �cono "new connection" en la solapa "
connections"; se abrir� una ventana en la cual deber� colocar un nombre de conexi�n ("connection name", puede ser el 
mismo nombre de usuario), el nombre del usuario ("username") y la contrase�a ("password"), luego presionar el bot�n 
"connect"; se abrir� una nueva solapa (nueva conexi�n) con el nombre del usuario; no se abrir� la nueva conexi�n si:

a) el usuario para quien quiere abrir una nueva sesi�n no existe,

b) la contrase�a es incorrecta o

c) el usuario existe pero no tiene permiso "create session".

Si consultamos el diccionario "user_sys_privs" obtendremos la misma informaci�n que "dba_sys_privs" pero �nicamente 
del usuario actual.

Podemos averiguar el nombre del usuario conectado con la siguiente sentencia:

 select user from dual;
*/

select user from dual;