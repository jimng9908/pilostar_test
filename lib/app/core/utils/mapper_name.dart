Map<String, String> mapperName(String name) {
  // 1. Limpieza inicial: quitar espacios extra y convertir a lista
  List<String> palabras = name.trim().split(RegExp(r'\s+'));
  
  // 2. Definición de partículas de nombres/apellidos compuestos
  const particulas = {'de', 'del', 'la', 'las', 'lo', 'los', 'y', 'san', 'santa'};

  // 3. Reagrupar palabras que pertenecen a la misma unidad (ej: "de la rosa")
  List<String> unidades = [];
  for (int i = 0; i < palabras.length; i++) {
    String actual = palabras[i];
    
    // Si la unidad actual es una partícula y no es la última palabra,
    // la unimos con la siguiente.
    if (particulas.contains(actual.toLowerCase()) && i + 1 < palabras.length) {
      String unidadCompuesta = actual;
      while (i + 1 < palabras.length && particulas.contains(palabras[i].toLowerCase())) {
        unidadCompuesta += " ${palabras[i + 1]}";
        i++;
      }
      unidades.add(unidadCompuesta);
    } else {
      unidades.add(actual);
    }
  }

  String nombres = "";
  String apellidos = "";

  // 4. Lógica de asignación basada en la cantidad de unidades resultantes
  if (unidades.length <= 2) {
    // Caso: "Pedro Perez"
    nombres = unidades.first;
    apellidos = unidades.length > 1 ? unidades.last : "";
  } else if (unidades.length == 3) {
    // Caso: "Pedro Juan Perez" -> Se asume 2 nombres, 1 apellido (muy común en registros incompletos)
    // Opcionalmente podrías decidir que sea 1 nombre y 2 apellidos.
    nombres = "${unidades[0]} ${unidades[1]}";
    apellidos = unidades[2];
  } else {
    // Caso: "Pedro Juan Perez Gomez" o más
    // Los últimos dos son apellidos, el resto son nombres
    apellidos = "${unidades[unidades.length - 2]} ${unidades[unidades.length - 1]}";
    nombres = unidades.sublist(0, unidades.length - 2).join(" ");
  }

  return {
    "nombres": nombres.trim(),
    "apellidos": apellidos.trim(),
  };
}