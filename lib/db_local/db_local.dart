import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import '../providers/app_state.dart';

class LocalDatabase {
  static Database? _database;

  static const _dbName = 'inspecciones.db';
  static const _dbVersion = 1;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    Directory documentsDirectory =
    await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: _onCreate,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {

    try {
      await db.execute(_crearInspecciones);

      await db.execute(_crearProyectos);

      await db.execute(_crearViviendas);

      await db.execute(_crearRecintos);

      await db.execute(_crearMuros);

      await db.execute(_crearPisoCielo);

      await db.execute(_crearPatologias);

      await insertarListadoPatologias(db);

      await db.execute(_crearSistemas_Ventilacion);

      await insertarListadoSistemas(db);

      await db.execute(_crearPatologias_Muro);

      await db.execute(_crearPatologias_PisoCielo);

      await db.execute(_crearVentilacionRecintos);


    } catch (e) {
      rethrow;
    }
  }

  static const _crearProyectos = '''
    CREATE TABLE proyectos (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      proyecto_uuid TEXT NOT NULL UNIQUE,
      nombre_proyecto TEXT,
      region TEXT,
      comuna TEXT,
      etapa TEXT,
      sync_status INTEGER DEFAULT 0,
      updated_at INTEGER
    );
  ''';

  static Future<String> insertarProyecto({
    required String nombreProyecto,
    String? region,
    String? comuna,
    String? etapa,
  }) async {
    final db = await database;

    final proyectoUuid = const Uuid().v4();
    final now = DateTime.now().millisecondsSinceEpoch;

    await db.insert('proyectos', {
      'proyecto_uuid': proyectoUuid,
      'nombre_proyecto': nombreProyecto,
      'region': region,
      'comuna': comuna,
      'etapa': etapa,
      'sync_status': 0,
      'updated_at': now,
    });

    return proyectoUuid;
  }

  static Future<List<Map<String, dynamic>>> obtenerProyectos() async {
    final db = await database;
    return await db.query('proyectos', orderBy: 'nombre_proyecto ASC');
  }

  static const _crearInspecciones = '''
    CREATE TABLE inspecciones (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      inspeccion_uuid TEXT NOT NULL UNIQUE,
      proyecto_uuid TEXT NOT NULL,
      n_ficha TEXT,
      fecha TEXT,
      hora_ingreso TEXT,
      hora_salida TEXT,
      recibido_por TEXT,
      nombre_receptor TEXT,
      nombre_inspector TEXT,
      rut_inspector TEXT,
      clima TEXT,
      estado TEXT,
      sync_status INTEGER DEFAULT 0,
      updated_at INTEGER,
      
      FOREIGN KEY (proyecto_uuid)
        REFERENCES proyectos(proyecto_uuid)
        ON DELETE CASCADE
      
    );
  ''';


  static Future<String> insertarInspeccion({
    required String proyectoUuid,
    required String nFicha,
    required String fecha,
    required String horaIngreso,
    required String horaSalida,
    required String recibidoPor,
    required String nombreReceptor,
    required String nombreInspector,
    required String rutInspector,
    String? clima,
  }) async {
    final db = await database;

    final inspeccionUuid = const Uuid().v4();
    final now = DateTime.now().millisecondsSinceEpoch;

    await db.insert('inspecciones', {
      'proyecto_uuid': proyectoUuid,
      'inspeccion_uuid': inspeccionUuid,
      'n_ficha': nFicha,
      'fecha': fecha,
      'hora_ingreso': horaIngreso,
      'hora_salida': horaSalida,
      'recibido_por': recibidoPor,
      'nombre_receptor': nombreReceptor,
      'nombre_inspector': nombreInspector,
      'rut_inspector': rutInspector,
      'clima': clima,
      'estado': 'en_progreso',
      'sync_status': 0,
      'updated_at': now,
    });

    return inspeccionUuid;
  }




