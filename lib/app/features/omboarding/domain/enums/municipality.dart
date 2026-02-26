enum Municipality {
  abadia,
  abertura,
  acebo,
  acehuche,
  cerviaDeTer,
  cistella,
  colera,
  collsuspina,
  elOlivar,
  elOrdial,
  elOso,
  elPapiol,
  elPlaDelPenedes,
  elPontDeVilomaraIRocafort,
  elPratDeLlobregat,
  elRobledo,
  elsPratsDeRei,
  laNouDeBergueda,
  laOlmedaDeJadraque,
  laPalmaDeCervello,
  laPoblaDeClaramunt,
  laPoblaDeLillet,
  laQuar,
  laRocaDelValles,
  lasNavasDeJadraque,
  lasNavasDelMarques,
  losPozuelosDeCalatrava,
  manzanares,
  membrilla,
  mestanza,
  miguelturra,
  mirabueno,
  miralrio,
  mochales,
  mohernando,
  molinaDeAragon,
  monasterio,
  mondejar,
  monsalupe,
  montarron,
  montiel,
  montmajor,
  montmaneu,
  montmelo,
  montornesDelValles,
  montseny,
  moralDeCalatrava,
  moralejaDeMatacabras,
  moratillaDeLosMeleros,
  morenilla,
  muduex,
  muntanyola,
  munana,
  munico,
  munogalindo,
  munogrande,
  munomerDelPeco,
  munopepe,
  munosancho,
  munotello,
  mura,
  narrillosDelAlamo,
  narrillosDelRebollar,
  narrosDeSalduena,
  narrosDelCastillo,
  narrosDelPuerto,
  navaDeArevalo,
  navaDelBarco,
  navacepedillaDeCorneja,
  navadijos,
  navaescurial,
  navahondilla,
  navalacruz,
  navalmoral,
  navalonguilla,
  navalosa,
  navalperalDePinares,
  navalperalDeTormes,
  navalpino,
  navaluenga,
  navaquesera,
  navarcles,
  navarredondaDeGredos,
  navarredondilla,
  navarrevisca,
  navasDeEstena,
  navas,
  navatalgordo,
  navatejares,
  negredo,
  neilaDeSanMiguel,
  niharra,
  ocentejo,
  odena,
  ojosAlbos,
  olerdola,
  olesaDeBonesvalls,
  olesaDeMontserrat,
  olivella,
  olmedaDeCobeta,
  olost,
  olvan,
  orbita,
  orea,
  oris,
  orista,
  orpi,
  orrius,
  pacsDelPenedes,
  padiernos,
  pajaresDeAdaja,
  palaciosDeGoda,
  palafolls,
  palauSolitaIPlegamans,
  palleja,
  paretsDelValles,
  pedroMunoz,
  perafita,
  picon,
  piedrabuena,
  piera,
  pinedaDeMar,
  poblete,
  polinya,
  pontons,
  porzuna,
  pozueloDeCalatrava,
  pratsDeLlucanes,
  premiaDeDalt,
  premiaDeMar,
  pueblaDeDonRodrigo,
  pueblaDelPrincipe,
  puertoLapice,
  puertollano,
  puigReig,
  puigdalber,
  pujalt,
  rajadell,
  rellinars,
  retuertaDelBullaque,
  ripollet,
  rodaDeTer,
  rubi,
  rubio,
  ruidera,
  rupitIPruit,
  rute,
  sabadell,
  saceruela,
  sagas,
  saldes,
  sanCarlosDelValle,
  sanLorenzoDeCalatrava,
  santaCruzDeLosCanamos,
  santpedor,
  una,
  villadiego,
  villaescusaDeRoa,
  villaescusaLaSombria,
  villaespasa,
  villafrancaMontesDeOca,
  villafruela,
  villagalijo,
  villagonzaloPedernales,
  villahoz,
  villalbaDeDuero,
  villalbillaDeBurgos,
  villalbillaDeGumiel,
  villaldemiro,
  villalmanzo,
  villamayorDeLosMontes,
  villamayorDeTrevino,
  villambistia,
  villamedianilla,
  villamielDeLaSierra,
  villangomez,
  villanuevaDeArgano,
  villanuevaDeCarazo,
  villanuevaDeGumiel,
  villanuevaDeTeba,
  villaquiranDeLaPuebla,
  villaquiranDeLosInfantes,
  villarcayoDeMerindadDeCastillaLaVieja,
  villariezo,
  villasandino,
  villasurDeHerreros,
  villatuelda,
  villaverdeDelMonte,
  villaverdeMogina,
  villayernoMorquillas,
  villazopeque,
  villegas,
  villoruebo,
  viloriaDeRioja,
  vilviestreDelPinar,
  vizcainos,
  zael,
  zarzosaDeRioPisuerga,
  zazuar,
  zuneda;
}

extension MunicipalityParsing on String {
  /// Convierte un string al valor del enum Municipality correspondiente
  /// basado en el nombre mostrado (displayName)
  Municipality? toMunicipality() {
    return Municipality.values.firstWhere(
      (municipality) =>
          municipality.displayName.toLowerCase() == toLowerCase().trim(),
      orElse: () => throw Exception('Municipio no encontrado: $this'),
    );
  }
}

