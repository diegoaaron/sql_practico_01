/*
Es posible obligar a todas las instrucciones de modificación de datos que se ejecutan en una vista a cumplir ciertos criterios.

Por ejemplo, creamos la siguiente vista:

 create view vista_empleados
 as
  select apellido, nombre, sexo, seccion
  from empleados
  where seccion='Administracion'
  with check option;
La vista definida anteriormente muestra solamente algunos registros y algunos campos de "empleados", los de la sección "Administracion".

Con la cláusula "with check option", no se permiten modificaciones en aquellos campos que afecten a los registros que retorna la vista. Es decir, 
no podemos modificar el campo "sección" porque al hacerlo, tal registro ya no aparecería en la vista; si podemos actualizar los demás campos. 
Por ejemplo, si intentamos actualizar a "Sistemas" el campo "seccion" de un registro mediante la vista, Oracle muestra un mensaje de error.

La misma restricción surge al ejecutar un "insert" sobre la vista; solamente podemos ingresar registros con el valor "Administracion" para "seccion"; 
si intentamos ingresar un registro con un valor diferente de "Administracion" para el campo "seccion", Oracle mostrará un mensaje de error.

Sintaxis básica:

 create view NOMBREVISTA
  as SUBCONSULTA
  with check option;
*/