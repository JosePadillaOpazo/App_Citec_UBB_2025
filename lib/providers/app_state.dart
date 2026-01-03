import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/rendering.dart' show RenderRepaintBoundary;
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
import 'package:file_picker/file_picker.dart';
import '../screens/inicio.dart';
import '../db_local/db_local.dart';


class AppState extends ChangeNotifier {

  // ---------------------------------------------------------------------------
  // Asignacion de variables y etiquetas para usar en el app
  // ---------------------------------------------------------------------------

  final picker = ImagePicker();
  final List<Recinto> recintos = [];
  final List<HojaMuro> hojasM = [];
  final List<HojaPisoCielo> hojasPC = [];
  int pantallaActual = 0;
  int cantFotos = 0;
  String? rutaGuardada;
  bool guardando = false;
  String? inspeccionUuid;

  //--> Uso con DB
  int? proyectoSeleccionadoId;
  List<Map<String, dynamic>> proyectos = [];
  Map<String, dynamic>? proyectoSeleccionado;



  //--> Fechas / horas
  String horaInicio = "00:00";
  String horaFin = "00:00";
  final String fechaFormateada = DateFormat('dd-MM-yyyy').format(DateTime.now());

  // ---------------------------------------------------------------------------
  // Flags de pantallas utilizadas
  // ---------------------------------------------------------------------------

  //-->Recinto 1
  bool muro_eje_p_info_r1 = false;
  bool muro_eje_p_r1 = false;
  bool muro_eje_b_r1 = false;
  bool muro_eje_c_r1 = false;
  bool muro_eje_d_r1 = false;
  bool muro_eje_e_r1 = false;
  bool muro_eje_f_r1 = false;
  bool muro_eje_g_r1 = false;
  bool muro_eje_h_r1 = false;
  bool piso_cielo_r1 = false;

  //-->Recinto 2
  bool muro_eje_p_info_r2 = false;
  bool muro_eje_p_r2 = false;
  bool muro_eje_b_r2 = false;
  bool muro_eje_c_r2 = false;
  bool muro_eje_d_r2 = false;
  bool muro_eje_e_r2 = false;
  bool muro_eje_f_r2 = false;
  bool muro_eje_g_r2 = false;
  bool muro_eje_h_r2 = false;
  bool piso_cielo_r2 = false;

  //-->Recinto 3
  bool muro_eje_p_info_r3 = false;
  bool muro_eje_p_r3 = false;
  bool muro_eje_b_r3 = false;
  bool muro_eje_c_r3 = false;
  bool muro_eje_d_r3 = false;
  bool muro_eje_e_r3 = false;
  bool muro_eje_f_r3 = false;
  bool muro_eje_g_r3= false;
  bool muro_eje_h_r3 = false;
  bool piso_cielo_r3 = false;

  //-->Recinto 4
  bool muro_eje_p_info_r4 = false;
  bool muro_eje_p_r4 = false;
  bool muro_eje_b_r4 = false;
  bool muro_eje_c_r4 = false;
  bool muro_eje_d_r4 = false;
  bool muro_eje_e_r4 = false;
  bool muro_eje_f_r4 = false;
  bool muro_eje_g_r4= false;
  bool muro_eje_h_r4 = false;
  bool piso_cielo_r4 = false;

  //-->Recinto 5
  bool muro_eje_p_info_r5 = false;
  bool muro_eje_p_r5 = false;
  bool muro_eje_b_r5 = false;
  bool muro_eje_c_r5 = false;
  bool muro_eje_d_r5 = false;
  bool muro_eje_e_r5 = false;
  bool muro_eje_f_r5 = false;
  bool muro_eje_g_r5= false;
  bool muro_eje_h_r5 = false;
  bool piso_cielo_r5 = false;

  // ---------------------------------------------------------------------------
  // IMAGEN DE LA HOJA INFO GENERAL
  // ---------------------------------------------------------------------------

  File? imagen1_Info_General;
  File? imagen1GuardadaInfoGeneral;
  File? imagen2_Info_General;
  File? imagen2GuardadaInfoGeneral;
  File? imagen3_Info_General;
  File? imagen3GuardadaInfoGeneral;
  File? imagen4_Info_General;
  File? imagen4GuardadaInfoGeneral;


  // ---------------------------------------------------------------------------
  // Controllers
  // ---------------------------------------------------------------------------

  //-->Formularios generales
  final TextEditingController nFichaController = TextEditingController();


  //-->Hoja Información general
  final TextEditingController nombreProyectoController = TextEditingController();
  final TextEditingController tipologiaViviendaController = TextEditingController();
  final TextEditingController regionController = TextEditingController();
  final TextEditingController comunasController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController etapaController = TextEditingController();
  final TextEditingController supViviendaController = TextEditingController();
  final TextEditingController nPisosController = TextEditingController();
  final TextEditingController oriFachadaController = TextEditingController();
  final TextEditingController oriFachadainfoController = TextEditingController();
  final TextEditingController oriAccesoController = TextEditingController();
  final TextEditingController oriAccesoinfoController = TextEditingController();
  final TextEditingController climaController = TextEditingController();
  final TextEditingController tempExteriorController = TextEditingController();
  final TextEditingController humExteriorController = TextEditingController();
  final TextEditingController tempInteriorController = TextEditingController();
  final TextEditingController humInteriorController = TextEditingController();
  final TextEditingController reciPorController = TextEditingController();
  final TextEditingController nombreReciController = TextEditingController();
  final TextEditingController nombreInspectorController = TextEditingController();
  final TextEditingController usoViviendaController = TextEditingController();
  final TextEditingController rutInspectorController = TextEditingController();
  final TextEditingController digVerifController = TextEditingController();
  final TextEditingController reparacionesController = TextEditingController();
  final TextEditingController detalleReparacionesController = TextEditingController();
  final TextEditingController ampliacionesController = TextEditingController();
  final TextEditingController detalleAmpliacionesController = TextEditingController();
  final TextEditingController obsInfoGeneralController = TextEditingController();
  final TextEditingController numRecintosController = TextEditingController();
  final TextEditingController totalHabitantesController = TextEditingController();
  final TextEditingController numAdultosController = TextEditingController();
  final TextEditingController numMenoresController = TextEditingController();
  final TextEditingController numAdulMayoresController = TextEditingController();
  final TextEditingController ocupDiaCompController = TextEditingController();
  final TextEditingController ocupIntermitenteController = TextEditingController();
  final TextEditingController densOcupPrevController = TextEditingController();
  final TextEditingController densOcupRealController = TextEditingController();
  final TextEditingController obsOcupVivController = TextEditingController();


  //-->Nombres de Recintos
  late TextEditingController recinto1_nombreController = TextEditingController(text: "Recinto 1");
  late TextEditingController recinto2_nombreController = TextEditingController(text: "Recinto 2");
  late TextEditingController recinto3_nombreController = TextEditingController(text: "Recinto 3");
  late TextEditingController recinto4_nombreController = TextEditingController(text: "Recinto 4");
  late TextEditingController recinto5_nombreController = TextEditingController(text: "Recinto 5");

  //-->Nombres de Muros Recinto 1 (tambien se utilizan para nombrar las hojas del excel)
  late TextEditingController r1_murop_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r1_murob_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r1_muroc_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r1_murod_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r1_muroe_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r1_murof_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r1_murog_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r1_pisocielo_nombreController = TextEditingController(text: "Piso Cielo");

  //-->Nombres de Muros Recinto 2 (tambien se utilizan para nombrar las hojas del excel)
  late TextEditingController r2_murop_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r2_murob_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r2_muroc_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r2_murod_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r2_muroe_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r2_murof_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r2_murog_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r2_pisocielo_nombreController = TextEditingController(text: "Piso Cielo");

  //-->Nombres de Muros Recinto 3 (tambien se utilizan para nombrar las hojas del excel)
  late TextEditingController r3_murop_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r3_murob_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r3_muroc_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r3_murod_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r3_muroe_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r3_murof_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r3_murog_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r3_pisocielo_nombreController = TextEditingController(text: "Piso Cielo");

//-->Nombres de Muros Recinto 4 (tambien se utilizan para nombrar las hojas del excel)
  late TextEditingController r4_murop_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r4_murob_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r4_muroc_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r4_murod_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r4_muroe_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r4_murof_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r4_murog_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r4_pisocielo_nombreController = TextEditingController(text: "Piso Cielo");

//-->Nombres de Muros Recinto 5 (tambien se utilizan para nombrar las hojas del excel)
  late TextEditingController r5_murop_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r5_murob_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r5_muroc_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r5_murod_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r5_muroe_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r5_murof_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r5_murog_nombreController = TextEditingController(text: "(__)");
  late TextEditingController r5_pisocielo_nombreController = TextEditingController(text: "Piso Cielo");


  //--------------------------------------------------------------------------------------------------------------------------------------------------------
  //                                                                            Funciones
  //---------------------------------------------------------------------------------------------------------------------------------------------------------

  Future<void> cargarProyectos() async {
    proyectos = await LocalDatabase.obtenerProyectos();
    notifyListeners();
  }

  void seleccionarProyecto(int? id) {
    proyectoSeleccionadoId = id;

    if (id == null) {
      proyectoSeleccionado = null;
    } else {
      proyectoSeleccionado = proyectos.firstWhere(
            (p) => p['id'] == id,
      );
    }

    notifyListeners();
  }



  Future<void> initApp() async {
    final db = await LocalDatabase.database;
    final tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table'"
    );

