import 'package:cloud_firestore/cloud_firestore.dart';
import '../db_local/db_local.dart';

class SyncService {
  // ---------------------------
  // SYNC ALL
  // ---------------------------
  static Future<void> syncAll() async {
    await syncPatologias();
    await syncSistemasVentilacion();
    await syncProyectos();
    await syncInspecciones();
    await syncViviendas();
    await syncRecintos();
    await syncMuros();
    await syncPisoCielo();
    await syncVentilacionRecintos();
    await syncPatologiasMuros();
    await syncPatologiasPisoCielo();

  }

  // ---------------------------
  // PROYECTOS
  // ---------------------------
  static Future<void> syncProyectos() async {
    final db = await LocalDatabase.database;
    final proyectos = await db.query('proyectos');
    final collection = FirebaseFirestore.instance.collection('proyectos');

    final querySnapshot = await collection.get();
    for (final doc in querySnapshot.docs) {
      final data = doc.data();
      final proyectoUuid = doc.id;

      final exist = await db.query(
        'proyectos',
        where: 'proyecto_uuid = ?',
        whereArgs: [proyectoUuid],
        limit: 1,
      );

      if (exist.isEmpty) {
        await db.insert('proyectos', {
          'proyecto_uuid': proyectoUuid,
          'nombre_proyecto': data['nombre_proyecto'] ?? '',
          'region': data['region'] ?? '',
          'comuna': data['comuna'] ?? '',
          'etapa': data['etapa'] ?? '',
          'sync_status': 1,
          'updated_at': data['updated_at'] ?? 0,
        });
      } else {
        await db.update(
          'proyectos',
          {
            'nombre_proyecto': data['nombre_proyecto'] ?? '',
            'region': data['region'] ?? '',
            'comuna': data['comuna'] ?? '',
            'etapa': data['etapa'] ?? '',
            'sync_status': 1,
            'updated_at': data['updated_at'] ?? 0,
          },
          where: 'proyecto_uuid = ?',
          whereArgs: [proyectoUuid],
        );
      }
    }

    for (final proyecto in proyectos) {
      final docId = (proyecto['proyecto_uuid'] ?? proyecto['id']).toString();

      await collection.doc(docId).set(
        {
          'nombre_proyecto': proyecto['nombre_proyecto']?.toString() ?? '',
          'region': proyecto['region']?.toString() ?? '',
          'comuna': proyecto['comuna']?.toString() ?? '',
          'etapa': proyecto['etapa']?.toString() ?? '',
          'sync_status': proyecto['sync_status'] ?? 0,
          'updated_at': proyecto['updated_at'] ?? 0,
        },
        SetOptions(merge: true),
      );
    }
  }

  // ---------------------------
  // INSPECCIONES
  // ---------------------------
  static Future<void> syncInspecciones() async {
    final db = await LocalDatabase.database;
    final inspecciones = await db.query('inspecciones');
    final collection = FirebaseFirestore.instance.collection('inspecciones');

    for (final inspeccion in inspecciones) {
      final docId = (inspeccion['inspeccion_uuid'] ?? inspeccion['id']).toString();

      try {
        await collection.doc(docId).set({
          'proyecto_uuid': inspeccion['proyecto_uuid']?.toString() ?? '',
          'fecha': inspeccion['fecha']?.toString() ?? '',
          'hora_ingreso': inspeccion['hora_ingreso']?.toString() ?? '',
          'hora_salida': inspeccion['hora_salida']?.toString() ?? '',
          'recibido_por': inspeccion['recibido_por']?.toString() ?? '',
          'nombre_receptor': inspeccion['nombre_receptor']?.toString() ?? '',
          'nombre_inspector': inspeccion['nombre_inspector']?.toString() ?? '',
          'rut_inspector': inspeccion['rut_inspector']?.toString() ?? '',
          'clima': inspeccion['clima']?.toString() ?? '',
          'estado': "sincronizado",
          'sync_status': 1,
          'updated_at': inspeccion['updated_at'] ?? 0,
        }, SetOptions(merge: true));
        await db.update(
          'inspecciones',
          {'estado': 'sincronizado',
            'sync_status': 1
          },
          where: 'id = ?',
          whereArgs: [inspeccion['id']],
        );
      } catch (e) {

      }
    }
  }

