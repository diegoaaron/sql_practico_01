/*
Es posible obligar a todas las instrucciones de modificaci�n de datos que se ejecutan en una vista a cumplir ciertos criterios.

Por ejemplo, creamos la siguiente vista:

 create view vista_empleados
 as
  select apellido, nombre, sexo, seccion
  from empleados
  where seccion='Administracion'
  with check option;
La vista definida anteriormente muestra solamente algunos registros y algunos campos de "empleados", los de la secci�n "Administracion".

Con la cl�usula "with check option", no se permiten modificaciones en aquellos campos que afecten a los registros que retorna la vista. Es decir, 
no podemos modificar el campo "secci�n" porque al hacerlo, tal registro ya no aparecer�a en la vista; si podemos actualizar los dem�s campos. 
Por ejemplo, si intentamos actualizar a "Sistemas" el campo "seccion" de un registro mediante la vista, Oracle muestra un mensaje de error.

La misma restricci�n surge al ejecutar un "insert" sobre la vista; solamente podemos ingresar registros con el valor "Administracion" para "seccion"; 
si intentamos ingresar un registro con un valor diferente de "Administracion" para el campo "seccion", Oracle mostrar� un mensaje de error.

Sintaxis b�sica:

 create view NOMBREVISTA
  as SUBCONSULTA
  with check option;
*/