# Pilotstar APK

**Nombre del Proyecto:** Pilotstar

## 1. Descripción
Pilotstar es una aplicación móvil avanzada desarrollada con **Flutter** para la gestión de KPIs y datos de negocio. Permite a los dueños de negocios visualizar métricas en tiempo real, gestionar el onboarding de sus locales (incluyendo integración con Google Maps Scrapper) y realizar seguimientos de finanzas y objetivos.

### Funcionalidades clave:
*   **Dashboard Inteligente**: Visualización de ingresos, reservas y ocupación con gráficos dinámicos.
*   **Onboarding de Negocio**: Flujo interactivo para registrar locales manualmente o importarlos desde Google.
*   **Gestión de Finanzas**: Seguimiento detallado de ingresos y gastos.
*   **Seguimiento de Objetivos**: Monitoreo de metas de ventas y clientes mediante indicadores visuales.
*   **Autenticación Segura**: Integración con Firebase Auth y Google Sign-In.

---

## 2. Tecnologías
*   **Lenguaje / Framework**: 
Dart 3.x, 
Flutter

*   **Librerías principales**: 
[BLoC](https://pub.dev/packages/flutter_bloc), 
[GoRouter](https://pub.dev/packages/go_router), 
[Dio](https://pub.dev/packages/dio), 
[GetIt](https://pub.dev/packages/get_it), 
[Equatale](https://pub.dev/packages/equatable)

*   **Base de datos / Servicios**: Firebase (Auth, Core), Google My Business API, Stripe (Pagos)
*   **Herramientas de desarrollo**: Clean Architecture, Repositories, Use Cases
*   **UI/UX**: Google Fonts, Shimmer effects, [fl_chart](https://pub.dev/packages/fl_chart)



## 3. Versiones
*   **Última versión estable**: v1.0.0+1
*   **Versión en desarrollo**: rama `develop`
*   **Rama de producción**: `main`
*   **Versionado**: Basado en SemVer (MAJOR.MINOR.PATCH)

---

## 4. Requisitos Previos
*   **SDK de Dart**: `>=3.0.0 <4.0.0`
*   **Flutter SDK**: `^3.x`
*   **Acceso**: Configuración de Firebase (`google-services.json` / `GoogleService-Info.plist`)
*   **Dependencias**: Ejecutar `flutter pub get`

---

## 5. Instalación y Arranque

### Paso 1: Clonar el repositorio
```bash
git clone https://github.com/rockstardata/pilotstar.git
cd pilotstar
```

### Paso 2: Instalar dependencias
```bash
flutter pub get
```

### Paso 3: Configurar variables de entorno
Asegúrate de tener los archivos de configuración de Firebase en sus respectivas carpetas:
*   `android/app/google-services.json`
*   `ios/Runner/GoogleService-Info.plist`

### Paso 4: Ejecutar proyecto
*   **Desarrollo**:
    ```bash
    flutter run
    ```
*   **Generación de código (si aplica)**:
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

---

## 6. Ramas y Flujo de Trabajo
*   `main`: Producción, código estable y desplegable.
*   `develop`: Integración de nuevas funcionalidades y correcciones.
*   `feature/nombre-feature`: Desarrollo de nuevas características.
*   `bugfix/nombre-bug`: Corrección de errores específicos.

---

## 7. Documentación Adicional
*   [Estructura y Arquitectura](DOCUMENTATION.md)
*   [Guía de Onboarding](ONBOARDING.md)
*   [Módulo de Pagos](PAYMENT_PLANS.md)

---


*Última actualización: 28 de enero de 2026*
