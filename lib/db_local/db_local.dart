import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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

    debugPrint('📁 DB PATH: $path');

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
    debugPrint('🟢 CREANDO BASE DE DATOS v$version');

    try {
      await db.execute(_crearInspecciones);
      debugPrint('✅ Tabla inspecciones creada');

      await db.execute(_crearProyectos);
      debugPrint('✅ Tabla proyectos creada');

      await db.execute(_crearViviendas);
      debugPrint('✅ Tabla viviendas creada');

      await db.execute(_crearRecintos);
      debugPrint('✅ Tabla recintos creada');

      await db.execute(_crearMuros);
      debugPrint('✅ Tabla muros creada');

      await db.execute(_crearPisoCielo);
      debugPrint('✅ Tabla pisocielo creada');

      await db.execute(_crearPatologias);
      debugPrint('✅ Tabla patologias_elemento creada');

      await insertarListadoPatologias(db);
      debugPrint('✅ Tabla patologias predefinidos creada');

      await db.execute(_crearSistemas_Ventilacion);
      debugPrint('✅ Tabla sistemas_ventilacion creada');

      await insertarListadoSistemas(db);
      debugPrint('✅ Tabla sistemas_ventilacion predefinidos creada');

      await db.execute(_crearPatologias_Muro);
      debugPrint('✅ Tabla patologias_elemento creada');

      await db.execute(_crearPatologias_PisoCielo);
      debugPrint('✅ Tabla patologias_elemento creada');

      await db.execute(_crearRecinto_Ventilacion);
      debugPrint('✅ Tabla recinto_ventilacion creada');


      debugPrint('🎉 TODAS LAS TABLAS CREADAS CORRECTAMENTE');
    } catch (e) {
      debugPrint('❌ ERROR CREANDO LA BASE DE DATOS: $e');
      rethrow;
    }
  }


  static const _crearProyectos = '''
  CREATE TABLE proyectos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_proyecto TEXT,
    region TEXT,
    comuna TEXT,
    etapa TEXT

  );
  ''';


  static Future<int> insertarProyecto(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('proyectos', data);
  }

  static Future<List<Map<String, dynamic>>> obtenerProyectos() async {
    final db = await database;
    return await db.query('proyectos', orderBy: 'nombre_proyecto ASC');
  }


  static const _crearInspecciones = '''
  CREATE TABLE inspecciones (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    uuid TEXT NOT NULL,
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
    sync_status INTEGER
  );
  ''';


  static Future<int> insertarInspeccion(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(
        'inspecciones',
        data
    );
  }


  static const _crearViviendas = '''
  CREATE TABLE viviendas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    proyecto_id INTEGER NOT NULL,
    tipologia_vivienda TEXT,
    direccion TEXT,
    superficie FLOAT,
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
  
    FOREIGN KEY (proyecto_id)
      REFERENCES proyectos(id)
      ON DELETE CASCADE
  );
  ''';


  static Future<int> insertarVivienda(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(
        'viviendas',
        data
    );
  }



  static const _crearRecintos = '''
    CREATE TABLE recintos (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      vivienda_id INTEGER,
      nombre_recinto TEXT,
      patologias_visibles INTEGER NOT NULL CHECK (patologias_visibles IN (0,1)),
      manifestaciones_ocultas INTEGER NOT NULL CHECK (manifestaciones_ocultas IN (0,1)),
      detalles_manifestaciones TEXT,
      olor_humedad INTEGER NOT NULL CHECK (olor_humedad IN (0,1)),
      modificaciones INTEGER NOT NULL CHECK (modificaciones IN (0,1)),
      detalles_modificaciones TEXT,
      calefaccion TEXT,
      tiempo_calefaccion INTEGER,
      
      FOREIGN KEY (vivienda_id)
        REFERENCES viviendas(id)
        ON DELETE CASCADE
    );
  ''';

  static Future<int> insertarRecinto(Map<String, dynamic> data) async {
    final db = await database;
    try {
      return await db.insert('recintos', data);
    } catch (e) {
      debugPrint('❌ Error insertando recinto: $e');
      debugPrint('📄 Data: $data');
      rethrow;
    }
  }

  static const _crearMuros = '''
    CREATE TABLE muros (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
    
      recinto_id INTEGER,
      nombre_muro TEXT,

      tipo_muro INTEGER NOT NULL CHECK (tipo_muro IN (0,1)),
      superficie REAL,
      superficie_ventana REAL,
    
      nivel_afectacion INTEGER NOT NULL CHECK (nivel_afectacion IN (0,1,2,3)),
    
      FOREIGN KEY (recinto_id)
        REFERENCES recintos(id)
        ON DELETE CASCADE
    );
  ''';

  static Future<int> insertarMuros(Map<String, dynamic> data) async {
    final db = await database;
    try {
      return await db.insert('muros', data);
    } catch (e) {
      debugPrint('❌ Error insertando muros: $e');
      debugPrint('📄 Data: $data');
      rethrow;
    }
  }

  static const _crearPisoCielo  = '''
    CREATE TABLE pisocielo (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
    
      recinto_id INTEGER,
      tipo TEXT,              
      superficie REAL,
      nivel_afectacion INTEGER NOT NULL CHECK (nivel_afectacion IN (0,1,2,3)),
    
      FOREIGN KEY (recinto_id)
        REFERENCES recintos(id)
        ON DELETE CASCADE
    );
  ''';

  static Future<int> insertarPisoCielo(Map<String, dynamic> data) async {
    final db = await database;
    try {
      return await db.insert('pisocielo', data);
    } catch (e) {
      debugPrint('❌ Error insertando piso/cielo: $e');
      debugPrint('📄 Data: $data');
      rethrow;
    }
  }


  static const _crearPatologias = '''
    CREATE TABLE patologias (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tipo TEXT NOT NULL,           
    ubicacion TEXT NOT NULL    
  );
  ''';

  static Future<void> insertarListadoPatologias(Database db) async {
    final patologias = [
      {'tipo': 'Manchas de humedad / moho', 'ubicacion': 'Encuentro esquina muro'},
      {'tipo': 'Manchas de humedad / moho', 'ubicacion': 'Encuentro cielo muro'},
      {'tipo': 'Manchas de humedad / moho', 'ubicacion': 'Encuentro piso muro'},
      {'tipo': 'Manchas de humedad / moho', 'ubicacion': 'Rasgo de ventana'},
      {'tipo': 'Manchas de humedad / moho', 'ubicacion': 'Puntual'},
      {'tipo': 'Manchas de humedad / moho', 'ubicacion': 'Bajo ventana (antepecho)'},
      {'tipo': 'Manchas de humedad / moho', 'ubicacion': 'Área central'},
      {'tipo': 'Manchas de humedad / moho', 'ubicacion': 'Puntual localizada y/o extendida'},
      {'tipo': 'Manchas de humedad / moho', 'ubicacion': 'Perímetro'},
      {'tipo': 'Daño físico mecánico', 'ubicacion': 'Encuentro esquina muro'},
      {'tipo': 'Daño físico mecánico', 'ubicacion': 'Encuentro cielo muro'},
      {'tipo': 'Daño físico mecánico', 'ubicacion': 'Encuentro piso muro'},
      {'tipo': 'Daño físico mecánico', 'ubicacion': 'Rasgo de ventana'},
      {'tipo': 'Daño físico mecánico', 'ubicacion': 'Puntual'},
      {'tipo': 'Daño físico mecánico', 'ubicacion': 'Bajo ventana (antepecho)'},
      {'tipo': 'Daño físico mecánico', 'ubicacion': 'Área central'},
      {'tipo': 'Daño físico mecánico', 'ubicacion': 'Puntual localizada y/o extendida'},
      {'tipo': 'Daño físico mecánico', 'ubicacion': 'Perímetro'},
    ];

    for (var patologia in patologias) {
      await db.insert(
        'patologias',
        patologia,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  static const _crearPatologias_Muro = '''
    CREATE TABLE patologias_muro (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      muro_id INTEGER NOT NULL,
      patologia_id INTEGER NOT NULL,  
      estado INTEGER NOT NULL CHECK (estado IN (0,1)),
      superficie TEXT NOT NULL,     
    
      FOREIGN KEY (muro_id)
        REFERENCES muros(id)
        ON DELETE CASCADE,
      FOREIGN KEY (patologia_id)
        REFERENCES patologias(id)
        ON DELETE CASCADE
    );

  ''';

  static Future<int> insertarPatologiasMuro(Map<String, dynamic> data) async {
    final db = await database;
    try {
      return await db.insert('patologias_muro', data);
    } catch (e) {
      debugPrint('❌ Error insertando patologias_muro: $e');
      debugPrint('📄 Data: $data');
      rethrow;
    }
  }


  static const _crearPatologias_PisoCielo = '''
    CREATE TABLE patologias_pisocielo(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
      pisocielo_id INTEGER NOT NULL,
      patologia_id INTEGER NOT NULL,  
      tipo TEXT NOT NULL,
      estado INTEGER NOT NULL CHECK (estado IN (0,1)),
      superficie REAL,     
    
      FOREIGN KEY (pisocielo_id)
        REFERENCES pisocielo(id)
        ON DELETE CASCADE,
      FOREIGN KEY (patologia_id)
        REFERENCES patologias(id)
        ON DELETE CASCADE
    );
  ''';



  static const _crearSistemas_Ventilacion = '''
    CREATE TABLE sistemas_ventilacion (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nombre_sistema TEXT NOT NULL
    );
  ''';

  static Future<void> insertarListadoSistemas(Database db) async {
    final sistemas = [
      {'nombre_sistema': 'Aireador'},
      {'nombre_sistema': 'Extractor'},
      {'nombre_sistema': 'Campana'},
      {'nombre_sistema': 'Celosía puerta'},
      {'nombre_sistema': 'Rebaje puerta'},
      {'nombre_sistema': 'Otro'},
    ];

    for (var sistema in sistemas) {
      await db.insert(
        'sistemas_ventilacion',
        sistema,
        conflictAlgorithm: ConflictAlgorithm.ignore, // evita duplicados
      );
    }
  }

  static const _crearRecinto_Ventilacion = '''
    CREATE TABLE recintos_ventilacion (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      recinto_id INTEGER NOT NULL,
      sistema_ventilacion_id INTEGER NOT NULL,
      estado TEXT,
      FOREIGN KEY (recinto_id) REFERENCES recintos(id) ON DELETE CASCADE,
      FOREIGN KEY (sistema_ventilacion_id) REFERENCES sistemas_ventilacion(id) ON DELETE CASCADE
    );
    ''';
  // ---------------------------------------------------------------------------
  // FUNCIONES DE RELACIONES
  // ---------------------------------------------------------------------------

  static Future<void> insertarPatologiasPisoCielo(
      int pisocielo_id, String tipo, HojaPisoCielo pisocielo) async {

    final db = await database;

    switch(tipo) {
      case 'Piso':
        // Mapa de patologia_id a sus controllers de estado y superficie
        final Map<int, Map<String, TextEditingController>> patologias = {
          7: {
            'estado': pisocielo.mh_aCentralPisoController,
            'superficie': pisocielo.mh_supaCentralPisoController,
          },
          8: {
            'estado': pisocielo.mh_punlocPisoController,
            'superficie': pisocielo.mh_supPunlocPisoController,
          },
          9: {
            'estado': pisocielo.mh_perimetroPisoController,
            'superficie': pisocielo.mh_supperimetroPisoController,
          },
          16: {
            'estado': pisocielo.df_aCentralPisoController,
            'superficie': pisocielo.df_supaCentralPisoController,
          },
          17: {
            'estado': pisocielo.df_punlocPisoController,
            'superficie': pisocielo.df_supPunlocPisoController,
          },
          18: {
            'estado': pisocielo.df_perimetroPisoController,
            'superficie': pisocielo.df_supperimetroPisoController,
          },
        };

        for (var entry in patologias.entries) {
          final patologiaId = entry.key;



          final estadoText = entry.value['estado']!.text.trim();
          final superficieText = entry.value['superficie']!.text.trim();



          if (estadoText.isNotEmpty) {
            final estado = (estadoText.toLowerCase() == 'si' || estadoText == '1') ? 1 : 0;
            final superficie = double.tryParse(superficieText) ?? 0;

            await db.insert(
              'patologias_pisocielo',
              {
                'pisocielo_id': pisocielo_id,
                'patologia_id': patologiaId,
                'tipo': tipo,
                'estado': estado,
                'superficie': superficie,
              },
              conflictAlgorithm: ConflictAlgorithm.replace,
            );

            debugPrint('✅ Patología insertada: $patologiaId, estado: $estado, superficie: $superficie, piso/cielo ID: $pisocielo_id');
          }
        }
          break;


        case 'Cielo':
        // Mapa de patologia_id a sus controllers de estado y superficie
          final Map<int, Map<String, TextEditingController>> patologias = {
            7: {
              'estado': pisocielo.mh_aCentralCieloController,
              'superficie': pisocielo.mh_supaCentralCieloController,
            },
            8: {
              'estado': pisocielo.mh_punlocCieloController,
              'superficie': pisocielo.mh_supPunlocCieloController,
            },
            9: {
              'estado': pisocielo.mh_perimetroCieloController,
              'superficie': pisocielo.mh_supperimetroCieloController,
            },
            16: {
              'estado': pisocielo.df_aCentralCieloController,
              'superficie': pisocielo.df_supaCentralCieloController,
            },
            17: {
              'estado': pisocielo.df_punlocCieloController,
              'superficie': pisocielo.df_supPunlocCieloController,
            },
            18: {
              'estado': pisocielo.df_perimetroCieloController,
              'superficie': pisocielo.df_supperimetroCieloController,
            },
          };
          for (var entry in patologias.entries) {
            final patologiaId = entry.key;
            final estadoText = entry.value['estado']!.text.trim();
            final superficieText = entry.value['superficie']!.text.trim();


            if (estadoText.isNotEmpty) {
              final estado = (estadoText.toLowerCase() == 'si' || estadoText == '1') ? 1 : 0;
              final superficie = double.tryParse(superficieText) ?? 0;

              await db.insert(
                'patologias_pisocielo',
                {
                  'pisocielo_id': pisocielo_id,
                  'patologia_id': patologiaId,
                  'tipo': tipo,
                  'estado': estado,
                  'superficie': superficie,
                },
                conflictAlgorithm: ConflictAlgorithm.replace,
              );

              debugPrint('✅ Patología insertada: $patologiaId, estado: $estado, superficie: $superficie, piso/cielo ID: $pisocielo_id');
            }
          }

          break;

    };



  }



  static Future<void> asociarSistemasARecinto(
      int recinto_id, Recinto recinto) async {

    final db = await database;

    // Mapa de sistema_id a controller
    final Map<int, TextEditingController> sistemas = {
      1: recinto.aireadorController,
      2: recinto.extractorController,
      3: recinto.campanaController,
      4: recinto.celosiapueController,
      5: recinto.rebajepueController,
      6: recinto.otroequipController,
    };

    for (var entry in sistemas.entries) {
      final sistema_id = entry.key;
      final estado = entry.value.text.trim();

      // Solo insertar si hay un estado definido
      if (estado.isNotEmpty) {
        await db.insert(
          'recintos_ventilacion',
          {
            'recinto_id': recinto_id,
            'sistema_ventilacion_id': sistema_id,
            'estado': estado,
          },
          conflictAlgorithm: ConflictAlgorithm.replace, // actualiza si ya existe
        );
      }
      debugPrint('✅ Sistema asociado: $sistema_id - $estado - $recinto_id');
    }
  }


  // ---------------------------------------------------------------------------
  // BORRAR BASE DE DATOS (solo para desarrollo)
  // ---------------------------------------------------------------------------

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