  static const _crearViviendas = '''
    CREATE TABLE viviendas (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      vivienda_uuid TEXT NOT NULL UNIQUE,
      inspeccion_uuid TEXT NOT NULL,
    
      tipologia_vivienda TEXT,
      direccion TEXT,
      superficie REAL,
      n_pisos INTEGER,
      orientacion_fachada TEXT,
      orientacion_acceso TEXT,
    
      temp_exterior INTEGER,
      hum_exterior INTEGER,
      temp_interior INTEGER,
      hum_interior INTEGER,
    
      a_de_uso INTEGER,
      reparaciones INTEGER NOT NULL CHECK (reparaciones IN (0,1)),
      detalle_reparaciones TEXT,
      ampliaciones INTEGER NOT NULL CHECK (ampliaciones IN (0,1)),
      detalle_ampliaciones TEXT,
    
      observaciones TEXT,
    
      n_recintos INTEGER,
      total_habitantes INTEGER,
      num_adultos INTEGER,
      num_menores INTEGER,
      num_adul_mayores INTEGER,
      ocup_dia_comp INTEGER,
      ocup_intermitente INTEGER,
    
      dens_ocup_prev INTEGER,
      dens_ocup_real INTEGER,
      observaciones_ocupacion TEXT,
    
      sync_status INTEGER DEFAULT 0,
      updated_at INTEGER,
    
      FOREIGN KEY (inspeccion_uuid)
        REFERENCES inspecciones(inspeccion_uuid)
        ON DELETE CASCADE
    );

  ''';


  static Future<String> insertarVivienda({
    required String inspeccionUuid,

    required String tipologiaVivienda,
    required String direccion,
    double? superficie,
    int? nPisos,
    String? orientacionFachada,
    String? orientacionAcceso,

    int? tempExterior,
    int? humExterior,
    int? tempInterior,
    int? humInterior,

    int? aniosUso,
    required int reparaciones,
    String? detalleReparaciones,
    required int ampliaciones,
    String? detalleAmpliaciones,

    String? observaciones,

    int? nRecintos,
    int? totalHabitantes,
    int? numAdultos,
    int? numMenores,
    int? numAdultosMayores,
    int? ocupDiaComp,
    int? ocupIntermitente,

    int? densOcupPrev,
    int? densOcupReal,
    String? observacionesOcupacion,
  }) async {
    final db = await database;

    final viviendaUuid = const Uuid().v4();
    final now = DateTime.now().millisecondsSinceEpoch;

    await db.insert('viviendas', {
      'vivienda_uuid': viviendaUuid,
      'inspeccion_uuid': inspeccionUuid,

      'tipologia_vivienda': tipologiaVivienda,
      'direccion': direccion,
      'superficie': superficie,
      'n_pisos': nPisos,
      'orientacion_fachada': orientacionFachada,
      'orientacion_acceso': orientacionAcceso,

      'temp_exterior': tempExterior,
      'hum_exterior': humExterior,
      'temp_interior': tempInterior,
      'hum_interior': humInterior,

      'a_de_uso': aniosUso,
      'reparaciones': reparaciones,
      'detalle_reparaciones': detalleReparaciones,
      'ampliaciones': ampliaciones,
      'detalle_ampliaciones': detalleAmpliaciones,

      'observaciones': observaciones,

      'n_recintos': nRecintos,
      'total_habitantes': totalHabitantes,
      'num_adultos': numAdultos,
      'num_menores': numMenores,
      'num_adul_mayores': numAdultosMayores,
      'ocup_dia_comp': ocupDiaComp,
      'ocup_intermitente': ocupIntermitente,

      'dens_ocup_prev': densOcupPrev,
      'dens_ocup_real': densOcupReal,
      'observaciones_ocupacion': observacionesOcupacion,

      'sync_status': 0,
      'updated_at': now,
    });

    return viviendaUuid;
  }




  static const _crearRecintos = '''
    CREATE TABLE recintos (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
  
      recinto_uuid TEXT NOT NULL UNIQUE,
      inspeccion_uuid TEXT NOT NULL,
      vivienda_uuid TEXT NOT NULL,
  
      nombre_recinto TEXT,
      patologias_visibles INTEGER NOT NULL CHECK (patologias_visibles IN (0,1)),
      manifestaciones_ocultas INTEGER NOT NULL CHECK (manifestaciones_ocultas IN (0,1)),
      detalles_manifestaciones TEXT,
      olor_humedad INTEGER NOT NULL CHECK (olor_humedad IN (0,1)),
      modificaciones INTEGER NOT NULL CHECK (modificaciones IN (0,1)),
      detalles_modificaciones TEXT,
      calefaccion TEXT,
      tiempo_calefaccion INTEGER,
   
      sync_status INTEGER DEFAULT 0,
      updated_at INTEGER,
      
       FOREIGN KEY (inspeccion_uuid)
        REFERENCES inspecciones(inspeccion_uuid)
        ON DELETE CASCADE,
      
    
      FOREIGN KEY (vivienda_uuid)
        REFERENCES viviendas(vivienda_uuid)
        ON DELETE CASCADE
    );

  ''';