extension MunicipalityProvince on Municipality {
  /// Obtiene la provincia del municipio
  String get provinceName {
    switch (this) {
      // Cáceres (70)
      case Municipality.abadia:
      case Municipality.abertura:
      case Municipality.acebo:
      case Municipality.acehuche:
        return 'Cáceres';

      // Barcelona (69)
      case Municipality.cerviaDeTer:
      case Municipality.cistella:
      case Municipality.colera:
      case Municipality.collsuspina:
      case Municipality.elPapiol:
      case Municipality.elPlaDelPenedes:
      case Municipality.elPontDeVilomaraIRocafort:
      case Municipality.elPratDeLlobregat:
      case Municipality.elsPratsDeRei:
      case Municipality.laNouDeBergueda:
      case Municipality.laPalmaDeCervello:
      case Municipality.laPoblaDeClaramunt:
      case Municipality.laPoblaDeLillet:
      case Municipality.laQuar:
      case Municipality.laRocaDelValles:
      case Municipality.montmajor:
      case Municipality.montmaneu:
      case Municipality.montmelo:
      case Municipality.montornesDelValles:
      case Municipality.montseny:
      case Municipality.muntanyola:
      case Municipality.mura:
      case Municipality.navarcles:
      case Municipality.navas:
      case Municipality.odena:
      case Municipality.olerdola:
      case Municipality.olesaDeBonesvalls:
      case Municipality.olesaDeMontserrat:
      case Municipality.olivella:
      case Municipality.olost:
      case Municipality.olvan:
      case Municipality.oris:
      case Municipality.orista:
      case Municipality.orpi:
      case Municipality.orrius:
      case Municipality.pacsDelPenedes:
      case Municipality.palafolls:
      case Municipality.palauSolitaIPlegamans:
      case Municipality.palleja:
      case Municipality.paretsDelValles:
      case Municipality.perafita:
      case Municipality.piera:
      case Municipality.pinedaDeMar:
      case Municipality.polinya:
      case Municipality.pontons:
      case Municipality.pratsDeLlucanes:
      case Municipality.premiaDeDalt:
      case Municipality.premiaDeMar:
      case Municipality.puigReig:
      case Municipality.puigdalber:
      case Municipality.pujalt:
      case Municipality.rajadell:
      case Municipality.rellinars:
      case Municipality.ripollet:
      case Municipality.rodaDeTer:
      case Municipality.rubi:
      case Municipality.rubio:
      case Municipality.rupitIPruit:
      case Municipality.sabadell:
      case Municipality.sagas:
      case Municipality.saldes:
      case Municipality.santpedor:
        return 'Barcelona';

      // Ciudad Real / Guadalajara (68)
      case Municipality.elOlivar:
      case Municipality.elOrdial:
      case Municipality.elRobledo:
      case Municipality.laOlmedaDeJadraque:
      case Municipality.lasNavasDeJadraque:
      case Municipality.losPozuelosDeCalatrava:
      case Municipality.manzanares:
      case Municipality.membrilla:
      case Municipality.mestanza:
      case Municipality.miguelturra:
      case Municipality.mirabueno:
      case Municipality.miralrio:
      case Municipality.mochales:
      case Municipality.mohernando:
      case Municipality.molinaDeAragon:
      case Municipality.monasterio:
      case Municipality.montarron:
      case Municipality.montiel:
      case Municipality.mondejar:
      case Municipality.moralDeCalatrava:
      case Municipality.moratillaDeLosMeleros:
      case Municipality.morenilla:
      case Municipality.muduex:
      case Municipality.navalpino:
      case Municipality.navasDeEstena:
      case Municipality.negredo:
      case Municipality.ocentejo:
      case Municipality.olmedaDeCobeta:
      case Municipality.orea:
      case Municipality.pedroMunoz:
      case Municipality.picon:
      case Municipality.piedrabuena:
      case Municipality.poblete:
      case Municipality.porzuna:
      case Municipality.pozueloDeCalatrava:
      case Municipality.pueblaDeDonRodrigo:
      case Municipality.pueblaDelPrincipe:
      case Municipality.puertoLapice:
      case Municipality.puertollano:
      case Municipality.retuertaDelBullaque:
      case Municipality.ruidera:
      case Municipality.saceruela:
      case Municipality.sanCarlosDelValle:
      case Municipality.sanLorenzoDeCalatrava:
      case Municipality.santaCruzDeLosCanamos:
      case Municipality.una:
        return 'Ciudad Real / Guadalajara';

      // Ávila / Burgos (67)
      case Municipality.elOso:
      case Municipality.lasNavasDelMarques:
      case Municipality.monsalupe:
      case Municipality.moralejaDeMatacabras:
      case Municipality.munana:
      case Municipality.munico:
      case Municipality.munogalindo:
      case Municipality.munogrande:
      case Municipality.munomerDelPeco:
      case Municipality.munopepe:
      case Municipality.munosancho:
      case Municipality.munotello:
      case Municipality.narrillosDelAlamo:
      case Municipality.narrillosDelRebollar:
      case Municipality.narrosDeSalduena:
      case Municipality.narrosDelCastillo:
      case Municipality.narrosDelPuerto:
      case Municipality.navaDeArevalo:
      case Municipality.navaDelBarco:
      case Municipality.navacepedillaDeCorneja:
      case Municipality.navadijos:
      case Municipality.navaescurial:
      case Municipality.navahondilla:
      case Municipality.navalacruz:
      case Municipality.navalmoral:
      case Municipality.navalonguilla:
      case Municipality.navalosa:
      case Municipality.navalperalDePinares:
      case Municipality.navalperalDeTormes:
      case Municipality.navaluenga:
      case Municipality.navaquesera:
      case Municipality.navarredondaDeGredos:
      case Municipality.navarredondilla:
      case Municipality.navarrevisca:
      case Municipality.navatalgordo:
      case Municipality.navatejares:
      case Municipality.neilaDeSanMiguel:
      case Municipality.niharra:
      case Municipality.ojosAlbos:
      case Municipality.orbita:
      case Municipality.padiernos:
      case Municipality.pajaresDeAdaja:
      case Municipality.palaciosDeGoda:
      case Municipality.villadiego:
      case Municipality.villaescusaDeRoa:
      case Municipality.villaescusaLaSombria:
      case Municipality.villaespasa:
      case Municipality.villafrancaMontesDeOca:
      case Municipality.villafruela:
      case Municipality.villagalijo:
      case Municipality.villagonzaloPedernales:
      case Municipality.villahoz:
      case Municipality.villalbaDeDuero:
      case Municipality.villalbillaDeBurgos:
      case Municipality.villalbillaDeGumiel:
      case Municipality.villaldemiro:
      case Municipality.villalmanzo:
      case Municipality.villamayorDeLosMontes:
      case Municipality.villamayorDeTrevino:
      case Municipality.villambistia:
      case Municipality.villamedianilla:
      case Municipality.villamielDeLaSierra:
      case Municipality.villangomez:
      case Municipality.villanuevaDeArgano:
      case Municipality.villanuevaDeCarazo:
      case Municipality.villanuevaDeGumiel:
      case Municipality.villanuevaDeTeba:
      case Municipality.villaquiranDeLaPuebla:
      case Municipality.villaquiranDeLosInfantes:
      case Municipality.villarcayoDeMerindadDeCastillaLaVieja:
      case Municipality.villariezo:
      case Municipality.villasandino:
      case Municipality.villasurDeHerreros:
      case Municipality.villatuelda:
      case Municipality.villaverdeDelMonte:
      case Municipality.villaverdeMogina:
      case Municipality.villayernoMorquillas:
      case Municipality.villazopeque:
      case Municipality.villegas:
      case Municipality.villoruebo:
      case Municipality.viloriaDeRioja:
      case Municipality.vilviestreDelPinar:
      case Municipality.vizcainos:
      case Municipality.zael:
      case Municipality.zarzosaDeRioPisuerga:
      case Municipality.zazuar:
      case Municipality.zuneda:
        return 'Ávila / Burgos';

      // Córdoba (61)
      case Municipality.rute:
        return 'Córdoba';
    }
  }

