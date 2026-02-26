# Documentación del Proyecto: RockstarData

Esta documentación detalla la estructura, arquitectura, tecnologías y funcionalidades principales del proyecto **RockstarData**, una aplicación móvil desarrollada con Flutter.

---

## 🚀 Tecnologías Principales

El proyecto utiliza un stack moderno y profesional para garantizar escalabilidad y mantenimiento:

- **Lenguaje**: Dart 3.x
- **Framework**: Flutter
- **Estado (State Management)**: [BLoC](https://pub.dev/packages/flutter_bloc) (Business Logic Component) para una separación clara entre la lógica y la UI.
- **Arquitectura**: Clean Architecture (Arquitectura Limpia).
- **Inyección de Dependencias**: [GetIt](https://pub.dev/packages/get_it) para la gestión del service locator.
- **Navegación**: [GoRouter](https://pub.dev/packages/go_router) para rutas declarativas y soporte de deep linking.
- **Networking**: [Dio](https://pub.dev/packages/dio) para peticiones HTTP avanzadas.
- **Backend/Servicios**: [Firebase](https://firebase.google.com/) (Auth, Core).
- **Programación Funcional**: [Dartz](https://pub.dev/packages/dartz) para el manejo de errores mediante el tipo `Either`.
- **Persistencia**: [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage) para datos sensibles y tokens.

---

## 🏗️ Arquitectura del Proyecto

El proyecto implementa **Clean Architecture** dividida por capas para facilitar el testing y la modularización. Cada funcionalidad (feature) reside en su propia carpeta bajo `lib/app/features/`.

### Capas por cada Feature:

1.  **Data**: Implementación de Repositorios, Modelos (JSON mapping) y Fuentes de Datos (Remote/Local).
2.  **Domain**: Entidades de negocio, interfaces de Repositorios y Casos de Uso (Usecases). Es la capa más interna y pura.
3.  **Presentation**: UI (Pages, Widgets) y gestión de estado mediante **BLoCs**.
4.  **DI**: Configuración de inyección de dependencias específica para el módulo.

---

## 📁 Estructura de Carpetas

```text
lib/
├── app/
│   ├── core/              # Motor de infraestructura
│   │   ├── config/        # Entorno y configuraciones
│   │   ├── constants/     # Estilos y URLs
│   │   ├── errors/        # Excepciones y fallos
│   │   ├── interceptors/  # Capa de red avanzada
│   │   ├── routes/        # Navegación (GoRouter)
│   │   ├── services/      # Servicios externos
│   │   └── utils/         # Helpers
│   ├── features/          
│   │   ├── auth/          
│   │   ├── business_onboarding/ 
│   │   ├── finanzas/      
│   │   ├── home/          
│   │   ├── profile/       
│   │   └── shared/        # Componentes reutilizables
│   │       ├── domain/    # Entidades compartidas
│   │       └── presentation/ # Widgets y componentes UI
│   ├── injection.dart     
│   └── rockstardata_app.dart 
├── main.dart              
└── firebase_options.dart  
```

---

## 🛠️ Módulos Base

### `core` (Infraestructura y Utilidades)
La carpeta `core` contiene la lógica transversal y la configuración base que soporta a toda la aplicación:
- **`config`**: Configuraciones globales y de entorno.
- **`constants`**: Valores constantes (URLs de API, estilos globales, assets).
- **`errors`**: Definiciones de `Failure` y `Exception` para el manejo uniforme de errores.
- **`interceptors`**: Interceptores de red (Dio) para añadir tokens, logs o manejo de timeouts.
- **`routes`**: Configuración de rutas declarativas con `GoRouter`.
- **`services`**: Servicios externos compartidos (Google Sign-In, Firebase, etc.).
- **`utils`**: Funciones de ayuda independientes del negocio (conversiones de fecha, validadores simples).

### `shared` (Componentes Reutilizables)
Ubicado en `features/shared`, contiene elementos que se consumen en múltiples módulos:
- **`presentation/widgets`**: Biblioteca de widgets comunes como botones premium, inputs personalizados, cards dinámicas y loaders. Centraliza la estética de la app siguiendo los principios de diseño definidos.

---

## 🏗️ Detalle de Módulos y Funcionalidades

### 1. Módulo de Autenticación (`auth`)

Este módulo gestiona el acceso del usuario, permitiendo registro manual, login con email y autenticación social con Google.

#### Capas en Detalle:
- **Data Layer**: 
  - `AuthRemoteDataSourceImpl`: Implementa la lógica de red con `http` y `dio`.
  - `UserModel`, `LoginRequestModel`, `RegisterRequestModel`: Mapeo de datos JSON a tipos de Dart.
- **Domain Layer**:
  - `User`, `RegisterRequest`: Entidades puras de negocio.
  - `LoginUserUsecase`, `RegisterUserUseCases`, etc.: Orquestan la lógica de autenticación.
- **Presentation Layer**:
  - `AuthBloc`: Gestor de estados de autenticación.
  - `LoginPage`, `RegisterPage`: Vistas principales.

#### Contratos de API (JSON):

**1. Login de Usuario**
- **Endpoint**: `POST /auth/login`
- **Request**:
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```
- **Response (200 OK)**:
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**2. Registro de Usuario**
- **Endpoint**: `POST /users`
- **Request**:
```json
{
  "firstName": "John",
  "lastName": "Doe",
  "email": "john.doe@example.com",
  "password": "password123",
  "phone": "+123456789",
  "isActive": true
}
```
- **Response (201 Created)**:
```json
{
  "id": "user_123",
  "firstName": "John",
  "lastName": "Doe",
  "email": "john.doe@example.com"
}
```

**3. Login/Registro con Google**
- **Endpoint**: `POST /auth/google/login` o `/auth/google/register`
- **Request**:
```json
{
  "token": "GOOGLE_ID_TOKEN"
}
```
- **Response (200 OK)**:
```json
{
  "user": {
    "firstName": "John",
    "lastName": "Doe",
    "email": "john.doe@example.com",
    "picture": "https://..."
  },
  "accessToken": "ey..."
}
```

#### Casos de Uso:
- **`LoginUserUsecase`**: Autenticación de usuarios mediante credenciales estándar (email/password).
- **`LoginWithGoogleUseCase`**: Autenticación delegada a Google Auth.
- **`RegisterUserUseCases`**: Creación de nuevas cuentas de usuario.
- **`RegisterWithGoogleUseCase`**: Registro automático utilizando el perfil de Google.
- **`GetLocalUserUsecase`**: Recupera la sesión del usuario del almacenamiento seguro.
- **`SaveLocalUserUsecase`**: Persiste los datos del usuario y el token de acceso.
- **`CleanDataUsecase`**: Limpia la caché y finaliza la sesión localmente.

---

### 2. Módulo de Onboarding de Negocio (`business_onboarding`)

Es un flujo multi-paso diseñado para registrar la información de un negocio, permitiendo importar datos desde Google My Business o ingresarlos manualmente.

#### Capas en Detalle:
- **Data Layer**:
  - `MyBusinessRemoteDataSourceImpl`: Utiliza `GoogleBusinessService` para la integración con APIs externas de Google.
  - `BusinessLocationModel`: Modelo para transformar datos de Google My Business.
- **Domain Layer**:
  - `BusinessLocation`: Entidad que representa un local comercial.
  - `GetMyBusinessLocations`: Caso de uso para recuperar locales.
- **Presentation Layer**:
  - `BusinessOnboardingBloc`: Gestiona el flujo multi-paso.
  - `GoogleImportPage`, `ManualEntryPage`: Vistas del flujo.

#### Contratos de API (Externas - Google):

**1. Obtención de Cuentas GMB**
- **Endpoint**: `GET https://mybusinessaccountmanagement.googleapis.com/v1/accounts`
- **Headers**: `Authorization: Bearer [TOKEN]`
- **Response (Simplified)**:
```json
{
  "accounts": [
    {
      "name": "accounts/123",
      "accountName": "Rockstar Business",
      "type": "PERSONAL",
      "state": { "status": "VERIFIED" }
    }
  ]
}
```

**2. Obtención de Ubicaciones**
- **Endpoint**: `GET https://mybusinessbusinessinformation.googleapis.com/v1/accounts/123/locations`
- **Params**: `readMask=name,title,storeCode,storefrontAddress,metadata`
- **Response (Simplified)**:
```json
{
  "locations": [
    {
      "name": "locations/456",
      "title": "Main Store",
      "storefrontAddress": {
        "addressLines": ["Calle 123"],
        "locality": "Medellín"
      }
    }
  ]
}
```

#### Casos de Uso:
- **`GetMyBusinessLocations`**: Conecta con Google My Business API para recuperar locales existentes y facilitar la importación de datos.

---

### 3. Módulo de Finanzas (`finanzas`)

Módulo encargado de la visualización de datos económicos del negocio mediante gráficos.

**Funcionalidades:**
- Visualización de ingresos/gastos.
- Gráficos interactivos utilizando `fl_chart`.
- Filtros por fechas o categorías.

---

## ⚙️ Configuración del Entorno (Guía rápida)

1.  **Dependencias**: Ejecutar `flutter pub get`.
2.  **Firebase**: Asegurarse de tener configurado el archivo `google-services.json` (Android) y `GoogleService-Info.plist` (iOS).
3.  **Generación de código**: Si usas `json_serializable`, ejecuta:
    `flutter pub run build_runner build --delete-conflicting-outputs`

---
*Última actualización: 14 de enero de 2026*
