# Dragon Ball Explorer App
Esta aplicación de Dragon Ball te permite explorar información detallada sobre personajes, incluyendo sus descripciones y localizaciones. Utiliza diversas tecnologías como Swift, UIKit, CoreData, MapKit y Keychain.

- Características
  Pantalla de Carga:
  
  Al iniciar la aplicación, se muestra una pantalla de carga para preparar los datos.
  Pantalla de Login:
  
  Se requiere autenticación para acceder a la aplicación.
  Los usuarios deben registrarse en la API de Keepcoding para obtener credenciales.
  Lista de Personajes:
  
  Una vez autenticado, se muestra una lista de todos los personajes de Dragon Ball en una UITableView en la tercera pantalla.
  Al tocar un personaje, se accede a la cuarta pantalla para ver detalles.
  Detalles del Personaje:
  
  La cuarta pantalla presenta la descripción completa del personaje seleccionado, junto con su foto.
  Además, se muestra la localización del personaje utilizando MapKit.

- Tecnologías Utilizadas

Swift:
  El lenguaje de programación principal utilizado en la aplicación.

UIKit:
  Utilizado para la creación de interfaces de usuario.

CoreData:
  Base de datos local para almacenar información persistente sobre los personajes.

MapKit:
  Se emplea para mostrar la localización del personaje en un mapa interactivo.

Keychain:
  Almacena de forma segura las credenciales de autenticación del usuario.
