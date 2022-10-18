/*
Una de las tareas al administrar Oracle es permitir el acceso a bases de datos y asignar permisos sobre los objetos que 
conforman una base de datos.

Para conectarnos con un servidor Oracle necesitamos un modo de acceso que incluye los permisos que dispondremos 
durante la conexi�n; estos permisos se definen a partir de un nombre de usuario.

Un USUARIO es un identificador necesario para acceder a una base de datos. Un usuario es un conjunto de permisos que 
se aplican a una conexi�n de base de datos. Un usuario es adem�s propietario de ciertos objetos.

Los PRIVILEGIOS (permisos) especifican qu� operaciones puede realizar un usuario y sobre qu� objetos de la base de 
datos tiene autorizaci�n, es decir, qu� tarea puede realizar con esos objetos y si puede emitir determinadas instrucciones. 
Estas operaciones pueden ser de dos tipos: de sistema y sobre objeto.

Un rol de base de datos es una agrupaci�n de permisos de sistema y de objeto.

Un ROL (role) es un grupo de usuarios; permite agrupar usuarios para aplicarles permisos; as�, al agregar un nuevo usuario 
a la base de datos, no es necesario concederle permiso para cada objeto, sino que lo agregamos a un rol; cuando 
asignamos permisos sobre un objeto al rol, autom�ticamente el permiso afectar� a los usuarios que pertenezcan a tal rol.

Los permisos controlan el acceso a los distintos objetos de una base de datos; pueden concederse a nivel de usuario 
(individualmente) o a nivel de rol (a todos los usuarios de un grupo).

Los permisos que un usuario tiene en una base de datos dependen de los permisos de usuario y de los roles al que 
pertenezca dicho usuario.

Usuarios, roles y permisos son la base de los mecanismos de seguridad de Oracle.
*/