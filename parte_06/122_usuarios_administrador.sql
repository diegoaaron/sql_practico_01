/*
Hemos aprendido la sintaxis b�sica para conceder permisos de sistema a los usuarios, mediante la instrucci�n "grant".

Agregando a la sentencia "grant", la cl�usula "with admin option" concedemos permiso para ceder a terceros los privilegios 
de sistema obtenidos. Es decir, la cl�usula "with admin option" permite que el privilegio concedido a un usuario (o rol) pueda 
ser otorgado a otros usuarios por el usuario al que estamos asign�ndoselo; es decir, se concede permiso para conceder el 
permiso obtenido, a otros usuarios.

Sintaxis:

 grant PERMISODESISTEMA
  to USUARIO
 with admin option;
 
En el siguiente ejemplo, concedemos el permiso de crear tablas al usuario "juan" y con "with admin option", el usuario "juan" 
podr� conceder este permiso de crear tablas a otros usuarios:

 grant create table
  to juan
 with admin option;
  
Podemos consultar el diccionario "dba_sys_privs" para encontrar los privilegios concedidos a los usuarios. 
Nos mostrar� una tabla con las siguientes columnas:

- grantee: el nombre del usuario,

- privilege: el permiso y

- admin_option: si el permiso adquirido puede ser cedido a otros o no, YES o NO.
*/