  static Future<String> insertarRecinto({
    required String inspeccionUuid,
    required String viviendaUuid,
    required String nombreRecinto,
    required int patologiasVisibles,
    required int manifestacionesOcultas,
    String? detallesManifestaciones,
    required int olorHumedad,
    required int modificaciones,
    String? detallesModificaciones,
    String? calefaccion,
    String? tiempoCalefaccion,
  }) async {
    final db = await database;
    final recintoUuid = const Uuid().v4();
    final now = DateTime.now().millisecondsSinceEpoch;
    await db.insert('recintos', {
      'recinto_uuid': recintoUuid,
      'inspeccion_uuid': inspeccionUuid,
      'vivienda_uuid': viviendaUuid,
      'nombre_recinto': nombreRecinto,
      'patologias_visibles': patologiasVisibles,
      'manifestaciones_ocultas': manifestacionesOcultas,
      'detalles_manifestaciones': detallesManifestaciones,
      'olor_humedad': olorHumedad,
      'modificaciones': modificaciones,
      'detalles_modificaciones': detallesModificaciones,
      'calefaccion': calefaccion,
      'tiempo_calefaccion': tiempoCalefaccion,
      'sync_status': 0,
      'updated_at': now,
    });

    return recintoUuid;
  }



  static const _crearMuros = '''
    CREATE TABLE muros (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      muro_uuid TEXT NOT NULL UNIQUE,
      recinto_uuid TEXT,
    
      nombre_muro TEXT,
      tipo_muro INTEGER NOT NULL CHECK (tipo_muro IN (0,1)),
      superficie REAL,
      superficie_ventana REAL,
      nivel_afectacion INTEGER NOT NULL CHECK (nivel_afectacion IN (0,1,2,3)),
    
      sync_status INTEGER DEFAULT 0,
      updated_at INTEGER,
    
      FOREIGN KEY (recinto_uuid)
        REFERENCES recintos(recinto_uuid)
        ON DELETE CASCADE
    );

  ''';

  static Future<String> insertarMuro({
    required String recintoUuid,
    required String nombreMuro,
    required int tipoMuro,
    double? superficie,
    double? superficieVentana,
    required int nivelAfectacion,
  }) async {
    final db = await database;
    final muroUuid = const Uuid().v4();
    final now = DateTime.now().millisecondsSinceEpoch;
    await db.insert('muros', {
      'muro_uuid': muroUuid,
      'recinto_uuid': recintoUuid,
      'nombre_muro': nombreMuro,
      'tipo_muro': tipoMuro,
      'superficie': superficie,
      'superficie_ventana': superficieVentana,
      'nivel_afectacion': nivelAfectacion,
      'sync_status': 0,
      'updated_at': now,
    });

    return muroUuid;
  }



  static const _crearPisoCielo  = '''
    CREATE TABLE pisocielo (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
    
      pisocielo_uuid TEXT NOT NULL UNIQUE,
      recinto_uuid TEXT,
    
      tipo TEXT,
      superficie REAL,
      nivel_afectacion INTEGER NOT NULL CHECK (nivel_afectacion IN (0,1,2,3)),
    
      sync_status INTEGER DEFAULT 0,
      updated_at INTEGER,
    
      FOREIGN KEY (recinto_uuid)
        REFERENCES recintos(recinto_uuid)
        ON DELETE CASCADE
    );

  ''';

  static Future<String> insertarPisoCielo({
    required String recintoUuid,
    required String tipo,
    double? superficie,
    required int nivelAfectacion,
  }) async {
    final db = await database;
    final pisocieloUuid = const Uuid().v4();
    final now = DateTime.now().millisecondsSinceEpoch;
    await db.insert('pisocielo', {
      'pisocielo_uuid': pisocieloUuid,
      'recinto_uuid': recintoUuid,
      'tipo': tipo,
      'superficie': superficie,
      'nivel_afectacion': nivelAfectacion,
      'sync_status': 0,
      'updated_at': now,
    });

    return pisocieloUuid;
  }



  static const _crearPatologias = '''
    CREATE TABLE patologias (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      patologia_uuid TEXT NOT NULL UNIQUE,
      tipo TEXT NOT NULL,
      ubicacion TEXT NOT NULL,
      sync_status INTEGER DEFAULT 0,
      updated_at INTEGER
    );

  ''';