  /// Obtiene la provincia específica (cuando hay ambigüedad)
  String get specificProvinceName {
    // Ávila
    if (_isAvila()) return 'Ávila';
    // Burgos
    if (_isBurgos()) return 'Burgos';
    // Ciudad Real
    if (_isCiudadReal()) return 'Ciudad Real';
    // Guadalajara
    if (_isGuadalajara()) return 'Guadalajara';
    // Barcelona
    if (zoneCode == '69') return 'Barcelona';
    // Cáceres
    if (zoneCode == '70') return 'Cáceres';
    // Córdoba
    if (zoneCode == '61') return 'Córdoba';
    
    return provinceName;
  }

  bool _isAvila() {
    switch (this) {
      case Municipality.elOso:
      case Municipality.lasNavasDelMarques:
      case Municipality.monsalupe:
      case Municipality.moralejaDeMatacabras:
      case Municipality.munana:
      case Municipality.munico:
      case Municipality.munogalindo:
      case Municipality.munogrande:
      case Municipality.munomerDelPeco:
      case Municipality.munopepe:
      case Municipality.munosancho:
      case Municipality.munotello:
      case Municipality.narrillosDelAlamo:
      case Municipality.narrillosDelRebollar:
      case Municipality.narrosDeSalduena:
      case Municipality.narrosDelCastillo:
      case Municipality.narrosDelPuerto:
      case Municipality.navaDeArevalo:
      case Municipality.navaDelBarco:
      case Municipality.navacepedillaDeCorneja:
      case Municipality.navadijos:
      case Municipality.navaescurial:
      case Municipality.navahondilla:
      case Municipality.navalacruz:
      case Municipality.navalmoral:
      case Municipality.navalonguilla:
      case Municipality.navalosa:
      case Municipality.navalperalDePinares:
      case Municipality.navalperalDeTormes:
      case Municipality.navaluenga:
      case Municipality.navaquesera:
      case Municipality.navarredondaDeGredos:
      case Municipality.navarredondilla:
      case Municipality.navarrevisca:
      case Municipality.navatalgordo:
      case Municipality.navatejares:
      case Municipality.neilaDeSanMiguel:
      case Municipality.niharra:
      case Municipality.ojosAlbos:
      case Municipality.orbita:
      case Municipality.padiernos:
      case Municipality.pajaresDeAdaja:
      case Municipality.palaciosDeGoda:
        return true;
      default:
        return false;
    }
  }

  bool _isBurgos() {
    switch (this) {
      case Municipality.villadiego:
      case Municipality.villaescusaDeRoa:
      case Municipality.villaescusaLaSombria:
      case Municipality.villaespasa:
      case Municipality.villafrancaMontesDeOca:
      case Municipality.villafruela:
      case Municipality.villagalijo:
      case Municipality.villagonzaloPedernales:
      case Municipality.villahoz:
      case Municipality.villalbaDeDuero:
      case Municipality.villalbillaDeBurgos:
      case Municipality.villalbillaDeGumiel:
      case Municipality.villaldemiro:
      case Municipality.villalmanzo:
      case Municipality.villamayorDeLosMontes:
      case Municipality.villamayorDeTrevino:
      case Municipality.villambistia:
      case Municipality.villamedianilla:
      case Municipality.villamielDeLaSierra:
      case Municipality.villangomez:
      case Municipality.villanuevaDeArgano:
      case Municipality.villanuevaDeCarazo:
      case Municipality.villanuevaDeGumiel:
      case Municipality.villanuevaDeTeba:
      case Municipality.villaquiranDeLaPuebla:
      case Municipality.villaquiranDeLosInfantes:
      case Municipality.villarcayoDeMerindadDeCastillaLaVieja:
      case Municipality.villariezo:
      case Municipality.villasandino:
      case Municipality.villasurDeHerreros:
      case Municipality.villatuelda:
      case Municipality.villaverdeDelMonte:
      case Municipality.villaverdeMogina:
      case Municipality.villayernoMorquillas:
      case Municipality.villazopeque:
      case Municipality.villegas:
      case Municipality.villoruebo:
      case Municipality.viloriaDeRioja:
      case Municipality.vilviestreDelPinar:
      case Municipality.vizcainos:
      case Municipality.zael:
      case Municipality.zarzosaDeRioPisuerga:
      case Municipality.zazuar:
      case Municipality.zuneda:
        return true;
      default:
        return false;
    }
  }

  bool _isCiudadReal() {
    switch (this) {
      case Municipality.manzanares:
      case Municipality.membrilla:
      case Municipality.mestanza:
      case Municipality.miguelturra:
      case Municipality.montiel:
      case Municipality.moralDeCalatrava:
      case Municipality.navalpino:
      case Municipality.navasDeEstena:
      case Municipality.pedroMunoz:
      case Municipality.picon:
      case Municipality.piedrabuena:
      case Municipality.poblete:
      case Municipality.porzuna:
      case Municipality.pozueloDeCalatrava:
      case Municipality.losPozuelosDeCalatrava:
      case Municipality.pueblaDeDonRodrigo:
      case Municipality.pueblaDelPrincipe:
      case Municipality.puertoLapice:
      case Municipality.puertollano:
      case Municipality.retuertaDelBullaque:
      case Municipality.elRobledo:
      case Municipality.ruidera:
      case Municipality.saceruela:
      case Municipality.sanCarlosDelValle:
      case Municipality.sanLorenzoDeCalatrava:
      case Municipality.santaCruzDeLosCanamos:
        return true;
      default:
        return false;
    }
  }

