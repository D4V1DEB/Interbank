Para ejecutar sin necesidad del apachenetbeans, solo necesario el .war  (dist/Interbank.war) este se copia en la carpeta xampp/tomcat/webapps/ despues de esto abrir el xampp y correr tomcat esto generar las carpetas y el codigo necesario para poder visualizar el proyecto. Finalmente en el navegador se escribe el comando https://localhost:8080/manager/html  esto mostrara todos los proyectos realizados en tomcat y hacer click en interbank esto desplegara la pagina el 8080 varia despendiendo el puerto establecido por cada uno

Para ejecutar en netbeas es necesario clonar el repositorio y copiar la carpeta Interbank a la carpeta donde se guardan los proyectos de netbeans, luego abrir el proyecto y hacer build del proyecto es necesario MariaDB Java Connector 3.4.1 (.jar) luego de dar build al proyecto este ejecutara automaticamente tomcat y mostrar el enlace del proyecto http://localhost:8080/Interbank esto lo copiamos y lo pegamos en el navegador.  

dentro del proyecto esta el como crear la base de datos, ya es reemplazar con las credenciales necesarias, se adjunta ejemplo de una inercion para probar la funcionabilidad de la pagina web.

-- Insertar un cliente de ejemplo (opcional) para verificacion
INSERT INTO clientes (dni, correo, nombre, celular, claveweb, card_number) 
VALUES ('12345678', 'ejemplo@correo.com', 'Juan Pérez', '987654321', 'clave123', '1234567890123456');