  static const _crearPatologias_Muro = '''
    CREATE TABLE patologias_muro (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      patologia_muro_uuid TEXT NOT NULL UNIQUE,
      muro_uuid TEXT NOT NULL,
      patologia_uuid TEXT NOT NULL,
    
      estado INTEGER NOT NULL CHECK (estado IN (0,1)),
      superficie REAL NOT NULL,
    
      sync_status INTEGER DEFAULT 0,
      updated_at INTEGER,
     
      FOREIGN KEY (muro_uuid) 
      REFERENCES muros(muro_uuid) 
      ON DELETE CASCADE,
      FOREIGN KEY (patologia_uuid) 
      REFERENCES patologias(patologia_uuid)
);

    );


  ''';


  static const _crearPatologias_PisoCielo = '''
    CREATE TABLE patologias_pisocielo (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
    
      patologia_pisocielo_uuid TEXT NOT NULL UNIQUE,
      pisocielo_uuid TEXT NOT NULL,
      patologia_uuid TEXT NOT NULL,
    
      tipo TEXT NOT NULL,
      estado INTEGER NOT NULL CHECK (estado IN (0,1)),
      superficie REAL,
    
      sync_status INTEGER DEFAULT 0,
      updated_at INTEGER,
    
      FOREIGN KEY (pisocielo_uuid)
        REFERENCES pisocielo(pisocielo_uuid)
        ON DELETE CASCADE,
    
      FOREIGN KEY (patologia_uuid)
        REFERENCES patologias(patologia_uuid)
        ON DELETE RESTRICT
    );

  ''';


  static const _crearSistemas_Ventilacion = '''
    CREATE TABLE sistemas_ventilacion (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      sistema_ventilacion_uuid TEXT NOT NULL UNIQUE,
      nombre_sistema TEXT NOT NULL,
      sync_status INTEGER DEFAULT 0,
      updated_at INTEGER
    );

''';



  static const _crearVentilacionRecintos = '''
    CREATE TABLE ventilacion_recintos (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ventilacion_recinto_uuid TEXT NOT NULL UNIQUE,
      recinto_uuid TEXT NOT NULL,
      sistema_ventilacion_uuid TEXT NOT NULL,
    
      estado INTEGER NOT NULL CHECK (estado IN (0,1)),
    
      sync_status INTEGER DEFAULT 0,
      updated_at INTEGER,
     
      FOREIGN KEY (recinto_uuid)
        REFERENCES recintos(recinto_uuid)
        ON DELETE CASCADE,
    
      FOREIGN KEY (sistema_ventilacion_uuid)
        REFERENCES sistemas_ventilacion(sistema_ventilacion_uuid)
        ON DELETE RESTRICT
    );

    ''';

  // ---------------------------------------------------------------------------
  // FUNCIONES DE RELACIONES
  // ---------------------------------------------------------------------------

