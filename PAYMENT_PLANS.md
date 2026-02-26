# Documentación Técnica Avanzada: Módulo Payment Plans (Planes de Pago)

Este documento proporciona una visión profunda y técnica del módulo `payment_plans`, diseñada para desarrolladores senior. El módulo gestiona el catálogo de planes de suscripción, la creación de intenciones de pago (Stripe) y la verificación del estado de suscripción del usuario.

---

## 📁 Estructura del Módulo

El módulo sigue estrictamente los principios de **Arquitectura Limpia**, desacoplando la lógica de facturación de la UI.

```text
payment_plans/
├── data/
│   ├── datasources/         # Implementación de red (payment_plans_remote_ds.dart)
│   ├── models/              # DTOs para Planes, Intentos y Estados
│   └── repositories/        # Implementación de los contratos del dominio
├── domain/
│   ├── entities/            # Objetos de negocio (Plan, SubscriptionStatus)
│   ├── repositories/        # Interfaces del repositorio
│   └── usecases/            # Casos de uso (get_plans, create_payment_intent, etc.)
├── presentation/
│   ├── bloc/                # Lógica de estado (payment_plans_bloc.dart)
│   ├── pages/               # Vistas principales de selección y pago
│   └── widgets/             # UI modular (Plan Cards, Payment Forms)
└── di/                      # Inyección de dependencias del módulo
```

### 🗝️ Archivos Clave de Lógica de Negocio

| Archivo | Rol Arquitectónico | Responsabilidad |
| :--- | :--- | :--- |
| `payment_plans_bloc.dart` | **Presentation (Bloc)** | Orquesta la carga de planes, creación de pagos y polling de estado de suscripción. |
| `payment_plans_remote_ds.dart` | **Data (DataSource)** | Realiza las peticiones `http` a los endpoints de suscripciones. |
| `payment_plans_repository.dart` | **Domain/Data (Repo)** | Maneja el flujo de datos y convierte excepciones de servidor en `Failures`. |
| `usecases/*.dart` | **Domain (UseCase)** | Clases para `GetPlans`, `CreatePaymentIntent` y `CheckSubscriptionStatus`. |

---

## 🏗️ Arquitectura y Gestión de Estado

El módulo utiliza el `PaymentPlansBloc` para manejar un ciclo de vida de pago complejo que incluye comunicación con pasarelas externas (Stripe).

### El Estado: `PaymentPlansDataState`
Este estado base persistente contiene:
- **`plans`**: Lista de `PlanModel` disponibles.
- **`currentIndex`**: Índice de navegación en el carrusel de planes.
- **`selectedPlanId`**: ID del plan que el usuario ha seleccionado para comprar.

### Ciclo de Vida del Pago
El Bloc maneja estados específicos para el proceso de transacción:
1.  **`PaymentProcessing`**: Indica que se está iniciando la comunicación con el backend.
2.  **`PaymentIntentCreated`**: Contiene el `clientSecret` necesario para que el SDK de Stripe complete el pago en el frontend.
3.  **`SubscriptionStatusLoaded`**: Estado final que confirma si el usuario ya tiene un plan activo.

---

## ⚡ Orquestación y Polling de Suscripción

Un punto crítico es el método `_onStartPollingSubscriptionStatus`, que se activa tras completar un pago en el frontend:

1.  **Polling Activo**: El Bloc ejecuta un bucle `while` que consulta el endpoint `/subscriptions/status`.
2.  **Estrategia de Reintento**: Realiza hasta **30 intentos** con un intervalo de **2 segundos** entre cada uno (aprox. 1 minuto de espera total).
3.  **Confirmación**: En cuanto `status.hasActivePlan` es `true`, emite `SubscriptionStatusLoaded` para permitir el acceso a las funcionalidades Premium.
4.  **Timeout**: Si tras los intentos no se confirma el pago, emite un error de timeout sugiriendo demora en el procesamiento.

---

## 🌐 Especificación Detallada de API

Todos los endpoints utilizan el prefijo `Constants.baseAuthUrl`.

### 1. Obtener Planes de Suscripción
- **Endpoint**: `GET /subscriptions/plans`
- **Headers**: `Authorization: Bearer [TOKEN]`
- **Respuesta (200)**: `List<PlanModel>`
  - Campos: `id`, `name`, `price`, `description`, `features`, etc.

### 2. Crear Intención de Pago
- **Endpoint**: `POST /subscriptions/create-intent`
- **Payload**:
```json
{
  "planId": 1
}
```
- **Respuesta (201)**: `PaymentIntentModel`
  - Campo clave: `clientSecret` (Ubicado para la integración con Stripe SDK).

### 3. Verificar Estado de Suscripción
- **Endpoint**: `GET /subscriptions/status`
- **Headers**: `Authorization: Bearer [TOKEN]`
- **Respuesta (200)**: `SubscriptionStatusModel`
  - Campos: `hasActivePlan` (bool), `planName`, `expirationDate`.

---

## 🚨 Manejo de Errores y Resiliencia

- **Seguridad**: El token JWT se inyecta dinámicamente recuperándolo de `GetLocalUserUsecase`.
- **Excepciones de Red**: Se utiliza el patrón `Either` (Dartz) para propagar `Failures` desde la capa de datos hasta la UI.
- **Timeout de Pago**: El polling maneja errores de red internos sin romper el bucle, reintentando hasta agotar el tiempo límite.

---

## 💡 Consideraciones de Implementación

- **Integración Stripe**: Este módulo genera el `clientSecret`. La ejecución real del pago (UI de tarjeta) debe delegarse al widget de Stripe que consuma este secreto.
- **Navegación Reactiva**: La UI debe escuchar el estado `SubscriptionStatusLoaded` para redirigir automáticamente al usuario fuera del flujo de pago una vez confirmado.
- **UI de Selección**: El evento `SelectPlanEvent` permite alternar la selección (toggle), facilitando una experiencia de usuario fluida antes de proceder al checkout.
