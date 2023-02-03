# Productos
app ios de productos

Desarrolla una aplicación de tipo eCommerce, nativa en iOS que le permita al usuario realizar la búsqueda de productos de un catálogo.
Requisitos de la aplicación
● Permitirle al usuario buscar productos en base a un texto que sea ingresado. La búsqueda se realizará consultando los servicios de Ia API proporcionada.
● Mostrar un listado de los productos que regrese el servicio, cada elemento deberá presentar el titulo, precio y Ia imagen (thumbnail).
● Mantener una lista de las palabras de búsquedas previas realizadas por el usuario. La lista debe mantenerse aun después de reiniciar Ia aplicación.
● Cuidar que Ia interfaz sea amigable, por ejemplo, que no se bloquee mientras se consultan los servicios.
● La aplicación debe poderse ejecutar en iOS 13 y superiores.
● La aplicación debe ser desarrollada con Swift v5 o superior, no se aceptan aplicaciones
en Objective C.
● El diseño de Ia aplicación no es un elemento para calificar, enfócate en cubrir la
funcionalidad solicitada.
Para este reto solo es necesario hacer llamadas al siguiente servicio:
https://00672285.us-south.apigw.appdomain.cloud/demo- gapsi/search?&query=[criterio]&page=[numeropagina]
En donde [criterio] es el termino de búsqueda a utilizar, por ejemplo: “computer”. **IMPORTANTE, considera utilizar palabras en inglés para probar la búsqueda, o marcas como “nintendo”, “sony”, etc.
En donde [numeropagina] es el número de página a consultar. La aplicación debe ir cargando los productos de más páginas que devuelva la búsqueda conforme realiza scroll vertical.
Para poder invocar el servicio, es forzoso que especifiques en el request el header
X-IBM-Client-Id
asignando como valor la llave que te será compartida junto con esta prueba.