  bool _isGuadalajara() {
    switch (this) {
      case Municipality.elOlivar:
      case Municipality.elOrdial:
      case Municipality.laOlmedaDeJadraque:
      case Municipality.lasNavasDeJadraque:
      case Municipality.mirabueno:
      case Municipality.miralrio:
      case Municipality.mochales:
      case Municipality.mohernando:
      case Municipality.molinaDeAragon:
      case Municipality.monasterio:
      case Municipality.montarron:
      case Municipality.mondejar:
      case Municipality.moratillaDeLosMeleros:
      case Municipality.morenilla:
      case Municipality.muduex:
      case Municipality.negredo:
      case Municipality.ocentejo:
      case Municipality.olmedaDeCobeta:
      case Municipality.orea:
      case Municipality.una:
        return true;
      default:
        return false;
    }
  }

  /// Obtiene la comunidad autónoma del municipio
  String get autonomousCommunity {
    switch (zoneCode) {
      case '61':
        return 'Andalucía';
      case '67':
        if (_isAvila()) return 'Castilla y León';
        if (_isBurgos()) return 'Castilla y León';
        return 'Castilla y León';
      case '68':
        if (_isCiudadReal()) return 'Castilla-La Mancha';
        if (_isGuadalajara()) return 'Castilla-La Mancha';
        return 'Castilla-La Mancha';
      case '69':
        return 'Cataluña';
      case '70':
        return 'Extremadura';
      default:
        return '';
    }
  }
}

