import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/rendering.dart' show RenderRepaintBoundary;
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
import 'package:file_picker/file_picker.dart';
import '../screens/inicio.dart';

class AppState extends ChangeNotifier {

  // ---------------------------------------------------------------------------
  // Asignacion de variables y etiquetas para usar en el app
  // ---------------------------------------------------------------------------

  final picker = ImagePicker();
  final List<HojaMuroPrincipal> hojasP = [];
  final List<HojaMuro> hojasM = [];
  final List<HojaPisoCielo> hojasPC = [];
  int pantallaActual = 0;

  //--> Fechas / horas
  String horaInicio = "00:00";
  String horaFin = "00:00";
  final String fechaFormateada = DateFormat('dd-MM-yyyy').format(DateTime.now());

  // ---------------------------------------------------------------------------
  // Flags de pantallas utilizadas
  // ---------------------------------------------------------------------------

  //-->Recinto 1
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

  File? imagen_Info_General;
  File? imagenGuardadaInfoGeneral;


  // ---------------------------------------------------------------------------
  // Keys para los canvas de cada hoja
  // ---------------------------------------------------------------------------

  //-->Info General
  final GlobalKey canvasKey_InfoGeneral = GlobalKey();

  //-->Recinto 2
  final GlobalKey canvasKey_EjeAR2 = GlobalKey();
  final GlobalKey canvasKey_EjeBR2 = GlobalKey();
  final GlobalKey canvasKey_EjeCR2 = GlobalKey();
  final GlobalKey canvasKey_EjeDR2 = GlobalKey();
  final GlobalKey canvasKey_EjeER2 = GlobalKey();
  final GlobalKey canvasKey_EjeFR2 = GlobalKey();
  final GlobalKey canvasKey_EjeGR2 = GlobalKey();
  final GlobalKey canvasKey_EjeHR2 = GlobalKey();
  final GlobalKey canvasKey_PisoCieloR2 = GlobalKey();

  //-->Recinto 3
  final GlobalKey canvasKey_EjeAR3 = GlobalKey();
  final GlobalKey canvasKey_EjeBR3 = GlobalKey();
  final GlobalKey canvasKey_EjeCR3 = GlobalKey();
  final GlobalKey canvasKey_EjeDR3 = GlobalKey();
  final GlobalKey canvasKey_EjeER3 = GlobalKey();
  final GlobalKey canvasKey_EjeFR3 = GlobalKey();
  final GlobalKey canvasKey_EjeGR3 = GlobalKey();
  final GlobalKey canvasKey_EjeHR3 = GlobalKey();
  final GlobalKey canvasKey_PisoCieloR3 = GlobalKey();

  //-->Recinto 4
  final GlobalKey canvasKey_EjeAR4 = GlobalKey();
  final GlobalKey canvasKey_EjeBR4 = GlobalKey();
  final GlobalKey canvasKey_EjeCR4 = GlobalKey();
  final GlobalKey canvasKey_EjeDR4 = GlobalKey();
  final GlobalKey canvasKey_EjeER4 = GlobalKey();
  final GlobalKey canvasKey_EjeFR4 = GlobalKey();
  final GlobalKey canvasKey_EjeGR4 = GlobalKey();
  final GlobalKey canvasKey_EjeHR4 = GlobalKey();
  final GlobalKey canvasKey_PisoCieloR4 = GlobalKey();

  // ---------------------------------------------------------------------------
  // Controllers
  // ---------------------------------------------------------------------------

  //-->Formularios generales
  final TextEditingController nombreArchivoController = TextEditingController();
  final TextEditingController nFichaController = TextEditingController();

  //-->Hoja Información general
  final TextEditingController nombreProyectoController = TextEditingController();
  final TextEditingController tipologiaViviendaController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController etapaController = TextEditingController();
  final TextEditingController supViviendaController = TextEditingController();
  final TextEditingController nPisosController = TextEditingController();
  final TextEditingController oriFachadaController = TextEditingController();
  final TextEditingController oriAccesoController = TextEditingController();
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
  final TextEditingController reparacionesController = TextEditingController();
  final TextEditingController detalleReparacionesController = TextEditingController();
  final TextEditingController ampliacionesController = TextEditingController();
  final TextEditingController detalleAmpliacionesController = TextEditingController();
  final TextEditingController obsInfoGeneralController = TextEditingController();
  final TextEditingController numRecintosController = TextEditingController();
  final TextEditingController totalHabitantesController = TextEditingController();
  final TextEditingController nnumAdultosController = TextEditingController();
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
  late TextEditingController r1_murop_nombreController = TextEditingController(text: "Muro Eje A");
  late TextEditingController r1_murob_nombreController = TextEditingController(text: "Muro Eje B");
  late TextEditingController r1_muroc_nombreController = TextEditingController(text: "Muro Eje C");
  late TextEditingController r1_murod_nombreController = TextEditingController(text: "Muro Eje D");
  late TextEditingController r1_muroe_nombreController = TextEditingController(text: "Muro Eje E");
  late TextEditingController r1_murof_nombreController = TextEditingController(text: "Muro Eje F");
  late TextEditingController r1_murog_nombreController = TextEditingController(text: "Muro Eje G");
  late TextEditingController r1_pisocielo_nombreController = TextEditingController(text: "Piso Cielo");

  //-->Nombres de Muros Recinto 2 (tambien se utilizan para nombrar las hojas del excel)
  late TextEditingController r2_murop_nombreController = TextEditingController(text: "Muro Eje A");
  late TextEditingController r2_murob_nombreController = TextEditingController(text: "Muro Eje B");
  late TextEditingController r2_muroc_nombreController = TextEditingController(text: "Muro Eje C");
  late TextEditingController r2_murod_nombreController = TextEditingController(text: "Muro Eje D");
  late TextEditingController r2_muroe_nombreController = TextEditingController(text: "Muro Eje E");
  late TextEditingController r2_murof_nombreController = TextEditingController(text: "Muro Eje F");
  late TextEditingController r2_murog_nombreController = TextEditingController(text: "Muro Eje G");
  late TextEditingController r2_pisocielo_nombreController = TextEditingController(text: "Piso Cielo");

  //-->Nombres de Muros Recinto 3 (tambien se utilizan para nombrar las hojas del excel)
  late TextEditingController r3_murop_nombreController = TextEditingController(text: "Muro Eje A");
  late TextEditingController r3_murob_nombreController = TextEditingController(text: "Muro Eje B");
  late TextEditingController r3_muroc_nombreController = TextEditingController(text: "Muro Eje C");
  late TextEditingController r3_murod_nombreController = TextEditingController(text: "Muro Eje D");
  late TextEditingController r3_muroe_nombreController = TextEditingController(text: "Muro Eje E");
  late TextEditingController r3_murof_nombreController = TextEditingController(text: "Muro Eje F");
  late TextEditingController r3_murog_nombreController = TextEditingController(text: "Muro Eje G");
  late TextEditingController r3_pisocielo_nombreController = TextEditingController(text: "Piso Cielo");

//-->Nombres de Muros Recinto 4 (tambien se utilizan para nombrar las hojas del excel)
  late TextEditingController r4_murop_nombreController = TextEditingController(text: "Muro Eje A");
  late TextEditingController r4_murob_nombreController = TextEditingController(text: "Muro Eje B");
  late TextEditingController r4_muroc_nombreController = TextEditingController(text: "Muro Eje C");
  late TextEditingController r4_murod_nombreController = TextEditingController(text: "Muro Eje D");
  late TextEditingController r4_muroe_nombreController = TextEditingController(text: "Muro Eje E");
  late TextEditingController r4_murof_nombreController = TextEditingController(text: "Muro Eje F");
  late TextEditingController r4_murog_nombreController = TextEditingController(text: "Muro Eje G");
  late TextEditingController r4_pisocielo_nombreController = TextEditingController(text: "Piso Cielo");

//-->Nombres de Muros Recinto 5 (tambien se utilizan para nombrar las hojas del excel)
  late TextEditingController r5_murop_nombreController = TextEditingController(text: "Muro Eje A");
  late TextEditingController r5_murob_nombreController = TextEditingController(text: "Muro Eje B");
  late TextEditingController r5_muroc_nombreController = TextEditingController(text: "Muro Eje C");
  late TextEditingController r5_murod_nombreController = TextEditingController(text: "Muro Eje D");
  late TextEditingController r5_muroe_nombreController = TextEditingController(text: "Muro Eje E");
  late TextEditingController r5_murof_nombreController = TextEditingController(text: "Muro Eje F");
  late TextEditingController r5_murog_nombreController = TextEditingController(text: "Muro Eje G");
  late TextEditingController r5_pisocielo_nombreController = TextEditingController(text: "Piso Cielo");



  //--------------------------------------------------------------------------------------------------------------------------------------------------------
  //                                                                            Funciones
  //---------------------------------------------------------------------------------------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  // Funcion de agregar hojas a la lista de hojas principales
  // ---------------------------------------------------------------------------

