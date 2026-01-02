import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

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

    await db.execute(_crearInspecciones);
    await db.execute(_crearProyectos);
    await db.execute(_crearViviendas);
    await db.execute(_crearRecintos);
    await db.execute(_crearElementos_de_Recintos);
    await db.execute(_crearPatologias_Elemento);
    await db.execute(_crearSistemas_Calefaccion);
    await db.execute(_crearRecinto_Calefaccion);
    await db.execute(_crearSistemas_Ventilacion);
    await db.execute(_crearRecinto_Ventilacion);

    debugPrint('✅ TODAS LAS TABLAS CREADAS');
  }

  static const _crearProyectos = '''
  CREATE TABLE proyectos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
  
    inspeccion_id INTEGER NOT NULL,
  
    region TEXT,
    comuna TEXT,
    etapa TEXT,
  
    FOREIGN KEY (inspeccion_id)
      REFERENCES inspecciones(id)
      ON DELETE CASCADE
  );
  ''';


  static Future<int> insertarProyecto(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(
        'proyectos',
        data
    );
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
      teimpo_calefaccion INTEGER
    );
  ''';

  static const _crearElementos_de_Recintos = '''
    CREATE TABLE elementos_de_recintos (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      uuid TEXT NOT NULL,
    
      recinto_uuid TEXT NOT NULL,
    
      tipo TEXT NOT NULL,           -- muro | piso | cielo
      tipo_muro TEXT,              -- exterior | interior | sin_muro
      superficie REAL,
      superficie_ventana REAL,
    
      nivel_afectacion TEXT,        -- Nulo | Bajo | Medio | Alto
    
      observaciones TEXT
    );
  ''';

  static const _crearPatologias_Elemento = '''
    CREATE TABLE patologias_elemento (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      uuid TEXT NOT NULL,
    
      elemento_uuid TEXT NOT NULL,
    
      tipo_patologia TEXT NOT NULL,     -- Humedad / moho | Daño físico mecánico
      ubicacion TEXT NOT NULL,          -- Perímetro | Área central | Puntual | Total
    
      superficie_afectada TEXT,
    
      observaciones TEXT
    );
  ''';

  static const _crearSistemas_Calefaccion = '''
    CREATE TABLE sistemas_calefaccion (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      uuid TEXT NOT NULL,
    
      nombre TEXT NOT NULL,       -- electrico | gas | parafina | biomasa
      condicion TEXT,             -- seca | humeda
      evacuacion TEXT             -- exterior | interior | sin_evacuacion
    );
  ''';

  static const _crearRecinto_Calefaccion = '''
    CREATE TABLE recinto_calefaccion (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      uuid TEXT NOT NULL,
      recinto_uuid TEXT NOT NULL,
      sistema_calefaccion_uuid TEXT NOT NULL,
      descripcion_otro TEXT
    );
  ''';

  static const _crearSistemas_Ventilacion = '''
    CREATE TABLE sistemas_ventilacion (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      uuid TEXT NOT NULL,
      nombre TEXT NOT NULL
    );
  ''';

  static const _crearRecinto_Ventilacion = '''
    CREATE TABLE recinto_ventilacion (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      uuid TEXT NOT NULL,
      recinto_uuid TEXT NOT NULL,
      sistema_ventilacion_uuid TEXT NOT NULL,
      operativo INTEGER NOT NULL CHECK (operativo IN (0,1)),
      ubicacion TEXT,
      descripcion_otro TEXT
    );
  ''';

  // =====================================================
// CRUD INSPECCIONES
// =====================================================

  /// READ (todas)
  static Future<List<Map<String, dynamic>>> obtenerInspecciones() async {
    final db = await database;
    return await db.query(
      'inspecciones',
      orderBy: 'fecha DESC',
    );
  }

  /// READ (por UUID)
  static Future<Map<String, dynamic>?> obtenerInspeccionPorUuid(
      String uuid) async {
    final db = await database;

    final result = await db.query(
      'inspecciones',
      where: 'uuid = ?',
      whereArgs: [uuid],
      limit: 1,
    );

    if (result.isEmpty) return null;
    return result.first;
  }

  /// UPDATE (por UUID)
  static Future<int> actualizarInspeccion(
      String uuid,
      Map<String, dynamic> data) async {
    final db = await database;
    return await db.update(
      'inspecciones',
      data,
      where: 'uuid = ?',
      whereArgs: [uuid],
    );
  }

  /// DELETE (por UUID)
  static Future<int> eliminarInspeccion(String uuid) async {
    final db = await database;
    return await db.delete(
      'inspecciones',
      where: 'uuid = ?',
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