    debugPrint('📋 TABLAS EN BD: $tables');
  }

  void iniciarNuevaInspeccion() {
    inspeccionUuid = const Uuid().v4();
  }


  Future<void> guardar(context) async {
    await guardarInspeccion();
    await guardarExcel(context);
  }

  Future<void> guardarInspeccion() async {
    if (inspeccionUuid == null) {
      debugPrint('❌ No hay inspección activa');
      return;
    }

    //-------------------------------INSPECCIONES-------------------------------
    final inspeccionData = {
      'uuid': inspeccionUuid,
      'n_ficha': nFichaController.text,
      'fecha': fechaFormateada,
      'hora_ingreso': horaInicio,
      'hora_salida': horaFin,
      'recibido_por': reciPorController.text,
      'nombre_receptor': nombreReciController.text,
      'nombre_inspector': nombreInspectorController.text,
      'rut_inspector': rutInspectorController.text + "-" + digVerifController.text,
      'clima': climaController.text,
      'estado': 'en_progreso',
      'sync_status': 0,
    };

    await LocalDatabase.insertarInspeccion(inspeccionData);

    //-------------------------------VIVIENDAS-------------------------------

    int reparaciones_VF = 0;

    if (reparacionesController.text == "Si"){
      reparaciones_VF = 1;
    }

    int ampliaciones_VF = 0;

    if (ampliacionesController.text == "Si"){
      ampliaciones_VF = 1;
    }

    final viviendaData = {
      // 🔗 Relación
      'proyecto_id': proyectoSeleccionadoId,

      // 🏠 Datos generales
      'tipologia_vivienda': tipologiaViviendaController.text,
      'direccion': direccionController.text,
      'superficie': double.tryParse(supViviendaController.text),
      'n_pisos': int.tryParse(nPisosController.text),
      'orientacion_fachada': oriFachadaController.text + ", " + oriFachadainfoController.text,
      'orientacion_acceso': oriAccesoController.text + ", " + oriAccesoinfoController.text,

      // 🌡️ Condiciones ambientales
      'temp_exterior': int.tryParse(tempExteriorController.text),
      'hum_exterior': int.tryParse(humExteriorController.text),
      'temp_interior': int.tryParse(tempInteriorController.text),
      'hum_interior': int.tryParse(humInteriorController.text),

      // ⏳ Antigüedad
      'a_de_uso': int.tryParse(usoViviendaController.text),

      // 🔧 Reparaciones
      'reparaciones': reparaciones_VF,

      'detalle_reparaciones': detalleReparacionesController.text,

      // 🏗️ Ampliaciones
      'ampliaciones': ampliaciones_VF,
      'detalle_ampliaciones': detalleAmpliacionesController.text,

      // 📝 Observaciones generales
      'observaciones': obsInfoGeneralController.text,

      // 👨‍👩‍👧‍👦 Ocupación
      'n_recintos': int.tryParse(numRecintosController.text),
      'total_habitantes': int.tryParse(totalHabitantesController.text),
      'num_adultos': int.tryParse(numAdultosController.text),
      'num_menores': int.tryParse(numMenoresController.text),
      'num_adul_mayores': int.tryParse(numAdulMayoresController.text),
      'ocup_dia_comp': int.tryParse(ocupDiaCompController.text),
      'ocup_intermitente': int.tryParse(ocupIntermitenteController.text),

      // 📊 Densidades (calculadas previamente)
      'dens_ocup_prev': densOcupPrevController.text,
      'dens_ocup_real': densOcupRealController.text,

      // 📝 Observaciones de ocupación
      'observaciones_ocupacion': obsOcupVivController.text,
    };

    final int vivienda_id = await LocalDatabase.insertarVivienda(viviendaData);
    debugPrint('🏠 vivienda_id: $vivienda_id');

    //-------------------------------RECINTOS-------------------------------
    asignarNombreRecintos(recintos: recintos);
    asignarNombreMuros(muros: hojasM);


    for (final recinto in recintos) {

      int patologias_VF = 0;

      if (recinto.patvisibleController.text == "Si"){
        patologias_VF = 1;
      }

      int manifestaciones_VF = 0;

      if (recinto.pinOlimpController.text == "Si"){
        manifestaciones_VF = 1;
      }

      int olor_humedad_VF = 0;

      if (recinto.olorhumController.text == "Si"){
        olor_humedad_VF = 1;
      }
      int modificaciones_VF = 0;

      if (recinto.modifController.text == "Si"){
        modificaciones_VF = 1;
      }
      final recinto_id = await LocalDatabase.insertarRecinto({
        'vivienda_id': vivienda_id,
        'nombre_recinto': recinto.nombreRecintoController.text,
        'patologias_visibles': patologias_VF,
        'manifestaciones_ocultas': manifestaciones_VF,
        'detalles_manifestaciones': recinto.cualpolController.text,
        'olor_humedad': olor_humedad_VF,
        'modificaciones': modificaciones_VF,
        'detalles_modificaciones': recinto.cualmodController.text,
        'calefaccion': recinto.sistcalefController.text,
        'tiempo_calefaccion': recinto.tiemcalefController.text,

      });

      debugPrint('📦 Insertando recinto: ${recinto.nombreRecintoController.text}');
      debugPrint(
          '${recinto.nombreRecintoController.text} '
              'tiene ${recinto.muros.length} muros'
      );

      await LocalDatabase.asociarSistemasARecinto(recinto_id, recinto);


      int mapNivelAfectacion(String value) {
        switch (value) {
          case 'Bajo':
            return 1;
          case 'Medio':
            return 2;
          case 'Alto':
            return 3;
          default:
            return 0; // Nulo
        }
      }

      for (final muro in recinto.muros) {

        int muro_tipo = 0;
        if(muro.tipoMuroController.text == "Muro interior") {
          muro_tipo = 1;
        }

        await LocalDatabase.insertarMuros({
          'recinto_id': recinto_id,
          'nombre_muro': muro.nombreMuroController.text,
          'tipo_muro': muro_tipo,
          'superficie': double.tryParse(muro.supmuroController.text),
          'superficie_ventana': double.tryParse(muro.supventanaController.text),
          'nivel_afectacion': mapNivelAfectacion(muro.nivelafecController.text),
        });
        
        debugPrint(
          '   🧱 Insertando muro: ${muro.nombreMuroController.text} '
              '(Recinto ID: $recinto_id)',
        );
      }



      final pisocielo = recinto.hojaPisoCielo;


      if (pisocielo != null) {

        final pisocielo_id = await LocalDatabase.insertarPisoCielo({
          'recinto_id': recinto_id,
          'tipo': 'Piso',
          'superficie': double.tryParse(pisocielo.supPisoController.text),

          'nivel_afectacion': mapNivelAfectacion(pisocielo.nivelafecPisoController.text),
        });
        debugPrint(
          '   🧱 Insertando piso: ${pisocielo.nombre} '
              '(Recinto ID: $recinto_id)',
        );

        await LocalDatabase.insertarPatologiasPisoCielo(
         pisocielo_id, "Piso", pisocielo);


        await LocalDatabase.insertarPisoCielo({
          'recinto_id': recinto_id,
          'tipo': 'Cielo',
          'superficie': double.tryParse(pisocielo.supCieloController.text),
          'nivel_afectacion': mapNivelAfectacion(pisocielo.nivelafecCieloController.text),
        });
        debugPrint(
          '   🧱 Insertando cielo: ${pisocielo.nombre} '
              '(Recinto ID: $recinto_id)',
        );

        await LocalDatabase.insertarPatologiasPisoCielo(
            pisocielo_id, "Cielo", pisocielo);





      }






    }

    debugPrint('✅ Inspección guardada');
  }


  void asignarMuroARecinto({
    required String nombreRecinto,
    required String nombreMuro,
  }) {
    final recinto = obtenerRecinto(nombreRecinto);
    final muro = obtenerHojaMuro(nombreMuro);

    if (recinto == null || muro == null) return;

    if (!recinto.muros.any((m) => m.nombre == muro.nombre)) {
      recinto.muros.add(muro);
      notifyListeners();
    }

  }

  void asignarPisoCieloARecinto({
    required String nombreRecinto,
    required String nombrePisoCielo,
  }) {
    final recinto = obtenerRecinto(nombreRecinto);
    final pisocielo = obtenerHojaPisoCielo(nombrePisoCielo);

    if (recinto == null || pisocielo == null) return;

    recinto.hojaPisoCielo ??= pisocielo;
    notifyListeners();
  }




  void asignarNombreRecintos ({
  required List<Recinto> recintos,
  }) {
    for(final recinto in recintos){
      switch(recinto.nombre){
        case "Recinto 1":
          recinto.nombreRecintoController = recinto1_nombreController;
          break;
        case "Recinto 2":
          recinto.nombreRecintoController = recinto2_nombreController;
          break;
        case "Recinto 3":
          recinto.nombreRecintoController = recinto3_nombreController;
          break;
        case "Recinto 4":
          recinto.nombreRecintoController = recinto4_nombreController;
          break;
        case "Recinto 5":
          recinto.nombreRecintoController = recinto5_nombreController;
          break;
      }
    }
  }





  void asignarNombreMuros({
    required List<HojaMuro> muros,
  }) {
    final Map<int, Map<String, TextEditingController>> murosControllers = {
      1: {
        'A': r1_murop_nombreController,
        'B': r1_murob_nombreController,
        'C': r1_muroc_nombreController,
        'D': r1_murod_nombreController,
        'E': r1_muroe_nombreController,
        'F': r1_murof_nombreController,
        'G': r1_murog_nombreController,
      },
      2: {
        'A': r2_murop_nombreController,
        'B': r2_murob_nombreController,
        'C': r2_muroc_nombreController,
        'D': r2_murod_nombreController,
        'E': r2_muroe_nombreController,
        'F': r2_murof_nombreController,
        'G': r2_murog_nombreController,
      },
      3: {
        'A': r3_murop_nombreController,
        'B': r3_murob_nombreController,
        'C': r3_muroc_nombreController,
        'D': r3_murod_nombreController,
        'E': r3_muroe_nombreController,
        'F': r3_murof_nombreController,
        'G': r3_murog_nombreController,
      },
      4: {
        'A': r4_murop_nombreController,
        'B': r4_murob_nombreController,
        'C': r4_muroc_nombreController,
        'D': r4_murod_nombreController,
        'E': r4_muroe_nombreController,
        'F': r4_murof_nombreController,
        'G': r4_murog_nombreController,
      },
      5: {
        'A': r5_murop_nombreController,
        'B': r5_murob_nombreController,
        'C': r5_muroc_nombreController,
        'D': r5_murod_nombreController,
        'E': r5_muroe_nombreController,
        'F': r5_murof_nombreController,
        'G': r5_murog_nombreController,
      },
    };
    for (final muro in hojasM) {

      // Ej: "Muro Eje A - Recinto 1"
      final regex = RegExp(r'Muro Eje ([A-Z]) - Recinto (\d+)');
      final match = regex.firstMatch(muro.nombre);

      if (match == null) continue;

      final eje = match.group(1)!;        // A, B, C...
      final recintoNum = int.parse(match.group(2)!); // 1, 2, 3...

      final controller = murosControllers[recintoNum]?[eje];

      if (controller != null) {
        muro.nombreMuroController = controller;
      }
    }
  }







  void resetApp(BuildContext context) {
    // ---------------------------------------------------------------------------
    // LIMPIAR CONTROLADORES DE TEXTO
    // ---------------------------------------------------------------------------
    proyectoSeleccionado = null;
    proyectoSeleccionadoId = null;

    List<TextEditingController> controllersClean = [
      // Formularios generales
      nFichaController,

      // Información general
      tipologiaViviendaController,
      regionController,
      comunasController,
      direccionController,
      etapaController,
      supViviendaController,
      nPisosController,
      oriFachadaController,
      oriAccesoController,
      climaController,
      tempExteriorController,
      humExteriorController,
      tempInteriorController,
      humInteriorController,
      reciPorController,
      nombreReciController,
      nombreInspectorController,
      usoViviendaController,
      rutInspectorController,
      digVerifController,
      reparacionesController,
      detalleReparacionesController,
      ampliacionesController,
      detalleAmpliacionesController,
      obsInfoGeneralController,
      numRecintosController,
      totalHabitantesController,
      numAdultosController,
      numMenoresController,
      numAdulMayoresController,
      ocupDiaCompController,
      ocupIntermitenteController,
      densOcupPrevController,
      densOcupRealController,
      obsOcupVivController,
    ];

    for (var c in controllersClean) {
      c.clear();
    }

    List<TextEditingController> controllersRecintos = [
      // Nombres Recintos
      recinto1_nombreController,
      recinto2_nombreController,
      recinto3_nombreController,
      recinto4_nombreController,
      recinto5_nombreController,
    ];

    for (final entry in controllersRecintos.asMap().entries) {
      final index = entry.key;
      final c = entry.value;

      c.clear();
      c.text = "Recinto ${index + 1}";
    }


    List<TextEditingController> controllersPisoCielo = [
      r1_pisocielo_nombreController,
      r2_pisocielo_nombreController,
      r3_pisocielo_nombreController,
      r4_pisocielo_nombreController,
      r5_pisocielo_nombreController,
    ];

    for (var c in controllersPisoCielo) {
      c.clear();
      c.text = "Piso Cielo";
    }


    List<TextEditingController> controllersMuros = [
      // Recinto 1
      r1_murop_nombreController,
      r1_murob_nombreController,
      r1_muroc_nombreController,
      r1_murod_nombreController,
      r1_muroe_nombreController,
      r1_murof_nombreController,
      r1_murog_nombreController,


      // Recinto 2
      r2_murop_nombreController,
      r2_murob_nombreController,
      r2_muroc_nombreController,
      r2_murod_nombreController,
      r2_muroe_nombreController,
      r2_murof_nombreController,
      r2_murog_nombreController,


      // Recinto 3
      r3_murop_nombreController,
      r3_murob_nombreController,
      r3_muroc_nombreController,
      r3_murod_nombreController,
      r3_muroe_nombreController,
      r3_murof_nombreController,
      r3_murog_nombreController,


      // Recinto 4
      r4_murop_nombreController,
      r4_murob_nombreController,
      r4_muroc_nombreController,
      r4_murod_nombreController,
      r4_muroe_nombreController,
      r4_murof_nombreController,
      r4_murog_nombreController,


      // Recinto 5
      r5_murop_nombreController,
      r5_murob_nombreController,
      r5_muroc_nombreController,
      r5_murod_nombreController,
      r5_muroe_nombreController,
      r5_murof_nombreController,
      r5_murog_nombreController,

    ];

    for (var c in controllersMuros) {
      c.clear();
      c.text = "(_)";
    }

    // ---------------------------------------------------------------------------
    // REINICIAR FLAGS
    // ---------------------------------------------------------------------------
    List<bool Function()> setters = [
          () => muro_eje_p_info_r1 = false,
          () => muro_eje_p_r1 = false,
          () => muro_eje_b_r1 = false,
          () => muro_eje_c_r1 = false,
          () => muro_eje_d_r1 = false,
          () => muro_eje_e_r1 = false,
          () => muro_eje_f_r1 = false,
          () => muro_eje_g_r1 = false,
          () => muro_eje_h_r1 = false,
          () => piso_cielo_r1 = false,

          () => muro_eje_p_info_r2 = false,
          () => muro_eje_p_r2 = false,
          () => muro_eje_b_r2 = false,
          () => muro_eje_c_r2 = false,
          () => muro_eje_d_r2 = false,
          () => muro_eje_e_r2 = false,
          () => muro_eje_f_r2 = false,
          () => muro_eje_g_r2 = false,
          () => muro_eje_h_r2 = false,
          () => piso_cielo_r2 = false,

          () => muro_eje_p_info_r3 = false,
          () => muro_eje_p_r3 = false,
          () => muro_eje_b_r3 = false,
          () => muro_eje_c_r3 = false,
          () => muro_eje_d_r3 = false,
          () => muro_eje_e_r3 = false,
          () => muro_eje_f_r3 = false,
          () => muro_eje_g_r3 = false,
          () => muro_eje_h_r3 = false,
          () => piso_cielo_r3 = false,

          () => muro_eje_p_info_r4 = false,
          () => muro_eje_p_r4 = false,
          () => muro_eje_b_r4 = false,
          () => muro_eje_c_r4 = false,
          () => muro_eje_d_r4 = false,
          () => muro_eje_e_r4 = false,
          () => muro_eje_f_r4 = false,
          () => muro_eje_g_r4 = false,
          () => muro_eje_h_r4 = false,
          () => piso_cielo_r4 = false,

          () => muro_eje_p_info_r5 = false,
          () => muro_eje_p_r5 = false,
          () => muro_eje_b_r5 = false,
          () => muro_eje_c_r5 = false,
          () => muro_eje_d_r5 = false,
          () => muro_eje_e_r5 = false,
          () => muro_eje_f_r5 = false,
          () => muro_eje_g_r5 = false,
          () => muro_eje_h_r5 = false,
          () => piso_cielo_r5 = false,
    ];

    for (var reset in setters) {
      reset();
    }

    // ---------------------------------------------------------------------------
    // REINICIAR IMÁGENES
    // ---------------------------------------------------------------------------
    imagen1_Info_General = null;
    imagen1GuardadaInfoGeneral = null;
    imagen2_Info_General = null;
    imagen2GuardadaInfoGeneral = null;
    imagen3_Info_General = null;
    imagen3GuardadaInfoGeneral = null;
    imagen4_Info_General = null;
    imagen4GuardadaInfoGeneral = null;

    // ---------------------------------------------------------------------------
    // REINICIAR LISTAS Y ESTADOS GENERALES
    // ---------------------------------------------------------------------------
    recintos.clear();
    hojasM.clear();
    hojasPC.clear();

    pantallaActual = 0;
    cantFotos = 0;
    rutaGuardada = null;
    guardando = false;

    // REINICIAR HORAS
    horaInicio = "00:00";
    horaFin = "00:00";
    // fechaFormateada = (se mantiene la del día)

    notifyListeners();
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) => const Inicio(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Funcion de agregar una hoja recinto
  // ---------------------------------------------------------------------------
  void agregarRecinto({
    required String nombre,
  }) {
    for (final r in recintos) {
      if (r.nombre == nombre) return;
    }

    recintos.add(Recinto(nombre: nombre));
    notifyListeners();
  }


  // ---------------------------------------------------------------------------
  // Funcion de obtener una hoja recinto
  // ---------------------------------------------------------------------------

  Recinto obtenerRecinto(String nombre) {
    try {
      return recintos.firstWhere((h) => h.nombre == nombre);
    } catch (_) {
      final nuevaHoja = Recinto(nombre: nombre);
      recintos.add(nuevaHoja);
      return nuevaHoja;
    }

  }


  // ---------------------------------------------------------------------------
  // Funcion de eliminar hojas de la lista de recintos
  // ---------------------------------------------------------------------------
  void eliminarRecinto(int indexRecinto, int indexHojaMuro) {
    recintos[indexRecinto].dispose();
    recintos.removeAt(indexRecinto);
    eliminarHojaMuro(indexHojaMuro);
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Funcion de obtener una hoja muro
  // ---------------------------------------------------------------------------

  HojaMuro obtenerHojaMuro(String nombre) {
    try {
      return hojasM.firstWhere((h) => h.nombre == nombre);
    } catch (_) {
      final nuevaHoja = HojaMuro(nombre: nombre);
      hojasM.add(nuevaHoja);
      return nuevaHoja;
    }
  }
  // ---------------------------------------------------------------------------
  // Funcion de eliminar hojas de la lista de hojas muro
  // ---------------------------------------------------------------------------

  void eliminarHojaMuro(int index) {
    hojasM[index].dispose();
    hojasM.removeAt(index);
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Funcion de eliminar hojas de la lista de hojas piso Cielo
  // ---------------------------------------------------------------------------

  void eliminarHojaPisoCielo(int index) {
    hojasPC[index].dispose();
    hojasPC.removeAt(index);
    notifyListeners();
  }


  HojaPisoCielo obtenerHojaPisoCielo(String nombre) {
    try {
      return hojasPC.firstWhere((h) => h.nombre == nombre);
    } catch (_) {
      final nuevaHoja = HojaPisoCielo(nombre: nombre);
      hojasPC.add(nuevaHoja);
      return nuevaHoja;
    }
  }

  // ---------------------------------------------------------------------------
  // Funciones de guardados de la hora
  // ---------------------------------------------------------------------------

  void HoraInicio() {
    horaInicio = DateFormat('HH:mm').format(DateTime.now());
    notifyListeners();
  }

  void HoraFin() {
    horaFin = DateFormat('HH:mm').format(DateTime.now());
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Funciones usadas para el guardado de excel
  // ---------------------------------------------------------------------------

  void rutaGuardarExcel(String? ruta) {
    rutaGuardada = ruta;
    notifyListeners();
  }

  void guardandoExcel(bool value) {
    guardando = value;
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Funciones de manejo de imagenes de info general
  // ---------------------------------------------------------------------------

  //--> Obtener imagen
  Future<void> obtenerImagenInfoGeneral({
    required ImageSource fuente,
    required Function(File) onImagenSeleccionada,
    required int imgnum,
  }) async {
    final XFile? imagen = await picker.pickImage(source: fuente);
    if (imagen != null) {
      final file = File(imagen.path);
      switch (imgnum){
        case 1:
          imagen1GuardadaInfoGeneral = null;
          imagen1_Info_General = file;
          break;
        case 2:
          imagen2GuardadaInfoGeneral = null;
          imagen2_Info_General = file;
          break;
        case 3:
          imagen3GuardadaInfoGeneral = null;
          imagen3_Info_General = file;
          break;
        case 4:
          imagen4GuardadaInfoGeneral = null;
          imagen4_Info_General = file;
          break;
      }

      notifyListeners();
      onImagenSeleccionada(file);
    }
  }

  //--> Guardar edición de la imagen de info general (formato JPG compatible Excel)
  Future<void> guardarDibujoInfoGeneral({
    required GlobalKey canvasKey,
    required void Function(File file) onGuardado,
    required String nombreArchivo,
    required int imgnum,
    BuildContext? context,
    bool silencioso = false,

  }) async {
    try {
      final renderObject = canvasKey.currentContext?.findRenderObject();
      if (renderObject == null || renderObject is! RenderRepaintBoundary) {
        throw Exception('No se encontró RenderRepaintBoundary para el canvasKey proporcionado.');
      }

      final RenderRepaintBoundary boundary = renderObject;
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        throw Exception('No se pudo convertir la imagen a bytes.');
      }

      final Uint8List pngBytes = byteData.buffer.asUint8List();

      final img.Image? decodedImage = img.decodeImage(pngBytes);
      if (decodedImage == null) {
        throw Exception("No se pudo decodificar la imagen PNG.");
      }

      final Uint8List jpegBytes =
      Uint8List.fromList(img.encodeJpg(decodedImage, quality: 95));

      final directory = await getApplicationDocumentsDirectory();
      final String sanitizedName = nombreArchivo.replaceAll(" ", "_");

      final String path = '${directory.path}/${sanitizedName}.jpg';
      final File file = File(path);

      await file.writeAsBytes(jpegBytes);

      // Guardar referencia global
      switch (imgnum) {
        case 1:
          imagen1GuardadaInfoGeneral = file;
          break;
        case 2:
          imagen2GuardadaInfoGeneral = file;
          break;
        case 3:
          imagen3GuardadaInfoGeneral = file;
          break;
        case 4:
          imagen4GuardadaInfoGeneral = file;
          break;
      };
      onGuardado(file);
      notifyListeners();

      if (!silencioso && context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Dibujo guardado correctamente')),
        );
      }
    } catch (e, st) {
      debugPrint('Error en guardarDibujoInfoGeneral: $e\n$st');
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar dibujo: $e')),
        );
      }
    }
  }

  //--> eliminar edicion de la imagen de info general
  Future<void> eliminarDibujoInfoGeneral({
    required BuildContext context,
    required int imgnum,
  }) async {
    final bool? confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Eliminar dibujo"),
        content: Text("¿Seguro que deseas eliminar el dibujo guardado?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text("Cancelar")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text("Eliminar")),
        ],
      ),
    );

    if (confirmar == true) {
      switch (imgnum) {
        case 1:
          imagen1_Info_General = null;
          imagen1GuardadaInfoGeneral = null;
          break;
        case 2:
          imagen2_Info_General = null;
          imagen2GuardadaInfoGeneral = null;
          break;
        case 3:
          imagen3_Info_General = null;
          imagen3GuardadaInfoGeneral = null;
          break;
        case 4:
          imagen4_Info_General = null;
          imagen4GuardadaInfoGeneral = null;
          break;
      }
      cantFotos--;
      notifyListeners();
    }
  }

  //----------------------------------------------------------------------------
  // Funciones de manejo de imagenes de Recintos
  //----------------------------------------------------------------------------

  //--> Obtener imagen del recinto
  Future<void> obtenerImagenRecinto({
    required ImageSource fuente,
    required Recinto recinto,
    required Function(File) onImagenSeleccionada,
  }) async {
    final XFile? imagen = await picker.pickImage(source: fuente);
    if (imagen == null) return;

    final file = File(imagen.path);

    // ✅ Asignación directa
    recinto.imgPlano = file;
    recinto.imgPlanoGuardada = null;

    notifyListeners();
    onImagenSeleccionada(file);
  }


  //--> Elimina edición de imagen del recinto
  Future<void> eliminarDibujoRecinto({
    required BuildContext context,
    required Recinto recinto,
  }) async {
    final bool? confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Eliminar dibujo"),
        content: const Text("¿Seguro que deseas eliminar el dibujo guardado?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Eliminar"),
          ),
        ],
      ),
    );

    if (confirmar != true) return;

    // ✅ Eliminar imagen del modelo
    recinto.imgPlanoGuardada = null;
    recinto.imgPlano = null;

    // ⚠️ Solo si esta clase extiende ChangeNotifier
    notifyListeners();
  }

  //--> Guardar edición de imagen de los recintos
  Future<void> guardarDibujoRecinto({
    required GlobalKey canvasKey,
    required Recinto recinto,
    required void Function(File file) onGuardado,
    BuildContext? context,
    bool silencioso = false,
  }) async {
    try {
      final renderObject = canvasKey.currentContext?.findRenderObject();
      if (renderObject == null || renderObject is! RenderRepaintBoundary) {
        throw Exception(
          'No se encontró RenderRepaintBoundary para el canvasKey proporcionado.',
        );
      }

      final boundary = renderObject as RenderRepaintBoundary;

      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? pngBytes =
      await image.toByteData(format: ui.ImageByteFormat.png);

      if (pngBytes == null) {
        throw Exception('No se pudo convertir la imagen.');
      }

      final Uint8List pngData = pngBytes.buffer.asUint8List();

      final Uint8List jpgData = Uint8List.fromList(
        img.encodeJpg(
          img.decodeImage(pngData)!,
          quality: 95,
        ),
      );

      final directory = await getApplicationDocumentsDirectory();

      final tipo = "PlanoRecinto";
      final path =
          '${directory.path}/${recinto.nombre.replaceAll(" ", "_")}_$tipo.jpg';

      final file = File(path);
      await file.writeAsBytes(jpgData);

      // ✅ Guardar directamente en el modelo
      recinto.imgPlanoGuardada = file;

      onGuardado(file);

      // ⚠️ Solo si esta clase extiende ChangeNotifier
      notifyListeners();

      if (!silencioso && context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Dibujo guardado correctamente'),
          ),
        );
      }
    } catch (e, st) {
      debugPrint('Error en guardarDibujoRecinto: $e\n$st');
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al guardar dibujo: $e'),
          ),
        );
      }
    }
  }


  //----------------------------------------------------------------------------
  // Funciones de manejo de imagenes de las hojas de muros
  //----------------------------------------------------------------------------

  //--> Obtener imagen
  Future<void> obtenerImagenHojaMuro({
    required ImageSource fuente,
    required HojaMuro hoja,
    required Function(File) onImagenSeleccionada,
    required int imgnum,
  }) async {
    final XFile? imagen = await picker.pickImage(source: fuente);
    if (imagen != null) {
      final file = File(imagen.path);
      switch (imgnum) {
        case 1:
          hoja.imgpatol = file;
          hoja.imgpatolGuardada = null;
          notifyListeners();
          onImagenSeleccionada(file);
          break;
        case 2:
          hoja.imgelev = file;
          hoja.imgelevGuardada = null;
          notifyListeners();
          onImagenSeleccionada(file);
          break;
      }
    }
  }


  //--> Guardar edición de imagen de las hojas de muros (formato compatible Excel)
  Future<void> guardarDibujoHojaMuro({
    required GlobalKey canvasKey,
    required HojaMuro hoja,
    required int imgnum,
    required void Function(File file) onGuardado,
    BuildContext? context,
    bool silencioso = false,
  }) async {
    try {
      final renderObject = canvasKey.currentContext?.findRenderObject();
      if (renderObject == null || renderObject is! RenderRepaintBoundary) {
        throw Exception(
            'No se encontró RenderRepaintBoundary para el canvasKey proporcionado.');
      }

      final RenderRepaintBoundary boundary = renderObject;

      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? pngBytes =
      await image.toByteData(format: ui.ImageByteFormat.png);

      if (pngBytes == null) throw Exception('No se pudo convertir la imagen.');

      final Uint8List pngData = pngBytes.buffer.asUint8List();

      final Uint8List jpgData = Uint8List.fromList(img.encodeJpg(
        img.decodeImage(pngData)!,
        quality: 95,
      ));

      final directory = await getApplicationDocumentsDirectory();

      // Diferenciar nombres piso/cielo
      final tipo = imgnum == 1 ? "patolMuro" : "elevMuro";
      final path =
          '${directory.path}/${hoja.nombre.replaceAll(" ", "_")}_$tipo.jpg';

      final file = File(path);
      await file.writeAsBytes(jpgData);

      // Guardar en el modelo
      switch (imgnum) {
        case 1:
          hoja.imgpatolGuardada = file;
          break;
        case 2:
          hoja.imgelevGuardada = file;
          break;
      }

      onGuardado(file);
      notifyListeners();

      if (!silencioso && context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Dibujo guardado correctamente')),
        );
      }
    } catch (e, st) {
      debugPrint('Error en guardarDibujoHoja: $e\n$st');
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar dibujo: $e')),
        );
      }
    }
  }


  //--> Elimina edicion de imagen de las hojas de muros
  Future<void> eliminarDibujoHojaMuro({
    required BuildContext context,
    required HojaMuro hoja,
    required int imgnum,
  }) async {
    final bool? confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Eliminar dibujo"),
        content: const Text("¿Seguro que deseas eliminar el dibujo guardado?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancelar")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Eliminar")),
        ],
      ),
    );

    if (confirmar == true) {
      switch (imgnum) {
        case 1:
          hoja.imgpatolGuardada = null;
          hoja.imgpatol = null;
          break;
        case 2:
          hoja.imgelevGuardada = null;
          hoja.imgelev = null;
          break;
      }
      notifyListeners();
    }
  }

  //----------------------------------------------------------------------------
  // Funciones de manejo de imagenes de las hojas Piso Cielo
  //---------------------------------------------------------------------------

  //--> Obtener imagen
  Future<void> obtenerImagenHojaPisoCielo({
    required ImageSource fuente,
    required HojaPisoCielo hoja,
    required Function(File) onImagenSeleccionada,
    required int imgnum,
  }) async {
    final XFile? imagen = await picker.pickImage(source: fuente);
    if (imagen != null) {
      final file = File(imagen.path);
      switch (imgnum) {
        case 1:
          hoja.imgpiso = file;
          hoja.imgPisoGuardada = null;
          notifyListeners();
          onImagenSeleccionada(file);
          break;
        case 2:
          hoja.imgcielo = file;
          hoja.imgCieloGuardada = null;
          notifyListeners();
          onImagenSeleccionada(file);
          break;
      }
    }
  }

  //--> Guardar edicion de imagen de las hojas de muros (compatible con Excel)
  Future<void> guardarDibujoHojaPisoCielo({
    required GlobalKey canvasKey,
    required HojaPisoCielo hoja,
    required void Function(File file) onGuardado,
    required int imgnum,
    BuildContext? context,
    bool silencioso = false,
  }) async {
    try {
      final renderObject = canvasKey.currentContext?.findRenderObject();
      if (renderObject == null || renderObject is! RenderRepaintBoundary) {
        throw Exception(
            'No se encontró RenderRepaintBoundary para el canvasKey proporcionado.');
      }

      final RenderRepaintBoundary boundary = renderObject;

      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? pngBytes =
      await image.toByteData(format: ui.ImageByteFormat.png);

      if (pngBytes == null) throw Exception('No se pudo convertir la imagen.');

      final Uint8List pngData = pngBytes.buffer.asUint8List();

      final Uint8List jpgData = Uint8List.fromList(img.encodeJpg(
        img.decodeImage(pngData)!,
        quality: 95,
      ));

      final directory = await getApplicationDocumentsDirectory();

      // Diferenciar nombres piso/cielo
      final tipo = imgnum == 1 ? "piso" : "cielo";
      final path =
          '${directory.path}/${hoja.nombre.replaceAll(" ", "_")}_$tipo.jpg';

      final file = File(path);
      await file.writeAsBytes(jpgData);

      // Guardar en el modelo
      switch (imgnum) {
        case 1:
          hoja.imgPisoGuardada = file;
          break;
        case 2:
          hoja.imgCieloGuardada = file;
          break;
      }

      onGuardado(file);
      notifyListeners();

      if (!silencioso && context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Dibujo guardado correctamente')),
        );
      }
    } catch (e, st) {
      debugPrint('Error en guardarDibujoHoja: $e\n$st');
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar dibujo: $e')),
        );
      }
    }
  }

  //--> Elimina edicion de imagen de las hojas piso cielo
  Future<void> eliminarDibujoHojaPisoCielo({
    required BuildContext context,
    required HojaPisoCielo hoja,
    required int imgnum,
  }) async {
    final bool? confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Eliminar dibujo"),
        content: const Text("¿Seguro que deseas eliminar el dibujo guardado?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancelar")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Eliminar")),
        ],
      ),
    );

    if (confirmar == true) {
      switch (imgnum) {
        case 1:
          hoja.imgPisoGuardada = null;
          hoja.imgpiso = null;
          break;
        case 2:
          hoja.imgCieloGuardada = null;
          hoja.imgcielo = null;
          break;
      }
      notifyListeners();
    }
  }

  //----------------------------------------------------------------------------
  // Funcion de actualizar nombres de recintos (Habitaciones)
  //----------------------------------------------------------------------------

  void actualizarNombreRecinto(int numero, String nuevoNombre) {
    switch (numero) {
      case 1:
        recinto1_nombreController.text = nuevoNombre;
        break;
      case 2:
        recinto2_nombreController.text = nuevoNombre;
        break;
      case 3:
        recinto3_nombreController.text = nuevoNombre;
        break;
      case 4:
        recinto4_nombreController.text = nuevoNombre;
        break;
      case 5:
        recinto5_nombreController.text = nuevoNombre;
        break;
    }
    notifyListeners();
  }

  //----------------------------------------------------------------------------
  // Funcion de actualizar los nombres de los muros y piso cielo
  //----------------------------------------------------------------------------

  void actualizarNombreMuro(int numero, String nuevoNombre) {
    switch (numero) {
      case 1:
        r1_murop_nombreController.text = nuevoNombre;
        break;
      case 2:
        r1_murob_nombreController.text = nuevoNombre;
        break;
      case 3:
        r1_muroc_nombreController.text = nuevoNombre;
        break;
      case 4:
        r1_murod_nombreController.text = nuevoNombre;
        break;
      case 5:
        r1_muroe_nombreController.text = nuevoNombre;
        break;
      case 6:
        r1_murof_nombreController.text = nuevoNombre;
        break;
      case 7:
        r1_murog_nombreController.text = nuevoNombre;
        break;
     /* case 8:
        r1_pisocielo_nombreController.text = nuevoNombre;
        break;*/
      case 9:
        r2_murop_nombreController.text = nuevoNombre;
        break;
      case 10:
        r2_murob_nombreController.text = nuevoNombre;
        break;
      case 11:
        r2_muroc_nombreController.text = nuevoNombre;
        break;
      case 12:
        r2_murod_nombreController.text = nuevoNombre;
        break;
      case 13:
        r2_muroe_nombreController.text = nuevoNombre;
        break;
      case 14:
        r2_murof_nombreController.text = nuevoNombre;
        break;
      case 15:
        r2_murog_nombreController.text = nuevoNombre;
        break;
      /*case 16:
        r2_pisocielo_nombreController.text = nuevoNombre;
        break;*/
      case 17:
        r3_murop_nombreController.text = nuevoNombre;
        break;
      case 18:
        r3_murob_nombreController.text = nuevoNombre;
        break;
      case 19:
        r3_muroc_nombreController.text = nuevoNombre;
        break;
      case 20:
        r3_murod_nombreController.text = nuevoNombre;
        break;
      case 21:
        r3_muroe_nombreController.text = nuevoNombre;
        break;
      case 22:
        r3_murof_nombreController.text = nuevoNombre;
        break;
      case 23:
        r3_murog_nombreController.text = nuevoNombre;
        break;
      /*case 24:
        r3_pisocielo_nombreController.text = nuevoNombre;
        break;*/
      case 25:
        r4_murop_nombreController.text = nuevoNombre;
        break;
      case 26:
        r4_murob_nombreController.text = nuevoNombre;
        break;
      case 27:
        r4_muroc_nombreController.text = nuevoNombre;
        break;
      case 28:
        r4_murod_nombreController.text = nuevoNombre;
        break;
      case 29:
        r4_muroe_nombreController.text = nuevoNombre;
        break;
      case 30:
        r4_murof_nombreController.text = nuevoNombre;
        break;
      case 31:
        r4_murog_nombreController.text = nuevoNombre;
        break;
      /*case 32:
        r4_pisocielo_nombreController.text = nuevoNombre;
        break;*/
      case 33:
        r5_murop_nombreController.text = nuevoNombre;
        break;
      case 34:
        r5_murob_nombreController.text = nuevoNombre;
        break;
      case 35:
        r5_muroc_nombreController.text = nuevoNombre;
        break;
      case 36:
        r5_murod_nombreController.text = nuevoNombre;
        break;
      case 37:
        r5_muroe_nombreController.text = nuevoNombre;
        break;
      case 38:
        r5_murof_nombreController.text = nuevoNombre;
        break;
      case 39:
        r5_murog_nombreController.text = nuevoNombre;
        break;
      /*case 40:
        r5_pisocielo_nombreController.text = nuevoNombre;
        break;*/
    }
    notifyListeners();
  }

  //----------------------------------------------------------------------------
  // Funcion de editar nombres de Variables
  //----------------------------------------------------------------------------

  Future<String?> EditarNombre(BuildContext context, String nombreActual) {
    final TextEditingController controller = TextEditingController(text: nombreActual);
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar nombre'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Nuevo nombre',
              border: OutlineInputBorder(),
            ),

            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  //----------------------------------------------------------------------------
  // Funcion para cambiar la pantalla
  //----------------------------------------------------------------------------

  void cambiarPantalla(int nuevaPantalla) {
    pantallaActual = nuevaPantalla;
    notifyListeners();
  }

  //----------------------------------------------------------------------------
  // Funciones para buscar indices en el listado de hojas
  //----------------------------------------------------------------------------

  //--> Indices Hojas Principales
  int? buscarIndexHojaRecinto(BuildContext context, String nombreRecintoActual) {
    final indexHoja = recintos.indexWhere((h) => h.nombre == nombreRecintoActual);
    if (indexHoja == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No se encontró la hoja \"$nombreRecintoActual\".")),
      );
      return null;
    }
    return indexHoja;
  }

  //--> Indices Hojas Muros
  int? buscarIndexHojaMuro(BuildContext context, String nombreHojaActual) {
    final indexHoja = hojasM.indexWhere((h) => h.nombre == nombreHojaActual);
    if (indexHoja == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No se encontró la hoja \"$nombreHojaActual\".")),
      );
      return null;
    }
    return indexHoja;
  }

  //--> Indices Hojas Piso Cielo
  int? buscarIndexHojaPisoCielo(BuildContext context, String nombreHojaActual) {
    final indexHoja = hojasPC.indexWhere((h) => h.nombre == nombreHojaActual);
    if (indexHoja == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No se encontró la hoja \"$nombreHojaActual\".")),
      );
      return null;
    }
    return indexHoja;
  }

  //----------------------------------------------------------------------------
  // Funciones para eliminar Hojas del listado dependiendo de la pantalla
  //----------------------------------------------------------------------------

  //--> Hojas Recintos
  Future<void> eliminarPantallaRecinto(BuildContext context) async {
    String? nombreRecintoActual;
    String? nombreHojaMuro;


    switch (pantallaActual) {
      case 1:
        nombreRecintoActual = "Recinto 1";
        nombreHojaMuro = "Muro Eje A - Recinto 1";
        muro_eje_p_info_r1 = false;
        muro_eje_p_r1 = false;
        r1_murop_nombreController = TextEditingController(text: "(_)");
        break;
      case 10:
        nombreRecintoActual = "Recinto 2";
        nombreHojaMuro = "Muro Eje A - Recinto 2";
        muro_eje_p_info_r2 = false;
        muro_eje_p_r2 = false;
        r2_murop_nombreController = TextEditingController(text: "(_)");
        break;
      case 19:
        nombreRecintoActual = "Recinto 3";
        nombreHojaMuro = "Muro Eje A - Recinto 3";
        muro_eje_p_info_r3 = false;
        muro_eje_p_r3 = false;
        r3_murop_nombreController = TextEditingController(text: "(_)");
        break;
      case 28:
        nombreRecintoActual = "Recinto 4";
        nombreHojaMuro = "Muro Eje A - Recinto 4";
        muro_eje_p_info_r4 = false;
        muro_eje_p_r4 = false;
        r4_murop_nombreController = TextEditingController(text: "(_)");
        break;
      case 37:
        nombreRecintoActual = "Recinto 5";
        nombreHojaMuro = "Muro Eje A - Recinto 5";
        muro_eje_p_info_r5 = false;
        muro_eje_p_r5 = false;
        r5_murop_nombreController = TextEditingController(text: "(_)");
        break;

    //-->agregar más recintos
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No hay hoja asociada a esta pantalla.")),
        );
        return;
    }

    final indexHoja = buscarIndexHojaRecinto(context, nombreRecintoActual);
    final indexHojaMuro = buscarIndexHojaMuro(context, nombreHojaMuro);

    final bool? confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Eliminar hoja"),
          content: Text("¿Seguro que deseas eliminar la hoja \"$nombreRecintoActual\"?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text(
                "Eliminar",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
    if (confirmar == true) {
      eliminarRecinto(indexHoja!, indexHojaMuro!);

      pantallaActual = 0;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Recinto \"$nombreRecintoActual\" eliminada y Hoja \"$nombreHojaMuro\" eliminada.")),
      );
    }
  }

  //--> Hojas Muros
  Future<void> eliminarPantallaMuroActual(BuildContext context) async {
    String? nombreHojaActual;

    switch (pantallaActual) {
      case 3:
        nombreHojaActual = "Muro Eje B - Recinto 1";
        muro_eje_b_r1 = false;
        r1_murob_nombreController = TextEditingController(text: "(_)");
        break;
      case 4:
        nombreHojaActual = "Muro Eje C - Recinto 1";
        muro_eje_c_r1 = false;
        r1_muroc_nombreController = TextEditingController(text: "(_)");
        break;
      case 5:
        nombreHojaActual = "Muro Eje D - Recinto 1";
        muro_eje_d_r1 = false;
        r1_murod_nombreController = TextEditingController(text: "(_)");
        break;
      case 6:
        nombreHojaActual = "Muro Eje E - Recinto 1";
        muro_eje_e_r1 = false;
        r1_muroe_nombreController = TextEditingController(text: "(_)");
        break;
      case 7:
        nombreHojaActual = "Muro Eje F - Recinto 1";
        muro_eje_f_r1 = false;
        r1_murof_nombreController = TextEditingController(text: "(_)");
        break;
      case 8:
        nombreHojaActual = "Muro Eje G - Recinto 1";
        muro_eje_g_r1 = false;
        r1_murog_nombreController = TextEditingController(text: "(_)");
        break;
      case 12:
        nombreHojaActual = "Muro Eje B - Recinto 2";
        muro_eje_b_r2 = false;
        r2_murob_nombreController = TextEditingController(text: "(_)");
        break;
      case 13:
        nombreHojaActual = "Muro Eje C - Recinto 2";
        muro_eje_c_r2 = false;
        r2_muroc_nombreController = TextEditingController(text: "(_)");
        break;
      case 14:
        nombreHojaActual = "Muro Eje D - Recinto 2";
        muro_eje_d_r2 = false;
        r2_murod_nombreController = TextEditingController(text: "(_)");
        break;
      case 15:
        nombreHojaActual = "Muro Eje E - Recinto 2";
        muro_eje_e_r2 = false;
        r2_muroe_nombreController = TextEditingController(text: "(_)");
        break;
      case 16:
        nombreHojaActual = "Muro Eje F - Recinto 2";
        muro_eje_f_r2 = false;
        r2_murof_nombreController = TextEditingController(text: "(_)");
        break;
      case 17:
        nombreHojaActual = "Muro Eje G - Recinto 2";
        muro_eje_g_r2 = false;
        r2_murog_nombreController = TextEditingController(text: "(_)");
        break;
      case 21:
        nombreHojaActual = "Muro Eje B - Recinto 3";
        muro_eje_b_r3 = false;
        r3_murob_nombreController = TextEditingController(text: "(_)");
        break;
      case 22:
        nombreHojaActual = "Muro Eje C - Recinto 3";
        muro_eje_c_r3 = false;
        r3_muroc_nombreController = TextEditingController(text: "(_)");
        break;
      case 23:
        nombreHojaActual = "Muro Eje D - Recinto 3";
        muro_eje_d_r3 = false;
        r3_murod_nombreController = TextEditingController(text: "(_)");
        break;
      case 24:
        nombreHojaActual = "Muro Eje E - Recinto 3";
        muro_eje_e_r3 = false;
        r3_muroe_nombreController = TextEditingController(text: "(_)");
        break;
      case 25:
        nombreHojaActual = "Muro Eje F - Recinto 3";
        muro_eje_f_r3 = false;
        r3_murof_nombreController = TextEditingController(text: "(_)");
        break;
      case 26:
        nombreHojaActual = "Muro Eje G - Recinto 3";
        muro_eje_g_r3 = false;
        r3_murog_nombreController = TextEditingController(text: "(_)");
        break;
      case 30:
        nombreHojaActual = "Muro Eje B - Recinto 4";
        muro_eje_b_r4 = false;
        r4_murob_nombreController = TextEditingController(text: "(_)");
        break;
      case 31:
        nombreHojaActual = "Muro Eje C - Recinto 4";
        muro_eje_c_r4 = false;
        r4_muroc_nombreController = TextEditingController(text: "(_)");
        break;
      case 32:
        nombreHojaActual = "Muro Eje D - Recinto 4";
        muro_eje_d_r4 = false;
        r4_murod_nombreController = TextEditingController(text: "(_)");
        break;
      case 33:
        nombreHojaActual = "Muro Eje E - Recinto 4";
        muro_eje_e_r4 = false;
        r4_muroe_nombreController = TextEditingController(text: "(_)");
        break;
      case 34:
        nombreHojaActual = "Muro Eje F - Recinto 4";
        muro_eje_f_r4 = false;
        r4_murof_nombreController = TextEditingController(text: "(_)");
        break;
      case 35:
        nombreHojaActual = "Muro Eje G - Recinto 4";
        muro_eje_g_r4 = false;
        r4_murog_nombreController = TextEditingController(text: "(_)");
        break;
      case 39:
        nombreHojaActual = "Muro Eje B - Recinto 5";
        muro_eje_b_r5 = false;
        r5_murob_nombreController = TextEditingController(text: "(_)");
        break;
      case 40:
        nombreHojaActual = "Muro Eje C - Recinto 5";
        muro_eje_c_r5 = false;
        r5_muroc_nombreController = TextEditingController(text: "(_)");
        break;
      case 41:
        nombreHojaActual = "Muro Eje D - Recinto 5";
        muro_eje_d_r5 = false;
        r5_murod_nombreController = TextEditingController(text: "(_)");
        break;
      case 42:
        nombreHojaActual = "Muro Eje E - Recinto 5";
        muro_eje_e_r5 = false;
        r5_muroe_nombreController = TextEditingController(text: "(_)");
        break;
      case 43:
        nombreHojaActual = "Muro Eje F - Recinto 5";
        muro_eje_f_r5 = false;
        r5_murof_nombreController = TextEditingController(text: "(_)");
        break;
      case 44:
        nombreHojaActual = "Muro Eje G - Recinto 5";
        muro_eje_g_r5 = false;
        r5_murog_nombreController = TextEditingController(text: "(_)");
        break;

    //--> agregar mas pantallas
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No hay hoja asociada a esta pantalla.")),
        );
        return;
    }

    final indexHoja = buscarIndexHojaMuro(context, nombreHojaActual);

    final bool? confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Eliminar hoja"),
          content: Text("¿Seguro que deseas eliminar la hoja \"$nombreHojaActual\"?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text(
                "Eliminar",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (confirmar == true) {
      eliminarHojaMuro(indexHoja!);

      pantallaActual = 0;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hoja \"$nombreHojaActual\" eliminada.")),
      );
    }
  }

  //--> Hojas Piso Cielo
  Future<void> eliminarPantallaPisoCieloActual(BuildContext context) async {
    String? nombreHojaActual;

    switch (pantallaActual) {
      case 9: //--------------------------------------------------cambiar al agregar las demas pantallas de muros de r1
        nombreHojaActual = "Piso Cielo - Recinto 1";
        break;
      case 18:
        nombreHojaActual = "Piso Cielo - Recinto 2";
        break;
      case 27:
        nombreHojaActual = "Piso Cielo - Recinto 3";
        break;
      case 36:
        nombreHojaActual = "Piso Cielo - Recinto 4";
        break;
      case 45:
        nombreHojaActual = "Piso Cielo - Recinto 5";
        break;

    //--> agregar mas pantallas
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No hay hoja asociada a esta pantalla.")),
        );
        return;
    }

    final indexHoja = buscarIndexHojaPisoCielo(context, nombreHojaActual);

    final bool? confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Eliminar hoja"),
          content: Text("¿Seguro que deseas eliminar la hoja \"$nombreHojaActual\"?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text(
                "Eliminar",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (confirmar == true) {
      eliminarHojaPisoCielo(indexHoja!);

      //--> Actualiza flags según la pantalla
      switch (pantallaActual) {
        case 9: //--------------------------------------------------cambiar al agregar las demas pantallas de muros de r1
          piso_cielo_r1 = false;
          r1_pisocielo_nombreController = TextEditingController(text: "Piso Cielo");
          break;
        case 18:
          piso_cielo_r2 = false;
          break;
        case 27:
          piso_cielo_r3 = false;
          break;
        case 36:
          piso_cielo_r4 = false;
          break;
        case 45:
          piso_cielo_r5 = false;
          break;

      }
      pantallaActual = 0;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hoja \"$nombreHojaActual\" eliminada.")),
      );
    }
  }

  //----------------------------------------------------------------------------
  // Funcion de guardar el excel con sus hojas
  //----------------------------------------------------------------------------

  Future<void> guardarExcel(BuildContext context) async {
    try {
      guardando = true;
      notifyListeners();

      String nombreArchivo = "Inspección " + direccionController.text.trim();
      if (nombreArchivo.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Por favor, ingrese la direccion de la vivienda.")),
        );
        pantallaActual = 0;
        guardando = false;
        notifyListeners();
        return;
      }

      //--> Seleccionar carpeta
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory == null) {
        pantallaActual = 0;
        guardando = false;
        notifyListeners();
        return;
      }

      //------------------------------------------------------------------------
      // Crear Workbook y agregar la hoja Informacion General
      //------------------------------------------------------------------------

      final ByteData imageData =
      await rootBundle.load('assets/logo_citec.jpg');

      final Uint8List imageBytes = imageData.buffer.asUint8List();

      final xlsio.Workbook workbook = xlsio.Workbook();
      final xlsio.Worksheet sheet = workbook.worksheets[0];
      sheet.name = 'Información General';


      //--> Bordes Celdas Encabezado
      sheet.getRangeByName('B2:R5').cellStyle
        ..borders.all.lineStyle = xlsio.LineStyle.thin
        ..borders.all.color = '#000000';

      sheet.getRangeByName('B2:E5').merge();
      // Insertar imagen en la hoja
      final xlsio.Picture picture = sheet.pictures.addStream(
        2, // fila inicial (1-based)
        2, // columna inicial (B = 2)
        imageBytes,
      );

      // Opcional: ajustar tamaño
      picture.height = 80;
      picture.width = 150;

      // Opcional: que quede dentro del rango B3:E5
      picture.lastRow = 6;
      picture.lastColumn = 6;

      sheet.getRangeByName('F2:N5').merge();
      sheet.getRangeByName('F2').setText(
        "PROTOCOLO\nINSPECCIÓN VISUAL DE VIVIENDAS - ACONDICIONAMIENTO AMBIENTAL",);
      sheet.getRangeByName('F3').cellStyle.bold = true;

      sheet.getRangeByName('O2:P5').merge();
      sheet.getRangeByName('O2').setText("Unidad");
      sheet.getRangeByName('O2').cellStyle.bold = true;

      sheet.getRangeByName('Q2:R5').merge();
      sheet.getRangeByName('Q2').setText("Citec Ubb");
      sheet.getRangeByName('Q2').cellStyle.bold = true;


      //--> Bordes de celdas Item 1
      sheet.getRangeByName('B7:R31').cellStyle
        ..borders.all.lineStyle = xlsio.LineStyle.thin
        ..borders.all.color = '#000000';

      sheet.getRangeByName('B7').setText("Item");
      sheet.getRangeByName('B7').cellStyle
        ..bold = true
        ..backColor = '#FFC000';

      sheet.getRangeByName('C7:R7').merge();
      sheet.getRangeByName('C7').setText("Información General ");
      sheet.getRangeByName('C7').cellStyle
        ..bold = true
        ..backColor = '#BFBFBF';

      sheet.getRangeByName('B8:B31').merge();
      sheet.getRangeByName('B8').setText("1");
      sheet.getRangeByName('B8').cellStyle
        ..bold = true
        ..backColor = '#FFC000';

      sheet.getRangeByName('C8:E8').merge();
      sheet.getRangeByName('C8').setText("Nombre Proyecto");
      sheet.getRangeByName('C8').cellStyle.bold = true;

      sheet.getRangeByName('F8:R8').merge();
      sheet.getRangeByName('F8').setText(nombreProyectoController.text);

      sheet.getRangeByName('C9:E9').merge();
      sheet.getRangeByName('C9').setText("Tipología de Vivienda");
      sheet.getRangeByName('C9').cellStyle.bold = true;

      sheet.getRangeByName('F9:R9').merge();
      sheet.getRangeByName('F9').setText(tipologiaViviendaController.text);

      sheet.getRangeByName('C10:E10').merge();
      sheet.getRangeByName('C10').setText("N° Ficha");
      sheet.getRangeByName('C10').cellStyle.bold = true;

      sheet.getRangeByName('F10:G10').merge();
      sheet.getRangeByName('F10').setText(nFichaController.text);

      sheet.getRangeByName('H10').setText("Fecha");
      sheet.getRangeByName('H10').cellStyle.bold = true;

      sheet.getRangeByName('I10:J10').merge();
      sheet.getRangeByName('I10').setText(fechaFormateada);

      sheet.getRangeByName('K10:L10').merge();
      sheet.getRangeByName('K10').setText("Hora Ingreso");
      sheet.getRangeByName('K10').cellStyle.bold = true;

      sheet.getRangeByName('M10:N10').merge();
      sheet.getRangeByName('M10').setText(horaInicio);

      sheet.getRangeByName('O10:P10').merge();
      sheet.getRangeByName('O10').setText("Hora Salida");
      sheet.getRangeByName('O10').cellStyle.bold = true;

      sheet.getRangeByName('Q10:R10').merge();
      sheet.getRangeByName('Q10').setText(horaFin);

      sheet.getRangeByName('C11:E11').merge();
      sheet.getRangeByName('C11').setText("Dirección");
      sheet.getRangeByName('C11').cellStyle.bold = true;

      sheet.getRangeByName('F11:L11').merge();
      sheet.getRangeByName('F11').setText(direccionController.text + ", " + comunasController.text + ", " + regionController.text);

      sheet.getRangeByName('M11:O11').merge();
      sheet.getRangeByName('M11').setText("Etapa");
      sheet.getRangeByName('M11').cellStyle.bold = true;

      sheet.getRangeByName('P11:R11').merge();
      sheet.getRangeByName('P11').setText(etapaController.text);

      sheet.getRangeByName('C12:E13').merge();
      sheet.getRangeByName('C12').setText("Superficie vivienda");
      sheet.getRangeByName('C12').cellStyle.bold = true;

      sheet.getRangeByName('F12:H13').merge();
      sheet.getRangeByName('F12').setText(supViviendaController.text);

      sheet.getRangeByName('I12:I13').merge();
      sheet.getRangeByName('I12').setText("N° Pisos");
      sheet.getRangeByName('I12').cellStyle.bold = true;

      sheet.getRangeByName('J12:J13').merge();
      sheet.getRangeByName('J12').setText(nPisosController.text);

      sheet.getRangeByName('K12:L13').merge();
      sheet.getRangeByName('K12').setText("Orientación fachada");
      sheet.getRangeByName('K12').cellStyle.bold = true;

      sheet.getRangeByName('M12:M13').merge();
      sheet.getRangeByName('M12').setText(oriFachadaController.text +" "+ oriFachadainfoController.text);

      sheet.getRangeByName('N12:O13').merge();
      sheet.getRangeByName('N12').setText("Orientación acceso");
      sheet.getRangeByName('N12').cellStyle.bold = true;

      sheet.getRangeByName('P12:P13').merge();
      sheet.getRangeByName('P12').setText(oriAccesoController.text +" "+ oriAccesoinfoController.text);

      sheet.getRangeByName('Q12:Q13').merge();
      sheet.getRangeByName('Q12').setText("Clima");
      sheet.getRangeByName('Q12').cellStyle.bold = true;

      sheet.getRangeByName('R12:R13').merge();
      sheet.getRangeByName('R12').setText(climaController.text);

      sheet.getRangeByName('C14:E14').merge();
      sheet.getRangeByName('C14').setText("Temperatura exterior");
      sheet.getRangeByName('C14').cellStyle.bold = true;

      sheet.getRangeByName('F14:J14').merge();
      sheet.getRangeByName('F14').setText(tempExteriorController.text);

      sheet.getRangeByName('K14:M14').merge();
      sheet.getRangeByName('K14').setText("Humedad exterior");
      sheet.getRangeByName('K14').cellStyle.bold = true;

      sheet.getRangeByName('N14:R14').merge();
      sheet.getRangeByName('N14').setText(humExteriorController.text);

      sheet.getRangeByName('C15:E15').merge();
      sheet.getRangeByName('C15').setText("Temperatura interior");
      sheet.getRangeByName('C15').cellStyle.bold = true;

      sheet.getRangeByName('F15:J15').merge();
      sheet.getRangeByName('F15').setText(tempInteriorController.text);

      sheet.getRangeByName('K15:M15').merge();
      sheet.getRangeByName('K15').setText("Humedad interior");
      sheet.getRangeByName('K15').cellStyle.bold = true;

      sheet.getRangeByName('N15:R15').merge();
      sheet.getRangeByName('N15').setText(humInteriorController.text);

      sheet.getRangeByName('C16:E20').merge();
      sheet.getRangeByName('C16').setText("Recibido por");
      sheet.getRangeByName('C16').cellStyle.bold = true;

      sheet.getRangeByName('F16:I20').merge();
      sheet.getRangeByName('F16').setText(reciPorController.text);

      sheet.getRangeByName('J16:R16').merge();
      sheet.getRangeByName('J16').setText("Nombre");
      sheet.getRangeByName('J16').cellStyle.bold = true;

      sheet.getRangeByName('J17:R19').merge();
      sheet.getRangeByName('J17').setText(nombreReciController.text);

      sheet.getRangeByName('J20:L20').merge();
      sheet.getRangeByName('J20').setText("Años de uso vivienda");
      sheet.getRangeByName('J20').cellStyle.bold = true;

      sheet.getRangeByName('M20:R20').merge();
      sheet.getRangeByName('M20').setText(usoViviendaController.text);

      sheet.getRangeByName('C21:E22').merge();
      sheet.getRangeByName('C21').setText("Inspector CITEC UBB");
      sheet.getRangeByName('C21').cellStyle.bold = true;

      sheet.getRangeByName('F21:L22').merge();
      sheet.getRangeByName('F21').setText(nombreInspectorController.text);

      sheet.getRangeByName('M21:M22').merge();
      sheet.getRangeByName('M21').setText("C.I:");
      sheet.getRangeByName('M21').cellStyle.bold = true;

      sheet.getRangeByName('N21:R22').merge();
      sheet.getRangeByName('N21').setText(rutInspectorController.text + " - " + digVerifController.text);

      sheet.getRangeByName('C23:E24').merge();
      sheet.getRangeByName('C23').setText("Reparaciones");
      sheet.getRangeByName('C23').cellStyle.bold = true;

      sheet.getRangeByName('F23').setText("SI");
      sheet.getRangeByName('F23').cellStyle.bold = true;

      sheet.getRangeByName('G23').setText("NO");
      sheet.getRangeByName('G23').cellStyle.bold = true;

      if (reparacionesController.text == "Si") {
        sheet.getRangeByName('F24').setText("✔");
      }else {
        sheet.getRangeByName('G24').setText("✔");
      }

      sheet.getRangeByName('H23:R23').merge();
      sheet.getRangeByName('H23').setText("¿Cuántas y de qué tipo?");
      sheet.getRangeByName('H23').cellStyle.bold = true;

      sheet.getRangeByName('H24:R24').merge();
      sheet.getRangeByName('H24').setText(detalleReparacionesController.text);

      sheet.getRangeByName('C25:E26').merge();
      sheet.getRangeByName('C25').setText("Ampliaciones");
      sheet.getRangeByName('C25').cellStyle.bold = true;

      sheet.getRangeByName('F25').setText("SI");
      sheet.getRangeByName('F25').cellStyle.bold = true;

      sheet.getRangeByName('G25').setText("NO");
      sheet.getRangeByName('G25').cellStyle.bold = true;

      if (ampliacionesController.text == "Si") {
        sheet.getRangeByName('F26').setText("✔");
      }else {
        sheet.getRangeByName('G26').setText("✔");
      }

      sheet.getRangeByName('H25:R25').merge();
      sheet.getRangeByName('H25').setText("¿Cuántas y de qué tipo?");
      sheet.getRangeByName('H25').cellStyle.bold = true;

      sheet.getRangeByName('H26:R26').merge();
      sheet.getRangeByName('H26').setText(detalleAmpliacionesController.text);

      sheet.getRangeByName('C27:E27').merge();
      sheet.getRangeByName('C27').setText("Observaciones:");
      sheet.getRangeByName('C27').cellStyle.bold = true;

      sheet.getRangeByName('F27:R27').merge();

      sheet.getRangeByName('C28:R31').merge();
      sheet.getRangeByName('C28').setText(obsInfoGeneralController.text);


      //--> Bordes de celdas Item 2
      sheet.getRangeByName('B33:R39').cellStyle
        ..borders.all.lineStyle = xlsio.LineStyle.thin
        ..borders.all.color = '#000000';

      sheet.getRangeByName('B33').setText("Item");
      sheet.getRangeByName('B33').cellStyle
        ..bold = true
        ..backColor = '#FFC000';

      sheet.getRangeByName('C33:R33').merge();
      sheet.getRangeByName('C33').setText("Ocupación vivienda");
      sheet.getRangeByName('C33').cellStyle
        ..bold = true
        ..backColor = '#BFBFBF';

      sheet.getRangeByName('B34:B39').merge();
      sheet.getRangeByName('B34').setText("2");
      sheet.getRangeByName('B34').cellStyle
        ..bold = true
        ..backColor = '#FFC000';

      sheet.getRangeByName('C34:E34').merge();
      sheet.getRangeByName('C34').setText("N° de recintos vivienda");
      sheet.getRangeByName('C34').cellStyle.bold = true;

      sheet.getRangeByName('C35:E35').merge();
      sheet.getRangeByName('C35').setText(numRecintosController.text);

      sheet.getRangeByName('F34:H34').merge();
      sheet.getRangeByName('F34').setText("Total número de habitantes");
      sheet.getRangeByName('F34').cellStyle.bold = true;

      sheet.getRangeByName('F35:H35').merge();
      sheet.getRangeByName('F35').setText(totalHabitantesController.text);

      sheet.getRangeByName('I34:K34').merge();
      sheet.getRangeByName('I34').setText("Adultos");
      sheet.getRangeByName('I34').cellStyle.bold = true;

      sheet.getRangeByName('I35:K35').merge();
      sheet.getRangeByName('I35').setText(numAdultosController.text);

      sheet.getRangeByName('L34:N34').merge();
      sheet.getRangeByName('L34').setText("Niños en edad escolar");
      sheet.getRangeByName('L34').cellStyle.bold = true;

      sheet.getRangeByName('L35:N35').merge();
      sheet.getRangeByName('L35').setText(numMenoresController.text);

      sheet.getRangeByName('O34:R34').merge();
      sheet.getRangeByName('O34').setText("Adutlos mayores");
      sheet.getRangeByName('O34').cellStyle.bold = true;

      sheet.getRangeByName('O35:R35').merge();
      sheet.getRangeByName('O35').setText(numAdulMayoresController.text);

      sheet.getRangeByName('C36:E37').merge();
      sheet.getRangeByName('C36').setText("Ocupación todo el día");
      sheet.getRangeByName('C36').cellStyle.bold = true;

      sheet.getRangeByName('F36:H37').merge();
      sheet.getRangeByName('F36').setText(ocupDiaCompController.text);

      sheet.getRangeByName('I36:K37').merge();
      sheet.getRangeByName('I36').setText("Ocupación intermitente");
      sheet.getRangeByName('I36').cellStyle.bold = true;

      sheet.getRangeByName('L36:N37').merge();
      sheet.getRangeByName('L36').setText(ocupIntermitenteController.text);

      sheet.getRangeByName('C38:E39').merge();
      sheet.getRangeByName('C38').setText("Densidad ocupacional prevista");
      sheet.getRangeByName('C38').cellStyle.bold = true;


      sheet.getRangeByName('F38:H39').merge();
      sheet.getRangeByName('F38').setText(densOcupPrevController.text);

      sheet.getRangeByName('I38:K39').merge();
      sheet.getRangeByName('I38').setText("Densidad ocupacional real");
      sheet.getRangeByName('I38').cellStyle.bold = true;

      sheet.getRangeByName('L38:N39').merge();
      sheet.getRangeByName('L38').setText(densOcupRealController.text);

      sheet.getRangeByName('O36:O39').merge();
      sheet.getRangeByName('O36').setText("Obs:");
      sheet.getRangeByName('O36').cellStyle.bold = true;

      sheet.getRangeByName('P36:R39').merge();
      sheet.getRangeByName('P36').setText(obsOcupVivController.text);


      //--> Bordes de celdas Item 3
      sheet.getRangeByName('B41:R65').cellStyle
        ..borders.all.lineStyle = xlsio.LineStyle.thin
        ..borders.all.color = '#000000';

      sheet.getRangeByName('B41').setText("Item");
      sheet.getRangeByName('B41').cellStyle
        ..bold = true
        ..backColor = '#FFC000';

      sheet.getRangeByName('C41:R41').merge();
      sheet.getRangeByName('C41').setText("Identificación tipología de vivienda ");
      sheet.getRangeByName('C41').cellStyle
        ..bold = true
        ..backColor = '#BFBFBF';

      sheet.getRangeByName('B42:B65').merge();
      sheet.getRangeByName('B42').setText("3");
      sheet.getRangeByName('B42').cellStyle
        ..bold = true
        ..backColor = '#FFC000';

      sheet.getRangeByName('C42:R42').merge();
      sheet.getRangeByName('C42').setText("Indicar tipología de vivienda a inspeccionar");
      sheet.getRangeByName('C42').cellStyle.bold = true;


      switch (cantFotos) {
        case 1:
          sheet.getRangeByName('C43:R65').merge();
          File? imagenAguardar;

          if (imagen1GuardadaInfoGeneral != null){
            imagenAguardar = imagen1GuardadaInfoGeneral!;
          }
          if (imagen2GuardadaInfoGeneral != null){
            imagenAguardar = imagen2GuardadaInfoGeneral!;
          }
          if (imagen3GuardadaInfoGeneral != null){
            imagenAguardar = imagen3GuardadaInfoGeneral!;
          }
          if (imagen4GuardadaInfoGeneral != null){
            imagenAguardar = imagen4GuardadaInfoGeneral!;
          }

          //--> Info General 1 imagen
          if (imagenAguardar != null && imagenAguardar.existsSync()) {
            final Uint8List imageBytes = await imagenAguardar.readAsBytes();
            final xlsio.Picture picture = sheet.pictures.addBase64(
              43, // fila
              6, // columna
              base64Encode(imageBytes),
            );
            picture.height = 460;
            picture.width = 1010;
          }
          break;
        case 2:
          sheet.getRangeByName('C43:J65').merge();
          sheet.getRangeByName('K43:R65').merge();
          File? imagen1Aguardar;
          File? imagen2Aguardar;

          if (imagen1GuardadaInfoGeneral != null && imagen2GuardadaInfoGeneral != null){
            imagen1Aguardar = imagen1GuardadaInfoGeneral!;
            imagen2Aguardar = imagen2GuardadaInfoGeneral!;
          }
          if (imagen1GuardadaInfoGeneral != null && imagen3GuardadaInfoGeneral != null){
            imagen1Aguardar = imagen1GuardadaInfoGeneral!;
            imagen2Aguardar = imagen3GuardadaInfoGeneral!;
          }
          if (imagen1GuardadaInfoGeneral != null && imagen4GuardadaInfoGeneral != null){
            imagen1Aguardar = imagen1GuardadaInfoGeneral!;
            imagen2Aguardar = imagen4GuardadaInfoGeneral!;
          }
          if (imagen2GuardadaInfoGeneral != null && imagen3GuardadaInfoGeneral != null){
            imagen1Aguardar = imagen2GuardadaInfoGeneral!;
            imagen2Aguardar = imagen3GuardadaInfoGeneral!;
          }
          if (imagen2GuardadaInfoGeneral != null && imagen4GuardadaInfoGeneral != null){
            imagen1Aguardar = imagen2GuardadaInfoGeneral!;
            imagen2Aguardar = imagen3GuardadaInfoGeneral!;
          }
          if (imagen3GuardadaInfoGeneral != null && imagen4GuardadaInfoGeneral != null){
            imagen1Aguardar = imagen3GuardadaInfoGeneral!;
            imagen2Aguardar = imagen4GuardadaInfoGeneral!;
          }

          //--> Info General 2 imagenes
          if (imagen1Aguardar != null && imagen1Aguardar.existsSync()) {
            final Uint8List imageBytes = await imagen1Aguardar.readAsBytes();
            final xlsio.Picture picture = sheet.pictures.addBase64(
              43, // fila
              5, // columna
              base64Encode(imageBytes),
            );
            picture.height = 460;
            picture.width = 450;
          }

          if (imagen2Aguardar != null && imagen2Aguardar.existsSync()) {
            final Uint8List imageBytes = await imagen2Aguardar.readAsBytes();
            final xlsio.Picture picture = sheet.pictures.addBase64(
              43, // fila
              13, // columna
              base64Encode(imageBytes),
            );
            picture.height = 460;
            picture.width = 450;
          }
          break;
        case 3:
          sheet.getRangeByName('C43:G65').merge();
          sheet.getRangeByName('H43:M65').merge();
          sheet.getRangeByName('N43:R65').merge();
          File? imagen1Aguardar;
          File? imagen2Aguardar;
          File? imagen3Aguardar;

          if (imagen1GuardadaInfoGeneral != null && imagen2GuardadaInfoGeneral != null && imagen3GuardadaInfoGeneral != null){
            imagen1Aguardar = imagen1GuardadaInfoGeneral!;
            imagen2Aguardar = imagen2GuardadaInfoGeneral!;
            imagen3Aguardar = imagen3GuardadaInfoGeneral!;
          }
          if (imagen1GuardadaInfoGeneral != null && imagen2GuardadaInfoGeneral != null && imagen4GuardadaInfoGeneral != null){
            imagen1Aguardar = imagen1GuardadaInfoGeneral!;
            imagen2Aguardar = imagen2GuardadaInfoGeneral!;
            imagen3Aguardar = imagen4GuardadaInfoGeneral!;
          }
          if (imagen1GuardadaInfoGeneral != null && imagen3GuardadaInfoGeneral != null && imagen4GuardadaInfoGeneral != null){
            imagen1Aguardar = imagen1GuardadaInfoGeneral!;
            imagen2Aguardar = imagen3GuardadaInfoGeneral!;
            imagen3Aguardar = imagen4GuardadaInfoGeneral!;
          }
          if (imagen2GuardadaInfoGeneral != null && imagen3GuardadaInfoGeneral != null && imagen4GuardadaInfoGeneral != null){
            imagen1Aguardar = imagen2GuardadaInfoGeneral!;
            imagen2Aguardar = imagen3GuardadaInfoGeneral!;
            imagen3Aguardar = imagen4GuardadaInfoGeneral!;
          }

          //--> Info General 3 imagenes
          if (imagen1Aguardar != null && imagen1Aguardar.existsSync()) {
            final Uint8List imageBytes = await imagen1Aguardar.readAsBytes();
            final xlsio.Picture picture = sheet.pictures.addBase64(
              43, // fila
              3, // columna
              base64Encode(imageBytes),
            );
            picture.height = 460;
            picture.width = 550;
          }

          if (imagen2Aguardar != null && imagen2Aguardar.existsSync()) {
            final Uint8List imageBytes = await imagen2Aguardar.readAsBytes();
            final xlsio.Picture picture = sheet.pictures.addBase64(
              43, // fila
              9, // columna
              base64Encode(imageBytes),
            );
            picture.height = 460;
            picture.width = 450;
          }
          if (imagen3Aguardar != null && imagen3Aguardar.existsSync()) {
            final Uint8List imageBytes = await imagen3Aguardar.readAsBytes();
            final xlsio.Picture picture = sheet.pictures.addBase64(
              43, // fila
              14, // columna
              base64Encode(imageBytes),
            );
            picture.height = 460;
            picture.width = 550;
          }
          break;
        case 4:
          sheet.getRangeByName('C43:F65').merge();
          sheet.getRangeByName('G43:J65').merge();
          sheet.getRangeByName('K43:N65').merge();
          sheet.getRangeByName('O43:R65').merge();

          //--> Info General 4 imagenes
          if (imagen1GuardadaInfoGeneral != null && imagen1GuardadaInfoGeneral!.existsSync()) {
            final Uint8List imageBytes = await imagen1GuardadaInfoGeneral!.readAsBytes();
            final xlsio.Picture picture = sheet.pictures.addBase64(
              43, // fila
              3, // columna
              base64Encode(imageBytes),
            );
            picture.height = 460;
            picture.width = 440;
          }
          if (imagen2GuardadaInfoGeneral != null && imagen2GuardadaInfoGeneral!.existsSync()) {
            final Uint8List imageBytes = await imagen2GuardadaInfoGeneral!.readAsBytes();
            final xlsio.Picture picture = sheet.pictures.addBase64(
              43, // fila
              7, // columna
              base64Encode(imageBytes),
            );
            picture.height = 460;
            picture.width = 440;
          }
          if (imagen3GuardadaInfoGeneral != null && imagen3GuardadaInfoGeneral!.existsSync()) {
            final Uint8List imageBytes = await imagen3GuardadaInfoGeneral!.readAsBytes();
            final xlsio.Picture picture = sheet.pictures.addBase64(
              43, // fila
              11, // columna
              base64Encode(imageBytes),
            );
            picture.height = 460;
            picture.width = 440;
          }
          if (imagen4GuardadaInfoGeneral != null && imagen4GuardadaInfoGeneral!.existsSync()) {
            final Uint8List imageBytes = await imagen4GuardadaInfoGeneral!.readAsBytes();
            final xlsio.Picture picture = sheet.pictures.addBase64(
              43, // fila
              15, // columna
              base64Encode(imageBytes),
            );
            picture.height = 460;
            picture.width = 440;
          }
          break;
      }

      sheet.showGridlines = false;
      sheet.getRangeByName('A1:S66').rowHeight = 15;
      sheet.getRangeByName('A12:S12').rowHeight = 25;
      sheet.getRangeByName('A13:S13').rowHeight = 25;
      sheet.getRangeByName('A1:S66').columnWidth = 15;
      sheet.getRangeByName('A1:S66').cellStyle
        ..fontSize = 12
        ..wrapText = true
        ..hAlign = xlsio.HAlignType.center
        ..vAlign = xlsio.VAlignType.center;


      //------------------------------------------------------------------------
      //-------------SECCION DE GUARDADO SEGUN HOJA UTILIZADA-------------------
      //------------------------------------------------------------------------

      //-- Recinto 1
      if (muro_eje_p_info_r1 == true && muro_eje_p_r1 == true) {
        final indexRecinto = buscarIndexHojaRecinto(context, "Recinto 1");
        final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje A - Recinto 1");
        if (indexRecinto == null && indexHojaMuro == null) {

        } else {
          await crearHojaMuroPrincipalExcel(
            workbook: workbook,
            recinto: recintos[indexRecinto!],
            hojaMuro: hojasM[indexHojaMuro!],
            nombreRecinto: recintos[indexRecinto].nombreRecintoController.text,
            nombreHoja: "MP${hojasM[indexHojaMuro].nombreMuroController.text}-",
            muroEje: hojasM[indexHojaMuro].nombreMuroController.text
          );
          //--ESTAS HOJAS SE GUARDAN SOLO SI LA HOJA PRINCIPAL ESTA UTILIZADA---
          //--HOJA Muro Eje B - Recinto 1
          if (muro_eje_b_r1 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje B - Recinto 1");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r1_murob_nombreController.text} - R1",
                muroEje: r1_murob_nombreController.text,
              );
            }
          }
        //--HOJA Muro Eje C - Recinto 1
          if (muro_eje_c_r1 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje C - Recinto 1");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r1_muroc_nombreController.text} - R1",
                muroEje: r1_muroc_nombreController.text,
              );
            }
          }
        //--HOJA Muro Eje D - Recinto 1
          if (muro_eje_d_r1 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje D - Recinto 1");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r1_murod_nombreController.text} - R1",
                muroEje: r1_murod_nombreController.text,
              );
            }
          }
        //--HOJA Muro Eje E - Recinto 1
          if (muro_eje_e_r1 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje E - Recinto 1");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r1_muroe_nombreController.text} - R1",
                muroEje: r1_muroe_nombreController.text,
              );
            }
          }
        //--HOJA Muro Eje F - Recinto 1
          if (muro_eje_f_r1 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje F - Recinto 1");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r1_murof_nombreController.text} - R1",
                muroEje: r1_murof_nombreController.text,
              );
            }
          }
        //--HOJA Muro Eje G - Recinto 1
          if (muro_eje_g_r1 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje G - Recinto 1");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r1_murog_nombreController.text} - R1",
                muroEje: r1_murog_nombreController.text,
              );
            }
          }
        //--HOJA Piso Cielo - Recinto 1
          if (piso_cielo_r1 == true) {
            final indexHojaPisoCielo = buscarIndexHojaPisoCielo(context, "Piso Cielo - Recinto 1");
            if (indexHojaPisoCielo == null) {
            } else {
              await crearHojaPisoCieloExcel(
                workbook: workbook,
                hojaPisoCielo: hojasPC[indexHojaPisoCielo],
                nombreHoja: "${r1_pisocielo_nombreController.text} - R1",
              );
            }
          }
        }
      }

      //--Recinto 2
      if (muro_eje_p_info_r2 == true && muro_eje_p_r2 == true) {
        final indexRecinto = buscarIndexHojaRecinto(context, "Recinto 2");
        final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje A - Recinto 2");
        if (indexRecinto == null && indexHojaMuro == null) {

        } else {
          await crearHojaMuroPrincipalExcel(
              workbook: workbook,
              recinto: recintos[indexRecinto!],
              hojaMuro: hojasM[indexHojaMuro!],
              nombreRecinto: "MP${recinto2_nombreController.text} - R2",
              nombreHoja: "MP${r2_murop_nombreController.text} - R2",
              muroEje: r2_murop_nombreController.text
          );
          //--ESTAS HOJAS SE GUARDAN SOLO SI LA HOJA PRINCIPAL ESTA UTILIZADA---
          //--HOJA Muro Eje B - Recinto 2
          if (muro_eje_b_r2 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje B - Recinto 2");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r2_murob_nombreController.text} - R2",
                muroEje: r2_murob_nombreController.text,
              );
            }
          }
          //--HOJA Muro Eje C - Recinto 2
          if (muro_eje_c_r2 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje C - Recinto 2");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r2_muroc_nombreController.text} - R2",
                muroEje: r2_muroc_nombreController.text,
              );
            }
          }
          //--HOJA Muro Eje D - Recinto 2
          if (muro_eje_d_r2 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje D - Recinto 2");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r2_murod_nombreController.text} - R2",
                muroEje: r2_murod_nombreController.text,
              );
            }
          }
          //--HOJA Muro Eje E - Recinto 2
          if (muro_eje_e_r2 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje E - Recinto 2");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r2_muroe_nombreController.text} - R2",
                muroEje: r2_muroe_nombreController.text,
              );
            }
          }
          //--HOJA Muro Eje F - Recinto 2
          if (muro_eje_f_r2 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje F - Recinto 2");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r2_murof_nombreController.text} - R2",
                muroEje: r2_murof_nombreController.text,
              );
            }
          }
          //--HOJA Muro Eje G - Recinto 2
          if (muro_eje_g_r2 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje G - Recinto 2");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r2_murog_nombreController.text} - R2",
                muroEje: r2_murog_nombreController.text,
              );
            }
          }
          //--HOJA Piso Cielo - Recinto 2
          if (piso_cielo_r2 == true) {
            final indexHojaPisoCielo = buscarIndexHojaPisoCielo(context, "Piso Cielo - Recinto 2");
            if (indexHojaPisoCielo == null) {
            } else {
              await crearHojaPisoCieloExcel(
                workbook: workbook,
                hojaPisoCielo: hojasPC[indexHojaPisoCielo],
                nombreHoja: "${r2_pisocielo_nombreController.text} - R2",
              );
            }
          }
        }
      }

      //-- Recinto 3
      if (muro_eje_p_info_r3 == true && muro_eje_p_r3 == true) {
        final indexRecinto = buscarIndexHojaRecinto(context, "Recinto 3");
        final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje A - Recinto 3");
        if (indexRecinto == null && indexHojaMuro == null) {

        } else {
          await crearHojaMuroPrincipalExcel(
              workbook: workbook,
              recinto: recintos[indexRecinto!],
              hojaMuro: hojasM[indexHojaMuro!],
              nombreRecinto: "MP${recinto3_nombreController.text} - R3",
              nombreHoja: "MP${r3_murop_nombreController.text} - R3",
              muroEje: r3_murop_nombreController.text
          );
          //--ESTAS HOJAS SE GUARDAN SOLO SI LA HOJA PRINCIPAL ESTA UTILIZADA---
          //--HOJA Muro Eje B - Recinto 3
          if (muro_eje_b_r3 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje B - Recinto 3");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r3_murob_nombreController.text} - R3",
                muroEje: r3_murob_nombreController.text,
              );
            }
          }
          //--HOJA Muro Eje C - Recinto 3
          if (muro_eje_c_r3 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje C - Recinto 3");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r3_muroc_nombreController.text} - R3",
                muroEje: r3_muroc_nombreController.text,
              );
            }
          }
          //--HOJA Muro Eje D - Recinto 3
          if (muro_eje_d_r3 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje D - Recinto 3");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r3_murod_nombreController.text} - R3",
                muroEje: r3_murod_nombreController.text,
              );
            }
          }
          //--HOJA Muro Eje E - Recinto 3
          if (muro_eje_e_r3 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje E - Recinto 3");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r3_muroe_nombreController.text} - R3",
                muroEje: r3_muroe_nombreController.text,
              );
            }
          }
          //--HOJA Muro Eje F - Recinto 1
          if (muro_eje_f_r3 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje F - Recinto 3");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r3_murof_nombreController.text} - R3",
                muroEje: r3_murof_nombreController.text,
              );
            }
          }
          //--HOJA Muro Eje G - Recinto 3
          if (muro_eje_g_r3 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje G - Recinto 3");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r3_murog_nombreController.text} - R3",
                muroEje: r3_murog_nombreController.text,
              );
            }
          }
          //--HOJA Piso Cielo - Recinto 3
          if (piso_cielo_r3 == true) {
            final indexHojaPisoCielo = buscarIndexHojaPisoCielo(context, "Piso Cielo - Recinto 3");
            if (indexHojaPisoCielo == null) {
            } else {
              await crearHojaPisoCieloExcel(
                workbook: workbook,
                hojaPisoCielo: hojasPC[indexHojaPisoCielo],
                nombreHoja: "${r3_pisocielo_nombreController.text} - R3",
              );
            }
          }
        }
      }

      //-- Recinto 4
      if (muro_eje_p_info_r4 == true && muro_eje_p_r4 == true) {
        final indexRecinto = buscarIndexHojaRecinto(context, "Recinto 4");
        final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje A - Recinto 4");
        if (indexRecinto == null && indexHojaMuro == null) {

        } else {
          await crearHojaMuroPrincipalExcel(
              workbook: workbook,
              recinto: recintos[indexRecinto!],
              hojaMuro: hojasM[indexHojaMuro!],
              nombreRecinto: "MP${recinto4_nombreController.text} - R4",
              nombreHoja: "MP${r4_murop_nombreController.text} - R4",
              muroEje: r4_murop_nombreController.text
          );
          //--ESTAS HOJAS SE GUARDAN SOLO SI LA HOJA PRINCIPAL ESTA UTILIZADA---
          //--HOJA Muro Eje B - Recinto 4
          if (muro_eje_b_r4 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje B - Recinto 4");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r4_murob_nombreController.text} - R4",
                muroEje: r4_murob_nombreController.text,
              );
            }
          }
          //--HOJA Muro Eje C - Recinto 3
          if (muro_eje_c_r4 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje C - Recinto 4");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r4_muroc_nombreController.text} - R4",
                muroEje: r4_muroc_nombreController.text,
              );
            }
          }
          //--HOJA Muro Eje D - Recinto 4
          if (muro_eje_d_r4 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje D - Recinto 4");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r4_murod_nombreController.text} - R4",
                muroEje: r4_murod_nombreController.text,
              );
            }
          }
          //--HOJA Muro Eje E - Recinto 4
          if (muro_eje_e_r4 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje E - Recinto 4");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r4_muroe_nombreController.text} - R4",
                muroEje: r4_muroe_nombreController.text,
              );
            }
          }
          //--HOJA Muro Eje F - Recinto 4
          if (muro_eje_f_r4 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje F - Recinto 4");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r4_murof_nombreController.text} - R4",
                muroEje: r4_murof_nombreController.text,
              );
            }
          }
          //--HOJA Muro Eje G - Recinto 4
          if (muro_eje_g_r4 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje G - Recinto 4");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r4_murog_nombreController.text} - R4",
                muroEje: r4_murog_nombreController.text,
              );
            }
          }
          //--HOJA Piso Cielo - Recinto 4
          if (piso_cielo_r4 == true) {
            final indexHojaPisoCielo = buscarIndexHojaPisoCielo(context, "Piso Cielo - Recinto 4");
            if (indexHojaPisoCielo == null) {
            } else {
              await crearHojaPisoCieloExcel(
                workbook: workbook,
                hojaPisoCielo: hojasPC[indexHojaPisoCielo],
                nombreHoja: "${r4_pisocielo_nombreController.text} - R4",
              );
            }
          }
        }
      }

      //-- Recinto 5
      if (muro_eje_p_info_r5 == true && muro_eje_p_r5 == true) {
        final indexRecinto = buscarIndexHojaRecinto(context, "Recinto 5");
        final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje A - Recinto 5");
        if (indexRecinto == null || indexHojaMuro == null) {

        } else {
          await crearHojaMuroPrincipalExcel(
              workbook: workbook,
              recinto: recintos[indexRecinto],
              hojaMuro: hojasM[indexHojaMuro],
              nombreRecinto: "MP${recinto5_nombreController.text} - R5",
              nombreHoja: "MP${r5_murop_nombreController.text} - R5",
              muroEje: r5_murop_nombreController.text
          );
          //--ESTAS HOJAS SE GUARDAN SOLO SI LA HOJA PRINCIPAL ESTA UTILIZADA---
          //--HOJA Muro Eje B - Recinto 5
          if (muro_eje_b_r5 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje B - Recinto 5");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r5_murob_nombreController.text} - R5",
                muroEje: r5_murob_nombreController.text,
              );
            }
          }
          //--HOJA Muro Eje C - Recinto 5
          if (muro_eje_c_r5 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje C - Recinto 5");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r5_muroc_nombreController.text} - R5",
                muroEje: r5_muroc_nombreController.text,
              );
            }
          }
          //--HOJA Muro Eje D - Recinto 5
          if (muro_eje_d_r5 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje D - Recinto 5");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r5_murod_nombreController.text} - R5",
                muroEje: r5_murod_nombreController.text,
              );
            }
          }
          //--HOJA Muro Eje E - Recinto 5
          if (muro_eje_e_r5 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje E - Recinto 5");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r5_muroe_nombreController.text} - R5",
                muroEje: r5_muroe_nombreController.text,
              );
            }
          }
          //--HOJA Muro Eje F - Recinto 5
          if (muro_eje_f_r5 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje F - Recinto 5");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r5_murof_nombreController.text} - R5",
                muroEje: r5_murof_nombreController.text,
              );
            }
          }
          //--HOJA Muro Eje G - Recinto 5
          if (muro_eje_g_r5 == true) {
            final indexHojaMuro = buscarIndexHojaMuro(context, "Muro Eje G - Recinto 5");
            if (indexHojaMuro == null) {
            } else {
              await crearHojaMuroExcel(
                workbook: workbook,
                hojaMuro: hojasM[indexHojaMuro],
                nombreHoja: "ME${r5_murog_nombreController.text} - R5",
                muroEje: r5_murog_nombreController.text,
              );
            }
          }
          //--HOJA Piso Cielo - Recinto 5
          if (piso_cielo_r5 == true) {
            final indexHojaPisoCielo = buscarIndexHojaPisoCielo(context, "Piso Cielo - Recinto 5");
            if (indexHojaPisoCielo == null) {
            } else {
              await crearHojaPisoCieloExcel(
                workbook: workbook,
                hojaPisoCielo: hojasPC[indexHojaPisoCielo],
                nombreHoja: "${r5_pisocielo_nombreController.text} - R5",
              );
            }
          }
        }
      }



      //------------------------------------------------------------------------
      //Guardar Archivo
      //------------------------------------------------------------------------

      final List<int> bytes = workbook.saveAsStream();
      workbook.dispose();

      final String filePath = '$selectedDirectory/$nombreArchivo.xlsx';
      final File file = File(filePath);
      await file.writeAsBytes(bytes, flush: true);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ Archivo guardado en: $filePath")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Error al guardar: $e")),
      );
    } finally {
      guardando = false;
      resetApp(context);
      notifyListeners();
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) => const Inicio(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    }
  }


  //------------------------------------------------------------------------------------------------
  // Agregar las hojas de los muros Principales de cada habitacion (1 muro pricipal por habitacion)
  //------------------------------------------------------------------------------------------------

  Future<void> crearHojaMuroPrincipalExcel({
    required xlsio.Workbook workbook,
    required Recinto recinto,
    required HojaMuro hojaMuro,
    required String nombreHoja,
    required String nombreRecinto,
    required String muroEje,
  }) async {

    final sheet = workbook.worksheets.addWithName(nombreHoja+nombreRecinto);

    // -------------------------------------------------------------------------
    // ENCABEZADO
    // -------------------------------------------------------------------------

    sheet.getRangeByName('B2:E5').merge();
    final ByteData imageData =
    await rootBundle.load('assets/logo_citec.jpg');

    final Uint8List imageBytes = imageData.buffer.asUint8List();

    //--> Bordes Celdas Encabezado
    sheet.getRangeByName('B2:R5').cellStyle
      ..borders.all.lineStyle = xlsio.LineStyle.thin
      ..borders.all.color = '#000000';

    sheet.getRangeByName('B2:E5').merge();
    // Insertar imagen en la hoja
    final xlsio.Picture picture = sheet.pictures.addStream(
      2, // fila inicial (1-based)
      2, // columna inicial (B = 2)
      imageBytes,
    );

    // Opcional: ajustar tamaño
    picture.height = 80;
    picture.width = 150;

    // Opcional: que quede dentro del rango B3:E5
    picture.lastRow = 6;
    picture.lastColumn = 6;

    sheet.getRangeByName('F2:N5').merge();
    sheet.getRangeByName('F2').setText(
        "PROTOCOLO\nINSPECCIÓN VISUAL DE VIVIENDAS - ACONDICIONAMIENTO AMBIENTAL");
    sheet.getRangeByName('F2').cellStyle.bold = true;

    sheet.getRangeByName('O2:P5').merge();
    sheet.getRangeByName('O2').setText("Unidad");
    sheet.getRangeByName('O2').cellStyle.bold = true;

    sheet.getRangeByName('Q2:R5').merge();
    sheet.getRangeByName('Q2').setText("CITEC UBB");
    sheet.getRangeByName('Q2').cellStyle.bold = true;

    // -------------------------------------------------------------------------
    // DATOS DEL MURO PRINCIPAL
    // -------------------------------------------------------------------------

    sheet.getRangeByName('B7:R30').cellStyle
      ..borders.all.lineStyle = xlsio.LineStyle.thin
      ..borders.all.color = '#000000';

    sheet.getRangeByName('B7').setText("Item");
    sheet.getRangeByName('B7').cellStyle
      ..bold = true
      ..backColor = '#FFC000';

    sheet.getRangeByName('B8:B65').merge();
    sheet.getRangeByName('B8').setText("5");
    sheet.getRangeByName('B8').cellStyle
      ..bold = true
      ..backColor = '#FFC000';

    sheet.getRangeByName('C7:R7').merge();
    sheet.getRangeByName('C7').setText("Levantamiento de Patologías higrotérmicas");
    sheet.getRangeByName('C7').cellStyle
      ..bold = true
      ..backColor = '#BFBFBF';

    sheet.getRangeByName('C8:R20').merge();

    sheet.getRangeByName('C21:F22').merge();
    sheet.getRangeByName('C21').setText("¿Presenta patologías visibles?");
    sheet.getRangeByName('C21').cellStyle.bold = true;

    sheet.getRangeByName('G21').setText("Si");
    sheet.getRangeByName('G21').cellStyle.bold = true;

    sheet.getRangeByName('H21').setText("No");
    sheet.getRangeByName('H21').cellStyle.bold = true;

    if (recinto.patvisibleController.text == "Si") {
      sheet.getRangeByName('G22').setText("✔");
    } else {
      sheet.getRangeByName('H22').setText("✔");
    }

    sheet.getRangeByName('I21:L22').merge();
    sheet.getRangeByName('I21').setText("Manifestaciones ocultas ¿fue pintado o limpiado últimamente?");
    sheet.getRangeByName('I21').cellStyle.bold = true;

    sheet.getRangeByName('M21').setText("Si");
    sheet.getRangeByName('M21').cellStyle.bold = true;

    sheet.getRangeByName('N21').setText("No");
    sheet.getRangeByName('N21').cellStyle.bold = true;

    if (recinto.pinOlimpController.text == "Si") {
      sheet.getRangeByName('M22').setText("✔");
    } else {
      sheet.getRangeByName('N22').setText("✔");
    }

    sheet.getRangeByName('O21:R21').merge();
    sheet.getRangeByName('O21').setText("¿Cuál?");
    sheet.getRangeByName('O21').cellStyle.bold = true;

    sheet.getRangeByName('O22:R22').merge();
    sheet.getRangeByName('O22').setText(recinto.cualpolController.text);

    sheet.getRangeByName('C23:F24').merge();
    sheet.getRangeByName('C23').setText("¿Olor a humedad?");
    sheet.getRangeByName('C23').cellStyle.bold = true;

    sheet.getRangeByName('G23').setText("Si");
    sheet.getRangeByName('G23').cellStyle.bold = true;

    sheet.getRangeByName('H23').setText("No");
    sheet.getRangeByName('H23').cellStyle.bold = true;

    if (recinto.olorhumController.text == "Si") {
      sheet.getRangeByName('G24').setText("✔");
    } else {
      sheet.getRangeByName('H24').setText("✔");
    }

    sheet.getRangeByName('I23:L24').merge();
    sheet.getRangeByName('I23').setText("¿Modificaciones?");
    sheet.getRangeByName('I23').cellStyle.bold = true;

    sheet.getRangeByName('M23').setText("Si");
    sheet.getRangeByName('M23').cellStyle.bold = true;

    sheet.getRangeByName('N23').setText("No");
    sheet.getRangeByName('N23').cellStyle.bold = true;

    if (recinto.modifController.text == "Si") {
      sheet.getRangeByName('M24').setText("✔");
    } else {
      sheet.getRangeByName('N24').setText("✔");
    }

    sheet.getRangeByName('O23:R23').merge();
    sheet.getRangeByName('O23').setText("¿Cuál?");
    sheet.getRangeByName('O23').cellStyle.bold = true;

    sheet.getRangeByName('O24:R24').merge();
    sheet.getRangeByName('O24').setText(recinto.cualmodController.text);

    sheet.getRangeByName('C25:F26').merge();
    sheet.getRangeByName('C25').setText("Sistema de Calefacción");
    sheet.getRangeByName('C25').cellStyle.bold = true;

    sheet.getRangeByName('G25:H25').merge();
    sheet.getRangeByName('G25').setText("Eléctrico (seca)");
    sheet.getRangeByName('G25').cellStyle.bold = true;

    sheet.getRangeByName('G26:H26').merge();

    sheet.getRangeByName('I25:J25').merge();
    sheet.getRangeByName('I25').setText("Gas / parafina con evacuacipon exterior (seca)");
    sheet.getRangeByName('I25').cellStyle.bold = true;

    sheet.getRangeByName('I26:J26').merge();

    sheet.getRangeByName('K25:L25').merge();
    sheet.getRangeByName('K25').setText("Biomasa con evacuación exterior (seca)");
    sheet.getRangeByName('K25').cellStyle.bold = true;

    sheet.getRangeByName('K26:L26').merge();

    sheet.getRangeByName('M25:N25').merge();
    sheet.getRangeByName('M25').setText("Parafina/gas móvil (húmeda)");
    sheet.getRangeByName('M25').cellStyle.bold = true;

    sheet.getRangeByName('M26:N26').merge();

    sheet.getRangeByName('O25:R25').merge();
    sheet.getRangeByName('O25').setText("Otro ¿cuál?");
    sheet.getRangeByName('O25').cellStyle.bold = true;

    sheet.getRangeByName('O26:R26').merge();

    if (recinto.sistcalefController.text == "Eléctrico (seca)") {
      sheet.getRangeByName('G26').setText("✔");
    }
    if (recinto.sistcalefController.text == "Gas / parafina con evacuación exterior (seca)") {
      sheet.getRangeByName('I26').setText("✔");
    }
    if (recinto.sistcalefController.text == "Biomasa con evacuación exterior (seca)") {
      sheet.getRangeByName('K26').setText("✔");
    }
    if (recinto.sistcalefController.text == "Parafina/gas móvil (húmeda)") {
      sheet.getRangeByName('M26').setText("✔");
    }
    if (recinto.sistcalefController.text == "Otro ¿cuál?") {
      sheet.getRangeByName('O26').setText(recinto.otrocalefController.text);
    }


    sheet.getRangeByName('C27:F27').merge();
    sheet.getRangeByName('C27').setText("¿Cuánto tiempo calefacciona?");
    sheet.getRangeByName('C27').cellStyle.bold = true;

    sheet.getRangeByName('G27:R27').merge();
    sheet.getRangeByName('G27').setText(recinto.tiemcalefController.text);

    sheet.getRangeByName('C28:F30').merge();
    sheet.getRangeByName('C28').setText("Sistema de ventilación (indicar en la planta su ubicación)");
    sheet.getRangeByName('C28').cellStyle.bold = true;

    sheet.getRangeByName('G28:H28').merge();
    sheet.getRangeByName('G28').setText("Aireador");
    sheet.getRangeByName('G28').cellStyle.bold = true;

    sheet.getRangeByName('G29').setText("Operativo");
    sheet.getRangeByName('G29').cellStyle.bold = true;

    sheet.getRangeByName('H29').setText("No Op");
    sheet.getRangeByName('H29').cellStyle.bold = true;

    if (recinto.aireadorController.text == "Operativo") {
      sheet.getRangeByName('G30').setText("✔");
    }
    if (recinto.aireadorController.text == "No Operativo") {
      sheet.getRangeByName('H30').setText("✔");
    }

    sheet.getRangeByName('I28:J28').merge();
    sheet.getRangeByName('I28').setText("Extractor");
    sheet.getRangeByName('I28').cellStyle.bold = true;

    sheet.getRangeByName('I29').setText("Operativo");
    sheet.getRangeByName('I29').cellStyle.bold = true;

    sheet.getRangeByName('J29').setText("No Op");
    sheet.getRangeByName('J29').cellStyle.bold = true;

    if (recinto.extractorController.text == "Operativo") {
      sheet.getRangeByName('I30').setText("✔");
    }
    if (recinto.extractorController.text == "No Operativo") {
      sheet.getRangeByName('J30').setText("✔");
    }

    sheet.getRangeByName('K28:L28').merge();
    sheet.getRangeByName('K28').setText("Campana");
    sheet.getRangeByName('K28').cellStyle.bold = true;

    sheet.getRangeByName('K29').setText("Operativo");
    sheet.getRangeByName('K29').cellStyle.bold = true;

    sheet.getRangeByName('L29').setText("No Op");
    sheet.getRangeByName('L29').cellStyle.bold = true;

    if (recinto.campanaController.text == "Operativo") {
      sheet.getRangeByName('K30').setText("✔");
    }
    if (recinto.campanaController.text == "No Operativo") {
      sheet.getRangeByName('L30').setText("✔");
    }

    sheet.getRangeByName('M28:N28').merge();
    sheet.getRangeByName('M28').setText("Celosía puerta");
    sheet.getRangeByName('M28').cellStyle.bold = true;

    sheet.getRangeByName('M29').setText("Operativo");
    sheet.getRangeByName('M29').cellStyle.bold = true;

    sheet.getRangeByName('N29').setText("No Op");
    sheet.getRangeByName('N29').cellStyle.bold = true;

    if (recinto.celosiapueController.text == "Operativo") {
      sheet.getRangeByName('M30').setText("✔");
    }
    if (recinto.celosiapueController.text == "No Operativo") {
      sheet.getRangeByName('N30').setText("✔");
    }

    sheet.getRangeByName('O28:P28').merge();
    sheet.getRangeByName('O28:P28').setText("Rebaje puerta");
    sheet.getRangeByName('O28:P28').cellStyle.bold = true;

    sheet.getRangeByName('O29').setText("Operativo");
    sheet.getRangeByName('O29').cellStyle.bold = true;

    sheet.getRangeByName('P29').setText("No Op");
    sheet.getRangeByName('P29').cellStyle.bold = true;

    if (recinto.rebajepueController.text == "Operativo") {
      sheet.getRangeByName('O30').setText("✔");
    }
    if (recinto.rebajepueController.text == "No Operativo") {
      sheet.getRangeByName('P30').setText("✔");
    }

    sheet.getRangeByName('Q28:R28').merge();
    sheet.getRangeByName('Q28').setText("Otro");
    sheet.getRangeByName('Q28').cellStyle.bold = true;

    sheet.getRangeByName('Q29').setText("Operativo");
    sheet.getRangeByName('Q29').cellStyle.bold = true;

    sheet.getRangeByName('R29').setText("No Op");
    sheet.getRangeByName('R29').cellStyle.bold = true;

    if (recinto.otroequipController.text == "Operativo") {
      sheet.getRangeByName('Q30').setText("✔");
    }
    if (recinto.otroequipController.text == "No Operativo") {
      sheet.getRangeByName('R30').setText("✔");
    }


    // -------------------------------------------------------------------------
    // DATOS MUROS NORMALES
    // -------------------------------------------------------------------------
    sheet.getRangeByName('C32:R34').cellStyle
      ..borders.all.lineStyle = xlsio.LineStyle.thin
      ..borders.all.color = '#000000';

    sheet.getRangeByName('C32:E32').merge();
    sheet.getRangeByName('C32').setText("MURO EJE");
    sheet.getRangeByName('C32').cellStyle
      ..bold = true
      ..backColor = '#FFE699';

    sheet.getRangeByName('F32').setText(muroEje);
    sheet.getRangeByName('F32').cellStyle.backColor = '#FFE699';

    sheet.getRangeByName('G32:I32').merge();
    sheet.getRangeByName('G32').setText("Superficie muro");
    sheet.getRangeByName('G32').cellStyle.bold = true;

    sheet.getRangeByName('J32:L32').merge();
    sheet.getRangeByName('J32').setText(hojaMuro.supmuroController.text);

    sheet.getRangeByName('M32:O32').merge();
    sheet.getRangeByName('M32').setText("Superficie ventana");
    sheet.getRangeByName('M32').cellStyle.bold = true;

    sheet.getRangeByName('P32:R32').merge();
    sheet.getRangeByName('P32').setText(hojaMuro.supventanaController.text);

    sheet.getRangeByName('C33:E33').merge();
    sheet.getRangeByName('C33').setText("Muro perimetral");
    sheet.getRangeByName('C33').cellStyle.bold = true;

    sheet.getRangeByName('C34:E34').merge();
    sheet.getRangeByName('C34').setText("Muro interior");
    sheet.getRangeByName('C34').cellStyle.bold = true;

    if (hojaMuro.tipoMuroController.text == "Muro perimetral") {
      sheet.getRangeByName('F33').setText("✔");
    }
    if (hojaMuro.tipoMuroController.text == "Muro interior") {
      sheet.getRangeByName('F34').setText("✔");
    }

    sheet.getRangeByName('G33:I34').merge();
    sheet.getRangeByName('G33').setText("Nivel de afectación");
    sheet.getRangeByName('G33').cellStyle.bold = true;

    sheet.getRangeByName('J33:K33').merge();
    sheet.getRangeByName('J33').setText("Nulo");
    sheet.getRangeByName('J33').cellStyle.bold = true;

    sheet.getRangeByName('J34:K34').merge();

    sheet.getRangeByName('L33:M33').merge();
    sheet.getRangeByName('L33').setText("Bajo");
    sheet.getRangeByName('L33').cellStyle.bold = true;

    sheet.getRangeByName('L34:M34').merge();

    sheet.getRangeByName('N33:O33').merge();
    sheet.getRangeByName('N33').setText("Medio");
    sheet.getRangeByName('N33').cellStyle.bold = true;

    sheet.getRangeByName('N34:O34').merge();

    sheet.getRangeByName('P33:R33').merge();
    sheet.getRangeByName('P33').setText("Alto");
    sheet.getRangeByName('P33').cellStyle.bold = true;

    sheet.getRangeByName('P34:R34').merge();

    switch(hojaMuro.nivelafecController.text) {
      case "Nulo":
        sheet.getRangeByName('J34').setText("✔");
        break;
      case "Bajo":
        sheet.getRangeByName('L34').setText("✔");
        break;
      case "Medio":
        sheet.getRangeByName('N34').setText("✔");
        break;
      case "Alto":
        sheet.getRangeByName('P34').setText("✔");
        break;
    }

    sheet.getRangeByName('C36:R46').cellStyle
      ..borders.all.lineStyle = xlsio.LineStyle.thin
      ..borders.all.color = '#000000';

    sheet.getRangeByName('C36:F38').merge();
    sheet.getRangeByName('C36').setText("Ubicación de patología");
    sheet.getRangeByName('C36').cellStyle.bold = true;

    sheet.getRangeByName('G36:R36').merge();
    sheet.getRangeByName('G36').setText("Patología detectada");
    sheet.getRangeByName('G36').cellStyle.bold = true;

    sheet.getRangeByName('G37:L37').merge();
    sheet.getRangeByName('G37').setText("Manchas de humedad / moho");
    sheet.getRangeByName('G37').cellStyle.bold = true;

    sheet.getRangeByName('M37:R37').merge();
    sheet.getRangeByName('M37').setText("Daño físico mecánico");
    sheet.getRangeByName('M37').cellStyle.bold = true;

    sheet.getRangeByName('G38:H38').merge();
    sheet.getRangeByName('G38').setText("SI");
    sheet.getRangeByName('G38').cellStyle.bold = true;

    sheet.getRangeByName('I38:J38').merge();
    sheet.getRangeByName('I38').setText("No");
    sheet.getRangeByName('I38').cellStyle.bold = true;

    sheet.getRangeByName('K38:L38').merge();
    sheet.getRangeByName('K38').setText("Superficie afectada");
    sheet.getRangeByName('K38').cellStyle.bold = true;

    sheet.getRangeByName('M38:N38').merge();
    sheet.getRangeByName('M38').setText("Si");
    sheet.getRangeByName('M38').cellStyle.bold = true;

    sheet.getRangeByName('O38:P38').merge();
    sheet.getRangeByName('O38').setText("No");
    sheet.getRangeByName('O38').cellStyle.bold = true;

    sheet.getRangeByName('Q38:R38').merge();
    sheet.getRangeByName('Q38').setText("Superficie afectada");
    sheet.getRangeByName('Q38').cellStyle.bold = true;


    //-- Encuentro esquina muro
    sheet.getRangeByName('C39:F39').merge();
    sheet.getRangeByName('C39').setText("Encuentro esquina muro");
    sheet.getRangeByName('C39').cellStyle.bold = true;

    sheet.getRangeByName('G39:H39').merge(); //Si
    sheet.getRangeByName('I39:J39').merge(); // No

    if (hojaMuro.mh_encEsqMurController.text == "Si") {
      sheet.getRangeByName('G39').setText("✔");
    }
    if (hojaMuro.mh_encEsqMurController.text == "No") {
      sheet.getRangeByName('I39').setText("✔");
    }

    sheet.getRangeByName('K39:L39').merge();
    sheet.getRangeByName('K39').setText(hojaMuro.mh_supencEsqMurController.text);

    sheet.getRangeByName('M39:N39').merge(); //Si
    sheet.getRangeByName('O39:P39').merge(); // No

    if (hojaMuro.df_encEsqMurController.text == "Si") {
      sheet.getRangeByName('M39').setText("✔");
    }
    if (hojaMuro.df_encEsqMurController.text == "No") {
      sheet.getRangeByName('O39').setText("✔");
    }

    sheet.getRangeByName('Q39:R39').merge();
    sheet.getRangeByName('Q39').setText(hojaMuro.df_supencEsqMurController.text);


    //-- Encuentro cielo muro
    sheet.getRangeByName('C40:F40').merge();
    sheet.getRangeByName('C40').setText("Encuentro cielo muro");
    sheet.getRangeByName('C40').cellStyle.bold = true;

    sheet.getRangeByName('G40:H40').merge(); //Si
    sheet.getRangeByName('I40:J40').merge(); // No

    if (hojaMuro.mh_encCieMurController.text == "Si") {
      sheet.getRangeByName('G40').setText("✔");
    }
    if (hojaMuro.mh_encCieMurController.text == "No") {
      sheet.getRangeByName('I40').setText("✔");
    }

    sheet.getRangeByName('K40:L40').merge();
    sheet.getRangeByName('K40').setText(hojaMuro.mh_supencCieMurController.text);

    sheet.getRangeByName('M40:N40').merge(); //Si
    sheet.getRangeByName('O40:P40').merge(); // No

    if (hojaMuro.df_encCieMurController.text == "Si") {
      sheet.getRangeByName('M40').setText("✔");
    }
    if (hojaMuro.df_encCieMurController.text == "No") {
      sheet.getRangeByName('O40').setText("✔");
    }

    sheet.getRangeByName('Q40:R40').merge();
    sheet.getRangeByName('Q40').setText(hojaMuro.df_supencCieMurController.text);


    //-- Encuentro piso muro
    sheet.getRangeByName('C41:F41').merge();
    sheet.getRangeByName('C41').setText("Encuentro piso muro");
    sheet.getRangeByName('C41').cellStyle.bold = true;

    sheet.getRangeByName('G41:H41').merge(); //Si
    sheet.getRangeByName('I41:J41').merge(); // No

    if (hojaMuro.mh_encPisMurController.text == "Si") {
      sheet.getRangeByName('G41').setText("✔");
    }
    if (hojaMuro.mh_encPisMurController.text == "No") {
      sheet.getRangeByName('I41').setText("✔");
    }

    sheet.getRangeByName('K41:L41').merge();
    sheet.getRangeByName('K41').setText(hojaMuro.mh_supencPisMurController.text);

    sheet.getRangeByName('M41:N41').merge(); //Si
    sheet.getRangeByName('O41:P41').merge(); // No

    if (hojaMuro.df_encPisMurController.text == "Si") {
      sheet.getRangeByName('M41').setText("✔");
    }
    if (hojaMuro.df_encPisMurController.text == "No") {
      sheet.getRangeByName('O41').setText("✔");
    }

    sheet.getRangeByName('Q41:R41').merge();
    sheet.getRangeByName('Q41').setText(hojaMuro.df_supencPisMurController.text);


    //-- Rasgo de ventana
    sheet.getRangeByName('C42:F42').merge();
    sheet.getRangeByName('C42').setText("Rasgo de ventana");
    sheet.getRangeByName('C42').cellStyle.bold = true;

    sheet.getRangeByName('G42:H42').merge(); //Si
    sheet.getRangeByName('I42:J42').merge(); // No

    if (hojaMuro.mh_rasgventController.text == "Si") {
      sheet.getRangeByName('G42').setText("✔");
    }
    if (hojaMuro.mh_rasgventController.text == "No") {
      sheet.getRangeByName('I42').setText("✔");
    }

    sheet.getRangeByName('K42:L42').merge();
    sheet.getRangeByName('K42').setText(hojaMuro.mh_suprasgventController.text);

    sheet.getRangeByName('M42:N42').merge(); //Si
    sheet.getRangeByName('O42:P42').merge(); // No

    if (hojaMuro.df_rasgventController.text == "Si") {
      sheet.getRangeByName('M42').setText("✔");
    }
    if (hojaMuro.df_rasgventController.text == "No") {
      sheet.getRangeByName('O42').setText("✔");
    }

    sheet.getRangeByName('Q42:R42').merge();
    sheet.getRangeByName('Q42').setText(hojaMuro.df_suprasgventController.text);


    //-- Bajo ventana (antepecho)
    sheet.getRangeByName('C43:F43').merge();
    sheet.getRangeByName('C43').setText("Bajo ventana (antepecho)");
    sheet.getRangeByName('C43').cellStyle.bold = true;

    sheet.getRangeByName('G43:H43').merge(); //Si
    sheet.getRangeByName('I43:J43').merge(); // No

    if (hojaMuro.mh_bajovenController.text == "Si") {
      sheet.getRangeByName('G43').setText("✔");
    }
    if (hojaMuro.mh_bajovenController.text == "No") {
      sheet.getRangeByName('I43').setText("✔");
    }

    sheet.getRangeByName('K43:L43').merge();
    sheet.getRangeByName('K43').setText(hojaMuro.mh_supbajovenController.text);

    sheet.getRangeByName('M43:N43').merge(); //Si
    sheet.getRangeByName('O43:P43').merge(); // No

    if (hojaMuro.df_bajovenController.text == "Si") {
      sheet.getRangeByName('M43').setText("✔");
    }
    if (hojaMuro.df_bajovenController.text == "No") {
      sheet.getRangeByName('O43').setText("✔");
    }

    sheet.getRangeByName('Q43:R43').merge();
    sheet.getRangeByName('Q43').setText(hojaMuro.df_supbajovenController.text);


    //-- Área central
    sheet.getRangeByName('C44:F44').merge();
    sheet.getRangeByName('C44').setText("Área central");
    sheet.getRangeByName('C44').cellStyle.bold = true;

    sheet.getRangeByName('G44:H44').merge(); //Si
    sheet.getRangeByName('I44:J44').merge(); // No

    if (hojaMuro.mh_aCentralController.text == "Si") {
      sheet.getRangeByName('G44').setText("✔");
    }
    if (hojaMuro.mh_aCentralController.text == "No") {
      sheet.getRangeByName('I44').setText("✔");
    }

    sheet.getRangeByName('K44:L44').merge();
    sheet.getRangeByName('K44').setText(hojaMuro.mh_supaCentralController.text);

    sheet.getRangeByName('M44:N44').merge(); //Si
    sheet.getRangeByName('O44:P44').merge(); // No

    if (hojaMuro.df_aCentralController.text == "Si") {
      sheet.getRangeByName('M44').setText("✔");
    }
    if (hojaMuro.df_aCentralController.text == "No") {
      sheet.getRangeByName('O44').setText("✔");
    }

    sheet.getRangeByName('Q44:R44').merge();
    sheet.getRangeByName('Q44').setText(hojaMuro.df_supaCentralController.text);


    //-- Puntual localizada y/o extendida
    sheet.getRangeByName('C45:F45').merge();
    sheet.getRangeByName('C45').setText("Puntual localizada y/o extendida");
    sheet.getRangeByName('C45').cellStyle.bold = true;

    sheet.getRangeByName('G45:H45').merge(); //Si
    sheet.getRangeByName('I45:J45').merge(); // No

    if (hojaMuro.mh_punLocController.text == "Si") {
      sheet.getRangeByName('G45').setText("✔");
    }
    if (hojaMuro.mh_punLocController.text == "No") {
      sheet.getRangeByName('I45').setText("✔");
    }

    sheet.getRangeByName('K45:L45').merge();
    sheet.getRangeByName('K45').setText(hojaMuro.mh_suppunLocController.text);

    sheet.getRangeByName('M45:N45').merge(); //Si
    sheet.getRangeByName('O45:P45').merge(); // No

    if (hojaMuro.df_punLocController.text == "Si") {
      sheet.getRangeByName('M45').setText("✔");
    }
    if (hojaMuro.df_punLocController.text == "No") {
      sheet.getRangeByName('O45').setText("✔");
    }

    sheet.getRangeByName('Q45:R45').merge();
    sheet.getRangeByName('Q45').setText(hojaMuro.df_suppunLocController.text);


    //-- Total superficie afectada
    sheet.getRangeByName('C46:F46').merge();
    sheet.getRangeByName('C46').setText("Total superficie de muro afectada");
    sheet.getRangeByName('C46').cellStyle.bold = true;

    sheet.getRangeByName('G46:R46').merge();
    sheet.getRangeByName('G46').setText(hojaMuro.totpalsupafecController.text);

    sheet.getRangeByName('C48:R65').cellStyle
      ..borders.all.lineStyle = xlsio.LineStyle.thin
      ..borders.all.color = '#000000';

    sheet.getRangeByName('C48:R65').merge();

    // -------------------------------------------------------------------------
    // IMAGEN
    // -------------------------------------------------------------------------

    if (hojaMuro.imgpatol != null && hojaMuro.imgpatolGuardada!.existsSync()) {
      try {
        final Uint8List imageBytes = await hojaMuro.imgpatolGuardada!.readAsBytes();
        final xlsio.Picture picture = sheet.pictures.addBase64(
          8, // fila
          9, // columna
          base64Encode(imageBytes),
        );
        picture.height = 260;
        picture.width = 450;
      } catch (e) {
        debugPrint("⚠️ Error al insertar imagen en hoja $nombreHoja: $e");
      }
    }

    if (hojaMuro.imgelev != null && hojaMuro.imgelevGuardada!.existsSync()) {
      try {
        final Uint8List imageBytes = await hojaMuro.imgelevGuardada!.readAsBytes();
        final xlsio.Picture picture = sheet.pictures.addBase64(
          48, // fila
          9, // columna
          base64Encode(imageBytes),
        );
        picture.height = 360;
        picture.width = 450;
      } catch (e) {
        debugPrint("⚠️ Error al insertar imagen en hoja $nombreHoja: $e");
      }
    }

    sheet.showGridlines = false;
    sheet.getRangeByName('A1:S24').rowHeight = 15;
    sheet.getRangeByName('A25:S25').rowHeight = 30;
    sheet.getRangeByName('A26:S56').rowHeight = 15;
    sheet.getRangeByName('A1:S56').columnWidth = 15;
    sheet.getRangeByName('A1:S56').cellStyle
      ..fontSize = 12
      ..hAlign = xlsio.HAlignType.center
      ..vAlign = xlsio.VAlignType.center
      ..wrapText = true;
  }

  //----------------------------------------------------------------------------------------------------------------------
  // Agregar las hojas de los muros restantes de la habitacion (todos los demas muros de la habitacion menos el principal)
  //----------------------------------------------------------------------------------------------------------------------

  Future<void> crearHojaMuroExcel({
    required xlsio.Workbook workbook,
    required HojaMuro hojaMuro,
    required String nombreHoja,
    required String muroEje,

  }) async {
    final sheet = workbook.worksheets.addWithName(nombreHoja);

    // -------------------------------------------------------------------------
    // ENCABEZADO
    // -------------------------------------------------------------------------

    sheet.getRangeByName('B2:R5').cellStyle
      ..borders.all.lineStyle = xlsio.LineStyle.thin
      ..borders.all.color = '#000000';

    sheet.getRangeByName('B2:E5').merge();
    final ByteData imageData =
    await rootBundle.load('assets/logo_citec.jpg');

    final Uint8List imageBytes = imageData.buffer.asUint8List();

    //--> Bordes Celdas Encabezado
    sheet.getRangeByName('B2:E5').cellStyle
      ..borders.all.lineStyle = xlsio.LineStyle.thin
      ..borders.all.color = '#000000';

    sheet.getRangeByName('B2:E5').merge();
    // Insertar imagen en la hoja
    final xlsio.Picture picture = sheet.pictures.addStream(
      2, // fila inicial (1-based)
      2, // columna inicial (B = 2)
      imageBytes,
    );

    // Opcional: ajustar tamaño
    picture.height = 80;
    picture.width = 150;

    // Opcional: que quede dentro del rango B3:E5
    picture.lastRow = 6;
    picture.lastColumn = 6;

    sheet.getRangeByName('F2:N5').merge();
    sheet.getRangeByName('F2').setText(
        "PROTOCOLO\nINSPECCIÓN VISUAL DE VIVIENDAS - ACONDICIONAMIENTO AMBIENTAL");
    sheet.getRangeByName('F2').cellStyle.bold = true;

    sheet.getRangeByName('O2:P5').merge();
    sheet.getRangeByName('O2').setText("Unidad");
    sheet.getRangeByName('O2').cellStyle.bold = true;

    sheet.getRangeByName('Q2:R5').merge();
    sheet.getRangeByName('Q2').setText("CITEC UBB");
    sheet.getRangeByName('Q2').cellStyle.bold = true;

    // -------------------------------------------------------------------------
    // DATOS MUROS NORMALES
    // -------------------------------------------------------------------------

    sheet.getRangeByName('B7:R23').cellStyle
      ..borders.all.lineStyle = xlsio.LineStyle.thin
      ..borders.all.color = '#000000';

    sheet.getRangeByName('B7').setText("Item");
    sheet.getRangeByName('B7').cellStyle
      ..bold = true
      ..backColor = '#FFC000';

    sheet.getRangeByName('B8:B55').merge();
    sheet.getRangeByName('B8').setText("5");
    sheet.getRangeByName('B8').cellStyle
      ..bold = true
      ..backColor = '#FFC000';

    sheet.getRangeByName('C7:R7').merge();
    sheet.getRangeByName('C7').setText(
        "Levantamiento de Patologías higrotérmicas");
    sheet.getRangeByName('C7').cellStyle
      ..bold = true
      ..backColor = '#BFBFBF';

    sheet.getRangeByName('C7:R7').merge();
    sheet.getRangeByName('C8:R20').merge();

    sheet.getRangeByName('C21:E21').merge();
    sheet.getRangeByName('C21').setText("MURO EJE");
    sheet.getRangeByName('C21').cellStyle
      ..bold = true
      ..backColor = '#FFE699';

    sheet.getRangeByName('F21').setText(muroEje);
    sheet.getRangeByName('F21').cellStyle.backColor = '#FFE699';

    sheet.getRangeByName('G21:I21').merge();
    sheet.getRangeByName('G21').setText("Superficie muro");
    sheet.getRangeByName('G21').cellStyle.bold = true;

    sheet.getRangeByName('J21:L21').merge();
    sheet.getRangeByName('J21').setText(hojaMuro.supmuroController.text);

    sheet.getRangeByName('M21:O21').merge();
    sheet.getRangeByName('M21').setText("Superficie ventana");
    sheet.getRangeByName('M21').cellStyle.bold = true;

    sheet.getRangeByName('P21:R21').merge();
    sheet.getRangeByName('P21').setText(hojaMuro.supventanaController.text);

    sheet.getRangeByName('C22:E22').merge();
    sheet.getRangeByName('C22').setText("Muro perimetral");
    sheet.getRangeByName('C22').cellStyle.bold = true;

    sheet.getRangeByName('C23:E23').merge();
    sheet.getRangeByName('C23').setText("Muro interior");
    sheet.getRangeByName('C23').cellStyle.bold = true;

    if (hojaMuro.tipoMuroController.text == "Muro perimetral") {
      sheet.getRangeByName('F22').setText("✔");
    }
    if (hojaMuro.tipoMuroController.text == "Muro interior") {
      sheet.getRangeByName('F23').setText("✔");
    }

    sheet.getRangeByName('G22:I23').merge();
    sheet.getRangeByName('G22').setText("Nivel de afectación");
    sheet.getRangeByName('G22').cellStyle.bold = true;

    sheet.getRangeByName('J22:K22').merge();
    sheet.getRangeByName('J22').setText("Nulo");
    sheet.getRangeByName('J22').cellStyle.bold = true;

    sheet.getRangeByName('J23:K23').merge();;

    sheet.getRangeByName('L22:M22').merge();
    sheet.getRangeByName('L22').setText("Bajo");
    sheet.getRangeByName('L22').cellStyle.bold = true;

    sheet.getRangeByName('L23:M23').merge();

    sheet.getRangeByName('N22:O22').merge();
    sheet.getRangeByName('N22').setText("Medio");
    sheet.getRangeByName('N22').cellStyle.bold = true;

    sheet.getRangeByName('N23:O23').merge();

    sheet.getRangeByName('P22:R22').merge();
    sheet.getRangeByName('P22').setText("Alto");
    sheet.getRangeByName('P22').cellStyle.bold = true;

    sheet.getRangeByName('P23:R23').merge();

    switch (hojaMuro.nivelafecController.text) {
      case "Nulo":
        sheet.getRangeByName('J23').setText("✔");
        break;
      case "Bajo":
        sheet.getRangeByName('L23').setText("✔");
        break;
      case "Medio":
        sheet.getRangeByName('N23').setText("✔");
        break;
      case "Alto":
        sheet.getRangeByName('P23').setText("✔");
        break;
    }

    sheet.getRangeByName('C25:R35').cellStyle
      ..borders.all.lineStyle = xlsio.LineStyle.thin
      ..borders.all.color = '#000000';

    sheet.getRangeByName('C25:F27').merge();
    sheet.getRangeByName('C25').setText("Ubicación de patología");
    sheet.getRangeByName('C25').cellStyle.bold = true;

    sheet.getRangeByName('G25:R25').merge();
    sheet.getRangeByName('G25').setText("Patología detectada");
    sheet.getRangeByName('G25').cellStyle.bold = true;

    sheet.getRangeByName('G26:L26').merge();
    sheet.getRangeByName('G26').setText("Manchas de humedad / moho");
    sheet.getRangeByName('G26').cellStyle.bold = true;

    sheet.getRangeByName('M26:R26').merge();
    sheet.getRangeByName('M26').setText("Daño físico mecánico");
    sheet.getRangeByName('M26').cellStyle.bold = true;

    sheet.getRangeByName('G27:H27').merge();
    sheet.getRangeByName('G27').setText("SI");
    sheet.getRangeByName('G27').cellStyle.bold = true;

    sheet.getRangeByName('I27:J27').merge();
    sheet.getRangeByName('I27').setText("No");
    sheet.getRangeByName('I27').cellStyle.bold = true;

    sheet.getRangeByName('K27:L27').merge();
    sheet.getRangeByName('K27').setText("Superficie afectada");
    sheet.getRangeByName('K27').cellStyle.bold = true;

    sheet.getRangeByName('M27:N27').merge();
    sheet.getRangeByName('M27').setText("SI");
    sheet.getRangeByName('M27').cellStyle.bold = true;

    sheet.getRangeByName('O27:P27').merge();
    sheet.getRangeByName('O27').setText("No");
    sheet.getRangeByName('O27').cellStyle.bold = true;

    sheet.getRangeByName('Q27:R27').merge();
    sheet.getRangeByName('Q27').setText("Superficie afectada");
    sheet.getRangeByName('Q27').cellStyle.bold = true;


    //-- Encuentro esquina muro
    sheet.getRangeByName('C28:F28').merge();
    sheet.getRangeByName('C28').setText("Encuentro esquina muro");
    sheet.getRangeByName('C28').cellStyle.bold = true;

    sheet.getRangeByName('G28:H28').merge(); //Si
    sheet.getRangeByName('I28:J28').merge(); // No

    if (hojaMuro.mh_encEsqMurController.text == "Si") {
      sheet.getRangeByName('G28').setText("✔");
    }
    if (hojaMuro.mh_encEsqMurController.text == "No") {
      sheet.getRangeByName('I28').setText("✔");
    }

    sheet.getRangeByName('K28:L28').merge();
    sheet.getRangeByName('K28').setText(hojaMuro.mh_supencEsqMurController.text);

    sheet.getRangeByName('M28:N28').merge(); //Si
    sheet.getRangeByName('O28:P28').merge(); // No

    if (hojaMuro.df_encEsqMurController.text == "Si") {
      sheet.getRangeByName('M28').setText("✔");
    }
    if (hojaMuro.df_encEsqMurController.text == "No") {
      sheet.getRangeByName('O28').setText("✔");
    }

    sheet.getRangeByName('Q28:R28').merge();
    sheet.getRangeByName('Q28').setText(hojaMuro.df_supencEsqMurController.text);


    //-- Encuentro cielo muro
    sheet.getRangeByName('C29:F29').merge();
    sheet.getRangeByName('C29').setText("Encuentro cielo muro");
    sheet.getRangeByName('C29').cellStyle.bold = true;

    sheet.getRangeByName('G29:H29').merge(); //Si
    sheet.getRangeByName('I29:J29').merge(); // No

    if (hojaMuro.mh_encCieMurController.text == "Si") {
      sheet.getRangeByName('G29').setText("✔");
    }
    if (hojaMuro.mh_encCieMurController.text == "No") {
      sheet.getRangeByName('I29').setText("✔");
    }

    sheet.getRangeByName('K29:L29').merge();
    sheet.getRangeByName('K29').setText(hojaMuro.mh_supencCieMurController.text);

    sheet.getRangeByName('M29:N29').merge(); //Si
    sheet.getRangeByName('O29:P29').merge(); // No

    if (hojaMuro.df_encCieMurController.text == "Si") {
      sheet.getRangeByName('M29').setText("✔");
    }
    if (hojaMuro.df_encCieMurController.text == "No") {
      sheet.getRangeByName('O29').setText("✔");
    }

    sheet.getRangeByName('Q29:R29').merge();
    sheet.getRangeByName('Q29').setText(hojaMuro.df_supencCieMurController.text);


    //-- Encuentro piso muro
    sheet.getRangeByName('C30:F30').merge();
    sheet.getRangeByName('C30').setText("Encuentro piso muro");
    sheet.getRangeByName('C30').cellStyle.bold = true;

    sheet.getRangeByName('G30:H01').merge(); //Si
    sheet.getRangeByName('I30:J30').merge(); // No

    if (hojaMuro.mh_encPisMurController.text == "Si") {
      sheet.getRangeByName('G30').setText("✔");
    }
    if (hojaMuro.mh_encPisMurController.text == "No") {
      sheet.getRangeByName('I30').setText("✔");
    }

    sheet.getRangeByName('K30:L30').merge();
    sheet.getRangeByName('K30').setText(hojaMuro.mh_supencPisMurController.text);

    sheet.getRangeByName('M30:N30').merge(); //Si
    sheet.getRangeByName('O30:P30').merge(); // No

    if (hojaMuro.df_encPisMurController.text == "Si") {
      sheet.getRangeByName('M30').setText("✔");
    }
    if (hojaMuro.df_encPisMurController.text == "No") {
      sheet.getRangeByName('O30').setText("✔");
    }

    sheet.getRangeByName('Q30:R30').merge();
    sheet.getRangeByName('Q30').setText(hojaMuro.df_supencPisMurController.text);


    //-- Rasgo de ventana
    sheet.getRangeByName('C31:F31').merge();
    sheet.getRangeByName('C31').setText("Rasgo de ventana");
    sheet.getRangeByName('C31').cellStyle.bold = true;

    sheet.getRangeByName('G31:H31').merge(); //Si
    sheet.getRangeByName('I31:J31').merge(); // No

    if (hojaMuro.mh_rasgventController.text == "Si") {
      sheet.getRangeByName('G31').setText("✔");
    }
    if (hojaMuro.mh_rasgventController.text == "No") {
      sheet.getRangeByName('I31').setText("✔");
    }

    sheet.getRangeByName('K31:L31').merge();
    sheet.getRangeByName('K31').setText(hojaMuro.mh_suprasgventController.text);

    sheet.getRangeByName('M31:N31').merge(); //Si
    sheet.getRangeByName('O31:P31').merge(); // No

    if (hojaMuro.df_rasgventController.text == "Si") {
      sheet.getRangeByName('M31').setText("✔");
    }
    if (hojaMuro.df_rasgventController.text == "No") {
      sheet.getRangeByName('O31').setText("✔");
    }

    sheet.getRangeByName('Q31:R31').merge();
    sheet.getRangeByName('Q31').setText(hojaMuro.df_suprasgventController.text);


    //-- Bajo ventana (antepecho)
    sheet.getRangeByName('C32:F32').merge();
    sheet.getRangeByName('C32').setText("Bajo ventana (antepecho)");
    sheet.getRangeByName('C32').cellStyle.bold = true;

    sheet.getRangeByName('G32:H32').merge(); //Si
    sheet.getRangeByName('I32:J32').merge(); // No

    if (hojaMuro.mh_bajovenController.text == "Si") {
      sheet.getRangeByName('G32').setText("✔");
    }
    if (hojaMuro.mh_bajovenController.text == "No") {
      sheet.getRangeByName('I32').setText("✔");
    }

    sheet.getRangeByName('K32:L32').merge();
    sheet.getRangeByName('K32').setText(hojaMuro.mh_supbajovenController.text);

    sheet.getRangeByName('M32:N32').merge(); //Si
    sheet.getRangeByName('O32:P32').merge(); // No

    if (hojaMuro.df_bajovenController.text == "Si") {
      sheet.getRangeByName('M32').setText("✔");
    }
    if (hojaMuro.df_bajovenController.text == "No") {
      sheet.getRangeByName('O32').setText("✔");
    }

    sheet.getRangeByName('Q32:R32').merge();
    sheet.getRangeByName('Q32').setText(hojaMuro.df_supbajovenController.text);

    //-- Área central
    sheet.getRangeByName('C33:F33').merge();
    sheet.getRangeByName('C33').setText("Área central");
    sheet.getRangeByName('C33').cellStyle.bold = true;

    sheet.getRangeByName('G33:H33').merge(); //Si
    sheet.getRangeByName('I33:J33').merge(); // No

    if (hojaMuro.mh_aCentralController.text == "Si") {
      sheet.getRangeByName('G33').setText("✔");
    }
    if (hojaMuro.mh_aCentralController.text == "No") {
      sheet.getRangeByName('I33').setText("✔");
    }

    sheet.getRangeByName('K33:L33').merge();
    sheet.getRangeByName('K33').setText(hojaMuro.mh_supaCentralController.text);

    sheet.getRangeByName('M33:N33').merge(); //Si
    sheet.getRangeByName('O33:P33').merge(); // No

    if (hojaMuro.df_aCentralController.text == "Si") {
      sheet.getRangeByName('M33').setText("✔");
    }
    if (hojaMuro.df_aCentralController.text == "No") {
      sheet.getRangeByName('O33').setText("✔");
    }

    sheet.getRangeByName('Q33:R33').merge();
    sheet.getRangeByName('Q33').setText(hojaMuro.df_supaCentralController.text);



    //-- Puntual localizada y/o extendida
    sheet.getRangeByName('C34:F34').merge();
    sheet.getRangeByName('C34').setText("Puntual localizada y/o extendida");
    sheet.getRangeByName('C34').cellStyle.bold = true;

    sheet.getRangeByName('G34:H34').merge(); //Si
    sheet.getRangeByName('I34:J34').merge(); // No

    if (hojaMuro.mh_punLocController.text == "Si") {
      sheet.getRangeByName('G34').setText("✔");
    }
    if (hojaMuro.mh_punLocController.text == "No") {
      sheet.getRangeByName('I34').setText("✔");
    }

    sheet.getRangeByName('K34:L34').merge();
    sheet.getRangeByName('K34').setText(hojaMuro.mh_suppunLocController.text);

    sheet.getRangeByName('M34:N34').merge(); //Si
    sheet.getRangeByName('O34:P34').merge(); // No

    if (hojaMuro.df_punLocController.text == "Si") {
      sheet.getRangeByName('M34').setText("✔");
    }
    if (hojaMuro.df_punLocController.text == "No") {
      sheet.getRangeByName('O34').setText("✔");
    }

    sheet.getRangeByName('Q34:R34').merge();
    sheet.getRangeByName('Q34').setText(hojaMuro.df_suppunLocController.text);

    //-- Total superficie afectada
    sheet.getRangeByName('C35:F35').merge();
    sheet.getRangeByName('C35').setText("Total superficie de muro afectada");
    sheet.getRangeByName('C35').cellStyle.bold = true;

    sheet.getRangeByName('G35:R35').merge();
    sheet.getRangeByName('G35').setText(hojaMuro.totpalsupafecController.text);


    sheet.getRangeByName('C37:R55').cellStyle
      ..borders.all.lineStyle = xlsio.LineStyle.thin
      ..borders.all.color = '#000000';

    sheet.getRangeByName('C37:R55').merge();



    // -------------------------------------------------------------------------
    // IMAGEN
    // -------------------------------------------------------------------------

    if (hojaMuro.imgpatol != null && hojaMuro.imgpatolGuardada!.existsSync()) {
      try {
        final Uint8List imageBytes = await hojaMuro.imgpatolGuardada!.readAsBytes();
        final xlsio.Picture picture = sheet.pictures.addBase64(
          8, // fila
          8, // columna
          base64Encode(imageBytes),
        );
        picture.height = 260;
        picture.width = 450;
      } catch (e) {
        debugPrint("⚠️ Error al insertar imagen en hoja $nombreHoja: $e");
      }
    }

    if (hojaMuro.imgelev != null && hojaMuro.imgelevGuardada!.existsSync()) {
      try {
        final Uint8List imageBytes = await hojaMuro.imgelevGuardada!.readAsBytes();
        final xlsio.Picture picture = sheet.pictures.addBase64(
          37, // fila
          8, // columna
          base64Encode(imageBytes),
        );
        picture.height = 380;
        picture.width = 450;
      } catch (e) {
        debugPrint("⚠️ Error al insertar imagen en hoja $nombreHoja: $e");
      }
    }

    sheet.showGridlines = false;
    sheet.getRangeByName('A1:S55').rowHeight = 15;
    sheet.getRangeByName('A1:S55').columnWidth = 15;
    sheet.getRangeByName('A1:S55').cellStyle
      ..hAlign = xlsio.HAlignType.center
      ..vAlign = xlsio.VAlignType.center
      ..wrapText = true
      ..fontSize = 12;
  }

  Future<void> crearHojaPisoCieloExcel({
    required xlsio.Workbook workbook,
    required HojaPisoCielo hojaPisoCielo,
    required String nombreHoja,
  }) async {
    final sheet = workbook.worksheets.addWithName(nombreHoja);

    // -------------------------------------------------------------------------
    // ENCABEZADO
    // -------------------------------------------------------------------------

    sheet.getRangeByName('B2:R5').cellStyle
      ..borders.all.lineStyle = xlsio.LineStyle.thin
      ..borders.all.color = '#000000';

    sheet.getRangeByName('B2:E5').merge();
    final ByteData imageData =
    await rootBundle.load('assets/logo_citec.jpg');

    final Uint8List imageBytes = imageData.buffer.asUint8List();

    //--> Bordes Celdas Encabezado
    sheet.getRangeByName('B2:E5').cellStyle
      ..borders.all.lineStyle = xlsio.LineStyle.thin
      ..borders.all.color = '#000000';

    sheet.getRangeByName('B2:E5').merge();
    // Insertar imagen en la hoja
    final xlsio.Picture picture = sheet.pictures.addStream(
      2, // fila inicial (1-based)
      2, // columna inicial (B = 2)
      imageBytes,
    );


    // Opcional: que quede dentro del rango B3:E5
    picture.lastRow = 6;
    picture.lastColumn = 6;

    sheet.getRangeByName('F2:N5').merge();
    sheet.getRangeByName('F2').setText(
        "PROTOCOLO\nINSPECCIÓN VISUAL DE VIVIENDAS - ACONDICIONAMIENTO AMBIENTAL");
    sheet.getRangeByName('F2').cellStyle.bold = true;

    sheet.getRangeByName('O2:P5').merge();
    sheet.getRangeByName('O2').setText("Unidad");
    sheet.getRangeByName('O2').cellStyle.bold = true;

    sheet.getRangeByName('Q2:R5').merge();
    sheet.getRangeByName('Q2').setText("CITEC UBB");
    sheet.getRangeByName('Q2').cellStyle.bold = true;

    // -------------------------------------------------------------------------
    // DATOS PISO Y CIELO
    // -------------------------------------------------------------------------

    sheet.getRangeByName('B7:R49').cellStyle
      ..borders.all.lineStyle = xlsio.LineStyle.thin
      ..borders.all.color = '#000000';

    sheet.getRangeByName('B7').setText("Item");
    sheet.getRangeByName('B7').cellStyle
      ..bold = true
      ..backColor = '#FFC000';

    sheet.getRangeByName('B8:B79').merge();
    sheet.getRangeByName('B8').setText("5");
    sheet.getRangeByName('B8').cellStyle
      ..bold = true
      ..backColor = '#FFC000';

    sheet.getRangeByName('C7:R7').merge();
    sheet.getRangeByName('C7').setText(
        "Levantamiento de Patologías higrotérmicas");
    sheet.getRangeByName('C7').cellStyle
      ..bold = true
      ..backColor = '#BFBFBF';

    sheet.getRangeByName('C8:R20').merge();

    sheet.getRangeByName('C21:F21').merge();
    sheet.getRangeByName('C21').setText("PISO");
    sheet.getRangeByName('C21').cellStyle
      ..bold = true
      ..backColor = '#FFE699';

    sheet.getRangeByName('G21:I21').merge();
    sheet.getRangeByName('G21').setText("Superficie piso");
    sheet.getRangeByName('G21').cellStyle.bold = true;

    sheet.getRangeByName('J21:R21').merge();
    sheet.getRangeByName('J21').setText(hojaPisoCielo.supPisoController.text);

    sheet.getRangeByName('C22:I23').merge();
    sheet.getRangeByName('C22').setText("Nivel de afectación");
    sheet.getRangeByName('C22').cellStyle.bold = true;

    sheet.getRangeByName('J22:K22').merge();
    sheet.getRangeByName('J22').setText("Nulo");
    sheet.getRangeByName('J22').cellStyle.bold = true;

    sheet.getRangeByName('J23:K23').merge();;

    sheet.getRangeByName('L22:M22').merge();
    sheet.getRangeByName('L22').setText("Bajo");
    sheet.getRangeByName('L22').cellStyle.bold = true;

    sheet.getRangeByName('L23:M23').merge();

    sheet.getRangeByName('N22:O22').merge();
    sheet.getRangeByName('N22').setText("Medio");
    sheet.getRangeByName('N22').cellStyle.bold = true;

    sheet.getRangeByName('N23:O23').merge();

    sheet.getRangeByName('P22:R22').merge();
    sheet.getRangeByName('P22').setText("Alto");
    sheet.getRangeByName('P22').cellStyle.bold = true;

    sheet.getRangeByName('P23:R23').merge();

    switch (hojaPisoCielo.nivelafecPisoController.text) {
      case "Nulo":
        sheet.getRangeByName('J23:K23').setText("✔");
        break;
      case "Bajo":
        sheet.getRangeByName('L23:M23').setText("✔");
        break;
      case "Medio":
        sheet.getRangeByName('N23:O23').setText("✔");
        break;
      case "Alto":
        sheet.getRangeByName('P23:R23').setText("✔");
        break;
    }

    sheet.getRangeByName('C24:R24').merge();

    sheet.getRangeByName('C25:F27').merge();
    sheet.getRangeByName('C25').setText("Ubicación de patología");
    sheet.getRangeByName('C25').cellStyle.bold = true;

    sheet.getRangeByName('G25:R25').merge();
    sheet.getRangeByName('G25').setText("Patología detectada");
    sheet.getRangeByName('G25').cellStyle.bold = true;

    sheet.getRangeByName('G26:L26').merge();
    sheet.getRangeByName('G26').setText("Manchas de humedad / moho");
    sheet.getRangeByName('G26').cellStyle.bold = true;

    sheet.getRangeByName('M26:R26').merge();
    sheet.getRangeByName('M26').setText("Daño físico mecánico");
    sheet.getRangeByName('M26').cellStyle.bold = true;

    sheet.getRangeByName('G27:H27').merge();
    sheet.getRangeByName('G27').setText("SI");
    sheet.getRangeByName('G27').cellStyle.bold = true;

    sheet.getRangeByName('I27:J27').merge();
    sheet.getRangeByName('I27').setText("NO");
    sheet.getRangeByName('I27').cellStyle.bold = true;

    sheet.getRangeByName('K27:L27').merge();
    sheet.getRangeByName('K27').setText("Superficie afectada");
    sheet.getRangeByName('K27').cellStyle.bold = true;

    sheet.getRangeByName('M27:N27').merge();
    sheet.getRangeByName('M27').setText("SI");
    sheet.getRangeByName('M27').cellStyle.bold = true;

    sheet.getRangeByName('O27:P27').merge();
    sheet.getRangeByName('O27').setText("NO");
    sheet.getRangeByName('O27').cellStyle.bold = true;

    sheet.getRangeByName('Q27:R27').merge();
    sheet.getRangeByName('Q27').setText("Superficie afectada");
    sheet.getRangeByName('Q27').cellStyle.bold = true;


    //-- Perimetro
    sheet.getRangeByName('C28:F28').merge();
    sheet.getRangeByName('C28').setText("Perímetro");
    sheet.getRangeByName('C28').cellStyle.bold = true;

    sheet.getRangeByName('G28:H28').merge(); //Si
    sheet.getRangeByName('I28:J28').merge(); // No

    if (hojaPisoCielo.mh_perimetroPisoController.text == "Si") {
      sheet.getRangeByName('G28').setText("✔");
    }
    if (hojaPisoCielo.mh_perimetroPisoController.text == "No") {
      sheet.getRangeByName('I28').setText("✔");
    }

    sheet.getRangeByName('K28:L28').merge();
    sheet.getRangeByName('K28').setText(hojaPisoCielo.mh_supperimetroPisoController.text);

    sheet.getRangeByName('M28:N28').merge(); //Si
    sheet.getRangeByName('O28:P28').merge(); // No

    if (hojaPisoCielo.df_perimetroPisoController.text == "Si") {
      sheet.getRangeByName('M28').setText("✔");
    }
    if (hojaPisoCielo.df_perimetroPisoController.text == "No") {
      sheet.getRangeByName('O28').setText("✔");
    }

    sheet.getRangeByName('Q28:R28').merge();
    sheet.getRangeByName('Q28').setText(hojaPisoCielo.df_supperimetroPisoController.text);


    //-- Area Central
    sheet.getRangeByName('C29:F29').merge();
    sheet.getRangeByName('C29').setText("Área central");
    sheet.getRangeByName('C29').cellStyle.bold = true;

    sheet.getRangeByName('G29:H29').merge(); //Si
    sheet.getRangeByName('I29:J29').merge(); // No

    if (hojaPisoCielo.mh_aCentralPisoController.text == "Si") {
      sheet.getRangeByName('G29').setText("✔");
    }
    if (hojaPisoCielo.mh_aCentralPisoController.text == "No") {
      sheet.getRangeByName('I29').setText("✔");
    }

    sheet.getRangeByName('K29:L29').merge();
    sheet.getRangeByName('K29').setText(hojaPisoCielo.mh_supaCentralPisoController.text);

    sheet.getRangeByName('M29:N29').merge(); //Si
    sheet.getRangeByName('O29:P29').merge(); // No

    if (hojaPisoCielo.df_aCentralPisoController.text == "Si") {
      sheet.getRangeByName('M29').setText("✔");
    }
    if (hojaPisoCielo.df_aCentralPisoController.text == "No") {
      sheet.getRangeByName('O29').setText("✔");
    }

    sheet.getRangeByName('Q29:R29').merge();
    sheet.getRangeByName('Q29').setText(hojaPisoCielo.df_supaCentralPisoController.text);


    //-- Puntual localizada y/o extendida
    sheet.getRangeByName('C30:F30').merge();
    sheet.getRangeByName('C30').setText("Puntual localizada y/o extendida");
    sheet.getRangeByName('C30').cellStyle.bold = true;

    sheet.getRangeByName('G30:H01').merge(); //Si
    sheet.getRangeByName('I30:J30').merge(); // No

    if (hojaPisoCielo.mh_punlocPisoController.text == "Si") {
      sheet.getRangeByName('G30').setText("✔");
    }
    if (hojaPisoCielo.mh_punlocPisoController.text == "No") {
      sheet.getRangeByName('I30').setText("✔");
    }

    sheet.getRangeByName('K30:L30').merge();
    sheet.getRangeByName('K30').setText(hojaPisoCielo.mh_supPunlocPisoController.text);

    sheet.getRangeByName('M30:N30').merge(); //Si
    sheet.getRangeByName('O30:P30').merge(); // No

    if (hojaPisoCielo.df_punlocPisoController.text == "Si") {
      sheet.getRangeByName('M30').setText("✔");
    }
    if (hojaPisoCielo.df_punlocPisoController.text == "No") {
      sheet.getRangeByName('O30').setText("✔");
    }

    sheet.getRangeByName('Q30:R30').merge();
    sheet.getRangeByName('Q30').setText(hojaPisoCielo.df_supPunlocPisoController.text);

    sheet.getRangeByName('C31:F31').merge();
    sheet.getRangeByName('C31').setText("Total superficie de piso afectada");
    sheet.getRangeByName('C31').cellStyle.bold = true;

    sheet.getRangeByName('G31:R31').merge();
    sheet.getRangeByName('G31').setText(hojaPisoCielo.totpalsupafecPisoController.text);

    sheet.getRangeByName('C32:R49').merge();
    sheet.getRangeByName('C50:R50').merge();

    sheet.getRangeByName('C51:R79').cellStyle
      ..borders.all.lineStyle = xlsio.LineStyle.thin
      ..borders.all.color = '#000000';


    // -------------------------------------------------------------------------
    // SECCION DE CIELO
    // -------------------------------------------------------------------------

    sheet.getRangeByName('C51:F51').merge();
    sheet.getRangeByName('C51').setText("CIELO");
    sheet.getRangeByName('C51').cellStyle
      ..bold = true
      ..backColor = '#FFE699';

    sheet.getRangeByName('G51:I51').merge();
    sheet.getRangeByName('G51').setText("Superficie cielo");
    sheet.getRangeByName('G51').cellStyle.bold = true;

    sheet.getRangeByName('J51:R51').merge();
    sheet.getRangeByName('J51').setText(hojaPisoCielo.supCieloController.text);

    sheet.getRangeByName('C52:I53').merge();
    sheet.getRangeByName('C52').setText("Nivel de afectación");
    sheet.getRangeByName('C52').cellStyle.bold = true;

    sheet.getRangeByName('J52:K52').merge();
    sheet.getRangeByName('J52').setText("Nulo");
    sheet.getRangeByName('J52').cellStyle.bold = true;

    sheet.getRangeByName('J53:K53').merge();;

    sheet.getRangeByName('L52:M52').merge();
    sheet.getRangeByName('L52').setText("Bajo");
    sheet.getRangeByName('L52').cellStyle.bold = true;

    sheet.getRangeByName('L53:M53').merge();

    sheet.getRangeByName('N52:O52').merge();
    sheet.getRangeByName('N52').setText("Medio");
    sheet.getRangeByName('N52').cellStyle.bold = true;

    sheet.getRangeByName('N53:O53').merge();

    sheet.getRangeByName('P52:R52').merge();
    sheet.getRangeByName('P52').setText("Alto");
    sheet.getRangeByName('P52').cellStyle.bold = true;

    sheet.getRangeByName('P53:R53').merge();

    switch (hojaPisoCielo.nivelafecCieloController.text) {
      case "Nulo":
        sheet.getRangeByName('J53:K53').setText("✔");
        break;
      case "Bajo":
        sheet.getRangeByName('L53:M53').setText("✔");
        break;
      case "Medio":
        sheet.getRangeByName('N53:O53').setText("✔");
        break;
      case "Alto":
        sheet.getRangeByName('P53:R53').setText("✔");
        break;
    }

    sheet.getRangeByName('C54:R54').merge();

    sheet.getRangeByName('C55:F57').merge();
    sheet.getRangeByName('C55').setText("Ubicación de patología");
    sheet.getRangeByName('C55').cellStyle.bold = true;

    sheet.getRangeByName('G55:R55').merge();
    sheet.getRangeByName('G55').setText("Patología detectada");
    sheet.getRangeByName('G55').cellStyle.bold = true;

    sheet.getRangeByName('G56:L56').merge();
    sheet.getRangeByName('G56').setText("Manchas de humedad / moho");
    sheet.getRangeByName('G56').cellStyle.bold = true;

    sheet.getRangeByName('M56:R56').merge();
    sheet.getRangeByName('M56').setText("Daño físico mecánico");
    sheet.getRangeByName('M56').cellStyle.bold = true;

    sheet.getRangeByName('G57:H57').merge();
    sheet.getRangeByName('G57').setText("SI");
    sheet.getRangeByName('G57').cellStyle.bold = true;

    sheet.getRangeByName('I57:J57').merge();
    sheet.getRangeByName('I57').setText("NO");
    sheet.getRangeByName('I57').cellStyle.bold = true;

    sheet.getRangeByName('K57:L57').merge();
    sheet.getRangeByName('K57').setText("Superficie afectada");
    sheet.getRangeByName('K57').cellStyle.bold = true;

    sheet.getRangeByName('M57:N57').merge();
    sheet.getRangeByName('M57').setText("SI");
    sheet.getRangeByName('M57').cellStyle.bold = true;

    sheet.getRangeByName('O57:P57').merge();
    sheet.getRangeByName('O57').setText("NO");
    sheet.getRangeByName('O57').cellStyle.bold = true;

    sheet.getRangeByName('Q57:R57').merge();
    sheet.getRangeByName('Q57').setText("Superficie afectada");
    sheet.getRangeByName('Q57').cellStyle.bold = true;


    //-- Perimetro
    sheet.getRangeByName('C58:F58').merge();
    sheet.getRangeByName('C58').setText("Perímetro");
    sheet.getRangeByName('C58').cellStyle.bold = true;

    sheet.getRangeByName('G58:H58').merge(); //Si
    sheet.getRangeByName('I58:J58').merge(); // No

    if (hojaPisoCielo.mh_perimetroCieloController.text == "Si") {
      sheet.getRangeByName('G58').setText("✔");
    }
    if (hojaPisoCielo.mh_perimetroCieloController.text == "No") {
      sheet.getRangeByName('I58').setText("✔");
    }

    sheet.getRangeByName('K58:L58').merge();
    sheet.getRangeByName('K58').setText(hojaPisoCielo.mh_supperimetroCieloController.text);

    sheet.getRangeByName('M58:N58').merge(); //Si
    sheet.getRangeByName('O58:P58').merge(); // No

    if (hojaPisoCielo.df_perimetroCieloController.text == "Si") {
      sheet.getRangeByName('M58').setText("✔");
    }
    if (hojaPisoCielo.df_perimetroCieloController.text == "No") {
      sheet.getRangeByName('O58').setText("✔");
    }

    sheet.getRangeByName('Q58:R58').merge();
    sheet.getRangeByName('Q58').setText(hojaPisoCielo.df_supperimetroCieloController.text);


    //-- Area Central
    sheet.getRangeByName('C59:F59').merge();
    sheet.getRangeByName('C59').setText("Área central");
    sheet.getRangeByName('C59').cellStyle.bold = true;

    sheet.getRangeByName('G59:H59').merge(); //Si
    sheet.getRangeByName('I59:J59').merge(); // No

    if (hojaPisoCielo.mh_aCentralCieloController.text == "Si") {
      sheet.getRangeByName('G59').setText("✔");
    }
    if (hojaPisoCielo.mh_aCentralCieloController.text == "No") {
      sheet.getRangeByName('I59').setText("✔");
    }

    sheet.getRangeByName('K59:L59').merge();
    sheet.getRangeByName('K59').setText(hojaPisoCielo.mh_supaCentralCieloController.text);

    sheet.getRangeByName('M59:N59').merge(); //Si
    sheet.getRangeByName('O59:P59').merge(); // No

    if (hojaPisoCielo.df_aCentralCieloController.text == "Si") {
      sheet.getRangeByName('M59').setText("✔");
    }
    if (hojaPisoCielo.df_aCentralCieloController.text == "No") {
      sheet.getRangeByName('O59').setText("✔");
    }

    sheet.getRangeByName('Q59:R59').merge();
    sheet.getRangeByName('Q59').setText(hojaPisoCielo.df_supaCentralCieloController.text);


    //-- Puntual localizada y/o extendida
    sheet.getRangeByName('C60:F60').merge();
    sheet.getRangeByName('C60').setText("Puntual localizada y/o extendida");
    sheet.getRangeByName('C60').cellStyle.bold = true;

    sheet.getRangeByName('G60:H60').merge(); //Si
    sheet.getRangeByName('I60:J60').merge(); // No

    if (hojaPisoCielo.mh_punlocCieloController.text == "Si") {
      sheet.getRangeByName('G60').setText("✔");
    }
    if (hojaPisoCielo.mh_punlocCieloController.text == "No") {
      sheet.getRangeByName('I60').setText("✔");
    }

    sheet.getRangeByName('K60:L60').merge();
    sheet.getRangeByName('K60').setText(hojaPisoCielo.mh_supPunlocCieloController.text);

    sheet.getRangeByName('M60:N60').merge(); //Si
    sheet.getRangeByName('O60:P60').merge(); // No

    if (hojaPisoCielo.df_punlocCieloController.text == "Si") {
      sheet.getRangeByName('M60').setText("✔");
    }
    if (hojaPisoCielo.df_punlocCieloController.text == "No") {
      sheet.getRangeByName('O60').setText("✔");
    }

    sheet.getRangeByName('Q60:R60').merge();
    sheet.getRangeByName('Q60').setText(hojaPisoCielo.df_supPunlocCieloController.text);


    sheet.getRangeByName('C61:F61').merge();
    sheet.getRangeByName('C61').setText("Total superficie de piso afectada");
    sheet.getRangeByName('C61').cellStyle.bold = true;

    sheet.getRangeByName('G61:R61').merge();
    sheet.getRangeByName('G61').setText(hojaPisoCielo.totpalsupafecPisoController.text);


    sheet.getRangeByName('C62:R79').merge();


    if (hojaPisoCielo.imgPisoGuardada != null && hojaPisoCielo.imgPisoGuardada!.existsSync()) {
      try {
        final Uint8List imageBytes = await hojaPisoCielo.imgPisoGuardada!.readAsBytes();
        final xlsio.Picture picture = sheet.pictures.addBase64(
          32, // fila
          8, // columna
          base64Encode(imageBytes),
        );
        picture.height = 360;
        picture.width = 450;
      } catch (e) {
        debugPrint("⚠️ Error al insertar imagen en hoja $nombreHoja: $e");
      }
    }

    if (hojaPisoCielo.imgCieloGuardada != null && hojaPisoCielo.imgCieloGuardada!.existsSync()) {
      try {
        final Uint8List imageBytes = await hojaPisoCielo.imgCieloGuardada!.readAsBytes();
        final xlsio.Picture picture = sheet.pictures.addBase64(
          62, // fila
          8, // columna
          base64Encode(imageBytes),
        );
        picture.height = 360;
        picture.width = 450;
      } catch (e) {
        debugPrint("⚠️ Error al insertar imagen en hoja $nombreHoja: $e");
      }
    }

    sheet.showGridlines = false;
    sheet.getRangeByName('A1:S80').rowHeight = 15;
    sheet.getRangeByName('A1:S80').columnWidth = 15;
    sheet.getRangeByName('A1:S80').cellStyle
      ..hAlign = xlsio.HAlignType.center
      ..vAlign = xlsio.VAlignType.center
      ..wrapText = true
      ..fontSize = 12;
  }


  @override
  void dispose() {
    nombreProyectoController.dispose();
    tipologiaViviendaController.dispose();
    direccionController.dispose();
    etapaController.dispose();
    supViviendaController.dispose();
    nPisosController.dispose();
    oriFachadaController.dispose();
    oriAccesoController.dispose();
    climaController.dispose();
    tempExteriorController.dispose();
    humExteriorController.dispose();
    tempInteriorController.dispose();
    humInteriorController.dispose();
    reciPorController.dispose();
    nombreReciController.dispose();
    nombreInspectorController.dispose();
    usoViviendaController.dispose();
    rutInspectorController.dispose();
    digVerifController.dispose();
    reparacionesController.dispose();
    detalleReparacionesController.dispose();
    ampliacionesController.dispose();
    detalleAmpliacionesController.dispose();
    obsInfoGeneralController.dispose();
    numRecintosController.dispose();
    totalHabitantesController.dispose();
    numAdultosController.dispose();
    numMenoresController.dispose();
    numAdulMayoresController.dispose();
    ocupDiaCompController.dispose();
    ocupIntermitenteController.dispose();
    densOcupPrevController.dispose();
    densOcupRealController.dispose();
    obsOcupVivController.dispose();
    nFichaController.dispose();
    recinto2_nombreController.dispose();
    recinto3_nombreController.dispose();
    super.dispose();
  }
}