  static Future<void> insertarListadoSistemas(Database db) async {
    final now = DateTime.now().millisecondsSinceEpoch;

    final sistemas = [
      {
        'sistema_ventilacion_uuid': SistemasVentilacionUUID.aireador,
        'nombre_sistema': 'Aireador',
      },
      {
        'sistema_ventilacion_uuid': SistemasVentilacionUUID.extractor,
        'nombre_sistema': 'Extractor',
      },
      {
        'sistema_ventilacion_uuid': SistemasVentilacionUUID.campana,
        'nombre_sistema': 'Campana',
      },
      {
        'sistema_ventilacion_uuid': SistemasVentilacionUUID.celosiaPuerta,
        'nombre_sistema': 'Celosía puerta',
      },
      {
        'sistema_ventilacion_uuid': SistemasVentilacionUUID.rebajePuerta,
        'nombre_sistema': 'Rebaje puerta',
      },
      {
        'sistema_ventilacion_uuid': SistemasVentilacionUUID.otro,
        'nombre_sistema': 'Otro',
      },
    ];

    for (final sistema in sistemas) {
      await db.insert(
        'sistemas_ventilacion',
        {
          ...sistema,
          'sync_status': 0,
          'updated_at': now,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  static Future<void> insertarListadoPatologias(Database db) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final patologias = [
      {
        'patologia_uuid': PatologiasUUID.humEsqMuro,
        'tipo': 'Manchas de humedad / moho',
        'ubicacion': 'Encuentro esquina muro',
      },
      {
        'patologia_uuid': PatologiasUUID.humCieloMuro,
        'tipo': 'Manchas de humedad / moho',
        'ubicacion': 'Encuentro cielo muro',
      },
      {
        'patologia_uuid': PatologiasUUID.humPisoMuro,
        'tipo': 'Manchas de humedad / moho',
        'ubicacion': 'Encuentro piso muro',
      },
      {
        'patologia_uuid': PatologiasUUID.humRasgoVentana,
        'tipo': 'Manchas de humedad / moho',
        'ubicacion': 'Rasgo de ventana',
      },
      {
        'patologia_uuid': PatologiasUUID.humBajoVentana,
        'tipo': 'Manchas de humedad / moho',
        'ubicacion': 'Bajo ventana (antepecho)',
      },
      {
        'patologia_uuid': PatologiasUUID.humAreaCentral,
        'tipo': 'Manchas de humedad / moho',
        'ubicacion': 'Área central',
      },
      {
        'patologia_uuid': PatologiasUUID.humPuntual,
        'tipo': 'Manchas de humedad / moho',
        'ubicacion': 'Puntual localizada y/o extendida',
      },
      {
        'patologia_uuid': PatologiasUUID.humPerimetro,
        'tipo': 'Manchas de humedad / moho',
        'ubicacion': 'Perímetro',
      },

      {
        'patologia_uuid': PatologiasUUID.danEsqMuro,
        'tipo': 'Daño físico mecánico',
        'ubicacion': 'Encuentro esquina muro',
      },
      {
        'patologia_uuid': PatologiasUUID.danCieloMuro,
        'tipo': 'Daño físico mecánico',
        'ubicacion': 'Encuentro cielo muro',
      },
      {
        'patologia_uuid': PatologiasUUID.danPisoMuro,
        'tipo': 'Daño físico mecánico',
        'ubicacion': 'Encuentro piso muro',
      },
      {
        'patologia_uuid': PatologiasUUID.danRasgoVentana,
        'tipo': 'Daño físico mecánico',
        'ubicacion': 'Rasgo de ventana',
      },
      {
        'patologia_uuid': PatologiasUUID.danBajoVentana,
        'tipo': 'Daño físico mecánico',
        'ubicacion': 'Bajo ventana (antepecho)',
      },
      {
        'patologia_uuid': PatologiasUUID.danAreaCentral,
        'tipo': 'Daño físico mecánico',
        'ubicacion': 'Área central',
      },
      {
        'patologia_uuid': PatologiasUUID.danPuntual,
        'tipo': 'Daño físico mecánico',
        'ubicacion': 'Puntual localizada y/o extendida',
      },
      {
        'patologia_uuid': PatologiasUUID.danPerimetro,
        'tipo': 'Daño físico mecánico',
        'ubicacion': 'Perímetro',
      },
    ];

    for (final patologia in patologias) {
      await db.insert(
        'patologias',
        {
          ...patologia,
          'sync_status': 0,
          'updated_at': now,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }


  static Future<void> asociarVentilacionARecinto(
      String recinto_uuid,
      Recinto recinto,
      ) async {
    final db = await database;
    final now = DateTime.now().millisecondsSinceEpoch;
    const uuid = Uuid();

    // Mapa controller → nombre del sistema
    final Map<String, TextEditingController> sistemas = {
      'Aireador': recinto.aireadorController,
      'Extractor': recinto.extractorController,
      'Campana': recinto.campanaController,
      'Celosía puerta': recinto.celosiapueController,
      'Rebaje puerta': recinto.rebajepueController,
      'Otro': recinto.otroequipController,
    };

    for (final entry in sistemas.entries) {
      final textoEstado = entry.value.text.trim();
      if (textoEstado.isEmpty) continue;

      final int estado = textoEstado == 'Si' ||
          textoEstado == 'Operativo' ||
          textoEstado == 'OK'
          ? 1
          : 0;


      // Obtener UUID del sistema
      final result = await db.query(
        'sistemas_ventilacion',
        columns: ['sistema_ventilacion_uuid'],
        where: 'nombre_sistema = ?',
        whereArgs: [entry.key],
        limit: 1,
      );

      if (result.isEmpty) {
        debugPrint('⚠️ Sistema no encontrado: ${entry.key}');
        continue;
      }

      final sistemaUuid = result.first['sistema_ventilacion_uuid'];

      await db.insert(
        'ventilacion_recintos',
        {
          'ventilacion_recinto_uuid': uuid.v4(),
          'recinto_uuid': recinto_uuid,
          'sistema_ventilacion_uuid': sistemaUuid,
          'estado': estado,
          'sync_status': 0,
          'updated_at': now,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      debugPrint(
        '✅ Ventilación asociada: ${entry.key} | $estado | $recinto_uuid',
      );
    }
  }

  static Future<void> asociarPatologiasAMuro({
    required String muroUuid,
    required HojaMuro muro,
  }) async {
    final db = await database;
    final now = DateTime.now().millisecondsSinceEpoch;
    const uuid = Uuid();


    /// Mapa: (tipo + ubicación) → controllers
    final Map<Map<String, String>, Map<String, TextEditingController>> patologias = {
      {
        'tipo': 'Manchas de humedad / moho',
        'ubicacion': 'Encuentro esquina muro',
      }: {
        'estado': muro.mh_encEsqMurController,
        'superficie': muro.mh_supencEsqMurController,
      },
      {
        'tipo': 'Manchas de humedad / moho',
        'ubicacion': 'Encuentro cielo muro',
      }: {
        'estado': muro.mh_encCieMurController,
        'superficie': muro.mh_supencCieMurController,
      },
      {
        'tipo': 'Manchas de humedad / moho',
        'ubicacion': 'Encuentro piso muro',
      }: {
        'estado': muro.mh_encPisMurController,
        'superficie': muro.mh_supencPisMurController,
      },
      {
        'tipo': 'Manchas de humedad / moho',
        'ubicacion': 'Rasgo de ventana',
      }: {
        'estado': muro.mh_rasgventController,
        'superficie': muro.mh_suprasgventController,
      },
      {
        'tipo': 'Manchas de humedad / moho',
        'ubicacion': 'Bajo ventana (antepecho)',
      }: {
        'estado': muro.mh_bajovenController,
        'superficie': muro.mh_supbajovenController,
      },
      {
        'tipo': 'Manchas de humedad / moho',
        'ubicacion': 'Área central',
      }: {
        'estado': muro.mh_aCentralController,
        'superficie': muro.mh_supaCentralController,
      },
      {
        'tipo': 'Manchas de humedad / moho',
        'ubicacion': 'Puntual localizada y/o extendida',
      }: {
        'estado': muro.mh_punLocController,
        'superficie': muro.mh_suppunLocController,
      },
      // DF
      {
        'tipo': 'Daño físico mecánico',
        'ubicacion': 'Encuentro esquina muro',
      }: {
        'estado': muro.df_encEsqMurController,
        'superficie': muro.df_supencEsqMurController,
      },
      {
        'tipo': 'Daño físico mecánico',
        'ubicacion': 'Encuentro cielo muro',
      }: {
        'estado': muro.df_encCieMurController,
        'superficie': muro.df_supencCieMurController,
      },
      {
        'tipo': 'Daño físico mecánico',
        'ubicacion': 'Encuentro piso muro',
      }: {
        'estado': muro.df_encPisMurController,
        'superficie': muro.df_supencPisMurController,
      },
      {
        'tipo': 'Daño físico mecánico',
        'ubicacion': 'Rasgo de ventana',
      }: {
        'estado': muro.df_rasgventController,
        'superficie': muro.df_suprasgventController,
      },
      {
        'tipo': 'Daño físico mecánico',
        'ubicacion': 'Bajo ventana (antepecho)',
      }: {
        'estado': muro.df_bajovenController,
        'superficie': muro.df_supbajovenController,
      },
      {
        'tipo': 'Daño físico mecánico',
        'ubicacion': 'Área central',
      }: {
        'estado': muro.df_aCentralController,
        'superficie': muro.df_supaCentralController,
      },
      {
        'tipo': 'Daño físico mecánico',
        'ubicacion': 'Puntual localizada y/o extendida',
      }: {
        'estado': muro.df_punLocController,
        'superficie': muro.df_suppunLocController,
      },
    };

    for (final entry in patologias.entries) {
      final estadoText = entry.value['estado']!.text.trim();
      if (estadoText.isEmpty) continue;

      final estado =
      (estadoText.toLowerCase() == 'si' || estadoText == '1') ? 1 : 0;
      final superficie =
          double.tryParse(entry.value['superficie']!.text.trim()) ?? 0;

      /// Obtener UUID de la patología desde catálogo
      final result = await db.query(
        'patologias',
        columns: ['patologia_uuid'],
        where: 'tipo = ? AND ubicacion = ?',
        whereArgs: [
          entry.key['tipo'],
          entry.key['ubicacion'],
        ],
        limit: 1,
      );

      if (result.isEmpty) {
        debugPrint(
          '⚠️ Patología no encontrada: ${entry.key['tipo']} - ${entry.key['ubicacion']}',
        );
        continue;
      }

      final patologiaUuid = result.first['patologia_uuid'] as String;

      await db.insert(
        'patologias_muro',
        {
          'patologia_muro_uuid': uuid.v4(),
          'muro_uuid': muroUuid,
          'patologia_uuid': patologiaUuid,
          'estado': estado,
          'superficie': superficie,
          'sync_status': 0,
          'updated_at': now,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      debugPrint(
        '✅ Patología asociada al muro $muroUuid → $patologiaUuid',
      );
    }
  }

  static Future<void> asociarPatologiasAPisoCielo({
    required String pisocieloUuid,
    required String tipo,
    required HojaPisoCielo pisocielo,
  }) async {
    final db = await database;
    final now = DateTime.now().millisecondsSinceEpoch;
    const uuid = Uuid();

    switch(tipo) {
      case 'Piso':
        /// Mapa: (tipo + ubicación) → controllers
        final Map<Map<String, String>, Map<String, TextEditingController>> patologias = {
          {
            'tipo': 'Manchas de humedad / moho',
            'ubicacion': 'Perímetro',
          }: {
            'estado': pisocielo.mh_perimetroPisoController,
            'superficie': pisocielo.mh_supperimetroPisoController,
          },
          {
            'tipo': 'Manchas de humedad / moho',
            'ubicacion': 'Área central',
          }: {
            'estado': pisocielo.mh_aCentralPisoController,
            'superficie': pisocielo.mh_supaCentralPisoController,
          },
          {
            'tipo': 'Manchas de humedad / moho',
            'ubicacion': 'Puntual localizada y/o extendida',
          }: {
            'estado': pisocielo.mh_punlocPisoController,
            'superficie': pisocielo.mh_supPunlocPisoController,
          },
          //DF
          {
            'tipo': 'Daño físico mecánico',
            'ubicacion': 'Perímetro',
          }: {
            'estado': pisocielo.df_perimetroPisoController,
            'superficie': pisocielo.df_supperimetroPisoController,
          },
          {
            'tipo': 'Daño físico mecánico',
            'ubicacion': 'Área central',
          }: {
            'estado': pisocielo.df_aCentralPisoController,
            'superficie': pisocielo.df_supaCentralPisoController,
          },
          {
            'tipo': 'Daño físico mecánico',
            'ubicacion': 'Puntual localizada y/o extendida',
          }: {
            'estado': pisocielo.df_punlocPisoController,
            'superficie': pisocielo.df_supPunlocPisoController,
          },

        };
          for (final entry in patologias.entries) {
            final estadoText = entry.value['estado']!.text.trim();
            if (estadoText.isEmpty) continue;

            final estado =
            (estadoText.toLowerCase() == 'si' || estadoText == '1') ? 1 : 0;
            final superficie =
                double.tryParse(entry.value['superficie']!.text.trim()) ?? 0;

            /// Obtener UUID de la patología desde catálogo
            final result = await db.query(
              'patologias',
              columns: ['patologia_uuid'],
              where: 'tipo = ? AND ubicacion = ?',
              whereArgs: [
                entry.key['tipo'],
                entry.key['ubicacion'],
              ],
              limit: 1,
            );

            if (result.isEmpty) {
              debugPrint(
                '⚠️ Patología no encontrada: ${entry.key['tipo']} - ${entry.key['ubicacion']}',
              );
              continue;
            }

            final patologiaUuid = result.first['patologia_uuid'] as String;

            await db.insert(
              'patologias_pisocielo',
              {
                'patologia_pisocielo_uuid': uuid.v4(),
                'pisocielo_uuid': pisocieloUuid,
                'patologia_uuid': patologiaUuid,
                'tipo': tipo,
                'estado': estado,
                'superficie': superficie,
                'sync_status': 0,
                'updated_at': now,
              },
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
            debugPrint(
              '✅ Patología asociada al piso $pisocieloUuid → $patologiaUuid',
            );

        };
        break;
      case 'Cielo':

      /// Mapa: (tipo + ubicación) → controllers
        final Map<Map<String, String>, Map<String, TextEditingController>> patologias = {
          {
            'tipo': 'Manchas de humedad / moho',
            'ubicacion': 'Perímetro',
          }: {
            'estado': pisocielo.mh_perimetroCieloController,
            'superficie': pisocielo.mh_supperimetroCieloController,
          },
          {
            'tipo': 'Manchas de humedad / moho',
            'ubicacion': 'Área central',
          }: {
            'estado': pisocielo.mh_aCentralCieloController,
            'superficie': pisocielo.mh_supaCentralCieloController,
          },
          {
            'tipo': 'Manchas de humedad / moho',
            'ubicacion': 'Puntual localizada y/o extendida',
          }: {
            'estado': pisocielo.mh_punlocCieloController,
            'superficie': pisocielo.mh_supPunlocCieloController,
          },
          //DF
          {
            'tipo': 'Daño físico mecánico',
            'ubicacion': 'Perímetro',
          }: {
            'estado': pisocielo.df_perimetroCieloController,
            'superficie': pisocielo.df_supperimetroCieloController,
          },
          {
            'tipo': 'Daño físico mecánico',
            'ubicacion': 'Área central',
          }: {
            'estado': pisocielo.df_aCentralCieloController,
            'superficie': pisocielo.df_supaCentralCieloController,
          },
          {
            'tipo': 'Daño físico mecánico',
            'ubicacion': 'Puntual localizada y/o extendida',
          }: {
            'estado': pisocielo.df_punlocCieloController,
            'superficie': pisocielo.df_supPunlocCieloController,
          },

        };
        for (final entry in patologias.entries) {
          final estadoText = entry.value['estado']!.text.trim();
          if (estadoText.isEmpty) continue;

          final estado =
          (estadoText.toLowerCase() == 'si' || estadoText == '1') ? 1 : 0;
          final superficie =
              double.tryParse(entry.value['superficie']!.text.trim()) ?? 0;

          /// Obtener UUID de la patología desde catálogo
          final result = await db.query(
            'patologias',
            columns: ['patologia_uuid'],
            where: 'tipo = ? AND ubicacion = ?',
            whereArgs: [
              entry.key['tipo'],
              entry.key['ubicacion'],
            ],
            limit: 1,
          );

          if (result.isEmpty) {
            debugPrint(
              '⚠️ Patología no encontrada: ${entry.key['tipo']} - ${entry.key['ubicacion']}',
            );
            continue;
          }

          final patologiaUuid = result.first['patologia_uuid'] as String;

          await db.insert(
            'patologias_pisocielo',
            {
              'patologia_pisocielo_uuid': uuid.v4(),
              'pisocielo_uuid': pisocieloUuid,
              'patologia_uuid': patologiaUuid,
              'tipo': tipo,
              'estado': estado,
              'superficie': superficie,
              'sync_status': 0,
              'updated_at': now,
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          debugPrint(
            '✅ Patología asociada al Cielo $pisocieloUuid → $patologiaUuid',
          );

        };
        break;



    }


  }
  // ---------------------------------------------------------------------------
  // BORRAR BASE DE DATOS (solo para desarrollo)
  // ---------------------------------------------------------------------------


  static Future<int> borrarDato({
    required String tabla,
    required String idColumn,
    required String uuid,
  }) async {
    final db = await database;

    return await db.delete(
      tabla,
      where: '$idColumn = ?',
      whereArgs: [uuid],
    );
  }


  static Future<void> borrarBaseDeDatos() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);

    if (await File(path).exists()) {
      await deleteDatabase(path);
      _database = null; // 🔴 importante: reinicia la instancia
      debugPrint('🗑️ Base de datos eliminada');
    } else {
      debugPrint('ℹ️ No existe la base de datos');
    }
  }





}


class SistemasVentilacionUUID {
  static const aireador = 'SYS-VENT-AIREADOR';
  static const extractor = 'SYS-VENT-EXTRACTOR';
  static const campana = 'SYS-VENT-CAMPANA';
  static const celosiaPuerta = 'SYS-VENT-CELOSIA-PUERTA';
  static const rebajePuerta = 'SYS-VENT-REBAJE-PUERTA';
  static const otro = 'SYS-VENT-OTRO';
}

class PatologiasUUID {
  static const humEsqMuro = 'PAT-HUM-ESQ-MURO';
  static const humCieloMuro = 'PAT-HUM-CIELO-MURO';
  static const humPisoMuro = 'PAT-HUM-PISO-MURO';
  static const humRasgoVentana = 'PAT-HUM-RASGO-VENTANA';
  static const humBajoVentana = 'PAT-HUM-BAJO-VENTANA';
  static const humAreaCentral = 'PAT-HUM-AREA-CENTRAL';
  static const humPuntual = 'PAT-HUM-PUNTUAL';
  static const humPerimetro = 'PAT-HUM-PERIMETRO';

  static const danEsqMuro = 'PAT-DAN-ESQ-MURO';
  static const danCieloMuro = 'PAT-DAN-CIELO-MURO';
  static const danPisoMuro = 'PAT-DAN-PISO-MURO';
  static const danRasgoVentana = 'PAT-DAN-RASGO-VENTANA';
  static const danBajoVentana = 'PAT-DAN-BAJO-VENTANA';
  static const danAreaCentral = 'PAT-DAN-AREA-CENTRAL';
  static const danPuntual = 'PAT-DAN-PUNTUAL';
  static const danPerimetro = 'PAT-DAN-PERIMETRO';
}