  // ---------------------------
  // VIVIENDAS
  // ---------------------------
  static Future<void> syncViviendas() async {
    final db = await LocalDatabase.database;
    final viviendas = await db.query('viviendas');
    final collection = FirebaseFirestore.instance.collection('viviendas');

    for (final vivienda in viviendas) {
      final docId = (vivienda['vivienda_uuid'] ?? vivienda['id']).toString();

      try {
        await collection.doc(docId).set({
          'vivienda_uuid': vivienda['vivienda_uuid']?.toString() ?? '',
          'inspeccion_uuid': vivienda['inspeccion_uuid']?.toString() ?? '',
          'tipologia_vivienda': vivienda['tipologia_vivienda']?.toString() ?? '',
          'direccion': vivienda['direccion']?.toString() ?? '',
          'superficie': vivienda['superficie']?.toString() ?? '',
          'n_pisos': vivienda['n_pisos']?.toString() ?? '',
          'orientacion_fachada': vivienda['orientacion_fachada']?.toString() ?? '',
          'orientacion_acceso': vivienda['orientacion_acceso']?.toString() ?? '',
          'temp_exterior': vivienda['temp_exterior'] ?? 0,
          'hum_exterior': vivienda['hum_exterior'] ?? 0,
          'temp_interior': vivienda['temp_interior'] ?? 0,
          'hum_interior': vivienda['hum_interior'] ?? 0,
          'a_de_uso': vivienda['a_de_uso'] ?? 0,
          'reparaciones': vivienda['reparaciones'] ?? 0,
          'detalle_reparaciones': vivienda['detalle_reparaciones']?.toString() ?? '',
          'ampliaciones': vivienda['ampliaciones'] ?? 0,
          'detalle_ampliaciones': vivienda['detalle_ampliaciones']?.toString() ?? '',
          'observaciones': vivienda['observaciones']?.toString() ?? '',
          'n_recintos': vivienda['n_recintos'] ?? 0,
          'total_habitantes': vivienda['total_habitantes'] ?? 0,
          'num_adultos': vivienda['num_adultos'] ?? 0,
          'num_menores': vivienda['num_menores'] ?? 0,
          'num_adul_mayores': vivienda['num_adul_mayores'] ?? 0,
          'ocup_dia_comp': vivienda['ocup_dia_comp'] ?? 0,
          'ocup_intermitente': vivienda['ocup_intermitente'] ?? 0,
          'dens_ocup_prev': vivienda['dens_ocup_prev'] ?? 0,
          'dens_ocup_real': vivienda['dens_ocup_real'] ?? 0,
          'observaciones_ocupacion': vivienda['observaciones_ocupacion']?.toString() ?? '',


          'sync_status': 1,
          'updated_at': vivienda['updated_at'] ?? 0,
        }, SetOptions(merge: true));

        await db.update(
          'viviendas',
          {'sync_status': 1},
          where: 'id = ?',
          whereArgs: [vivienda['id']],
        );

      } catch (e) {

      }
    }
  }

  // ---------------------------
  // RECINTOS
  // ---------------------------
  static Future<void> syncRecintos() async {
    final db = await LocalDatabase.database;
    final recintos = await db.query('recintos');
    final collection = FirebaseFirestore.instance.collection('recintos');

    for (final recinto in recintos) {
      final docId = (recinto['recintos_uuid'] ?? recinto['id']).toString();

      try {
        await collection.doc(docId).set({
          'inspeccion_uuid': recinto['inspeccion_uuid']?.toString() ?? '',
          'vivienda_uuid': recinto['vivienda_uuid']?.toString() ?? '',
          'nombre_recinto': recinto['nombre_recinto']?.toString() ?? '',
          'patologias_visibles': recinto['patologias_visibles'] ?? 0,
          'manifestaciones_ocultas': recinto['manifestaciones_ocultas'] ?? 0,
          'detalles_manifestaciones': recinto['detalles_manifestaciones']?.toString() ?? '',
          'olor_humedad': recinto['olor_humedad'] ?? 0,
          'modificaciones': recinto['modificaciones'] ?? 0,
          'calefaccion': recinto['calefaccion']?.toString() ?? '',
          'tiempo_calefaccion': recinto['tiempo_calefaccion'] ?? 0,

          'sync_status': 1,
          'updated_at': recinto['updated_at'] ?? 0,
        }, SetOptions(merge: true));

        await db.update(
          'recintos',
          {'sync_status': 1},
          where: 'id = ?',
          whereArgs: [recinto['id']],
        );

      } catch (e) {

      }
    }
  }

