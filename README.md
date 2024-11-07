# PinApp Challenge

Este projecto representa un challenge técnico para la empresa PinApp.

## Ejecución

Para correr la aplicación, se debe ejecutar el siguiente comando en la raíz del proyecto:

```bash
flutter run --flavor development
```

## Descripción

El proyecto consiste en una aplicación mobile orientada a iOS para obtener post y los comentarios asociados a estos, utilizando la API de JSONPlaceholder.

## Arquitectura

La arquitectura de la aplicación se compone de 3 capas principales:

### Capa de Presentación

La capa de presentación se compone de las siguientes subcapas:

- `View`: Contiene las vistas de la aplicación.
- `Widgets`: Contiene los widgets reutilizables de la aplicación.
- `Cubit`: Contiene los controladores de la aplicación.

### Capa de Dominio

- `Repository`: Contiene las interfaces de los repositorios.
- `Models`: Contiene los modelos de la aplicación.

### Capa de Datos

- `API`: Contiene las clases de la API.

## Dependencias

- `flutter_bloc`: Para la gestión de estados.
- `dio`: Para realizar peticiones HTTP.
- `equatable`: Para comparar objetos de forma más sencilla.
- `fpdart`: Para el manejo de errores con Either.

## Notas de implemetación

- Se utilizó `equatable` y no `freezed` para la comparación de objetos, ya que los modelos eran pocos y sencillos, por lo que opté por ir por una solución más sencilla. Además, el feature de `macros` esta a la vuelta de la esquina, por lo cual no se va a depender más de la generación de código a futuro.
- Se realizó una paginación virtual en la pantalla de posts, ya que el widget `CupertinoListSection` no funciona como el `ListView.builder` de Flutter, cargando todos los elementos de una sola vez.
- Se utilizó `fpdart` para el manejo de errores. Se podría haber utilizado `Either` de `dartz`, pero este paquete esta descontinuado y no se actualiza desde hace varios años.
- El look and feel de la aplicación es muy básico, ya que no se especificaron requerimientos de diseño. Se utilizó el estilo por defecto de iOS para la aplicación, utilizando los widgets de Cupertino.
