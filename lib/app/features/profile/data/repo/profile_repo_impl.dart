import '../../domain/entities/data_source.dart';
import '../../domain/repo/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  @override
  Future<List<ProfileDataSource>> getDataSources() async {
    await Future.delayed(
        const Duration(milliseconds: 800)); // Simulating latency
    return [
      const ProfileDataSource(
        id: 'lastapp',
        title: "LastApp",
        isRequired: true,
        description: "Sistema de punto de ventas",
        status: "Conectado",
        lastSync: "Hace 5m",
        kpis: "4/4",
        kpisList: [
          DataSourceKpi(
            id: 'la_facturacion',
            title: "Facturación total",
            description: "Ingresos totales acumulados",
            isActive: true,
          ),
          DataSourceKpi(
            id: 'la_fact_turno',
            title: "Facturación por turno",
            description: "Distribución de ingresos por franja horaria",
            isActive: true,
          ),
          DataSourceKpi(
            id: 'la_origen',
            title: "Tipo / origen de ingreso",
            description: "Canales de venta (Local, Delivery, Web)",
            isActive: true,
          ),
          DataSourceKpi(
            id: 'la_ticket',
            title: "Ticket medio",
            description: "Gasto promedio por cliente",
            isActive: true,
          ),
        ],
      ),
      const ProfileDataSource(
        id: 'covermanager',
        title: "CoverManager",
        isRequired: true,
        description: "Gestión de reservas",
        status: "Conectado",
        lastSync: "Hace 10m",
        kpis: "5/5",
        kpisList: [
          DataSourceKpi(
            id: 'cm_ocupacion',
            title: "Ocupación del local",
            description: "% de mesas ocupadas sobre el total",
            isActive: true,
          ),
          DataSourceKpi(
            id: 'cm_reservas',
            title: "Total de reservas",
            description: "Volumen diario, semanal, mensual y anual",
            isActive: true,
          ),
          DataSourceKpi(
            id: 'cm_origen',
            title: "Origen de la reserva",
            description: "Plataformas de origen (Web, Teléfono, App)",
            isActive: true,
          ),
          DataSourceKpi(
            id: 'cm_media',
            title: "Media de comensales por reserva",
            description: "Tamaño promedio de los grupos",
            isActive: true,
          ),
          DataSourceKpi(
            id: 'cm_noshows',
            title: "No shows",
            description: "Reservas confirmadas que no se presentaron",
            isActive: true,
          ),
        ],
      ),
      const ProfileDataSource(
        id: 'holded',
        title: "Holded",
        description: "Software de contabilidad",
        status: "Conectado",
        lastSync: "Hace 1h",
        kpis: "13/13",
        hasUnlink: true,
        kpisList: [
          DataSourceKpi(
            id: 'h_ing_gast',
            title: "Ingresos y gastos total",
            description: "Balance general monetario",
            isActive: true,
          ),
          DataSourceKpi(
            id: 'h_benef_mens',
            title: "Beneficio mensual",
            description: "Comparativa consolidada",
            isActive: true,
          ),
          DataSourceKpi(
            id: 'h_mercaderias',
            title: "% Mercaderías",
            description: "Costo de ventas sobre ingresos",
            isActive: true,
          ),
          DataSourceKpi(
            id: 'h_personal',
            title: "% Personal",
            description: "Costo laboral sobre ingresos",
            isActive: true,
          ),
          DataSourceKpi(
            id: 'h_ebitda',
            title: "Beneficio Real (EBITDA)",
            description: "Calculado del Libro Diario",
            isActive: true,
          ),
          DataSourceKpi(
            id: 'h_salud',
            title: "Ratios de Salud",
            description: "Personal y Materia Prima",
            isActive: true,
          ),
          DataSourceKpi(
            id: 'h_tesoreria',
            title: "Saldo de Tesorería",
            description: "Cobros y pagos históricos",
            isActive: true,
          ),
          DataSourceKpi(
            id: 'h_ing_comp',
            title: "Ingresos Totales",
            description: "Comparativa vs período anterior",
            isActive: true,
          ),
          DataSourceKpi(
            id: 'h_top_gastos',
            title: "Top 3 Gastos del Período",
            description: "Principales centros de costo",
            isActive: true,
          ),
          DataSourceKpi(
            id: 'h_deuda_total',
            title: "Deuda Total",
            description: "Ranking de Acreedores",
            isActive: true,
          ),
          DataSourceKpi(
            id: 'h_deuda_banc',
            title: "Deuda Bancaria",
            description: "Largo y corto plazo",
            isActive: true,
          ),
          DataSourceKpi(
            id: 'h_rentabilidad',
            title: "Rentabilidad",
            description: "Margen neto después de impuestos",
            isActive: true,
          ),
          DataSourceKpi(
            id: 'h_cashflow',
            title: "Cash flow",
            description: "Flujo de caja operativo",
            isActive: true,
          ),
        ],
      ),
      const ProfileDataSource(
        id: 'agora',
        title: "Agora",
        description: "Analytics y métricas avanzadas",
        status: "Desconectado",
        lastSync: "Hace 30m",
        kpis: "2/2",
        hasUnlink: true,
        kpisList: [
          DataSourceKpi(
            id: 'ag_analytics',
            title: "Métricas Avanzadas",
            description: "Comportamiento del cliente en tiempo real",
            isActive: true,
          ),
          DataSourceKpi(
            id: 'ag_perf',
            title: "Rendimiento de Ventas",
            description: "Comparativa entre sucursales o periodos",
            isActive: true,
          ),
        ],
      ),
      const ProfileDataSource(
        id: 'skello',
        title: "Skello",
        description: "Gestión de recursos laborales",
        status: "Desconectado",
        lastSync: "Hace 30m",
        kpis: "2/2",
        hasUnlink: true,
        kpisList: [],
      ),
      const ProfileDataSource(
        id: 'google-maps',
        title: "Google Maps Scrapper",
        description: "Reseñas y valoraciones",
        status: "Conectado",
        lastSync: "Hace 2h",
        kpis: "2/2",
        hasUnlink: true,
        kpisList: [
          DataSourceKpi(
            id: 'gm_valoraciones',
            title: "Valoraciones",
            description: "Reseñas medias y feedback de clientes",
            isActive: true,
          ),
          DataSourceKpi(
            id: 'gm_asientos',
            title: "Asientos al aire libre",
            description: "Información de servicios disponibles",
            isActive: true,
          ),
        ],
      ),
      const ProfileDataSource(
        id: 'tspoonlab',
        title: "TspoonLab",
        description: "Gestión de inventarios y recetas",
        status: "Desconectado",
        lastSync: "Hace 1d",
        kpis: "3/3",
        hasUnlink: true,
        kpisList: [
          DataSourceKpi(
            id: 'ts_ratio_personal',
            title: "Ratio personal sobre ventas",
            description: "Eficiencia laboral en cocina",
            isActive: true,
          ),
          DataSourceKpi(
            id: 'ts_escandallos',
            title: "Gestión de Escandallos",
            description: "Control de costes por plato",
            isActive: true,
          ),
          DataSourceKpi(
            id: 'ts_inventario',
            title: "Mermas e Inventario",
            description: "Control de stock crítico",
            isActive: true,
          ),
        ],
      ),
    ];
  }

  @override
  Future<DataSourcesSummary> getSummary() async {
    return const DataSourcesSummary(
      connectedCount: 6,
      totalCount: 6,
      totalKpis: 29,
      lastSync: "15m",
    );
  }
}
