import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import 'package:image_picker/image_picker.dart';

class InformacionGeneral extends StatefulWidget {
  const InformacionGeneral({super.key});

  @override
  State<InformacionGeneral> createState() => _InformacionGeneralState();
}

class _InformacionGeneralState extends State<InformacionGeneral> {
  final GlobalKey canvasKey_InfoGeneral_1 = GlobalKey();
  final GlobalKey canvasKey_InfoGeneral_2 = GlobalKey();
  final GlobalKey canvasKey_InfoGeneral_3 = GlobalKey();
  final GlobalKey canvasKey_InfoGeneral_4 = GlobalKey();

  List<Offset?> _pointsImg1 = [];
  List<Offset?> _pointsImg2 = [];
  List<Offset?> _pointsImg3 = [];
  List<Offset?> _pointsImg4 = [];

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(50),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Title(
              color: Colors.blue,
              child: const Text(
                "Información General",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),


          Text(
            "Plano de la Vivienda:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => appState.obtenerImagenInfoGeneral(
                  fuente: ImageSource.camera,
                  imgnum: 1,
                  onImagenSeleccionada: (img) {
                    setState(() {
                      appState.imagen1_Info_General = img;
                      appState.imagen1GuardadaInfoGeneral = img;
                      appState.cantFotos++;
                      print("HAY UN TOTAL DE " + appState.cantFotos.toString() + " FOTOS");
                    });
                  },
                ),
                icon: Icon(Icons.camera_alt),
                label: Text("Tomar Foto"),
              ),
            ],
          ),

          const SizedBox(height: 15),

          if (appState.imagen1GuardadaInfoGeneral != null) ...[
            Center(
              child: Image.file(
                appState.imagen1GuardadaInfoGeneral!,
                width: 900,
                height: 800,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 15),

            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  await appState.eliminarDibujoInfoGeneral(
                    context: context,
                    imgnum: 1,
                  );
                  setState(() {
                    print("HAY UN TOTAL DE " + appState.cantFotos.toString() + " FOTOS");
                  });

                },
                icon: Icon(Icons.delete),
                label: Text("Eliminar"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ),
          ],

          const SizedBox(height: 30),

          Text(
            "Nombre del proyecto",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.nombreProyectoController,
            decoration: const InputDecoration(
              labelText: "Nombre de Proyecto",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un nombre de proyecto';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          Text(
            "Tipología de Vivienda:" ,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: appState.tipologiaViviendaController,
            decoration: const InputDecoration(
              labelText: "Tipologia de Vivienda",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una tipologia de vivienda';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Dirección:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.direccionController,
            decoration: const InputDecoration(
              labelText: "Dirección",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una dirección';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Etapa:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.etapaController,
            decoration: const InputDecoration(
              labelText: "Etapa",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una etapa';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Superficie de Vivienda:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.supViviendaController,
            decoration: const InputDecoration(
              labelText: "Superficie de Vivienda",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una superficie de vivienda';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Número de Pisos:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.nPisosController,
            decoration: const InputDecoration(
              labelText: "Número de Pisos",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el número de pisos';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Orientación Fachada",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.oriFachadaController,
            decoration: const InputDecoration(
              labelText: "Orientación Fachada",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la orientación de la fachada';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Orientación Acceso",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.oriAccesoController,
            decoration: const InputDecoration(
              labelText: "Orientación del Acceso",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la orienación del acceso';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Clima",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.climaController,
            decoration: const InputDecoration(
              labelText: "Clima",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el clima';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Clima",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: appState.climaController,
            builder: (context, TextEditingValue value, _) {
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(
                      value: 'Soleado',
                      label: Text('Soleado'),
                      icon: Icon(Icons.sunny)
                  ),
                  ButtonSegment(
                      value: 'Parcialmente Nublado',
                      label: Text('Parcialmente Nublado'),
                      icon: Icon(Icons.cloud_queue)
                  ),
                  ButtonSegment(
                      value: 'Nublado',
                      label: Text('Nublado'),
                      icon: Icon(Icons.cloud)
                  ),
                  ButtonSegment(
                      value: 'Lluvioso',
                      label: Text('Lluvioso'),
                      icon: Icon(Icons.cloudy_snowing)
                  ),
                ],
                selected: {value.text},
                onSelectionChanged: (Set<String> newSelection) {
                  appState.climaController.text = newSelection.first;
                },
              );
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Temperatuta Exterior",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.tempExteriorController,
            decoration: const InputDecoration(
              labelText: "Temperatuta Exterior",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la temperatura exterior';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Humedad Exterior",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.humExteriorController,
            decoration: const InputDecoration(
              labelText: "Humedad Exterior",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el % de humedad exterior';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Temperatura Interior:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.tempInteriorController,
            decoration: const InputDecoration(
              labelText: "Temperatura Interior",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la temperatura interior';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Humedad Interior:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.humInteriorController,
            decoration: const InputDecoration(
              labelText: "Humedad Interior",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el % de humedad interior';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Recibido por:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.reciPorController,
            decoration: const InputDecoration(
              labelText: "Recibido por",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese quien es la persona que lo recibió';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Nombre de la persona que lo recibió",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.nombreReciController,
            decoration: const InputDecoration(
              labelText: "Nombre de la persona que lo recibió",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el nombre de la persona que lo recibió';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Años de uso de la vivienda:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.usoViviendaController,
            decoration: const InputDecoration(
              labelText: "Años de uso de la vivienda",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese los años de uso de la vivienda ';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Nombre Inspector:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.nombreInspectorController,
            decoration: const InputDecoration(
              labelText: "Nombre de Inspector",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el nombre del inspector';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Rut Inspector",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.reciPorController,
            decoration: const InputDecoration(
              labelText: "Rut Inspector",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el Rut del inspector';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Reparaciones",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.reparacionesController,
            decoration: const InputDecoration(
              labelText: "Reparaciones",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese reparaciones';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Reparaciones",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: appState.reparacionesController,
            builder: (context, TextEditingValue value, _) {
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  appState.reparacionesController.text = newSelection.first;
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                        (states) {
                      if (states.contains(WidgetState.selected)) {
                        return seleccion == 'No' ? Colors.red : Colors.green;
                      }
                      return Colors.grey.shade300;
                    },
                  ),
                  foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                        (states) => states.contains(WidgetState.selected)
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 10),

          Text(
            "¿Cuántas y de qué tipo?",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.detalleReparacionesController,
            decoration: const InputDecoration(
              labelText: "Detalles de reparaciones",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese detalles de las reparaciones';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Ampliaciones",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.ampliacionesController,
            decoration: const InputDecoration(
              labelText: "",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese si existen ampliaciones';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Ampliaciones",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),


          ValueListenableBuilder(
            valueListenable: appState.ampliacionesController,
            builder: (context, TextEditingValue value, _) {
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  appState.ampliacionesController.text = newSelection.first;
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                        (states) {
                      if (states.contains(WidgetState.selected)) {
                        return seleccion == 'No' ? Colors.red : Colors.green;
                      }
                      return Colors.grey.shade300;
                    },
                  ),
                  foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                        (states) => states.contains(WidgetState.selected)
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              );
            },
          ),


          const SizedBox(height: 10),

          Text(
            "¿Cuántas y de qué tipo?",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.detalleAmpliacionesController,
            decoration: const InputDecoration(
              labelText: "Detalles de ampliaciones",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese los detalles de las ampliaciones';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Observación:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.obsInfoGeneralController,
            decoration: const InputDecoration(
              labelText: "Observación",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una observacion';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "N° de recintos vivienda",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.numRecintosController,
            decoration: const InputDecoration(
              labelText: "N° de recintos vivienda",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un número de recintos';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Total número de habitantes:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.totalHabitantesController,
            decoration: const InputDecoration(
              labelText: "Total número de habitantes",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un total de habitantes';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Adultos:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.nnumAdultosController,
            decoration: const InputDecoration(
              labelText: "Numero de Adultos",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese na cantidad de adultos';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Niños en edad escolar:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.numMenoresController,
            decoration: const InputDecoration(
              labelText: "Niños en edad escolar",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una cantidad de niños en edad escolar';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Adultos mayores:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.numAdulMayoresController,
            decoration: const InputDecoration(
              labelText: "Adultos mayores",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una cantidad de adultos mayores';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Ocupacion dia completo:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.ocupDiaCompController,
            decoration: const InputDecoration(
              labelText: "Ocupacion dia completo",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una ocupacion de dia completo';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Ocupacion intermitente:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.ocupIntermitenteController,
            decoration: const InputDecoration(
              labelText: "Ocupacion intermitente",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una ocupacion intermitente';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Denegacion de ocupacion prevista:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.densOcupPrevController,
            decoration: const InputDecoration(
              labelText: "Densidad de ocupacion prevista",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una densidad de ocupacion prevista';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Densidad de ocupacion real:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.densOcupRealController,
            decoration: const InputDecoration(
              labelText: "Densidad de ocupacion real",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una densidad de ocupacion real';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Observaciones de ocupacion de vivienda:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.obsOcupVivController,
            decoration: const InputDecoration(
              labelText: "obsservaciones de ocupacion de vivienda",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una observacion';
              }
              return null;
            },
          ),

          const SizedBox(height: 35),


          // -------------------------------------------------------------------
          // SECCIÓN DE FOTO 2
          // -------------------------------------------------------------------
          Text(
          "Fotografía 2:",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => appState.obtenerImagenInfoGeneral(
                  fuente: ImageSource.camera,
                  imgnum: 2,
                  onImagenSeleccionada: (img) {
                    setState(() {
                      appState.imagen2_Info_General = img;
                      appState.imagen2GuardadaInfoGeneral = null;
                      print("Se tomo la foto 2 y se guardon en: " + appState.imagen1_Info_General!.path.toString());
                      _pointsImg2.clear();
                    });
                  },
                ),
                icon: Icon(Icons.camera_alt),
                label: Text("Tomar Foto"),
              ),
            ],
          ),

          const SizedBox(height: 20),

         // -------------------------------------------------------------------
         // SECCIÓN DIBUJO
         // -------------------------------------------------------------------

          if (appState.imagen2_Info_General != null && appState.imagen2GuardadaInfoGeneral == null) ...[
            Text(
              "Dibuja observaciones sobre la imagen:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Center(
              child: RepaintBoundary(
                key: canvasKey_InfoGeneral_2,
                child: Container(
                  width: 900,
                  height: 800,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    image: DecorationImage(
                      image: FileImage(appState.imagen2_Info_General!),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return GestureDetector(
                        onPanUpdate: (details) {
                          setState(() {
                            final RenderBox box = context.findRenderObject() as RenderBox;
                            final localPosition = box.globalToLocal(details.globalPosition);
                            if (localPosition.dx >= 0 &&
                              localPosition.dx <= constraints.maxWidth &&
                              localPosition.dy >= 0 &&
                              localPosition.dy <= constraints.maxHeight) {
                              _pointsImg2 = List.from(_pointsImg2)..add(localPosition);
                            }
                          });
                        },
                        onPanEnd: (_) => setState(() => _pointsImg2.add(null)),
                        child: CustomPaint(
                          painter: DibujoPainter(_pointsImg2),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Center(
              child: ElevatedButton.icon(
                icon: Icon(Icons.save),
                label: Text("Guardar Dibujo"),
                onPressed: () async {
                  await appState.guardarDibujoInfoGeneral(
                    canvasKey: canvasKey_InfoGeneral_2,
                    imgnum: 2,
                    nombreArchivo: "Imagen2_Info_General",
                    onGuardado: (file) {
                      setState(() {
                        appState.imagen2GuardadaInfoGeneral = file;
                        appState.cantFotos++;
                        print("HAY UN TOTAL DE " + appState.cantFotos.toString() + " FOTOS");
                        _pointsImg2.clear();
                      });
                    },
                    context: context,
                  );
                },
              ),
            ),
          ],

          const SizedBox(height: 20),

          // -------------------------------------------------------------------
          // SECCIÓN RESULTADO (IMAGEN GUARDADA)
          // -------------------------------------------------------------------

          if (appState.imagen2GuardadaInfoGeneral != null) ...[
            Text(
              "Imagen 2 guardada:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Center(
              child: Image.file(
                appState.imagen2GuardadaInfoGeneral!,
                width: 900,
                height: 800,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 15),

            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  await appState.eliminarDibujoInfoGeneral(
                    context: context,
                    imgnum: 2,
                  );
                  setState(() {
                    print("HAY UN TOTAL DE " + appState.cantFotos.toString() + " FOTOS");
                    _pointsImg2.clear();
                  });
                },
                icon: Icon(Icons.delete),
                label: Text("Eliminar dibujo"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ),

          ],
        ],
      ),
    );
  }
}