// -----------------------------------------------------------------------------
// PINTOR PERSONALIZADO
// -----------------------------------------------------------------------------

class DibujoPainter extends CustomPainter {
  final List<Offset?> puntos;
  DibujoPainter(this.puntos);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < puntos.length - 1; i++) {
      if (puntos[i] != null && puntos[i + 1] != null) {
        canvas.drawLine(puntos[i]!, puntos[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(DibujoPainter oldDelegate) => oldDelegate.puntos != puntos;
}

class Recinto {
  final String nombre;
  final List <HojaMuro> muros = [];
  HojaPisoCielo? hojaPisoCielo;

  File? imgPlano;
  File? imgPlanoGuardada;

  late TextEditingController nombreRecintoController = TextEditingController(text: "Recinto");
  final TextEditingController patvisibleController = TextEditingController();
  final TextEditingController pinOlimpController = TextEditingController();
  final TextEditingController cualpolController = TextEditingController();
  final TextEditingController olorhumController = TextEditingController();
  final TextEditingController modifController = TextEditingController();
  final TextEditingController cualmodController = TextEditingController();
  final TextEditingController sistcalefController = TextEditingController();
  final TextEditingController otrocalefController = TextEditingController();
  final TextEditingController tiemcalefController = TextEditingController();
  final TextEditingController aireadorController = TextEditingController();
  final TextEditingController extractorController = TextEditingController();
  final TextEditingController campanaController = TextEditingController();
  final TextEditingController celosiapueController = TextEditingController();
  final TextEditingController rebajepueController = TextEditingController();
  final TextEditingController otroequipController = TextEditingController();

  Recinto({required this.nombre});

  void dispose() {
    patvisibleController.dispose();
    pinOlimpController.dispose();
    cualpolController.dispose();
    olorhumController.dispose();
    modifController.dispose();
    cualmodController.dispose();
    sistcalefController.dispose();
    otrocalefController.dispose();
    tiemcalefController.dispose();
    aireadorController.dispose();
    extractorController.dispose();
    campanaController.dispose();
    celosiapueController.dispose();
    rebajepueController.dispose();
    otroequipController.dispose();
  }
}

class HojaMuro {
  final String nombre;

  File? imgpatol;
  File? imgpatolGuardada;

  File? imgelev;
  File? imgelevGuardada;

  late TextEditingController nombreMuroController = TextEditingController(text: "(_)");
  final TextEditingController supmuroController = TextEditingController();
  final TextEditingController supventanaController = TextEditingController();
  final TextEditingController tipoMuroController = TextEditingController();
  final TextEditingController nivelafecController = TextEditingController();
  final TextEditingController mh_encEsqMurController = TextEditingController();
  final TextEditingController mh_encCieMurController = TextEditingController();
  final TextEditingController mh_encPisMurController = TextEditingController();
  final TextEditingController mh_rasgventController = TextEditingController();
  final TextEditingController mh_bajovenController = TextEditingController();
  final TextEditingController mh_aCentralController = TextEditingController();
  final TextEditingController mh_punLocController = TextEditingController();
  final TextEditingController mh_supencEsqMurController = TextEditingController();
  final TextEditingController mh_supencCieMurController = TextEditingController();
  final TextEditingController mh_supencPisMurController = TextEditingController();
  final TextEditingController mh_suprasgventController = TextEditingController();
  final TextEditingController mh_supbajovenController = TextEditingController();
  final TextEditingController mh_supaCentralController = TextEditingController();
  final TextEditingController mh_suppunLocController = TextEditingController();
  final TextEditingController df_encEsqMurController = TextEditingController();
  final TextEditingController df_encCieMurController = TextEditingController();
  final TextEditingController df_encPisMurController = TextEditingController();
  final TextEditingController df_rasgventController = TextEditingController();
  final TextEditingController df_bajovenController = TextEditingController();
  final TextEditingController df_aCentralController = TextEditingController();
  final TextEditingController df_punLocController = TextEditingController();
  final TextEditingController df_supencEsqMurController = TextEditingController();
  final TextEditingController df_supencCieMurController = TextEditingController();
  final TextEditingController df_supencPisMurController = TextEditingController();
  final TextEditingController df_suprasgventController = TextEditingController();
  final TextEditingController df_supbajovenController = TextEditingController();
  final TextEditingController df_supaCentralController = TextEditingController();
  final TextEditingController df_suppunLocController = TextEditingController();
  final TextEditingController totpalsupafecController = TextEditingController();

  HojaMuro({required this.nombre});

  void dispose() {
    nombreMuroController.dispose();
    supmuroController.dispose();
    supventanaController.dispose();
    tipoMuroController.dispose();
    nivelafecController.dispose();
    mh_encEsqMurController.dispose();
    mh_encCieMurController.dispose();
    mh_encPisMurController.dispose();
    mh_rasgventController.dispose();
    mh_bajovenController.dispose();
    mh_aCentralController.dispose();
    mh_punLocController.dispose();
    mh_supencEsqMurController.dispose();
    mh_supencCieMurController.dispose();
    mh_supencPisMurController.dispose();
    mh_suprasgventController.dispose();
    mh_supbajovenController.dispose();
    mh_supaCentralController.dispose();
    mh_suppunLocController.dispose();
    df_encEsqMurController.dispose();
    df_encCieMurController.dispose();
    df_encPisMurController.dispose();
    df_rasgventController.dispose();
    df_bajovenController.dispose();
    df_aCentralController.dispose();
    df_punLocController.dispose();
    df_supencEsqMurController.dispose();
    df_supencCieMurController.dispose();
    df_supencPisMurController.dispose();
    df_suprasgventController.dispose();
    df_supbajovenController.dispose();
    df_supaCentralController.dispose();
    df_suppunLocController.dispose();
    totpalsupafecController.dispose();
  }
}

class HojaPisoCielo {
  final String nombre;

  File? imgpiso;
  File? imgPisoGuardada;

  File? imgcielo;
  File? imgCieloGuardada;

  // Controladores Piso
  final TextEditingController supPisoController = TextEditingController();
  final TextEditingController nivelafecPisoController = TextEditingController();
  final TextEditingController mh_perimetroPisoController = TextEditingController();
  final TextEditingController mh_supperimetroPisoController = TextEditingController();
  final TextEditingController mh_aCentralPisoController = TextEditingController();
  final TextEditingController mh_supaCentralPisoController = TextEditingController();
  final TextEditingController mh_punlocPisoController = TextEditingController();
  final TextEditingController mh_supPunlocPisoController = TextEditingController();
  final TextEditingController df_perimetroPisoController = TextEditingController();
  final TextEditingController df_supperimetroPisoController = TextEditingController();
  final TextEditingController df_aCentralPisoController = TextEditingController();
  final TextEditingController df_supaCentralPisoController = TextEditingController();
  final TextEditingController df_punlocPisoController = TextEditingController();
  final TextEditingController df_supPunlocPisoController = TextEditingController();
  final TextEditingController totpalsupafecPisoController = TextEditingController();

  // Controladores Cielo
  final TextEditingController supCieloController = TextEditingController();
  final TextEditingController nivelafecCieloController = TextEditingController();
  final TextEditingController mh_perimetroCieloController = TextEditingController();
  final TextEditingController mh_supperimetroCieloController = TextEditingController();
  final TextEditingController mh_aCentralCieloController = TextEditingController();
  final TextEditingController mh_supaCentralCieloController = TextEditingController();
  final TextEditingController mh_punlocCieloController = TextEditingController();
  final TextEditingController mh_supPunlocCieloController = TextEditingController();
  final TextEditingController df_perimetroCieloController = TextEditingController();
  final TextEditingController df_supperimetroCieloController = TextEditingController();
  final TextEditingController df_aCentralCieloController = TextEditingController();
  final TextEditingController df_supaCentralCieloController = TextEditingController();
  final TextEditingController df_punlocCieloController = TextEditingController();
  final TextEditingController df_supPunlocCieloController = TextEditingController();
  final TextEditingController totpalsupafecCieloController = TextEditingController();

  HojaPisoCielo({required this.nombre});

  void dispose() {
    supPisoController.dispose();
    nivelafecPisoController.dispose();
    mh_perimetroPisoController.dispose();
    mh_supperimetroPisoController.dispose();
    mh_aCentralPisoController.dispose();
    mh_supaCentralPisoController.dispose();
    mh_punlocPisoController.dispose();
    mh_supPunlocPisoController.dispose();
    df_perimetroPisoController.dispose();
    df_supperimetroPisoController.dispose();
    df_aCentralPisoController.dispose();
    df_supaCentralPisoController.dispose();
    df_punlocPisoController.dispose();
    df_supPunlocPisoController.dispose();
    totpalsupafecPisoController.dispose();
    supCieloController.dispose();
    nivelafecCieloController.dispose();
    mh_perimetroCieloController.dispose();
    mh_supperimetroCieloController.dispose();
    mh_aCentralCieloController.dispose();
    mh_supaCentralCieloController.dispose();
    mh_punlocCieloController.dispose();
    mh_supPunlocCieloController.dispose();
    df_perimetroCieloController.dispose();
    df_supperimetroCieloController.dispose();
    df_aCentralCieloController.dispose();
    df_supaCentralCieloController.dispose();
    df_punlocCieloController.dispose();
    df_supPunlocCieloController.dispose();
    totpalsupafecCieloController.dispose();
  }
}

class PegarDisabled extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if ((newValue.text.length - oldValue.text.length) > 1) {
      return oldValue;
    }
    return newValue;
  }
}