  void agregarHojaMuroPrincipal({required String nombre}) {
    hojasP.add(HojaMuroPrincipal(nombre: nombre));
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Funcion de agregar hojas a la lista de hojas muro
  // ---------------------------------------------------------------------------

  void agregarHojaMuro({required String nombre}) {
    hojasM.add(HojaMuro(nombre: nombre));
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Funcion de agregar hojas a la lista de hojas piso Cielo
  // ---------------------------------------------------------------------------

  void agregarHojaPisoCielo({required String nombre}) {
    hojasPC.add(HojaPisoCielo(nombre: nombre));
    notifyListeners();
  }


  // ---------------------------------------------------------------------------
  // Funcion de eliminar hojas de la lista de hojas principales
  // ---------------------------------------------------------------------------

  void eliminarHojaMuroPrincipal(int index) {
    hojasP[index].dispose();
    hojasP.removeAt(index);
    notifyListeners();
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

  // ---------------------------------------------------------------------------
  // Funcion de obtener una hoja principal
  // ---------------------------------------------------------------------------

  HojaMuroPrincipal obtenerHojaMuroPrincipal(String nombre) {
    try {
      return hojasP.firstWhere((h) => h.nombre == nombre);
    } catch (_) {
      final nuevaHoja = HojaMuroPrincipal(nombre: nombre);
      hojasP.add(nuevaHoja);
      return nuevaHoja;
    }
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

  String? rutaGuardada;
  bool guardando = false;

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
  }) async {
    final XFile? imagen = await picker.pickImage(source: fuente);
    if (imagen != null) {
      final file = File(imagen.path);

      imagenGuardadaInfoGeneral = null;
      imagen_Info_General = file;

      notifyListeners();
      onImagenSeleccionada(file);
    }
  }

  //--> Guardar edición de la imagen de info general (formato JPG compatible Excel)
  Future<void> guardarDibujoInfoGeneral({
    required GlobalKey canvasKey,
    required void Function(File file) onGuardado,
    BuildContext? context,
    bool silencioso = false,
    String nombreArchivo = "ImagenInfoGeneral",
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
      imagenGuardadaInfoGeneral = file;
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
      imagen_Info_General = null;
      imagenGuardadaInfoGeneral = null;
      notifyListeners();
    }
  }

  //----------------------------------------------------------------------------
  // Funciones de manejo de imagenes de las hojas principales
  //----------------------------------------------------------------------------

  //--> Obtener Imagen
  Future<void> obtenerImagenHojaPrincipal({
    required ImageSource fuente,
    required HojaMuroPrincipal hoja,
    required Function(File) onImagenSeleccionada,
    required int imgnum
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


//--> Guardar edición de imagen de las hojas principales (formato compatible Excel)
  Future<void> guardarDibujoHojaPrincipal({
    required GlobalKey canvasKey,
    required HojaMuroPrincipal hoja,
    required int imgnum,
    required void Function(File file) onGuardado,
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
      final ByteData? pngBytes =
      await image.toByteData(format: ui.ImageByteFormat.png);

      if (pngBytes == null) throw Exception('No se pudo convertir la imagen.');

      final Uint8List pngData = pngBytes.buffer.asUint8List();

      final Uint8List jpgData = Uint8List.fromList(img.encodeJpg(
        img.decodeImage(pngData)!,
        quality: 95,
      ));

      final directory = await getApplicationDocumentsDirectory();

      //--> Diferenciar nombres piso/cielo
      final tipo = imgnum == 1 ? "imgPatol" : "imgElev";
      final path =
          '${directory.path}/${hoja.nombre.replaceAll(" ", "_")}_$tipo.jpg';

      final file = File(path);
      await file.writeAsBytes(jpgData);

      //--> Guardar en el modelo
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


  //--> Eliminar la edicion de la imagen de las hojas principales
  Future<void> eliminarDibujoHojaPrincipal({
    required BuildContext context,
    required HojaMuroPrincipal hoja,
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
      case 8:
        r1_pisocielo_nombreController.text = nuevoNombre;
        break;
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
      case 16:
        r2_pisocielo_nombreController.text = nuevoNombre;
        break;
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
      case 24:
        r3_pisocielo_nombreController.text = nuevoNombre;
        break;
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
      case 32:
        r4_pisocielo_nombreController.text = nuevoNombre;
        break;
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
      case 40:
        r5_pisocielo_nombreController.text = nuevoNombre;
        break;
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
  int? buscarIndexHojaPrincipal(BuildContext context, String nombreHojaActual) {
    final indexHoja = hojasP.indexWhere((h) => h.nombre == nombreHojaActual);
    if (indexHoja == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No se encontró la hoja \"$nombreHojaActual\".")),
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

  //--> Hojas Principales
  Future<void> eliminarPantallaPrincipalActual(BuildContext context) async {
    String? nombreHojaActual;

    switch (pantallaActual) {
      case 2:
        nombreHojaActual = "Muro Eje Principal - Recinto 1";
        break;

    //-->agregar más pantallas principales
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No hay hoja asociada a esta pantalla.")),
        );
        return;
    }

    final indexHoja = buscarIndexHojaPrincipal(context, nombreHojaActual);

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
      eliminarHojaMuroPrincipal(indexHoja!);

      //--> Actualiza flags según la pantalla
      switch (pantallaActual) {
        case 2:
          muro_eje_p_r1 = false;
          r1_murop_nombreController = TextEditingController(text: "Muro Eje A");
          break;
      }
      pantallaActual = 0;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hoja \"$nombreHojaActual\" eliminada.")),
      );
    }
  }

  //--> Hojas Muros
  Future<void> eliminarPantallaMuroActual(BuildContext context) async {
    String? nombreHojaActual;

    switch (pantallaActual) {
      case 3:
        nombreHojaActual = "Muro Eje B - Recinto 1";
        break;
      case 4:
        nombreHojaActual = "Muro Eje C - Recinto 1";
        break;
      case 5:
        nombreHojaActual = "Muro Eje D - Recinto 1";
        break;
      case 6:
        nombreHojaActual = "Muro Eje E - Recinto 1";
        break;
      case 7:
        nombreHojaActual = "Muro Eje F - Recinto 1";
        break;
      case 8:
        nombreHojaActual = "Muro Eje G - Recinto 1";
        break;
      case 11:
        nombreHojaActual = "Muro Eje B - Recinto 2";
        break;
      case 12:
        nombreHojaActual = "Muro Eje C - Recinto 2";
        break;
      case 13:
        nombreHojaActual = "Muro Eje D - Recinto 2";
        break;
      case 14:
        nombreHojaActual = "Muro Eje E - Recinto 2";
        break;
      case 15:
        nombreHojaActual = "Muro Eje F - Recinto 2";
        break;
      case 16:
        nombreHojaActual = "Muro Eje G - Recinto 2";
        break;
      case 19:
        nombreHojaActual = "Muro Eje B - Recinto 3";
        break;
      case 20:
        nombreHojaActual = "Muro Eje C - Recinto 3";
        break;
      case 21:
        nombreHojaActual = "Muro Eje D - Recinto 3";
        break;
      case 22:
        nombreHojaActual = "Muro Eje E - Recinto 3";
        break;
      case 23:
        nombreHojaActual = "Muro Eje F - Recinto 3";
        break;
      case 24:
        nombreHojaActual = "Muro Eje G - Recinto 3";
        break;
      case 27:
        nombreHojaActual = "Muro Eje B - Recinto 4";
        break;
      case 28:
        nombreHojaActual = "Muro Eje C - Recinto 4";
        break;
      case 29:
        nombreHojaActual = "Muro Eje D - Recinto 4";
        break;
      case 30:
        nombreHojaActual = "Muro Eje E - Recinto 4";
        break;
      case 31:
        nombreHojaActual = "Muro Eje F - Recinto 4";
        break;
      case 32:
        nombreHojaActual = "Muro Eje G - Recinto 4";
        break;
      case 35:
        nombreHojaActual = "Muro Eje B - Recinto 5";
        break;
      case 36:
        nombreHojaActual = "Muro Eje C - Recinto 5";
        break;
      case 37:
        nombreHojaActual = "Muro Eje D - Recinto 5";
        break;
      case 38:
        nombreHojaActual = "Muro Eje E - Recinto 5";
        break;
      case 39:
        nombreHojaActual = "Muro Eje F - Recinto 5";
        break;
      case 40:
        nombreHojaActual = "Muro Eje G - Recinto 5";
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

      //--> Actualiza flags según la pantalla
      switch (pantallaActual) {
        case 3:
          muro_eje_b_r1 = false;
          r1_murob_nombreController = TextEditingController(text: "Muro Eje B");
          break;
        case 4:
          muro_eje_c_r1 = false;
          r1_muroc_nombreController = TextEditingController(text: "Muro Eje C");
          break;
        case 5:
          muro_eje_d_r1 = false;
          r1_murod_nombreController = TextEditingController(text: "Muro Eje D");
          break;
        case 6:
          muro_eje_e_r1 = false;
          r1_muroe_nombreController = TextEditingController(text: "Muro Eje E");
          break;
        case 7:
          muro_eje_f_r1 = false;
          r1_murof_nombreController = TextEditingController(text: "Muro Eje F");
          break;
        case 8:
          muro_eje_g_r1 = false;
          r1_murog_nombreController = TextEditingController(text: "Muro Eje G");
          break;
        case 11:
          muro_eje_b_r2 = false;
          r2_murob_nombreController = TextEditingController(text: "Muro Eje B");
          break;
        case 12:
          muro_eje_c_r2 = false;
          r2_murob_nombreController = TextEditingController(text: "Muro Eje C");
          break;
        case 13:
          muro_eje_d_r2 = false;
          r2_murob_nombreController = TextEditingController(text: "Muro Eje D");
          break;
        case 14:
          muro_eje_e_r2 = false;
          r2_murob_nombreController = TextEditingController(text: "Muro Eje E");
          break;
        case 15:
          muro_eje_f_r2 = false;
          r2_murob_nombreController = TextEditingController(text: "Muro Eje F");
          break;
        case 16:
          muro_eje_g_r2 = false;
          r2_murob_nombreController = TextEditingController(text: "Muro Eje G");
          break;
        case 19:
          muro_eje_b_r3 = false;
          r3_murob_nombreController = TextEditingController(text: "Muro Eje B");
          break;
        case 20:
          muro_eje_c_r3 = false;
          r3_murob_nombreController = TextEditingController(text: "Muro Eje C");
          break;
        case 21:
          muro_eje_d_r3 = false;
          r3_murob_nombreController = TextEditingController(text: "Muro Eje D");
          break;
        case 22:
          muro_eje_e_r3 = false;
          r3_murob_nombreController = TextEditingController(text: "Muro Eje E");
          break;
        case 23:
          muro_eje_f_r3 = false;
          r3_murob_nombreController = TextEditingController(text: "Muro Eje F");
          break;
        case 24:
          muro_eje_g_r3 = false;
          r3_murob_nombreController = TextEditingController(text: "Muro Eje G");
          break;
        case 27:
          muro_eje_b_r4 = false;
          r4_murob_nombreController = TextEditingController(text: "Muro Eje B");
          break;
        case 28:
          muro_eje_c_r4 = false;
          r4_murob_nombreController = TextEditingController(text: "Muro Eje C");
          break;
        case 29:
          muro_eje_d_r4 = false;
          r4_murob_nombreController = TextEditingController(text: "Muro Eje D");
          break;
        case 30:
          muro_eje_e_r4 = false;
          r4_murob_nombreController = TextEditingController(text: "Muro Eje E");
          break;
        case 31:
          muro_eje_f_r4 = false;
          r4_murob_nombreController = TextEditingController(text: "Muro Eje F");
          break;
        case 32:
          muro_eje_g_r4 = false;
          r4_murob_nombreController = TextEditingController(text: "Muro Eje G");
          break;
        case 35:
          muro_eje_b_r5 = false;
          r5_murob_nombreController = TextEditingController(text: "Muro Eje B");
          break;
        case 36:
          muro_eje_c_r5 = false;
          r5_murob_nombreController = TextEditingController(text: "Muro Eje C");
          break;
        case 37:
          muro_eje_d_r5 = false;
          r5_murob_nombreController = TextEditingController(text: "Muro Eje D");
          break;
        case 38:
          muro_eje_e_r5 = false;
          r5_murob_nombreController = TextEditingController(text: "Muro Eje E");
          break;
        case 39:
          muro_eje_f_r5 = false;
          r5_murob_nombreController = TextEditingController(text: "Muro Eje F");
          break;
        case 40:
          muro_eje_g_r5 = false;
          r5_murob_nombreController = TextEditingController(text: "Muro Eje G");
          break;

      }
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
      case 17:
        nombreHojaActual = "Piso Cielo - Recinto 2";
        break;
      case 25:
        nombreHojaActual = "Piso Cielo - Recinto 3";
        break;
      case 33:
        nombreHojaActual = "Piso Cielo - Recinto 4";
        break;
      case 41:
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
        case 17:
          piso_cielo_r2 = false;
          break;
        case 25:
          piso_cielo_r3 = false;
          break;
        case 33:
          piso_cielo_r4 = false;
          break;
        case 41:
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

      String nombreArchivo = nombreArchivoController.text.trim();
      if (nombreArchivo.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Por favor, ingrese un nombre de archivo.")),
        );
        pantallaActual = 1;
        guardando = false;
        notifyListeners();
        return;
      }

      //--> Seleccionar carpeta
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory == null) {
        guardando = false;
        notifyListeners();
        return;
      }

      //------------------------------------------------------------------------
      // Crear Workbook y agregar la hoja Informacion General
      //------------------------------------------------------------------------

      final xlsio.Workbook workbook = xlsio.Workbook();
      final xlsio.Worksheet sheet = workbook.worksheets[0];
      sheet.name = 'Información General';


      //--> Bordes Celdas Encabezado
      sheet.getRangeByName('B3:R5').cellStyle
        ..borders.all.lineStyle = xlsio.LineStyle.thin
        ..borders.all.color = '#000000';

      sheet.getRangeByName('B3:E5').merge();
      sheet.getRangeByName('B3').setText("Logo Citec");
      sheet.getRangeByName('B3').cellStyle.bold = true;

      sheet.getRangeByName('F3:N5').merge();
      sheet.getRangeByName('F3').setText(
        "PROTOCOLO\nINSPECCIÓN VISUAL DE VIVIENDAS - ACONDICIONAMIENTO AMBIENTAL",);
      sheet.getRangeByName('F3').cellStyle.bold = true;

      sheet.getRangeByName('O3:P3').merge();
      sheet.getRangeByName('O4:P4').merge();
      sheet.getRangeByName('O5:P5').merge();
      sheet.getRangeByName('O4').setText("Unidad");
      sheet.getRangeByName('O4').cellStyle.bold = true;

      sheet.getRangeByName('Q3:R3').merge();
      sheet.getRangeByName('Q4:R4').merge();
      sheet.getRangeByName('Q5:R5').merge();
      sheet.getRangeByName('Q4').setText("Citec Ubb");
      sheet.getRangeByName('Q4').cellStyle.bold = true;


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
      sheet.getRangeByName('F11').setText(direccionController.text);

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
      sheet.getRangeByName('M12').setText(oriFachadaController.text);

      sheet.getRangeByName('N12:O13').merge();
      sheet.getRangeByName('N12').setText("Orientación acceso");
      sheet.getRangeByName('N12').cellStyle.bold = true;

      sheet.getRangeByName('P12:P13').merge();
      sheet.getRangeByName('P12').setText(oriAccesoController.text);

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
      sheet.getRangeByName('J16').setText(nombreReciController.text);

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
      sheet.getRangeByName('N21').setText(rutInspectorController.text);

      sheet.getRangeByName('C23:E24').merge();
      sheet.getRangeByName('C23').setText("Reparaciones");
      sheet.getRangeByName('C23').cellStyle.bold = true;

      sheet.getRangeByName('F23:G23').merge();
      sheet.getRangeByName('F23').setText("SI o NO");
      sheet.getRangeByName('F23').cellStyle.bold = true;

      sheet.getRangeByName('F24:G24').merge();
      sheet.getRangeByName('F24').setText(reparacionesController.text);

      sheet.getRangeByName('H23:R23').merge();
      sheet.getRangeByName('H23').setText("¿Cuántas y de qué tipo?");
      sheet.getRangeByName('H23').cellStyle.bold = true;

      sheet.getRangeByName('H24:R24').merge();
      sheet.getRangeByName('H24').setText(detalleReparacionesController.text);

      sheet.getRangeByName('C25:E26').merge();
      sheet.getRangeByName('C25').setText("Ampliaciones");
      sheet.getRangeByName('C25').cellStyle.bold = true;

      sheet.getRangeByName('F25:G25').merge();
      sheet.getRangeByName('F25').setText("SI o NO");
      sheet.getRangeByName('F25').cellStyle.bold = true;

      sheet.getRangeByName('F26:G26').merge();
      sheet.getRangeByName('F26').setText(ampliacionesController.text);

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
      sheet.getRangeByName('I35').setText(nnumAdultosController.text);

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
      sheet.getRangeByName('L36').setText(densOcupPrevController.text);

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

      sheet.getRangeByName('C43:R65').merge();


      //--> Imagen Info General
      if (imagenGuardadaInfoGeneral != null && imagenGuardadaInfoGeneral!.existsSync()) {
        final Uint8List imageBytes = await imagenGuardadaInfoGeneral!.readAsBytes();
        final xlsio.Picture picture = sheet.pictures.addBase64(
          43, // fila
          6, // columna
          base64Encode(imageBytes),
        );
        picture.height = 460;
        picture.width = 1010;
      }

      sheet.showGridlines = false;
      sheet.getRangeByName('A1:S66').rowHeight = 15;
      sheet.getRangeByName('A1:S66').columnWidth = 15;
      sheet.getRangeByName('A1:S66').cellStyle
        ..fontSize = 12
        ..wrapText = true
        ..hAlign = xlsio.HAlignType.center
        ..vAlign = xlsio.VAlignType.center;


      //------------------------------------------------------------------------
      //-------------SECCION DE GUARDADO SEGUN HOJA UTILIZADA-------------------
      //------------------------------------------------------------------------

      if (muro_eje_p_r1 == true) {
        final indexHojaPrincipal = buscarIndexHojaPrincipal(context, "Muro Eje Principal - Recinto 1");
        if (indexHojaPrincipal == null) {

        } else {
          await crearHojaMuroPrincipalExcel(
            workbook: workbook,
            hojaMuroPrincipal: hojasP[indexHojaPrincipal],
            nombreHoja: r1_murop_nombreController.text,
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
                  nombreHoja: r1_murob_nombreController.text,
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
                  nombreHoja: r1_muroc_nombreController.text,
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
                  nombreHoja: r1_murod_nombreController.text,
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
                  nombreHoja: r1_muroe_nombreController.text,
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
                  nombreHoja: r1_murof_nombreController.text,
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
                  nombreHoja: r1_murog_nombreController.text,
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
                  nombreHoja: r1_pisocielo_nombreController.text,
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
      reiniciarApp();
      guardando = false;
      notifyListeners();
    }
  }


  //------------------------------------------------------------------------------------------------
  // Agregar las hojas de los muros Principales de cada habitacion (1 muro pricipal por habitacion)
  //------------------------------------------------------------------------------------------------

  Future<void> crearHojaMuroPrincipalExcel({
    required xlsio.Workbook workbook,
    required HojaMuroPrincipal hojaMuroPrincipal,
    required String nombreHoja,
  }) async {

    final sheet = workbook.worksheets.addWithName(nombreHoja);

    // -------------------------------------------------------------------------
    // ENCABEZADO
    // -------------------------------------------------------------------------

    sheet.getRangeByName('B3:R5').cellStyle
      ..borders.all.lineStyle = xlsio.LineStyle.thin
      ..borders.all.color = '#000000';

    sheet.getRangeByName('B3:E5').merge();
    sheet.getRangeByName('B3').setText("Logo Citec");
    sheet.getRangeByName('B3').cellStyle
      ..bold = true
      ..hAlign = xlsio.HAlignType.center
      ..vAlign = xlsio.VAlignType.center;

    sheet.getRangeByName('F3:N5').merge();
    sheet.getRangeByName('F3').setText(
        "PROTOCOLO\nINSPECCIÓN VISUAL DE VIVIENDAS - ACONDICIONAMIENTO AMBIENTAL");
    sheet.getRangeByName('F3').cellStyle.bold = true;

    sheet.getRangeByName('O3:P3').merge();
    sheet.getRangeByName('O4:P4').merge();
    sheet.getRangeByName('O5:P5').merge();
    sheet.getRangeByName('O4').setText("Unidad");
    sheet.getRangeByName('O4').cellStyle.bold = true;

    sheet.getRangeByName('Q3:R3').merge();
    sheet.getRangeByName('Q4:R4').merge();
    sheet.getRangeByName('Q5:R5').merge();
    sheet.getRangeByName('Q4').setText("CITEC UBB");
    sheet.getRangeByName('Q4').cellStyle.bold = true;

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

    sheet.getRangeByName('B8:B55').merge();
    sheet.getRangeByName('B8').setText("5");
    sheet.getRangeByName('B8').cellStyle
      ..bold = true
      ..backColor = '#FFC000';

    sheet.getRangeByName('C7:R7').merge();
    sheet.getRangeByName('C7').setText("Levantamiento de Patologías higrotérmicas");
    sheet.getRangeByName('C7').cellStyle
      ..bold = true
      ..backColor = '#BFBFBF';

    sheet.getRangeByName('C8:R8').merge();
    sheet.getRangeByName('C9:R20').merge();

    sheet.getRangeByName('C21:F22').merge();
    sheet.getRangeByName('C21').setText("¿Presenta patologías visibles?");
    sheet.getRangeByName('C21').cellStyle.bold = true;

    sheet.getRangeByName('G21:H21').merge();
    sheet.getRangeByName('G21').setText("Si o No");
    sheet.getRangeByName('G21').cellStyle.bold = true;

    sheet.getRangeByName('G22:H22').merge();
    sheet.getRangeByName('G22').setText(hojaMuroPrincipal.patvisibleController.text);

    sheet.getRangeByName('I21:L22').merge();
    sheet.getRangeByName('I21').setText("Manifestaciones ocultas ¿fue pintado o limpiado últimamente?");
    sheet.getRangeByName('I21').cellStyle.bold = true;

    sheet.getRangeByName('M21:N21').merge();
    sheet.getRangeByName('M21').setText("Si o No");
    sheet.getRangeByName('M21').cellStyle.bold = true;

    sheet.getRangeByName('M22:N22').merge();
    sheet.getRangeByName('M22').setText(hojaMuroPrincipal.pinOlimpController.text);

    sheet.getRangeByName('O21:R21').merge();
    sheet.getRangeByName('O21').setText("¿Cuál?");
    sheet.getRangeByName('O21').cellStyle.bold = true;

    sheet.getRangeByName('O22:R22').merge();
    sheet.getRangeByName('O22').setText(hojaMuroPrincipal.cualpolController.text);

    sheet.getRangeByName('C23:F24').merge();
    sheet.getRangeByName('C23').setText("¿Olor a humedad?");
    sheet.getRangeByName('C23').cellStyle.bold = true;

    sheet.getRangeByName('G23:H23').merge();
    sheet.getRangeByName('G23').setText("Si o No");
    sheet.getRangeByName('G23').cellStyle.bold = true;

    sheet.getRangeByName('G24:H24').merge();
    sheet.getRangeByName('G24').setText(hojaMuroPrincipal.olorhumController.text);
    sheet.getRangeByName('G24').cellStyle.bold = true;

    sheet.getRangeByName('I23:L24').merge();
    sheet.getRangeByName('I23').setText("¿Modificaciones?");
    sheet.getRangeByName('I23').cellStyle.bold = true;

    sheet.getRangeByName('M23:N23').merge();
    sheet.getRangeByName('M23').setText("Si o No");
    sheet.getRangeByName('M23').cellStyle.bold = true;

    sheet.getRangeByName('M24:N24').merge();
    sheet.getRangeByName('M24').setText(hojaMuroPrincipal.modifController.text);

    sheet.getRangeByName('O23:R23').merge();
    sheet.getRangeByName('O23').setText("¿Cuál?");
    sheet.getRangeByName('O23').cellStyle.bold = true;

    sheet.getRangeByName('O24:R24').merge();
    sheet.getRangeByName('O24').setText(hojaMuroPrincipal.cualmodController.text);

    sheet.getRangeByName('C25:F26').merge();
    sheet.getRangeByName('C25').setText("Sistema de Calefacción");
    sheet.getRangeByName('C25').cellStyle.bold = true;

    sheet.getRangeByName('G25:H25').merge();
    sheet.getRangeByName('G25').setText("Eléctrico (seca)");
    sheet.getRangeByName('G25').cellStyle.bold = true;

    sheet.getRangeByName('I25:J25').merge();
    sheet.getRangeByName('I25').setText("Gas / parafina con evacuacipon exterior (seca)");
    sheet.getRangeByName('I25').cellStyle.bold = true;

    sheet.getRangeByName('K25:L25').merge();
    sheet.getRangeByName('K25').setText("Biomasa con evacuación exterior (seca)");
    sheet.getRangeByName('K25').cellStyle.bold = true;

    sheet.getRangeByName('M25:N25').merge();
    sheet.getRangeByName('M25').setText("Parafina/gas móvil (húmeda)");
    sheet.getRangeByName('M25').cellStyle.bold = true;

    sheet.getRangeByName('G26:N26').merge();
    sheet.getRangeByName('G26').setText(hojaMuroPrincipal.sistcalefController.text);

    sheet.getRangeByName('O25:R25').merge();
    sheet.getRangeByName('O25').setText("Otro ¿cuál?");
    sheet.getRangeByName('O25').cellStyle.bold = true;

    sheet.getRangeByName('O26:R26').merge();
    sheet.getRangeByName('O26').setText(hojaMuroPrincipal.otrocalefController.text);

    sheet.getRangeByName('C27:F27').merge();
    sheet.getRangeByName('C27').setText("¿Cuánto tiempo calefacciona?");
    sheet.getRangeByName('C27').cellStyle.bold = true;

    sheet.getRangeByName('G27:R27').merge();
    sheet.getRangeByName('G27').setText(hojaMuroPrincipal.tiemcalefController.text);

    sheet.getRangeByName('C28:F30').merge();
    sheet.getRangeByName('C28').setText("Sistema de ventilación (indicar en la planta su ubicación)");
    sheet.getRangeByName('C28').cellStyle.bold = true;

    sheet.getRangeByName('G28:H28').merge();
    sheet.getRangeByName('G28').setText("Aireador");
    sheet.getRangeByName('G28').cellStyle.bold = true;

    sheet.getRangeByName('G29').setText("Operativo");
    sheet.getRangeByName('G29').cellStyle.bold = true;

    if (hojaMuroPrincipal.aireadorController.text == "Operativo") {
      sheet.getRangeByName('G29').cellStyle.backColor = '#93C47d';
    }

    sheet.getRangeByName('H29').setText("No Op");
    sheet.getRangeByName('H29').cellStyle.bold = true;

    if (hojaMuroPrincipal.aireadorController.text == "No Operativo") {
      sheet.getRangeByName('G29').cellStyle.backColor =  '#E06666';
    }

    sheet.getRangeByName('G30:H30').merge();
    sheet.getRangeByName('G30').setText(hojaMuroPrincipal.aireadorController.text);

    sheet.getRangeByName('I28:J28').merge();
    sheet.getRangeByName('I28').setText("Extractor");
    sheet.getRangeByName('I28').cellStyle.bold = true;

    sheet.getRangeByName('I29').setText("Operativo");
    sheet.getRangeByName('I29').cellStyle.bold = true;

    if (hojaMuroPrincipal.extractorController.text == "Operativo") {
      sheet.getRangeByName('I29').cellStyle.backColor = '#93C47D';
    }

    sheet.getRangeByName('J29').setText("No Op");
    sheet.getRangeByName('J29').cellStyle.bold = true;

    if (hojaMuroPrincipal.extractorController.text == "No Operativo") {
      sheet.getRangeByName('J29').cellStyle.backColor =  '#E06666';
    }

    sheet.getRangeByName('I30:J30').merge();
    sheet.getRangeByName('I30').setText(hojaMuroPrincipal.extractorController.text);

    sheet.getRangeByName('K28:L28').merge();
    sheet.getRangeByName('K28').setText("Campana");
    sheet.getRangeByName('K28').cellStyle.bold = true;

    sheet.getRangeByName('K29').setText("Operativo");
    sheet.getRangeByName('K29').cellStyle.bold = true;

    if (hojaMuroPrincipal.campanaController.text == "Operativo") {
      sheet.getRangeByName('K29').cellStyle.backColor = '#93C47D';
    }

    sheet.getRangeByName('L29').setText("No Op");
    sheet.getRangeByName('L29').cellStyle.bold = true;

    if (hojaMuroPrincipal.campanaController.text == "No Operativo") {
      sheet.getRangeByName('L29').cellStyle.backColor =  '#E06666';
    }

    sheet.getRangeByName('K30:L30').merge();
    sheet.getRangeByName('K30').setText(hojaMuroPrincipal.campanaController.text);

    sheet.getRangeByName('M28:N28').merge();
    sheet.getRangeByName('M28').setText("Celosía puerta");
    sheet.getRangeByName('M28').cellStyle.bold = true;


    sheet.getRangeByName('M29').setText("Operativo");
    sheet.getRangeByName('M29').cellStyle.bold = true;

    if (hojaMuroPrincipal.celosiapueController.text == "Operativo") {
      sheet.getRangeByName('M29').cellStyle.backColor = '#93C47D';
    }

    sheet.getRangeByName('N29').setText("No Op");
    sheet.getRangeByName('N29').cellStyle.bold = true;

    if (hojaMuroPrincipal.celosiapueController.text == "No Operativo") {
      sheet.getRangeByName('N29').cellStyle.backColor =  '#E06666';
    }

    sheet.getRangeByName('M30:N30').merge();
    sheet.getRangeByName('M30').setText(hojaMuroPrincipal.celosiapueController.text);

    sheet.getRangeByName('O28:P28').merge();
    sheet.getRangeByName('O28:P28').setText("Rebaje puerta");
    sheet.getRangeByName('O28:P28').cellStyle.bold = true;

    sheet.getRangeByName('O29').setText("Operativo");
    sheet.getRangeByName('O29').cellStyle.bold = true;

    if (hojaMuroPrincipal.rebajepueController.text == "Operativo") {
      sheet.getRangeByName('O29').cellStyle.backColor = '#93C47D';
    }

    sheet.getRangeByName('P29').setText("No Op");
    sheet.getRangeByName('P29').cellStyle.bold = true;

    if (hojaMuroPrincipal.rebajepueController.text == "No Operativo") {
      sheet.getRangeByName('P29').cellStyle.backColor =  '#E06666';
    }

    sheet.getRangeByName('O30:P30').merge();
    sheet.getRangeByName('O30:P30').setText(hojaMuroPrincipal.rebajepueController.text);

    sheet.getRangeByName('Q28:R28').merge();
    sheet.getRangeByName('Q28').setText("Otro");
    sheet.getRangeByName('Q28').cellStyle.bold = true;

    sheet.getRangeByName('Q29').setText("Operativo");
    sheet.getRangeByName('Q29').cellStyle.bold = true;

    if (hojaMuroPrincipal.otroequipController.text == "Operativo") {
      sheet.getRangeByName('Q29').cellStyle.backColor = '#93C47D';
    }

    sheet.getRangeByName('R29').setText("No Op");
    sheet.getRangeByName('R29').cellStyle.bold = true;

    if (hojaMuroPrincipal.otroequipController.text == "No Operativo") {
      sheet.getRangeByName('R29').cellStyle.backColor =  '#E06666';
    }

    sheet.getRangeByName('Q30:R30').merge();
    sheet.getRangeByName('Q30').setText(hojaMuroPrincipal.otroequipController.text);


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

    sheet.getRangeByName('F32').setText(hojaMuroPrincipal.muroejeController.text);
    sheet.getRangeByName('F32').cellStyle.backColor = '#FFE699';

    sheet.getRangeByName('G32:I32').merge();
    sheet.getRangeByName('G32').setText("Superficie muro");
    sheet.getRangeByName('G32').cellStyle.bold = true;

    sheet.getRangeByName('J32:L32').merge();
    sheet.getRangeByName('J32').setText(hojaMuroPrincipal.supmuroController.text);

    sheet.getRangeByName('M32:O32').merge();
    sheet.getRangeByName('M32').setText("Superficie ventana");
    sheet.getRangeByName('M32').cellStyle.bold = true;

    sheet.getRangeByName('P32:R32').merge();
    sheet.getRangeByName('P32').setText(hojaMuroPrincipal.supventanaController.text);

    sheet.getRangeByName('C33:E33').merge();
    sheet.getRangeByName('C33').setText("Muro perimetral");
    sheet.getRangeByName('C33').cellStyle.bold = true;

    sheet.getRangeByName('F33').setText(hojaMuroPrincipal.muroperimetralController.text);

    sheet.getRangeByName('C34:E34').merge();
    sheet.getRangeByName('C34').setText("Muro interior");
    sheet.getRangeByName('C34').cellStyle.bold = true;

    sheet.getRangeByName('F34').setText(hojaMuroPrincipal.murointController.text);

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

    switch(hojaMuroPrincipal.nivelafecController.text) {
      case "Nulo":
        sheet.getRangeByName('J34:K34').cellStyle.backColor = '#A2C4C9';
        break;
      case "Bajo":
        sheet.getRangeByName('L33:M33').cellStyle.backColor = '#93C47D';
        break;
      case "Medio":
        sheet.getRangeByName('N34:O34').cellStyle.backColor = '#FFD966';
        break;
      case "Alto":
        sheet.getRangeByName('P34:R34').cellStyle.backColor = '#E06666';
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

    sheet.getRangeByName('G38:J38').merge();
    sheet.getRangeByName('G38').setText("SI ó No");
    sheet.getRangeByName('G38').cellStyle.bold = true;

    sheet.getRangeByName('K38:L38').merge();
    sheet.getRangeByName('K38').setText("Superficie afectada");
    sheet.getRangeByName('K38').cellStyle.bold = true;

    sheet.getRangeByName('M38:P38').merge();
    sheet.getRangeByName('M38').setText("SI ó No");
    sheet.getRangeByName('M38').cellStyle.bold = true;

    sheet.getRangeByName('Q38:R38').merge();
    sheet.getRangeByName('Q38').setText("Superficie afectada");
    sheet.getRangeByName('Q38').cellStyle.bold = true;

    sheet.getRangeByName('C39:F39').merge();
    sheet.getRangeByName('C39').setText("Encuentro esquina muro");
    sheet.getRangeByName('C39').cellStyle.bold = true;

    sheet.getRangeByName('G39:J39').merge();
    sheet.getRangeByName('G39').setText(hojaMuroPrincipal.mh_encEsqMurController.text);

    sheet.getRangeByName('K39:L39').merge();
    sheet.getRangeByName('K39').setText(hojaMuroPrincipal.mh_supencEsqMurController.text);

    sheet.getRangeByName('M39:P39').merge();
    sheet.getRangeByName('M39').setText(hojaMuroPrincipal.df_encEsqMurController.text);

    sheet.getRangeByName('Q39:R39').merge();
    sheet.getRangeByName('Q39').setText(hojaMuroPrincipal.df_supencEsqMurController.text);

    sheet.getRangeByName('C40:F40').merge();
    sheet.getRangeByName('C40').setText("Encuentro cielo muro");
    sheet.getRangeByName('C40').cellStyle.bold = true;

    sheet.getRangeByName('G40:J40').merge();
    sheet.getRangeByName('G40').setText(hojaMuroPrincipal.mh_encCieMurController.text);

    sheet.getRangeByName('K40:L40').merge();
    sheet.getRangeByName('K40').setText(hojaMuroPrincipal.mh_supencCieMurController.text);

    sheet.getRangeByName('M40:P40').merge();
    sheet.getRangeByName('M40').setText(hojaMuroPrincipal.df_encCieMurController.text);

    sheet.getRangeByName('Q40:R40').merge();
    sheet.getRangeByName('Q40').setText(hojaMuroPrincipal.df_supencCieMurController.text);

    sheet.getRangeByName('C41:F41').merge();
    sheet.getRangeByName('C41').setText("Encuentro piso muro");
    sheet.getRangeByName('C41').cellStyle.bold = true;

    sheet.getRangeByName('G41:J41').merge();
    sheet.getRangeByName('G41').setText(hojaMuroPrincipal.mh_encPisMurController.text);

    sheet.getRangeByName('K41:L41').merge();
    sheet.getRangeByName('K41').setText(hojaMuroPrincipal.mh_supencPisMurController.text);

    sheet.getRangeByName('M41:P41').merge();
    sheet.getRangeByName('M41').setText(hojaMuroPrincipal.df_encPisMurController.text);

    sheet.getRangeByName('Q41:R41').merge();
    sheet.getRangeByName('Q41').setText(hojaMuroPrincipal.df_supencPisMurController.text);

    sheet.getRangeByName('C42:F42').merge();
    sheet.getRangeByName('C42').setText("Rasgo de ventana");
    sheet.getRangeByName('C42').cellStyle.bold = true;

    sheet.getRangeByName('G42:J42').merge();
    sheet.getRangeByName('G42').setText(hojaMuroPrincipal.mh_rasgventController.text);

    sheet.getRangeByName('K42:L42').merge();
    sheet.getRangeByName('K42').setText(hojaMuroPrincipal.mh_suprasgventController.text);

    sheet.getRangeByName('M42:P42').merge();
    sheet.getRangeByName('M42').setText(hojaMuroPrincipal.df_rasgventController.text);

    sheet.getRangeByName('Q42:R42').merge();
    sheet.getRangeByName('Q42').setText(hojaMuroPrincipal.df_suprasgventController.text);

    sheet.getRangeByName('C43:F43').merge();
    sheet.getRangeByName('C43').setText("Bajo ventana (antepecho)");
    sheet.getRangeByName('C43').cellStyle.bold = true;

    sheet.getRangeByName('G43:J43').merge();
    sheet.getRangeByName('G43').setText(hojaMuroPrincipal.mh_bajovenController.text);

    sheet.getRangeByName('K43:L43').merge();
    sheet.getRangeByName('K43').setText(hojaMuroPrincipal.mh_supbajovenController.text);

    sheet.getRangeByName('M43:P43').merge();
    sheet.getRangeByName('M43').setText(hojaMuroPrincipal.df_bajovenController.text);

    sheet.getRangeByName('Q43:R43').merge();
    sheet.getRangeByName('Q43').setText(hojaMuroPrincipal.df_supbajovenController.text);

    sheet.getRangeByName('C44:F44').merge();
    sheet.getRangeByName('C44').setText("Área central");
    sheet.getRangeByName('C44').cellStyle.bold = true;

    sheet.getRangeByName('G44:J44').merge();
    sheet.getRangeByName('G44').setText(hojaMuroPrincipal.mh_aCentralController.text);

    sheet.getRangeByName('K44:L44').merge();
    sheet.getRangeByName('K44').setText(hojaMuroPrincipal.mh_supaCentralController.text);

    sheet.getRangeByName('M44:P44').merge();
    sheet.getRangeByName('M44').setText(hojaMuroPrincipal.df_aCentralController.text);

    sheet.getRangeByName('Q44:R44').merge();
    sheet.getRangeByName('Q44').setText(hojaMuroPrincipal.df_supaCentralController.text);

    sheet.getRangeByName('C45:F45').merge();
    sheet.getRangeByName('C45').setText("Puntual localizada y/o extendida");
    sheet.getRangeByName('C45').cellStyle.bold = true;

    sheet.getRangeByName('G45:J45').merge();
    sheet.getRangeByName('G45').setText(hojaMuroPrincipal.mh_punLocController.text);

    sheet.getRangeByName('K45:L45').merge();
    sheet.getRangeByName('K45').setText(hojaMuroPrincipal.mh_suppunLocController.text);

    sheet.getRangeByName('M45:P45').merge();
    sheet.getRangeByName('M45').setText(hojaMuroPrincipal.df_punLocController.text);

    sheet.getRangeByName('Q45:R45').merge();
    sheet.getRangeByName('Q45').setText(hojaMuroPrincipal.df_suppunLocController.text);

    sheet.getRangeByName('C46:F46').merge();
    sheet.getRangeByName('C46').setText("Total superficie de muro afectada");
    sheet.getRangeByName('C46').cellStyle.bold = true;

    sheet.getRangeByName('G46:R46').merge();
    sheet.getRangeByName('G46').setText(hojaMuroPrincipal.totpalsupafecController.text);

    sheet.getRangeByName('C48:R55').cellStyle
      ..borders.all.lineStyle = xlsio.LineStyle.thin
      ..borders.all.color = '#000000';

    sheet.getRangeByName('C48:R55').merge();

    // -------------------------------------------------------------------------
    // IMAGEN
    // -------------------------------------------------------------------------

    if (hojaMuroPrincipal.imgpatol != null && hojaMuroPrincipal.imgpatolGuardada!.existsSync()) {
      try {
        final Uint8List imageBytes = await hojaMuroPrincipal.imgpatolGuardada!.readAsBytes();
        final xlsio.Picture picture = sheet.pictures.addBase64(
          9, // fila
          8, // columna
          base64Encode(imageBytes),
        );
        picture.height = 240;
        picture.width = 450;
      } catch (e) {
        print("⚠️ Error al insertar imagen en hoja $nombreHoja: $e");
      }
    }

    if (hojaMuroPrincipal.imgelev != null && hojaMuroPrincipal.imgelevGuardada!.existsSync()) {
      try {
        final Uint8List imageBytes = await hojaMuroPrincipal.imgelevGuardada!.readAsBytes();
        final xlsio.Picture picture = sheet.pictures.addBase64(
          48, // fila
          8, // columna
          base64Encode(imageBytes),
        );
        picture.height = 160;
        picture.width = 450;
      } catch (e) {
        print("⚠️ Error al insertar imagen en hoja $nombreHoja: $e");
      }
    }

    sheet.showGridlines = false;
    sheet.getRangeByName('A1:S24').rowHeight = 15;
    sheet.getRangeByName('A25:S25').rowHeight = 25;
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

  }) async {
    final sheet = workbook.worksheets.addWithName(nombreHoja);

    // -------------------------------------------------------------------------
    // ENCABEZADO
    // -------------------------------------------------------------------------

    sheet.getRangeByName('B2:R4').cellStyle
      ..borders.all.lineStyle = xlsio.LineStyle.thin
      ..borders.all.color = '#000000';

    sheet.getRangeByName('B2:E4').merge();
    sheet.getRangeByName('B2').setText("Logo Citec");
    sheet.getRangeByName('B2').cellStyle.bold = true;

    sheet.getRangeByName('F2:N4').merge();
    sheet.getRangeByName('F2').setText(
        "PROTOCOLO\nINSPECCIÓN VISUAL DE VIVIENDAS - ACONDICIONAMIENTO AMBIENTAL");
    sheet.getRangeByName('F2').cellStyle.bold = true;

    sheet.getRangeByName('O2:P2').merge();
    sheet.getRangeByName('O3:P3').merge();
    sheet.getRangeByName('O4:P4').merge();
    sheet.getRangeByName('O3').setText("Unidad");
    sheet.getRangeByName('O3').cellStyle.bold = true;

    sheet.getRangeByName('Q2:R2').merge();
    sheet.getRangeByName('Q3:R3').merge();
    sheet.getRangeByName('Q4:R4').merge();
    sheet.getRangeByName('Q3').setText("CITEC UBB");
    sheet.getRangeByName('Q3').cellStyle.bold = true;

    // -------------------------------------------------------------------------
    // DATOS MUROS NORMALES
    // -------------------------------------------------------------------------

    sheet.getRangeByName('B6:R23').cellStyle
      ..borders.all.lineStyle = xlsio.LineStyle.thin
      ..borders.all.color = '#000000';

    sheet.getRangeByName('B6').setText("Item");
    sheet.getRangeByName('B6').cellStyle
      ..bold = true
      ..backColor = '#FFC000';

    sheet.getRangeByName('B7:B44').merge();
    sheet.getRangeByName('B7').setText("5");
    sheet.getRangeByName('B7').cellStyle
      ..bold = true
      ..backColor = '#FFC000';

    sheet.getRangeByName('C6:R6').merge();
    sheet.getRangeByName('C6').setText(
        "Levantamiento de Patologías higrotérmicas");
    sheet.getRangeByName('C6').cellStyle
      ..bold = true
      ..backColor = '#BFBFBF';

    sheet.getRangeByName('C7:R7').merge();
    sheet.getRangeByName('C8:R20').merge();

    sheet.getRangeByName('C21:E21').merge();
    sheet.getRangeByName('C21').setText("MURO EJE");
    sheet.getRangeByName('C21').cellStyle
      ..bold = true
      ..backColor = '#FFE699';

    sheet.getRangeByName('F21').setText(hojaMuro.muroejeController.text);
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

    sheet.getRangeByName('F22').setText(hojaMuro.muroperimetralController.text);

    sheet.getRangeByName('C23:E23').merge();
    sheet.getRangeByName('C23').setText("Muro interior");
    sheet.getRangeByName('C23').cellStyle.bold = true;

    sheet.getRangeByName('F23').setText(hojaMuro.murointController.text);

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
        sheet.getRangeByName('J23:K23').cellStyle.backColor = '#A2C4C9';
        break;
      case "Bajo":
        sheet.getRangeByName('L23:M23').cellStyle.backColor = '#93C47D';
        break;
      case "Medio":
        sheet.getRangeByName('N23:O23').cellStyle.backColor = '#FFD966';
        break;
      case "Alto":
        sheet.getRangeByName('P23:R23').cellStyle.backColor = '#E06666';
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

    sheet.getRangeByName('G27:J27').merge();
    sheet.getRangeByName('G27').setText("SI ó No");
    sheet.getRangeByName('G27').cellStyle.bold = true;

    sheet.getRangeByName('K27:L27').merge();
    sheet.getRangeByName('K27').setText("Superficie afectada");
    sheet.getRangeByName('K27').cellStyle.bold = true;

    sheet.getRangeByName('M27:P27').merge();
    sheet.getRangeByName('M27').setText("SI ó No");
    sheet.getRangeByName('M27').cellStyle.bold = true;

    sheet.getRangeByName('Q27:R27').merge();
    sheet.getRangeByName('Q27').setText("Superficie afectada");
    sheet.getRangeByName('Q27').cellStyle.bold = true;

    sheet.getRangeByName('C28:F28').merge();
    sheet.getRangeByName('C28').setText("Encuentro esquina muro");
    sheet.getRangeByName('C28').cellStyle.bold = true;

    sheet.getRangeByName('G28:J28').merge();
    sheet.getRangeByName('G28').setText(hojaMuro.mh_encEsqMurController.text);

    sheet.getRangeByName('K28:L28').merge();
    sheet.getRangeByName('K28').setText(hojaMuro.mh_supencEsqMurController.text);

    sheet.getRangeByName('M28:P28').merge();
    sheet.getRangeByName('M28').setText(hojaMuro.df_encEsqMurController.text);

    sheet.getRangeByName('Q28:R28').merge();
    sheet.getRangeByName('Q28').setText(hojaMuro.df_supencEsqMurController.text);

    sheet.getRangeByName('C29:F29').merge();
    sheet.getRangeByName('C29').setText("Encuentro cielo muro");
    sheet.getRangeByName('C29').cellStyle.bold = true;

    sheet.getRangeByName('G29:J29').merge();
    sheet.getRangeByName('G29').setText(hojaMuro.mh_encCieMurController.text);

    sheet.getRangeByName('K29:L29').merge();
    sheet.getRangeByName('K29').setText(hojaMuro.mh_supencCieMurController.text);

    sheet.getRangeByName('M29:P29').merge();
    sheet.getRangeByName('M29').setText(hojaMuro.df_encCieMurController.text);

    sheet.getRangeByName('Q29:R29').merge();
    sheet.getRangeByName('Q29').setText(
        hojaMuro.df_supencCieMurController.text);

    sheet.getRangeByName('C30:F30').merge();
    sheet.getRangeByName('C30').setText("Encuentro piso muro");
    sheet.getRangeByName('C30').cellStyle.bold = true;

    sheet.getRangeByName('G30:J30').merge();
    sheet.getRangeByName('G30').setText(hojaMuro.mh_encPisMurController.text);

    sheet.getRangeByName('K30:L30').merge();
    sheet.getRangeByName('K30').setText(
        hojaMuro.mh_supencPisMurController.text);

    sheet.getRangeByName('M30:P30').merge();
    sheet.getRangeByName('M30').setText(hojaMuro.df_encPisMurController.text);

    sheet.getRangeByName('Q30:R30').merge();
    sheet.getRangeByName('Q30').setText(
        hojaMuro.df_supencPisMurController.text);

    sheet.getRangeByName('C31:F31').merge();
    sheet.getRangeByName('C31').setText("Rasgo de ventana");
    sheet.getRangeByName('C31').cellStyle.bold = true;

    sheet.getRangeByName('G31:J31').merge();
    sheet.getRangeByName('G31').setText(hojaMuro.mh_rasgventController.text);

    sheet.getRangeByName('K31:L31').merge();
    sheet.getRangeByName('K31').setText(hojaMuro.mh_suprasgventController.text);

    sheet.getRangeByName('M31:P31').merge();
    sheet.getRangeByName('M31').setText(hojaMuro.df_rasgventController.text);

    sheet.getRangeByName('Q31:R31').merge();
    sheet.getRangeByName('Q31').setText(hojaMuro.df_suprasgventController.text);

    sheet.getRangeByName('C32:F32').merge();
    sheet.getRangeByName('C32').setText("Bajo ventana (antepecho)");
    sheet.getRangeByName('C32').cellStyle.bold = true;

    sheet.getRangeByName('G32:J32').merge();
    sheet.getRangeByName('G32').setText(hojaMuro.mh_bajovenController.text);

    sheet.getRangeByName('K32:L32').merge();
    sheet.getRangeByName('K32').setText(hojaMuro.mh_supbajovenController.text);

    sheet.getRangeByName('M32:P32').merge();
    sheet.getRangeByName('M32').setText(hojaMuro.df_bajovenController.text);

    sheet.getRangeByName('Q32:R32').merge();
    sheet.getRangeByName('Q32').setText(hojaMuro.df_supbajovenController.text);

    sheet.getRangeByName('C33:F33').merge();
    sheet.getRangeByName('C33').setText("Área central");
    sheet.getRangeByName('C33').cellStyle.bold = true;

    sheet.getRangeByName('G33:J33').merge();
    sheet.getRangeByName('G33').setText(hojaMuro.mh_aCentralController.text);

    sheet.getRangeByName('K33:L33').merge();
    sheet.getRangeByName('K33').setText(hojaMuro.mh_supaCentralController.text);

    sheet.getRangeByName('M33:P33').merge();
    sheet.getRangeByName('M33').setText(hojaMuro.df_aCentralController.text);

    sheet.getRangeByName('Q33:R33').merge();
    sheet.getRangeByName('Q33').setText(hojaMuro.df_supaCentralController.text);

    sheet.getRangeByName('C34:F34').merge();
    sheet.getRangeByName('C34').setText("Puntual localizada y/o extendida");
    sheet.getRangeByName('C34').cellStyle.bold = true;

    sheet.getRangeByName('G34:J34').merge();
    sheet.getRangeByName('G34').setText(hojaMuro.mh_punLocController.text);

    sheet.getRangeByName('K34:L34').merge();
    sheet.getRangeByName('K34').setText(hojaMuro.mh_suppunLocController.text);

    sheet.getRangeByName('M34:P34').merge();
    sheet.getRangeByName('M34').setText(hojaMuro.df_punLocController.text);

    sheet.getRangeByName('Q34:R34').merge();
    sheet.getRangeByName('Q34').setText(hojaMuro.df_suppunLocController.text);

    sheet.getRangeByName('C35:F35').merge();
    sheet.getRangeByName('C35').setText("Total superficie de muro afectada");
    sheet.getRangeByName('C35').cellStyle.bold = true;

    sheet.getRangeByName('G35:R35').merge();
    sheet.getRangeByName('G35').setText(hojaMuro.totpalsupafecController.text);


    sheet.getRangeByName('C37:R44').cellStyle
      ..borders.all.lineStyle = xlsio.LineStyle.thin
      ..borders.all.color = '#000000';

    sheet.getRangeByName('C37:R44').merge();



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
        picture.height = 250;
        picture.width = 450;
      } catch (e) {
        print("⚠️ Error al insertar imagen en hoja $nombreHoja: $e");
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
        picture.height = 160;
        picture.width = 450;
      } catch (e) {
        print("⚠️ Error al insertar imagen en hoja $nombreHoja: $e");
      }
    }

    sheet.showGridlines = false;
    sheet.getRangeByName('A1:S45').rowHeight = 15;
    sheet.getRangeByName('A1:S45').columnWidth = 10;
    sheet.getRangeByName('A1:S45').cellStyle
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

    sheet.getRangeByName('B2:R4').cellStyle
      ..borders.all.lineStyle = xlsio.LineStyle.thin
      ..borders.all.color = '#000000';

    sheet.getRangeByName('B2:E4').merge();
    sheet.getRangeByName('B2').setText("Logo Citec");
    sheet.getRangeByName('B2').cellStyle.bold = true;

    sheet.getRangeByName('F2:N4').merge();
    sheet.getRangeByName('F2').setText(
        "PROTOCOLO\nINSPECCIÓN VISUAL DE VIVIENDAS - ACONDICIONAMIENTO AMBIENTAL");
    sheet.getRangeByName('F2').cellStyle.bold = true;

    sheet.getRangeByName('O2:P2').merge();
    sheet.getRangeByName('O3:P3').merge();
    sheet.getRangeByName('O4:P4').merge();
    sheet.getRangeByName('O3').setText("Unidad");
    sheet.getRangeByName('O3').cellStyle.bold = true;

    sheet.getRangeByName('Q2:R2').merge();
    sheet.getRangeByName('Q3:R3').merge();
    sheet.getRangeByName('Q4:R4').merge();
    sheet.getRangeByName('Q3').setText("CITEC UBB");
    sheet.getRangeByName('Q3').cellStyle.bold = true;

    // -------------------------------------------------------------------------
    // DATOS PISO Y CIELO
    // -------------------------------------------------------------------------

    sheet.getRangeByName('B6:R49').cellStyle
      ..borders.all.lineStyle = xlsio.LineStyle.thin
      ..borders.all.color = '#000000';

    sheet.getRangeByName('B6').setText("Item");
    sheet.getRangeByName('B6').cellStyle
      ..bold = true
      ..backColor = '#FFC000';

    sheet.getRangeByName('B7:B79').merge();
    sheet.getRangeByName('B7').setText("5");
    sheet.getRangeByName('B7').cellStyle
      ..bold = true
      ..backColor = '#FFC000';

    sheet.getRangeByName('C6:R6').merge();
    sheet.getRangeByName('C6').setText(
        "Levantamiento de Patologías higrotérmicas");
    sheet.getRangeByName('C6').cellStyle
      ..bold = true
      ..backColor = '#BFBFBF';

    sheet.getRangeByName('C7:R7').merge();
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
        sheet.getRangeByName('J23:K23').cellStyle.backColor = '#A2C4C9';
        break;
      case "Bajo":
        sheet.getRangeByName('L23:M23').cellStyle.backColor = '#93C47D';
        break;
      case "Medio":
        sheet.getRangeByName('N23:O23').cellStyle.backColor = '#FFD966';
        break;
      case "Alto":
        sheet.getRangeByName('P23:R23').cellStyle.backColor = '#E06666';
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

    sheet.getRangeByName('G27:J27').merge();
    sheet.getRangeByName('G27').setText("SI ó No");
    sheet.getRangeByName('G27').cellStyle.bold = true;

    sheet.getRangeByName('K27:L27').merge();
    sheet.getRangeByName('K27').setText("Superficie afectada");
    sheet.getRangeByName('K27').cellStyle.bold = true;

    sheet.getRangeByName('M27:P27').merge();
    sheet.getRangeByName('M27').setText("SI ó No");
    sheet.getRangeByName('M27').cellStyle.bold = true;

    sheet.getRangeByName('Q27:R27').merge();
    sheet.getRangeByName('Q27').setText("Superficie afectada");
    sheet.getRangeByName('Q27').cellStyle.bold = true;

    sheet.getRangeByName('C28:F28').merge();
    sheet.getRangeByName('C28').setText("Perímetro");
    sheet.getRangeByName('C28').cellStyle.bold = true;

    sheet.getRangeByName('G28:J28').merge();
    sheet.getRangeByName('G28').setText(hojaPisoCielo.mh_perimetroPisoController.text);

    sheet.getRangeByName('K28:L28').merge();
    sheet.getRangeByName('K28').setText(hojaPisoCielo.mh_supperimetroPisoController.text);

    sheet.getRangeByName('M28:P28').merge();
    sheet.getRangeByName('M28').setText(hojaPisoCielo.df_perimetroPisoController.text);

    sheet.getRangeByName('Q28:R28').merge();
    sheet.getRangeByName('Q28').setText(hojaPisoCielo.df_supperimetroPisoController.text);

    sheet.getRangeByName('C29:F29').merge();
    sheet.getRangeByName('C29').setText("Área central");
    sheet.getRangeByName('C29').cellStyle.bold = true;

    sheet.getRangeByName('G29:J29').merge();
    sheet.getRangeByName('G29').setText(hojaPisoCielo.mh_aCentralPisoController.text);

    sheet.getRangeByName('K29:L29').merge();
    sheet.getRangeByName('K29').setText(hojaPisoCielo.mh_supaCentralPisoController.text);

    sheet.getRangeByName('M29:P29').merge();
    sheet.getRangeByName('M29').setText(hojaPisoCielo.df_aCentralPisoController.text);

    sheet.getRangeByName('Q29:R29').merge();
    sheet.getRangeByName('Q29').setText(hojaPisoCielo.df_supaCentralPisoController.text);

    sheet.getRangeByName('C30:F30').merge();
    sheet.getRangeByName('C30').setText("Puntual localizada y/o extendida");
    sheet.getRangeByName('C30').cellStyle.bold = true;

    sheet.getRangeByName('G30:J30').merge();
    sheet.getRangeByName('G30').setText(hojaPisoCielo.mh_punlocPisoController.text);

    sheet.getRangeByName('K30:L30').merge();
    sheet.getRangeByName('K30').setText(hojaPisoCielo.mh_supPunlocPisoController.text);

    sheet.getRangeByName('M30:P30').merge();
    sheet.getRangeByName('M30').setText(hojaPisoCielo.df_punlocPisoController.text);

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
        sheet.getRangeByName('J53:K53').cellStyle.backColor = '#A2C4C9';
        break;
      case "Bajo":
        sheet.getRangeByName('L53:M53').cellStyle.backColor = '#93C47D';
        break;
      case "Medio":
        sheet.getRangeByName('N53:O53').cellStyle.backColor = '#FFD966';
        break;
      case "Alto":
        sheet.getRangeByName('P53:R53').cellStyle.backColor = '#E06666';
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

    sheet.getRangeByName('G57:J57').merge();
    sheet.getRangeByName('G57').setText("SI ó No");
    sheet.getRangeByName('G57').cellStyle.bold = true;

    sheet.getRangeByName('K57:L57').merge();
    sheet.getRangeByName('K57').setText("Superficie afectada");
    sheet.getRangeByName('K57').cellStyle.bold = true;

    sheet.getRangeByName('M57:P57').merge();
    sheet.getRangeByName('M57').setText("SI ó No");
    sheet.getRangeByName('M57').cellStyle.bold = true;

    sheet.getRangeByName('Q57:R57').merge();
    sheet.getRangeByName('Q57').setText("Superficie afectada");
    sheet.getRangeByName('Q57').cellStyle.bold = true;

    sheet.getRangeByName('C58:F58').merge();
    sheet.getRangeByName('C58').setText("Perímetro");
    sheet.getRangeByName('C58').cellStyle.bold = true;

    sheet.getRangeByName('G58:J58').merge();
    sheet.getRangeByName('G58').setText(hojaPisoCielo.mh_perimetroCieloController.text);

    sheet.getRangeByName('K58:L58').merge();
    sheet.getRangeByName('K58').setText(hojaPisoCielo.mh_supperimetroCieloController.text);

    sheet.getRangeByName('M58:P58').merge();
    sheet.getRangeByName('M58').setText(hojaPisoCielo.df_perimetroCieloController.text);

    sheet.getRangeByName('Q58:R58').merge();
    sheet.getRangeByName('Q58').setText(hojaPisoCielo.df_supperimetroCieloController.text);

    sheet.getRangeByName('C59:F59').merge();
    sheet.getRangeByName('C59').setText("Área central");
    sheet.getRangeByName('C59').cellStyle.bold = true;

    sheet.getRangeByName('G59:J59').merge();
    sheet.getRangeByName('G59').setText(hojaPisoCielo.mh_aCentralCieloController.text);

    sheet.getRangeByName('K59:L59').merge();
    sheet.getRangeByName('K59').setText(hojaPisoCielo.mh_supaCentralCieloController.text);

    sheet.getRangeByName('M59:P59').merge();
    sheet.getRangeByName('M59').setText(hojaPisoCielo.df_aCentralCieloController.text);

    sheet.getRangeByName('Q59:R59').merge();
    sheet.getRangeByName('Q59').setText(hojaPisoCielo.df_supaCentralCieloController.text);

    sheet.getRangeByName('C60:F60').merge();
    sheet.getRangeByName('C60').setText("Puntual localizada y/o extendida");
    sheet.getRangeByName('C60').cellStyle.bold = true;

    sheet.getRangeByName('G60:J60').merge();
    sheet.getRangeByName('G60').setText(hojaPisoCielo.mh_punlocCieloController.text);

    sheet.getRangeByName('K60:L60').merge();
    sheet.getRangeByName('K60').setText(hojaPisoCielo.mh_supPunlocCieloController.text);

    sheet.getRangeByName('M60:P60').merge();
    sheet.getRangeByName('M60').setText(hojaPisoCielo.df_punlocCieloController.text);

    sheet.getRangeByName('Q60:R60').merge();
    sheet.getRangeByName('Q60').setText(hojaPisoCielo.df_supPunlocCieloController.text);

    sheet.getRangeByName('C61:F61').merge();
    sheet.getRangeByName('C61').setText("Total superficie de piso afectada");
    sheet.getRangeByName('C61').cellStyle.bold = true;

    sheet.getRangeByName('G61:R61').merge();
    sheet.getRangeByName('G61').setText(hojaPisoCielo.totpalsupafecCieloController.text);

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
        print("⚠️ Error al insertar imagen en hoja $nombreHoja: $e");
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
        print("⚠️ Error al insertar imagen en hoja $nombreHoja: $e");
      }
    }

    sheet.showGridlines = false;
    sheet.getRangeByName('A1:S80').rowHeight = 15;
    sheet.getRangeByName('A1:S80').columnWidth = 10;
    sheet.getRangeByName('A1:S80').cellStyle
      ..hAlign = xlsio.HAlignType.center
      ..vAlign = xlsio.VAlignType.center
      ..wrapText = true
      ..fontSize = 12;
  }


