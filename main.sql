
SET SERVEROUTPUT ON

BEGIN
   dbms_output.put_line('Comenzando con el borrado de las tablas previas:');
END;/
START D:\SQL\P\borrar.sql;

BEGIN
   dbms_output.put_line('Creando las tablas y secuencias:');
END;/
START D:\SQL\P\tablas.sql;

BEGIN
   dbms_output.put_line('Ejecucion de secuencias:');
END;/
START D:\SQL\P\secuencias.sql;
BEGIN
   dbms_output.put_line('Vistas de la bases:');
END;/
START D:\SQL\P\vistas.sql;

BEGIN
   dbms_output.put_line('Poblado de tablas:');
END;/
START D:\SQL\P\poblado.sql;