extension MunicipalityDisplayName on Municipality {
  String get displayName {
    switch (this) {
      case Municipality.abadia:
        return 'Abadía';
      case Municipality.abertura:
        return 'Abertura';
      case Municipality.acebo:
        return 'Acebo';
      case Municipality.acehuche:
        return 'Acehúche';
      case Municipality.cerviaDeTer:
        return 'Cervià de Ter';
      case Municipality.cistella:
        return 'Cistella';
      case Municipality.colera:
        return 'Colera';
      case Municipality.collsuspina:
        return 'Collsuspina';
      case Municipality.elOlivar:
        return 'El Olivar';
      case Municipality.elOrdial:
        return 'El Ordial';
      case Municipality.elOso:
        return 'El Oso';
      case Municipality.elPapiol:
        return 'El Papiol';
      case Municipality.elPlaDelPenedes:
        return 'El Pla del Penedès';
      case Municipality.elPontDeVilomaraIRocafort:
        return 'El Pont de Vilomara i Rocafort';
      case Municipality.elPratDeLlobregat:
        return 'El Prat de Llobregat';
      case Municipality.elRobledo:
        return 'El Robledo';
      case Municipality.elsPratsDeRei:
        return 'Els Prats de Rei';
      case Municipality.laNouDeBergueda:
        return 'La Nou de Berguedà';
      case Municipality.laOlmedaDeJadraque:
        return 'La Olmeda de Jadraque';
      case Municipality.laPalmaDeCervello:
        return 'La Palma de Cervelló';
      case Municipality.laPoblaDeClaramunt:
        return 'La Pobla de Claramunt';
      case Municipality.laPoblaDeLillet:
        return 'La Pobla de Lillet';
      case Municipality.laQuar:
        return 'La Quar';
      case Municipality.laRocaDelValles:
        return 'La Roca del Vallès';
      case Municipality.lasNavasDeJadraque:
        return 'Las Navas de Jadraque';
      case Municipality.lasNavasDelMarques:
        return 'Las Navas del Marqués';
      case Municipality.losPozuelosDeCalatrava:
        return 'Los Pozuelos de Calatrava';
      case Municipality.manzanares:
        return 'Manzanares';
      case Municipality.membrilla:
        return 'Membrilla';
      case Municipality.mestanza:
        return 'Mestanza';
      case Municipality.miguelturra:
        return 'Miguelturra';
      case Municipality.mirabueno:
        return 'Mirabueno';
      case Municipality.miralrio:
        return 'Miralrío';
      case Municipality.mochales:
        return 'Mochales';
      case Municipality.mohernando:
        return 'Mohernando';
      case Municipality.molinaDeAragon:
        return 'Molina de Aragón';
      case Municipality.monasterio:
        return 'Monasterio';
      case Municipality.mondejar:
        return 'Mondéjar';
      case Municipality.monsalupe:
        return 'Monsalupe';
      case Municipality.montarron:
        return 'Montarrón';
      case Municipality.montiel:
        return 'Montiel';
      case Municipality.montmajor:
        return 'Montmajor';
      case Municipality.montmaneu:
        return 'Montmaneu';
      case Municipality.montmelo:
        return 'Montmeló';
      case Municipality.montornesDelValles:
        return 'Montornès del Vallès';
      case Municipality.montseny:
        return 'Montseny';
      case Municipality.moralDeCalatrava:
        return 'Moral de Calatrava';
      case Municipality.moralejaDeMatacabras:
        return 'Moraleja de Matacabras';
      case Municipality.moratillaDeLosMeleros:
        return 'Moratilla de los Meleros';
      case Municipality.morenilla:
        return 'Morenilla';
      case Municipality.muduex:
        return 'Muduex';
      case Municipality.muntanyola:
        return 'Muntanyola';
      case Municipality.munana:
        return 'Muñana';
      case Municipality.munico:
        return 'Muñico';
      case Municipality.munogalindo:
        return 'Muñogalindo';
      case Municipality.munogrande:
        return 'Muñogrande';
      case Municipality.munomerDelPeco:
        return 'Muñomer del Peco';
      case Municipality.munopepe:
        return 'Muñopepe';
      case Municipality.munosancho:
        return 'Muñosancho';
      case Municipality.munotello:
        return 'Muñotello';
      case Municipality.mura:
        return 'Mura';
      case Municipality.narrillosDelAlamo:
        return 'Narrillos del Álamo';
      case Municipality.narrillosDelRebollar:
        return 'Narrillos del Rebollar';
      case Municipality.narrosDeSalduena:
        return 'Narros de Saldueña';
      case Municipality.narrosDelCastillo:
        return 'Narros del Castillo';
      case Municipality.narrosDelPuerto:
        return 'Narros del Puerto';
      case Municipality.navaDeArevalo:
        return 'Nava de Arévalo';
      case Municipality.navaDelBarco:
        return 'Nava del Barco';
      case Municipality.navacepedillaDeCorneja:
        return 'Navacepedilla de Corneja';
      case Municipality.navadijos:
        return 'Navadijos';
      case Municipality.navaescurial:
        return 'Navaescurial';
      case Municipality.navahondilla:
        return 'Navahondilla';
      case Municipality.navalacruz:
        return 'Navalacruz';
      case Municipality.navalmoral:
        return 'Navalmoral';
      case Municipality.navalonguilla:
        return 'Navalonguilla';
      case Municipality.navalosa:
        return 'Navalosa';
      case Municipality.navalperalDePinares:
        return 'Navalperal de Pinares';
      case Municipality.navalperalDeTormes:
        return 'Navalperal de Tormes';
      case Municipality.navalpino:
        return 'Navalpino';
      case Municipality.navaluenga:
        return 'Navaluenga';
      case Municipality.navaquesera:
        return 'Navaquesera';
      case Municipality.navarcles:
        return 'Navarcles';
      case Municipality.navarredondaDeGredos:
        return 'Navarredonda de Gredos';
      case Municipality.navarredondilla:
        return 'Navarredondilla';
      case Municipality.navarrevisca:
        return 'Navarrevisca';
      case Municipality.navasDeEstena:
        return 'Navas de Estena';
      case Municipality.navas:
        return 'Navàs';
      case Municipality.navatalgordo:
        return 'Navatalgordo';
      case Municipality.navatejares:
        return 'Navatejares';
      case Municipality.negredo:
        return 'Negredo';
      case Municipality.neilaDeSanMiguel:
        return 'Neila de San Miguel';
      case Municipality.niharra:
        return 'Niharra';
      case Municipality.ocentejo:
        return 'Ocentejo';
      case Municipality.odena:
        return 'Òdena';
      case Municipality.ojosAlbos:
        return 'Ojos-Albos';
      case Municipality.olerdola:
        return 'Olèrdola';
      case Municipality.olesaDeBonesvalls:
        return 'Olesa de Bonesvalls';
      case Municipality.olesaDeMontserrat:
        return 'Olesa de Montserrat';
      case Municipality.olivella:
        return 'Olivella';
      case Municipality.olmedaDeCobeta:
        return 'Olmeda de Cobeta';
      case Municipality.olost:
        return 'Olost';
      case Municipality.olvan:
        return 'Olvan';
      case Municipality.orbita:
        return 'Orbita';
      case Municipality.orea:
        return 'Orea';
      case Municipality.oris:
        return 'Orís';
      case Municipality.orista:
        return 'Oristà';
      case Municipality.orpi:
        return 'Orpí';
      case Municipality.orrius:
        return 'Òrrius';
      case Municipality.pacsDelPenedes:
        return 'Pacs del Penedès';
      case Municipality.padiernos:
        return 'Padiernos';
      case Municipality.pajaresDeAdaja:
        return 'Pajares de Adaja';
      case Municipality.palaciosDeGoda:
        return 'Palacios de Goda';
      case Municipality.palafolls:
        return 'Palafolls';
      case Municipality.palauSolitaIPlegamans:
        return 'Palau-solità i Plegamans';
      case Municipality.palleja:
        return 'Pallejà';
      case Municipality.paretsDelValles:
        return 'Parets del Vallès';
      case Municipality.pedroMunoz:
        return 'Pedro Muñoz';
      case Municipality.perafita:
        return 'Perafita';
      case Municipality.picon:
        return 'Picón';
      case Municipality.piedrabuena:
        return 'Piedrabuena';
      case Municipality.piera:
        return 'Piera';
      case Municipality.pinedaDeMar:
        return 'Pineda de Mar';
      case Municipality.poblete:
        return 'Poblete';
      case Municipality.polinya:
        return 'Polinyà';
      case Municipality.pontons:
        return 'Pontons';
      case Municipality.porzuna:
        return 'Porzuna';
      case Municipality.pozueloDeCalatrava:
        return 'Pozuelo de Calatrava';
      case Municipality.pratsDeLlucanes:
        return 'Prats de Lluçanès';
      case Municipality.premiaDeDalt:
        return 'Premià de Dalt';
      case Municipality.premiaDeMar:
        return 'Premià de Mar';
      case Municipality.pueblaDeDonRodrigo:
        return 'Puebla de Don Rodrigo';
      case Municipality.pueblaDelPrincipe:
        return 'Puebla del Príncipe';
      case Municipality.puertoLapice:
        return 'Puerto Lápice';
      case Municipality.puertollano:
        return 'Puertollano';
      case Municipality.puigReig:
        return 'Puig-reig';
      case Municipality.puigdalber:
        return 'Puigdàlber';
      case Municipality.pujalt:
        return 'Pujalt';
      case Municipality.rajadell:
        return 'Rajadell';
      case Municipality.rellinars:
        return 'Rellinars';
      case Municipality.retuertaDelBullaque:
        return 'Retuerta del Bullaque';
      case Municipality.ripollet:
        return 'Ripollet';
      case Municipality.rodaDeTer:
        return 'Roda de Ter';
      case Municipality.rubi:
        return 'Rubí';
      case Municipality.rubio:
        return 'Rubió';
      case Municipality.ruidera:
        return 'Ruidera';
      case Municipality.rupitIPruit:
        return 'Rupit i Pruit';
      case Municipality.rute:
        return 'Rute';
      case Municipality.sabadell:
        return 'Sabadell';
      case Municipality.saceruela:
        return 'Saceruela';
      case Municipality.sagas:
        return 'Sagàs';
      case Municipality.saldes:
        return 'Saldes';
      case Municipality.sanCarlosDelValle:
        return 'San Carlos del Valle';
      case Municipality.sanLorenzoDeCalatrava:
        return 'San Lorenzo de Calatrava';
      case Municipality.santaCruzDeLosCanamos:
        return 'Santa Cruz de los Cáñamos';
      case Municipality.santpedor:
        return 'Santpedor';
      case Municipality.una:
        return 'Uña';
      case Municipality.villadiego:
        return 'Villadiego';
      case Municipality.villaescusaDeRoa:
        return 'Villaescusa de Roa';
      case Municipality.villaescusaLaSombria:
        return 'Villaescusa la Sombría';
      case Municipality.villaespasa:
        return 'Villaespasa';
      case Municipality.villafrancaMontesDeOca:
        return 'Villafranca Montes de Oca';
      case Municipality.villafruela:
        return 'Villafruela';
      case Municipality.villagalijo:
        return 'Villagalijo';
      case Municipality.villagonzaloPedernales:
        return 'Villagonzalo Pedernales';
      case Municipality.villahoz:
        return 'Villahoz';
      case Municipality.villalbaDeDuero:
        return 'Villalba de Duero';
      case Municipality.villalbillaDeBurgos:
        return 'Villalbilla de Burgos';
      case Municipality.villalbillaDeGumiel:
        return 'Villalbilla de Gumiel';
      case Municipality.villaldemiro:
        return 'Villaldemiro';
      case Municipality.villalmanzo:
        return 'Villalmanzo';
      case Municipality.villamayorDeLosMontes:
        return 'Villamayor de los Montes';
      case Municipality.villamayorDeTrevino:
        return 'Villamayor de Treviño';
      case Municipality.villambistia:
        return 'Villambistia';
      case Municipality.villamedianilla:
        return 'Villamedianilla';
      case Municipality.villamielDeLaSierra:
        return 'Villamiel de la Sierra';
      case Municipality.villangomez:
        return 'Villangómez';
      case Municipality.villanuevaDeArgano:
        return 'Villanueva de Argaño';
      case Municipality.villanuevaDeCarazo:
        return 'Villanueva de Carazo';
      case Municipality.villanuevaDeGumiel:
        return 'Villanueva de Gumiel';
      case Municipality.villanuevaDeTeba:
        return 'Villanueva de Teba';
      case Municipality.villaquiranDeLaPuebla:
        return 'Villaquirán de la Puebla';
      case Municipality.villaquiranDeLosInfantes:
        return 'Villaquirán de los Infantes';
      case Municipality.villarcayoDeMerindadDeCastillaLaVieja:
        return 'Villarcayo de Merindad de Castilla la Vieja';
      case Municipality.villariezo:
        return 'Villariezo';
      case Municipality.villasandino:
        return 'Villasandino';
      case Municipality.villasurDeHerreros:
        return 'Villasur de Herreros';
      case Municipality.villatuelda:
        return 'Villatuelda';
      case Municipality.villaverdeDelMonte:
        return 'Villaverde del Monte';
      case Municipality.villaverdeMogina:
        return 'Villaverde-Mogina';
      case Municipality.villayernoMorquillas:
        return 'Villayerno Morquillas';
      case Municipality.villazopeque:
        return 'Villazopeque';
      case Municipality.villegas:
        return 'Villegas';
      case Municipality.villoruebo:
        return 'Villoruebo';
      case Municipality.viloriaDeRioja:
        return 'Viloria de Rioja';
      case Municipality.vilviestreDelPinar:
        return 'Vilviestre del Pinar';
      case Municipality.vizcainos:
        return 'Vizcaínos';
      case Municipality.zael:
        return 'Zael';
      case Municipality.zarzosaDeRioPisuerga:
        return 'Zarzosa de Río Pisuerga';
      case Municipality.zazuar:
        return 'Zazuar';
      case Municipality.zuneda:
        return 'Zuñeda';
    }
  }