  // ---------------------------------------------------------------------------
  // Reiniciar toda la app
  // ---------------------------------------------------------------------------

  void reiniciarApp() {

    imagen_Info_General = null;
    imagenGuardadaInfoGeneral = null;

    for (var controller in [
      nombreArchivoController,
      nFichaController,
      nombreProyectoController,
      tipologiaViviendaController,
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
      reparacionesController,
      detalleReparacionesController,
      ampliacionesController,
      detalleAmpliacionesController,
      obsInfoGeneralController,
      numRecintosController,
      totalHabitantesController,
      nnumAdultosController,
      numMenoresController,
      numAdulMayoresController,
      ocupDiaCompController,
      ocupIntermitenteController,
      densOcupPrevController,
      densOcupRealController,
      obsOcupVivController,
    ]) {
      controller.clear();
    }

    // Restablecer nombres por defecto
    recinto2_nombreController.text = "Recinto 2";
    recinto3_nombreController.text = "Recinto 3";
    r1_murob_nombreController.text = "Muro Eje B";

    // Reiniciar flags
    muro_eje_p_r1 = false;
    muro_eje_b_r1 = false;
    muro_eje_c_r1 = false;
    muro_eje_d_r1 = false;
    piso_cielo_r1 = false;

    // Reiniciar horas y estados
    horaInicio = "00:00";
    horaFin = "00:00";
    rutaGuardada = null;
    guardando = false;

    notifyListeners();
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
    reparacionesController.dispose();
    detalleReparacionesController.dispose();
    ampliacionesController.dispose();
    detalleAmpliacionesController.dispose();
    obsInfoGeneralController.dispose();
    numRecintosController.dispose();
    totalHabitantesController.dispose();
    nnumAdultosController.dispose();
    numMenoresController.dispose();
    numAdulMayoresController.dispose();
    ocupDiaCompController.dispose();
    ocupIntermitenteController.dispose();
    densOcupPrevController.dispose();
    densOcupRealController.dispose();
    obsOcupVivController.dispose();
    nombreArchivoController.dispose();
    nFichaController.dispose();
    recinto1_nombreController.dispose();
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

class HojaMuroPrincipal {
  final String nombre;

  File? imgpatol;
  File? imgpatolGuardada;

  File? imgelev;
  File? imgelevGuardada;

  // Controladores
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
  final TextEditingController muroejeController = TextEditingController();
  final TextEditingController supmuroController = TextEditingController();
  final TextEditingController supventanaController = TextEditingController();
  final TextEditingController muroperimetralController = TextEditingController();
  final TextEditingController murointController = TextEditingController();
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

  HojaMuroPrincipal({required this.nombre});

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
    muroejeController.dispose();
    supmuroController.dispose();
    supventanaController.dispose();
    muroperimetralController.dispose();
    murointController.dispose();
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

class HojaMuro {
  final String nombre;

  File? imgpatol;
  File? imgpatolGuardada;

  File? imgelev;
  File? imgelevGuardada;

  final TextEditingController muroejeController = TextEditingController();
  final TextEditingController supmuroController = TextEditingController();
  final TextEditingController supventanaController = TextEditingController();
  final TextEditingController muroperimetralController = TextEditingController();
  final TextEditingController murointController = TextEditingController();
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
    muroejeController.dispose();
    supmuroController.dispose();
    supventanaController.dispose();
    muroperimetralController.dispose();
    murointController.dispose();
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
