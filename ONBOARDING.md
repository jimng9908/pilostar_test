# Documentación Técnica Avanzada: Módulo Onboarding

Este documento proporciona una visión profunda y técnica del módulo `business_onboarding`, diseñada para desarrolladores senior. El módulo implementa un flujo orquestado dinámico que utiliza **Clean Architecture** y el patrón **BLoC**.

---

## 📁 Estructura del Módulo

El módulo sigue estrictamente los principios de **Arquitectura Limpia**, desacoplando la lógica de negocio de la infraestructura y la UI.

```text
business_onboarding/
├── data/
│   ├── datasources/         # Implementación de red (business_omboarding_ds.dart)
│   ├── models/              # DTOs y mapeo JSON (16 archivos de Request/Response)
│   └── repositories/        # Implementación de los contratos del dominio
├── domain/
│   ├── entities/            # Objetos de negocio puros (19 entidades)
│   ├── repositories/        # Interfaces/Contratos del repositorio
│   └── usecases/            # Casos de uso atómicos (10 casos: create_venue, etc.)
├── presentation/
│   ├── bloc/                # Lógica de estado (business_onboarding_bloc.dart)
│   ├── pages/               # Contenedores principales (GoogleImportPage, BusinessMethodPage)
│   └── widgets/             # UI modular (26 componentes especializados)
└── di/                      # Inyección de dependencias del módulo
```

### 🗝️ Archivos Clave de Lógica de Negocio

| Archivo | Rol Arquitectónico | Responsabilidad |
| :--- | :--- | :--- |
| `business_onboarding_bloc.dart` | **Presentation (Bloc)** | Orquesta el flujo completo, maneja la navegación persistente y ejecuta los casos de uso secuencialmente. |
| `business_omboarding_ds.dart` | **Data (DataSource)** | Realiza las peticiones `http` crudas a los endpoints de backend (Google Places y Onboarding). |
| `my_business_repository.dart` | **Domain/Data (Repo)** | Interfaz y su implementación que maneja el flujo de datos y convierte excepciones en `Failures`. |
| `usecases/*.dart` | **Domain (UseCase)** | 10 clases especializadas que ejecutan acciones únicas (ej. `CreateVenue`, `SubmitGoals`) garantizando el principio de responsabilidad única. |

---

## 🏗️ Arquitectura y Gestión de Estado

El módulo centraliza su lógica en el `BusinessOnboardingBloc`. A diferencia de un flujo lineal simple, este módulo maneja un estado persistente (`BusinessOnboardingLoaded`) que acumula información a través de múltiples pantallas.

### El Estado: `BusinessOnboardingLoaded`
Este estado es de tipo *value-object* (vía `Equatable`) y contiene:
- **`OnboardingStep`**: Enum que determina la vista actual y la lógica de validación.
- **`OnboardingMethod`**: `automatic` (vía Google) o `manual`. Condiciona la ruta de pasos.
- **`endingStepIndex`**: Un entero (0-5) utilizado para controlar la progresión visual en la "pantalla de configuración final", donde se ejecutan múltiples llamadas asíncronas secuenciales.
- **Acumuladores**: `businessInformations`, `connectedSources`, `selectedServices`, `kpis`, etc.

### Máquina de Estados y Navegación
La navegación no es imperativa desde la UI, sino reactiva desde el Bloc. El evento `BackToPrevious` implementa una lógica de retroceso inteligente basada en el método de onboarding seleccionado y el paso actual:

```dart
// Ejemplo de lógica de navegación selectiva en business_onboarding_bloc.dart
case OnboardingStep.sourcesConfirmed:
  previousStep = OnboardingMethod.manual == data.method
      ? OnboardingStep.manualDataConfirmed
      : OnboardingStep.googleDataConfirmed;
  break;
```

---

## ⚡ Orquestación Secuencial (Finalización)

Uno de los puntos más críticos es el método `_onStartConfiguration` (Manual) y `_onStartAutomaticConfiguration` (Automático). Estos métodos orquestan la creación de múltiples entidades en cascada:

1.  **Conexión de DataSources**: Envío masivo de credenciales.
2.  **Creación de Organización**: Genera el `organizationId`.
3.  **Creación de Compañía**: Depende del `organizationId`.
4.  **Creación de Venue (Local)**: Depende del `companyId` y `organizationId`. Incluye la serialización de `serviceHours` a JSON dinámico.
5.  **Obtención de KPIs**: Recupera indicadores basados en las fuentes conectadas.

