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

-- Creamos un usuario denominado "ana", con contrase�a "anita", le asignamos espacio en "system" (100M). Antes lo 
-- eliminamos por si existe:

 drop user ana cascade;

 create user ana identified by anita
 default tablespace system
 quota 100M on system;

-- Creamos un usuario denominado "juan", con contrase�a "juancito", le asignamos espacio en "system" (100M). Antes lo 
-- eliminamos por si existe:

 drop user juan cascade;

 create user juan identified by juancito
 default tablespace system
 quota 100M on system;

-- Consultamos el diccionario "dba_users" y analizamos la informaci�n que nos muestra:

 select username, password, default_tablespace, created from dba_users;

-- Verificamos que los usuarios "ana" y "juan" existen.

-- Consultamos el diccionario "dba_sys_privs" para encontrar los privilegios concedidos a nuestros usuarios. Nos mostrar� 
-- el nombre del usuario (grantee) y el permiso (si lo tiene):

select grantee, privilege from dba_sys_privs where GRANTEE='ANA' or grantee='JUAN';

-- Nos muestra que estos usuarios no tienen ning�n privilegio concedido.

-- Concedemos a "juan" permiso para conectarse:

 grant create session to juan;

-- Consultamos el diccionario "dba_sys_privs" para encontrar los privilegios concedidos a "juan":

 select grantee,privilege from dba_sys_privs 
  where grantee='JUAN';

-- Tiene permiso "create session".

-- Abrimos una nueva conexi�n para "juan":

-- Presionamos el �cono "new connection" en la solapa "connections"; se abre una ventana en la cual colocamos:

-- "connection name" (nombre de la conexi�n): juan;
-- "username" (nombre del usuario): juan y

-- "password" (contrase�a): juancito.

-- Luego presionamos "connect"; se abre una nueva solapa (nueva conexi�n) con el nombre del usuario (juan).

-- En la conexi�n de "juan" podemos consultar sus privilegios:

 select username, privilege from user_sys_privs;

-- Note que �nicamente aparecen los permisos del usuario actual.

-- Para obtener el nombre del usuario conectado, empleamos la siguiente sentencia:

 select user from dual;

-- Aparece Juan.

-- Volvemos a la conexi�n "system" (la otra solapa).

-- Comprobamos el usuario actual:

 select user from dual;

-- Aparece System.

-- Ya sabemos abrir una nueva sessi�n de usuario. Aprendimos que existen 3 razones por las cuales una nueva sesi�n no 
-- se pueda iniciar; una de ellas es que el usuario no exista. Intentemos abrir una nueva conexi�n para un usuario inexistente:

-- Presionamos el �cono "new connection" en la solapa "connections"; se abre una ventana en la cual colocamos:

-- "connection name" (nombre de la conexi�n): pedro;

-- "username" (nombre del usuario): pedro y

-- "password" (contrase�a): pedrito.

-- Luego presionamos "connect"; la sessi�n no se abre, un mensaje de error indica que el nombre de usuario o la contrase�a 
-- son inv�lidas y que la conexi�n se deniega.

-- Cancelamos.

-- Otra raz�n por la cual la apertura de una nueva sesi�n puede fallar es que el usuario no tenga permiso de conexi�n. 
-- Intentemos abrir una nueva conexi�n para un usuario que no tenga tal permiso, caso de "ana":

-- Presionamos el �cono "new connection" en la solapa "connections"; se abre una ventana en la cual colocamos:

-- "connection name" (nombre de la conexi�n): ana;

-- "username" (nombre del usuario): ana y

-- "password" (contrase�a): anita.

-- Luego presionamos "connect"; la sessi�n no se abre, un mensaje de error indica que el usuario "ana" no tiene permiso 
-- "create session" por lo cual se deniega la conexi�n. Cancelamos.

-- Concedemos a "ana" permiso de conexi�n:

 grant create session to ana;

-- Consultamos el diccionario "dba_sys_privs" para encontrar los privilegios concedidos a "ana":

 select grantee,privilege from dba_sys_privs 
  where grantee='ANA';

-- Tiene permiso "create session".

-- La tercera raz�n por la cual puede no iniciarse una nueva sesi�n es que coloquemos la contrase�a incorrecta. Intentemos 
-- abrir una nueva conexi�n para un usuario que tenga permiso, pero le demos una contrase�a incorrecta:

-- Presionamos el �cono "new connection" en la solapa "connections"; se abre una ventana en la cual colocamos:

-- "connection name" (nombre de la conexi�n): ana;

-- "username" (nombre del usuario): ana y