  // ---------------------------
  // MUROS
  // ---------------------------
  static Future<void> syncMuros() async {
    final db = await LocalDatabase.database;
    final muros = await db.query('muros');
    final collection = FirebaseFirestore.instance.collection('muros');

    for (final muro in muros) {
      final docId = (muro['muro_uuid'] ?? muro['id']).toString();

      try {

        await collection.doc(docId).set({
          'recinto_uuid': muro['recinto_uuid']?.toString() ?? '',
          'nombre_muro': muro['nombre_muro']?.toString() ?? '',
          'tipo_muro': muro['tipo_muro'] ?? 0,
          'superficie': (muro['superficie'] is num)
              ? (muro['superficie'] as num).toDouble()
              : 0.0,
          'superficie_ventana': (muro['superficie_ventana'] is num)
              ? (muro['superficie_ventana'] as num).toDouble()
              : 0.0,
          'nivel_afectacion': muro['nivel_afectacion'] ?? 0,

          'sync_status': 1,
          'updated_at': muro['updated_at'] ?? 0,
        }, SetOptions(merge: true));

        await db.update(
          'muros',
          {'sync_status': 1},
          where: 'id = ?',
          whereArgs: [muro['id']],
        );

      } catch (e) {
      }
    }
  }

  // ---------------------------
  // PATOLOGIAS MURO
  // ---------------------------
  static Future<void> syncPatologiasMuros() async {
    final db = await LocalDatabase.database;
    final patologias_muro = await db.query('patologias_muro');
    final collection = FirebaseFirestore.instance.collection('patologias_muro');

    for (final patologia_muro in patologias_muro) {
      final docId = (patologia_muro['patologia_muro_uuid'] ?? patologia_muro['id']).toString();

      try {
        await collection.doc(docId).set({
          'muro_uuid': patologia_muro['muro_uuid']?.toString() ?? '',
          'patologia_uuid': patologia_muro['patologia_uuid']?.toString() ?? '',
          'estado': patologia_muro['estado'] ?? 0,
          'superficie': (patologia_muro['superficie'] is num)
              ? (patologia_muro['superficie'] as num).toDouble()
              : 0.0,
          'sync_status': 1,
          'updated_at': patologia_muro['updated_at'] ?? 0,
        }, SetOptions(merge: true));

        await db.update(
          'patologias_muro',
          {'sync_status': 1},
          where: 'id = ?',
          whereArgs: [patologia_muro['id']],
        );

      } catch (e) {

      }
    }
  }

  // ---------------------------
  // VENTILACION RECINTOS
  // ---------------------------
  static Future<void> syncVentilacionRecintos() async {
    final db = await LocalDatabase.database;
    final ventilacion_recintos = await db.query('ventilacion_recintos');
    final collection = FirebaseFirestore.instance.collection('ventilacion_recintos');

    for (final ventilacion_recinto in ventilacion_recintos) {
      final docId = (ventilacion_recinto['ventilacion_recinto_uuid'] ?? ventilacion_recinto['id']).toString();

      try {
        await collection.doc(docId).set({
          'recinto_uuid': ventilacion_recinto['recinto_uuid']?.toString() ?? '',
          'sistema_ventilacion_uuid': ventilacion_recinto['sistema_ventilacion_uuid']?.toString() ?? '',
          'estado': ventilacion_recinto['estado'] ?? 0,
          'sync_status': 1,
          'updated_at': ventilacion_recinto['updated_at'] ?? 0,
        }, SetOptions(merge: true));

        await db.update(
          'ventilacion_recintos',
          {'sync_status': 1},
          where: 'id = ?',
          whereArgs: [ventilacion_recinto['id']],
        );


      } catch (e) {

      }
    }
  }