  String get zoneCode {
    switch (this) {
      // Andalusia (61)
      case Municipality.rute:
        return '61';
      // Castile and León (67)
      case Municipality.abadia:
      case Municipality.abertura:
      case Municipality.acebo:
      case Municipality.acehuche:
      case Municipality.elOso:
      case Municipality.lasNavasDelMarques:
      case Municipality.monsalupe:
      case Municipality.moralejaDeMatacabras:
      case Municipality.munana:
      case Municipality.munico:
      case Municipality.munogalindo:
      case Municipality.munogrande:
      case Municipality.munomerDelPeco:
      case Municipality.munopepe:
      case Municipality.munosancho:
      case Municipality.munotello:
      case Municipality.narrillosDelAlamo:
      case Municipality.narrillosDelRebollar:
      case Municipality.narrosDeSalduena:
      case Municipality.narrosDelCastillo:
      case Municipality.narrosDelPuerto:
      case Municipality.navaDeArevalo:
      case Municipality.navaDelBarco:
      case Municipality.navacepedillaDeCorneja:
      case Municipality.navadijos:
      case Municipality.navaescurial:
      case Municipality.navahondilla:
      case Municipality.navalacruz:
      case Municipality.navalmoral:
      case Municipality.navalonguilla:
      case Municipality.navalosa:
      case Municipality.navalperalDePinares:
      case Municipality.navalperalDeTormes:
      case Municipality.navaluenga:
      case Municipality.navaquesera:
      case Municipality.navarredondaDeGredos:
      case Municipality.navarredondilla:
      case Municipality.navarrevisca:
      case Municipality.navatalgordo:
      case Municipality.navatejares:
      case Municipality.neilaDeSanMiguel:
      case Municipality.niharra:
      case Municipality.ojosAlbos:
      case Municipality.orbita:
      case Municipality.padiernos:
      case Municipality.pajaresDeAdaja:
      case Municipality.palaciosDeGoda:
      case Municipality.villadiego:
      case Municipality.villaescusaDeRoa:
      case Municipality.villaescusaLaSombria:
      case Municipality.villaespasa:
      case Municipality.villafrancaMontesDeOca:
      case Municipality.villafruela:
      case Municipality.villagalijo:
      case Municipality.villagonzaloPedernales:
      case Municipality.villahoz:
      case Municipality.villalbaDeDuero:
      case Municipality.villalbillaDeBurgos:
      case Municipality.villalbillaDeGumiel:
      case Municipality.villaldemiro:
      case Municipality.villalmanzo:
      case Municipality.villamayorDeLosMontes:
      case Municipality.villamayorDeTrevino:
      case Municipality.villambistia:
      case Municipality.villamedianilla:
      case Municipality.villamielDeLaSierra:
      case Municipality.villangomez:
      case Municipality.villanuevaDeArgano:
      case Municipality.villanuevaDeCarazo:
      case Municipality.villanuevaDeGumiel:
      case Municipality.villanuevaDeTeba:
      case Municipality.villaquiranDeLaPuebla:
      case Municipality.villaquiranDeLosInfantes:
      case Municipality.villarcayoDeMerindadDeCastillaLaVieja:
      case Municipality.villariezo:
      case Municipality.villasandino:
      case Municipality.villasurDeHerreros:
      case Municipality.villatuelda:
      case Municipality.villaverdeDelMonte:
      case Municipality.villaverdeMogina:
      case Municipality.villayernoMorquillas:
      case Municipality.villazopeque:
      case Municipality.villegas:
      case Municipality.villoruebo:
      case Municipality.viloriaDeRioja:
      case Municipality.vilviestreDelPinar:
      case Municipality.vizcainos:
      case Municipality.zael:
      case Municipality.zarzosaDeRioPisuerga:
      case Municipality.zazuar:
      case Municipality.zuneda:
        return '67';
      // Castilla-La Mancha (68)
      case Municipality.elOlivar:
      case Municipality.elOrdial:
      case Municipality.elRobledo:
      case Municipality.laOlmedaDeJadraque:
      case Municipality.lasNavasDeJadraque:
      case Municipality.losPozuelosDeCalatrava:
      case Municipality.manzanares:
      case Municipality.membrilla:
      case Municipality.mestanza:
      case Municipality.miguelturra:
      case Municipality.mirabueno:
      case Municipality.miralrio:
      case Municipality.mochales:
      case Municipality.mohernando:
      case Municipality.molinaDeAragon:
      case Municipality.monasterio:
      case Municipality.montarron:
      case Municipality.montiel:
      case Municipality.mondejar:
      case Municipality.moralDeCalatrava:
      case Municipality.moratillaDeLosMeleros:
      case Municipality.morenilla:
      case Municipality.muduex:
      case Municipality.navalpino:
      case Municipality.navasDeEstena:
      case Municipality.negredo:
      case Municipality.ocentejo:
      case Municipality.olmedaDeCobeta:
      case Municipality.orea:
      case Municipality.pedroMunoz:
      case Municipality.picon:
      case Municipality.piedrabuena:
      case Municipality.poblete:
      case Municipality.porzuna:
      case Municipality.pozueloDeCalatrava:
      case Municipality.pueblaDeDonRodrigo:
      case Municipality.pueblaDelPrincipe:
      case Municipality.puertoLapice:
      case Municipality.puertollano:
      case Municipality.retuertaDelBullaque:
      case Municipality.ruidera:
      case Municipality.saceruela:
      case Municipality.sanCarlosDelValle:
      case Municipality.sanLorenzoDeCalatrava:
      case Municipality.santaCruzDeLosCanamos:
      case Municipality.una:
        return '68';
      // Catalonia  (69)
      case Municipality.cerviaDeTer:
      case Municipality.cistella:
      case Municipality.colera:
      case Municipality.collsuspina:
      case Municipality.elPapiol:
      case Municipality.elPlaDelPenedes:
      case Municipality.elPontDeVilomaraIRocafort:
      case Municipality.elPratDeLlobregat:
      case Municipality.elsPratsDeRei:
      case Municipality.laPalmaDeCervello:
      case Municipality.laPoblaDeClaramunt:
      case Municipality.laPoblaDeLillet:
      case Municipality.laQuar:
      case Municipality.laRocaDelValles:
      case Municipality.laNouDeBergueda:
      case Municipality.montmajor:
      case Municipality.montmaneu:
      case Municipality.montmelo:
      case Municipality.montornesDelValles:
      case Municipality.muntanyola:
      case Municipality.mura:
      case Municipality.montseny:
      case Municipality.navarcles:
      case Municipality.navas:
      case Municipality.odena:
      case Municipality.olerdola:
      case Municipality.olesaDeBonesvalls:
      case Municipality.olesaDeMontserrat:
      case Municipality.olivella:
      case Municipality.olost:
      case Municipality.olvan:
      case Municipality.oris:
      case Municipality.orista:
      case Municipality.orpi:
      case Municipality.orrius:
      case Municipality.pacsDelPenedes:
      case Municipality.palafolls:
      case Municipality.palauSolitaIPlegamans:
      case Municipality.palleja:
      case Municipality.paretsDelValles:
      case Municipality.perafita:
      case Municipality.piera:
      case Municipality.pinedaDeMar:
      case Municipality.polinya:
      case Municipality.pontons:
      case Municipality.pratsDeLlucanes:
      case Municipality.premiaDeDalt:
      case Municipality.premiaDeMar:
      case Municipality.puigReig:
      case Municipality.puigdalber:
      case Municipality.pujalt:
      case Municipality.rajadell:
      case Municipality.rellinars:
      case Municipality.ripollet:
      case Municipality.rodaDeTer:
      case Municipality.rubi:
      case Municipality.rubio:
      case Municipality.rupitIPruit:
      case Municipality.sabadell:
      case Municipality.sagas:
      case Municipality.saldes:
      case Municipality.santpedor:
        return '69';
    }
  }