-- "password" (contrase�a): ana.

-- Luego presionamos "connect"; la sessi�n no se abre, un mensaje de error indica que el nombre de usuario o la 
-- contrase�a son inv�lidas y que la conexi�n se deniega.
-- Abramos una nueva conexi�n para "ana" colocando los datos correctos:

-- Presionamos el �cono "new connection" en la solapa "connections"; se abre una ventana en la cual colocamos:

-- "connection name" (nombre de la conexi�n): ana;
-- "username" (nombre del usuario): ana y
-- "password" (contrase�a): anita.

-- Presionamos "connect"; se abre una nueva solapa (nueva conexi�n) con el nombre del usuario (ana).
-- Consultamos el diccionario "user_sys_privs":

 select username,privilege from user_sys_privs;

-- Note que �nicamente aparecen los permisos del usuario actual.

-- Comprobamos que estamos en la sesi�n de "ana":

 select user from dual;
 
 --  Ejercicio 1
 
 -- Con�ctese como administrador (por ejemplo "system").
-- Elimine el usuario "director", porque si existe, aparecer� un mensaje de error:

 drop user director cascade;

-- Cree un usuario "director", con contrase�a "dire" y 100M de espacio en "system"

 create user director identified by dire
 default tablespace system
 quota 100M on system;

-- Elimine el usuario "profesor":

 drop user profesor cascade;

-- Cree un usuario "profesor", con contrase�a "profe" y espacio en "system"

 create user profesor identified by maestro
 default tablespace system;

-- Elimine el usuario "alumno" y luego cr�elo con contrase�a "alu" y espacio en "system"

 drop user alumno cascade;

 create user alumno identified by alu
 default tablespace system;

-- Consulte el diccionario "dba_users" y analice la informaci�n que nos muestra
-- Deben aparecer los tres usuarios creados anteriormente.

 select username, password, default_tablespace, created from dba_users;

-- Consulte el diccionario "dba_sys_privs" para encontrar los privilegios concedidos a nuestros tres usuarios
-- Nos muestra que estos usuarios no tienen ning�n privilegio concedido.

 select grantee, privilege from dba_sys_privs where GRANTEE='DIRECTOR' or grantee='PROFESOR' or grantee='ALUMNO';

-- Conceda a "director" permiso para conectarse

 grant create session
  to director;

-- Conceda a "profesor" permiso para conectarse

grant create session
  to profesor;

-- Consulte el diccionario "dba_sys_privs" para encontrar los privilegios concedidos a nuestros 3 usuarios
-- "director" y "profesor" tienen permiso "create session".

 select grantee,privilege from dba_sys_privs 
  where grantee='DIRECTOR' or grantee='PROFESOR' or grantee='ALUMNO';

-- Abra una nueva conexi�n para "director". Se debe abrir una nueva solapa (nueva conexi�n) con el nombre del 
-- usuario (director)
-- En la conexi�n de "director" consulte sus privilegios

 select username, privilege from user_sys_privs;

-- Obtenga el nombre del usuario conectado

 select user from dual;

-- Vuelva a la conexi�n "system" (la otra solapa) y compruebe el usuario actual

 select user from dual;

-- Intente abrir una nueva conexi�n para el usuario inexistente. Debe aparecer un mensaje de error y denegarse la conexi�n. 
-- Cancele.

-- Intente abrir una nueva conexi�n para el usuario "profesor" colocando una contrase�a incorrecta. Debe aparecer un mensaje 
-- de error y denegarse la conexi�n. Cancele.

-- Abra una nueva conexi�n para "profesor" colocando los datos correctos. Se debe abrir una nueva solapa (nueva conexi�n) 
-- con el nombre del usuario (profesor).

-- Intentemos abrir una nueva conexi�n para el usuario "alumno", el cual no tiene permiso. Un mensaje de error indica que el 
-- usuario "alumno" no tiene permiso "create session" por lo cual se deniega la conexi�n. Cancele.

-- Conceda a "alumno" permiso de conexi�n

 grant create session
  to alumno;

-- Consulte el diccionario "dba_sys_privs" para encontrar los privilegios concedidos a "alumno"

 select grantee,privilege from dba_sys_privs 
  where grantee='ALUMNO';

-- Abra una nueva conexi�n para "ALUMNO". Se debe abrir una nueva solapa (nueva conexi�n) con el nombre del usuario 
-- (profesor)
-- Consulte el diccionario "user_sys_privs"

 select username,privilege from user_sys_privs;

-- Compruebe que est� en la sesi�n de "alumno"

 select user from dual;