  // ---------------------------
  // PISOCIELO
  // ---------------------------
  static Future<void> syncPisoCielo() async {
    final db = await LocalDatabase.database;
    final pisoscielos = await db.query('pisocielo');
    final collection = FirebaseFirestore.instance.collection('pisocielo');

    for (final pisocielo in pisoscielos) {
      final docId = (pisocielo['pisocielo_uuid'] ?? pisocielo['id']).toString();

      try {
        await collection.doc(docId).set({
          'recinto_uuid': pisocielo['recinto_uuid']?.toString() ?? '',
          'tipo': pisocielo['tipo']?.toString() ?? '',
          'superficie': (pisocielo['superficie'] is num)
              ? (pisocielo['superficie'] as num).toDouble()
              : 0.0,
          'nivel_afectacion': pisocielo['nivel_afectacion'] ?? 0,

          'sync_status': 1,
          'updated_at': pisocielo['updated_at'] ?? 0,
        }, SetOptions(merge: true));


        await db.update(
          'pisocielo',
          {'sync_status': 1},
          where: 'id = ?',
          whereArgs: [pisocielo['id']],
        );

      } catch (e) {

      }
    }
  }

  // ---------------------------
  // PATOLOGIAS PISOCIELO
  // ---------------------------
  static Future<void> syncPatologiasPisoCielo() async {
    final db = await LocalDatabase.database;
    final patologias_pisocielo = await db.query('patologias_pisocielo');
    final collection = FirebaseFirestore.instance.collection('patologias_pisocielo');

    for (final patologia_pisocielo in patologias_pisocielo) {
      final docId = (patologia_pisocielo['patologia_pisocielo_uuid'] ?? patologia_pisocielo['id']).toString();

      try {
        await collection.doc(docId).set({
          'pisocielo_uuid': patologia_pisocielo['pisocielo_uuid']?.toString() ?? '',
          'patologia_uuid': patologia_pisocielo['patologia_uuid']?.toString() ?? '',
          'tipo': patologia_pisocielo['tipo']?.toString() ?? '',
          'estado': patologia_pisocielo['estado'] ?? 0,
          'superficie': (patologia_pisocielo['superficie'] is num)
              ? (patologia_pisocielo['superficie'] as num).toDouble()
              : 0.0,
          'sync_status': 1,
          'updated_at': patologia_pisocielo['updated_at'] ?? 0,
        }, SetOptions(merge: true));

        await db.update(
          'patologias_pisocielo',
          {'sync_status': 1},
          where: 'id = ?',
          whereArgs: [patologia_pisocielo['id']],
        );

      } catch (e) {

      }
    }
  }



  // ---------------------------
  // PATOLOGIAS
  // ---------------------------
  static Future<void> syncPatologias() async {
    final db = await LocalDatabase.database;
    final patologias = await db.query('patologias');
    final collection = FirebaseFirestore.instance.collection('patologias');

    for (final patologia in patologias) {
      final docId = (patologia['patologia_uuid'] ?? patologia['id']).toString();

      try {
        await collection.doc(docId).set({
          'tipo': patologia['tipo']?.toString() ?? '',
          'ubicacion': patologia['ubicacion']?.toString() ?? '',
          'sync_status': 1,
          'updated_at': patologia['updated_at'] ?? 0,
        }, SetOptions(merge: true));

        await db.update(
          'patologias',
          {'sync_status': 1},
          where: 'id = ?',
          whereArgs: [patologia['id']],
        );

      } catch (e) {

      }
    }
  }

  // ---------------------------
  // SISTEMAS DE VENTILACION
  // ---------------------------
  static Future<void> syncSistemasVentilacion() async {
    final db = await LocalDatabase.database;
    final sistemas_ventilacion = await db.query('sistemas_ventilacion');
    final collection = FirebaseFirestore.instance.collection('sistemas_ventilacion');

    for (final sistema_ventilacion in sistemas_ventilacion) {
      final docId = (sistema_ventilacion['sistema_ventilacion_uuid'] ?? sistema_ventilacion['id']).toString();

      try {
        await collection.doc(docId).set({
          'nombre_sistema': sistema_ventilacion['nombre_sistema']?.toString() ?? '',
          'sync_status': 1,
        }, SetOptions(merge: true));

        await db.update(
          'sistemas_ventilacion',
          {'sync_status': 1},
          where: 'id = ?',
          whereArgs: [sistema_ventilacion['id']],
        );

      } catch (e) {

      }
    }
  }

}
