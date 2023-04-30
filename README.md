# TOFU_ MOBILITY

## Descripción del proyecto
Aplicación móvil para iPhone que permite gestionar el flujo de flotas de transporte público colectivo. Con la posibilidad de notificar a los conductores si hay algún problema en su ruta o si debe cambiar su transcurso para agilizar el flujo. En este sentido la aplicación permite tener un control en tiempo real de los conductores y los recorridos que hacen. Esta aplicación permite al usuario pasajero conocer el transporte más pronto a su parada y el estado del vehículo, el conductor a bordo, si el transporte es sostenible energéticamente y  si es apto para personas discapacitadas así como la disponibilidad de asientos. Tanto los conductores como los usuarios pueden notificar si hay algún problema con la ruta, ya sea un problema vial o un asalto. Por último, los gestores de las flotas pueden consultar en tiempo real el estado no solo de los camiones sino también de las paradas, para conocer la demanda de transporte y la disponibilidad de los transportes

## Manera de acceder al proyecto
El repositorio está dividido en 2 ramas:
- Main: En esta rama se encuentra el frontend del proyecto orientado hacia los usuarios pasajeros de los transportes públicos y el backend completo con la funcionalidad de los flujos de los usuarios conductores y pasajeros.
- Conductor: En esta rama se encuentra el frontend del proyecto orientado hacia los conductores de los transportes públicos colectivos.

Primero es necesario correr el backend. Se debe agregar una conexión a una base de datos MYSQL dentro de un archivo .env en la variable de entorno DATABASE_URL, después instalar las dependencias utilizadas para el proyecto con npm install y finalmente iniciar la ejecución con el comando npm start. 

Para correr la aplicación de IOS una vez descargado el proyecto es necesario abrirlo con XCode y correrlo.

## Pila tecnológica
- MySQL
- Typescript
- NodeJS
- ExpressJS
- Socket.io
- SwiftUI