Cada paso exitoso incrementa el `endingStepIndex`, permitiendo a la UI mostrar progreso en tiempo real.

---

## 🌐 Especificación Detallada de API

### 1. Búsqueda de Negocios (Google Places)
- **Endpoint**: `GET /google-places/search`
- **Query Params**: `query=Nombre+o+URL`
- **Respuesta (200)**: `List<BusinessInformationModel>`
  - Contiene: `placeId`, `name`, `address`, `phone`, `categories`, `photos`, etc.

### 2. Creación de Organización (Onboarding)
- **Endpoint**: `POST /organizations/onboarding`
- **Request Body**:
```json
{
  "name": "Nombre de la Organización",
  "nif": "CIF/NIF"
}
```
- **Respuesta (201)**: `OrganizationModel` con `id`.

### 3. Creación de Compañía
- **Endpoint**: `POST /companies/onboarding`
- **Request Body**:
```json
{
  "name": "Nombre Comercial",
  "address": "Dirección completa",
  "phone": "600000000",
  "email": "contacto@negocio.com",
  "website": "https://...",
  "organizationId": 123
}
```

### 4. Registro de Venue (Local - Manual)
- **Endpoint**: `POST /venue/onboarding`
- **Payload**:
```json
{
  "name": "Nombre Venue",
  "companyId": 456,
  "organizationId": 123,
  "type": "restaurante",
  "isActive": true,
  "delivery": true,
  "takeaway": false,
  "serviceHours": { "json": { ... } }
}
```

### 5. Importación Automática desde Google
- **Endpoint**: `POST /venue/import-from-google`
- **Payload**:
```json
{
  "placeId": "ChIJ...",
  "venueType": "restaurante",
  "userId": 789,
  "hasTerrace": true,
  "terraceTables": 10,
  "terraceChairs": 40,
  "interiorTables": 15,
  "interiorChairs": 60,
  "delivery": true,
  "takeaway": true
}
```

### 6. Selección de Fuentes de Datos (Data Sources)
- **Endpoint**: `POST /data-sources/select`
- **Request Body** (Lista):
```json
[
  {
    "dataSourceId": 1,
    "apiKey": "optional_key",
    "token": "optional_token",
    "email": "optional_email",
    "password": "optional_password"
  }
]
```

### 7. Obtención de KPIs por Usuario
- **Endpoint**: `POST /k-picore-finance/kpis/by-sources`
- **Request Body**: `{ "userId": 789 }`
- **Respuesta (201)**: `List<KpiModel>` (KPIs disponibles según fuentes conectadas).

### 8. Guardar Preferencias de KPIs
- **Endpoint**: `POST /users/kpi-preferences`
- **Request Body** (Lista):
```json
[
  {
    "kpiId": 101,
    "isActive": true
  }
]
```

### 9. Definición de Objetivos (Goals)
- **Endpoint**: `POST /user-goals`
- **Request Body**:
```json
{
  "userId": 789,
  "monthlySalesTarget": 50000.0,
  "monthlyClientsTarget": 1200.0,
  "averageTicketTarget": 45.0,
  "averageMarginPerDishTarget": 15.0,
  "marginPercentageTarget": 30.0
}
```

---

## 🚨 Manejo de Errores y Resiliencia

- **Clean Arch Separation**: Todas las excepciones del `DataSource` (ej: `ServerException`) se capturan en el `Repository` para ser emitidas como un `Failure` (Dartz `Left`).
- **UI Error Feedback**: El estado `BusinessOnboardingLoaded` contiene flags `hasError` y `errorMessage`. La UI debe reaccionar a estos cambios para mostrar un banner de error sin perder el progreso acumulado en los otros campos.
- **Seguridad**: El token JWT se inyecta en todas las cabeceras vía `Authorization: Bearer [TOKEN]`. El token se recupera desde el `GetLocalUserUsecase`.

---

## � Consideraciones de Implementación

- **Serialización**: Se utiliza `jsonEncode` para estructuras complejas como `serviceHours` antes de ser enviadas al backend.
- **Debouncing**: Las búsquedas en Google Search deberían implementar debouncing en la UI para evitar excesivas llamadas a la API de Places.
- **Cierre del Ciclo**: El flujo termina cuando el estado llega a `OnboardingStep.goalsConfirmed`. En este punto, la UI del `GoogleImportPage` reacciona para navegar al Dashboard principal.
