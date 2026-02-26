class MapperPreviousDate {
  static String getPreviousDate(String filterType) {
    final now = DateTime.now();
    int weekDay = now.weekday;

    if (filterType == 'Ayer') {
      weekDay -= 1;
    }

    switch (weekDay) {
      case 1:
        return 'Lunes';
      case 2:
        return 'Martes';
      case 3:
        return 'Miercoles';
      case 4:
        return 'Jueves';
      case 5:
        return 'Viernes';
      case 6:
        return 'Sabado';
      default:
        return 'Domingo';
    }
  }

  static String getVsText(String filterType) {
    switch (filterType) {
      case 'Hoy':
        return '${MapperPreviousDate.getPreviousDate(filterType)} anterior';
      case 'Esta semana':
        return 'semana anterior';
      case 'Este mes':
        return 'mes anterior';
      case 'Ayer':
        return '${MapperPreviousDate.getPreviousDate(filterType)} anterior ';
      default:
        return 'ayer';
    }
  }
}