  String get municipalityCode {
    switch (this) {
      // Ávila (05)
      case Municipality.monsalupe:
        return '05133';
      case Municipality.moralejaDeMatacabras:
        return '05134';
      case Municipality.munana:
        return '05135';
      case Municipality.munico:
        return '05136';
      case Municipality.munogalindo:
        return '05138';
      case Municipality.munogrande:
        return '05139';
      case Municipality.munomerDelPeco:
        return '05140';
      case Municipality.munopepe:
        return '05141';
      case Municipality.munosancho:
        return '05142';
      case Municipality.munotello:
        return '05143';
      case Municipality.narrillosDelAlamo:
        return '05144';
      case Municipality.narrillosDelRebollar:
        return '05145';
      case Municipality.narrosDeSalduena:
        return '05149';
      case Municipality.narrosDelCastillo:
        return '05147';
      case Municipality.narrosDelPuerto:
        return '05148';
      case Municipality.navaDeArevalo:
        return '05152';
      case Municipality.navaDelBarco:
        return '05153';
      case Municipality.navacepedillaDeCorneja:
        return '05151';
      case Municipality.navadijos:
        return '05154';
      case Municipality.navaescurial:
        return '05155';
      case Municipality.navahondilla:
        return '05156';
      case Municipality.navalacruz:
        return '05157';
      case Municipality.navalmoral:
        return '05158';
      case Municipality.navalonguilla:
        return '05159';
      case Municipality.navalosa:
        return '05160';
      case Municipality.navalperalDePinares:
        return '05161';
      case Municipality.navalperalDeTormes:
        return '05162';
      case Municipality.navaluenga:
        return '05163';
      case Municipality.navaquesera:
        return '05164';
      case Municipality.navarredondaDeGredos:
        return '05165';
      case Municipality.navarredondilla:
        return '05166';
      case Municipality.navarrevisca:
        return '05167';
      case Municipality.lasNavasDelMarques:
        return '05168';
      case Municipality.navatalgordo:
        return '05169';
      case Municipality.navatejares:
        return '05170';
      case Municipality.neilaDeSanMiguel:
        return '05171';
      case Municipality.niharra:
        return '05172';
      case Municipality.ojosAlbos:
        return '05173';
      case Municipality.orbita:
        return '05174';
      case Municipality.elOso:
        return '05175';
      case Municipality.padiernos:
        return '05176';
      case Municipality.pajaresDeAdaja:
        return '05177';
      case Municipality.palaciosDeGoda:
        return '05178';

      // Barcelona (08)
      case Municipality.collsuspina:
        return '08070';
      case Municipality.montmajor:
        return '08132';
      case Municipality.montmaneu:
        return '08133';
      case Municipality.montmelo:
        return '08135';
      case Municipality.montornesDelValles:
        return '08136';
      case Municipality.montseny:
        return '08137';
      case Municipality.muntanyola:
        return '08129';
      case Municipality.mura:
        return '08139';
      case Municipality.navarcles:
        return '08140';
      case Municipality.navas:
        return '08141';
      case Municipality.laNouDeBergueda:
        return '08142';
      case Municipality.odena:
        return '08143';
      case Municipality.olerdola:
        return '08145';
      case Municipality.olesaDeBonesvalls:
        return '08146';
      case Municipality.olesaDeMontserrat:
        return '08147';
      case Municipality.olivella:
        return '08148';
      case Municipality.olost:
        return '08149';
      case Municipality.olvan:
        return '08144';
      case Municipality.oris:
        return '08150';
      case Municipality.orista:
        return '08151';
      case Municipality.orpi:
        return '08152';
      case Municipality.orrius:
        return '08153';
      case Municipality.pacsDelPenedes:
        return '08154';
      case Municipality.palafolls:
        return '08155';
      case Municipality.palauSolitaIPlegamans:
        return '08156';
      case Municipality.palleja:
        return '08157';
      case Municipality.laPalmaDeCervello:
        return '08905';
      case Municipality.elPapiol:
        return '08158';
      case Municipality.paretsDelValles:
        return '08159';
      case Municipality.perafita:
        return '08160';
      case Municipality.piera:
        return '08161';
      case Municipality.pinedaDeMar:
        return '08163';
      case Municipality.elPlaDelPenedes:
        return '08164';
      case Municipality.laPoblaDeClaramunt:
        return '08165';
      case Municipality.laPoblaDeLillet:
        return '08166';
      case Municipality.polinya:
        return '08167';
      case Municipality.elPontDeVilomaraIRocafort:
        return '08182';
      case Municipality.pontons:
        return '08168';
      case Municipality.elPratDeLlobregat:
        return '08169';
      case Municipality.pratsDeLlucanes:
        return '08171';
      case Municipality.elsPratsDeRei:
        return '08170';
      case Municipality.premiaDeDalt:
        return '08230';
      case Municipality.premiaDeMar:
        return '08172';
      case Municipality.puigdalber:
        return '08174';
      case Municipality.puigReig:
        return '08175';
      case Municipality.pujalt:
        return '08176';
      case Municipality.laQuar:
        return '08177';
      case Municipality.rajadell:
        return '08178';
      case Municipality.rellinars:
        return '08179';
      case Municipality.ripollet:
        return '08180';
      case Municipality.laRocaDelValles:
        return '08181';
      case Municipality.rodaDeTer:
        return '08183';
      case Municipality.rubi:
        return '08184';
      case Municipality.rubio:
        return '08185';
      case Municipality.rupitIPruit:
        return '08901';
      case Municipality.sabadell:
        return '08187';
      case Municipality.sagas:
        return '08188';
      case Municipality.saldes:
        return '08190';
      case Municipality.santpedor:
        return '08192';

      // Burgos (09)
      case Municipality.villadiego:
        return '09427';
      case Municipality.villaescusaDeRoa:
        return '09428';
      case Municipality.villaescusaLaSombria:
        return '09429';
      case Municipality.villaespasa:
        return '09430';
      case Municipality.villafrancaMontesDeOca:
        return '09431';
      case Municipality.villafruela:
        return '09432';
      case Municipality.villagalijo:
        return '09433';
      case Municipality.villagonzaloPedernales:
        return '09434';
      case Municipality.villahoz:
        return '09437';
      case Municipality.villalbaDeDuero:
        return '09438';
      case Municipality.villalbillaDeBurgos:
        return '09439';
      case Municipality.villalbillaDeGumiel:
        return '09440';

      default:
        return '';
    }
  }
}
