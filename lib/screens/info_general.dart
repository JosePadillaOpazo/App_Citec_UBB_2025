import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

          const SizedBox(height: 20),

          if (appState.imagen1GuardadaInfoGeneral != null) ...[
            Center(
              child: Image.file(
                appState.imagen1GuardadaInfoGeneral!,
                width: 900,
                height: 800,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 20),

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
            "ℹ️ Informacion General del Proyecto",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Nombre del proyecto",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),

              Text(
                " *",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red),
              ),

              IconButton(
                icon: Icon(Icons.info_rounded),
                color: Colors.grey,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Campos obligatorios"),
                        content: Text("El símbolo * indica los campos obligatorios."),
                        actions: [
                          ElevatedButton(
                            child: Text("Aceptar"),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),


          TextFormField(
            controller: appState.nombreProyectoController,
            decoration: const InputDecoration(
              labelText: "Nombre de Proyecto",
              border: OutlineInputBorder(),
            ),
            enableInteractiveSelection: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ, ]'),
              ),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un nombre de proyecto';
              }
              if (!RegExp(r'^[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ, ]+$').hasMatch(value)) {
                return 'Solo se permiten letras, números y comas';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Tipología de Vivienda:" ,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.tipologiaViviendaController,
            decoration: const InputDecoration(
              labelText: "Tipologia de Vivienda",
              border: OutlineInputBorder(),
            ),
            enableInteractiveSelection: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ, ]'),
              ),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un nombre de proyecto';
              }
              if (!RegExp(r'^[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ, ]+$').hasMatch(value)) {
                return 'Solo se permiten letras, números y comas';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Dirección",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),

              Text(
                " *",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red),
              ),

              IconButton(
                icon: Icon(Icons.info),
                color: Colors.grey,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Campos obligatorios"),
                        content: Text("La dirección es utilizada para nombrar el archivo al guardar."),
                        actions: [
                          ElevatedButton(
                            child: Text("Aceptar"),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),

          TextFormField(
            controller: appState.direccionController,
            decoration: const InputDecoration(
              labelText: "Dirección",
              border: OutlineInputBorder(),
            ),
            enableInteractiveSelection: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ, ]'),
              ),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un nombre de proyecto';
              }
              if (!RegExp(r'^[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ,# ]+$').hasMatch(value)) {
                return 'Solo se permiten letras, números y comas';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

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
            enableInteractiveSelection: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ, ]'),
              ),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un nombre de proyecto';
              }
              if (!RegExp(r'^[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ, ]+$').hasMatch(value)) {
                return 'Solo se permiten letras, números y comas';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Superficie de Vivienda (m²)",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.supViviendaController,
            decoration: const InputDecoration(
              labelText: "Superficie de Vivienda",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$')),
            ],
            enableInteractiveSelection: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una superficie';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

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
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*$')),
            ],
            enableInteractiveSelection: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una superficie';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Orientación Fachada",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          DropdownButtonFormField<String>(
            value: appState.oriFachadaController.text.isEmpty
              ? null
              : appState.oriFachadaController.text,
            decoration: const InputDecoration(
              labelText: "Orientación de fachada",
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: "Norte", child: Text("Norte")),
              DropdownMenuItem(value: "Sur", child: Text("Sur")),
              DropdownMenuItem(value: "Este", child: Text("Este")),
              DropdownMenuItem(value: "Oeste", child: Text("Oeste")),
              DropdownMenuItem(value: "Noreste", child: Text("Noreste")),
              DropdownMenuItem(value: "Noroeste", child: Text("Noroeste")),
              DropdownMenuItem(value: "Sureste", child: Text("Sureste")),
              DropdownMenuItem(value: "Suroeste", child: Text("Suroeste")),
            ],
            onChanged: (value) {
              if (value != null) {
                appState.oriFachadaController.text = value;
              }
            },
            validator: (value) {
              if (appState.oriFachadaController.text.isEmpty) {
                return "Seleccione una orientación";
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Informacion adicional de Orientación Fachada",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: appState.oriFachadaController,
            builder: (context, value, _) {
              final estaSeleccionado = value.text.isNotEmpty;

              return TextFormField(
                controller: appState.oriFachadainfoController,
                enabled: estaSeleccionado,
                enableInteractiveSelection: false,
                decoration: const InputDecoration(
                  labelText: "Ingrese información como grados, etc",
                  border: OutlineInputBorder(),
                ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ, °]'),
                    ),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la informacion pertinente';
                    }
                    if (!RegExp(r'^[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ, °]+$').hasMatch(value)) {
                      return 'Solo se permiten letras, números y comas';
                    }
                    return null;
                  }
              );
            },
          ),



          const SizedBox(height: 20),

          Text(
            "Orientación Acceso",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          DropdownButtonFormField<String>(
            value: appState.oriAccesoController.text.isEmpty
                ? null
                : appState.oriAccesoController.text,
            decoration: const InputDecoration(
              labelText: "Orientación de acceso",
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: "Norte", child: Text("Norte")),
              DropdownMenuItem(value: "Sur", child: Text("Sur")),
              DropdownMenuItem(value: "Este", child: Text("Este")),
              DropdownMenuItem(value: "Oeste", child: Text("Oeste")),
              DropdownMenuItem(value: "Noreste", child: Text("Noreste")),
              DropdownMenuItem(value: "Noroeste", child: Text("Noroeste")),
              DropdownMenuItem(value: "Sureste", child: Text("Sureste")),
              DropdownMenuItem(value: "Suroeste", child: Text("Suroeste")),
            ],
            onChanged: (value) {
              if (value != null) {
                appState.oriAccesoController.text = value;
              }
            },
            validator: (value) {
              if (appState.oriAccesoController.text.isEmpty) {
                return "Seleccione una orientación";
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Informacion adicional de Orientación Acceso",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: appState.oriAccesoController,
            builder: (context, value, _) {
              final estaSeleccionado = value.text.isNotEmpty;

              return TextFormField(
                controller: appState.oriAccesoinfoController,
                enabled: estaSeleccionado,
                enableInteractiveSelection: false,
                decoration: const InputDecoration(
                  labelText: "Ingrese información como grados, etc",
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ, °]'),
                  ),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la informacion pertinente';
                  }
                  if (!RegExp(r'^[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ, °]+$').hasMatch(value)) {
                    return 'Solo se permiten letras, números y comas';
                  }
                  return null;
                }
              );
            },
          ),

          const SizedBox(height: 20),

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

          const SizedBox(height: 20),

          Text(
            "Temperatuta Exterior: (°C)",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.tempExteriorController,
            decoration: const InputDecoration(
              labelText: "Temperatuta Exterior",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$')),
            ],
            enableInteractiveSelection: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la información requerida';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Humedad Exterior: (%)",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.humExteriorController,
            decoration: const InputDecoration(
              labelText: "Humedad Exterior",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$')),
            ],
            enableInteractiveSelection: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la información requerida';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Temperatura Interior: (°C)",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.tempInteriorController,
            decoration: const InputDecoration(
              labelText: "Temperatura Interior",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$')),
            ],
            enableInteractiveSelection: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la información requerida';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Humedad Interior: (%)",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.humInteriorController,
            decoration: const InputDecoration(
              labelText: "Humedad Interior",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$')),
            ],
            enableInteractiveSelection: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la información requerida';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

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
            enableInteractiveSelection: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚñÑ ]'),
              ),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la información requerida';
              }
              if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]+$').hasMatch(value)) {
                return 'Solo se permiten letras y espacios';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

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
            enableInteractiveSelection: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚñÑ ]'),
              ),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un nombre';
              }
              if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]+$').hasMatch(value)) {
                return 'Solo se permiten letras y espacios';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

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
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$')),
            ],
            enableInteractiveSelection: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una cantidad de años';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

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
            enableInteractiveSelection: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚñÑ ]'),
              ),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un nombre';
              }
              if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]+$').hasMatch(value)) {
                return 'Solo se permiten letras y espacios';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Rut Inspector (ej: 12345678-9)",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.reciPorController,
            decoration: const InputDecoration(
              labelText: "RUT Inspector",
              border: OutlineInputBorder(),
            ),
            enableInteractiveSelection: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[0-9kK.\-]'),
              ),
            ],
            validator: appState.validarRut,
          ),

          const SizedBox(height: 20),

          Text(
            "Reparaciones",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: appState.reparacionesController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                appState.reparacionesController.text = "No";
              }
              final seleccion = appState.reparacionesController.text;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(value: 'Si', label: Text('Sí')),
                      ButtonSegment(value: 'No', label: Text('No')),
                    ],
                    selected: {seleccion},
                    onSelectionChanged: (Set<String> newSelection) {
                      appState.reparacionesController.text = newSelection.first;
                      if (newSelection.first != 'Si') {
                        appState.detalleReparacionesController.clear();
                      }
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
                  ),
                  const SizedBox(height: 10),

                  Text(
                    "¿Cuántas y de qué tipo?",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  TextFormField(
                    controller: appState.detalleReparacionesController,
                    enabled: seleccion == 'Si',
                    decoration: const InputDecoration(
                      labelText: "Detalles de reparaciones",
                      border: OutlineInputBorder(),
                    ),
                    enableInteractiveSelection: false,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ, ]'),
                      ),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese los detalles de Reparaciones';
                      }
                      if (!RegExp(r'^[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ, ]+$').hasMatch(value)) {
                        return 'Solo se permiten letras, números y comas';
                      }
                      return null;
                    },
                  ),

                ],
              );
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Ampliaciones",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: appState.ampliacionesController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                appState.ampliacionesController.text = "No";
              }
              final seleccion = appState.ampliacionesController.text;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(value: 'Si', label: Text('Sí')),
                      ButtonSegment(value: 'No', label: Text('No')),
                    ],
                    selected: {seleccion},
                    onSelectionChanged: (Set<String> newSelection) {
                      appState.ampliacionesController.text = newSelection.first;
                      if (newSelection.first != 'Si') {
                        appState.detalleAmpliacionesController.clear();
                      }
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
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "¿Cuántas y de qué tipo?",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  TextFormField(
                    controller: appState.detalleAmpliacionesController,
                    enabled: seleccion == 'Si',
                    decoration: const InputDecoration(
                      labelText: "Detalles de Amplaciones",
                      border: OutlineInputBorder(),
                    ),
                    enableInteractiveSelection: false,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ, ]'),
                      ),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese los detalles de Amplaciones';
                      }
                      if (!RegExp(r'^[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ, ]+$').hasMatch(value)) {
                        return 'Solo se permiten letras, números y comas';
                      }
                      return null;
                    },
                  ),

                ],
              );
            },
          ),


          const SizedBox(height: 20),

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
            enableInteractiveSelection: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ, ]'),
              ),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese observación';
              }
              if (!RegExp(r'^[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ, ]+$').hasMatch(value)) {
                return 'Solo se permiten letras, números y comas';
              }
              return null;
            },
          ),

          const SizedBox(height: 40),

          Text(
            "🏠 Informacion de Ocupacion Vivienda",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

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
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*$')),
            ],
            enableInteractiveSelection: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el N° de recintos vivienda';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

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
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*$')),
            ],
            enableInteractiveSelection: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el Total número de habitantes';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

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
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*$')),
            ],
            enableInteractiveSelection: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la cantidad de Adultos';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

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
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*$')),
            ],
            enableInteractiveSelection: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la cantidad de Niños en edad escolar';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

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
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*$')),
            ],
            enableInteractiveSelection: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la cantidad de Adultos Mayores';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Ocupación todo el día:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.ocupDiaCompController,
            decoration: const InputDecoration(
              labelText: "Ocupación todo el día",
              border: OutlineInputBorder(),
            ),
            enableInteractiveSelection: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ,:/ ]'),
              ),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la Ocupación todo el día';
              }
              if (!RegExp(r'^[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ,:/ ]+$').hasMatch(value)) {
                return 'Solo se permiten letras, números y comas';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Ocupación intermitente:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.ocupIntermitenteController,
            decoration: const InputDecoration(
              labelText: "Ocupación intermitente",
              border: OutlineInputBorder(),
            ),
            enableInteractiveSelection: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ,:/ ]'),
              ),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la ocupacion intermitente';
              }
              if (!RegExp(r'^[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ,:/ ]+$').hasMatch(value)) {
                return 'Solo se permiten letras, números y comas';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Densidad ocupacional prevista:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.densOcupPrevController,
            decoration: const InputDecoration(
              labelText: "Densidad ocupacional prevista",
              border: OutlineInputBorder(),
            ),
            enableInteractiveSelection: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ,:/ ]'),
              ),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la Densidad ocupacional prevista';
              }
              if (!RegExp(r'^[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ,:/ ]+$').hasMatch(value)) {
                return 'Solo se permiten letras, números y comas';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Densidad ocupacional real:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.densOcupRealController,
            decoration: const InputDecoration(
              labelText: "Densidad ocupacional real",
              border: OutlineInputBorder(),
            ),
            enableInteractiveSelection: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ,:/ ]'),
              ),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la Densidad ocupacional real';
              }
              if (!RegExp(r'^[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ,:/ ]+$').hasMatch(value)) {
                return 'Solo se permiten letras, números y comas';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Observaciones de ocupación de vivienda:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.obsOcupVivController,
            decoration: const InputDecoration(
              labelText: "Observaciones de ocupación de vivienda",
              border: OutlineInputBorder(),
            ),
            enableInteractiveSelection: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ,:/ ]'),
              ),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese obbservaciones de ser necesario';
              }
              if (!RegExp(r'^[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ,:/ ]+$').hasMatch(value)) {
                return 'Solo se permiten letras, números y comas';
              }
              return null;
            },
          ),

          const SizedBox(height: 40),

          Text(
            "📷 Identificación tipología de vivienda ",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 30),


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
                      print("Se tomo la foto 2 y se guardon en: " + appState.imagen2_Info_General!.path.toString());
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










          // -------------------------------------------------------------------
          // SECCIÓN DE FOTO 3
          // -------------------------------------------------------------------

          Text(
            "Fotografía 3:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => appState.obtenerImagenInfoGeneral(
                  fuente: ImageSource.camera,
                  imgnum: 3,
                  onImagenSeleccionada: (img) {
                    setState(() {
                      appState.imagen3_Info_General = img;
                      appState.imagen3GuardadaInfoGeneral = null;
                      print("Se tomo la foto 3 y se guardon en: " + appState.imagen3_Info_General!.path.toString());
                      _pointsImg3.clear();
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

          if (appState.imagen3_Info_General != null && appState.imagen3GuardadaInfoGeneral == null) ...[
            Text(
              "Dibuja observaciones sobre la imagen:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Center(
              child: RepaintBoundary(
                key: canvasKey_InfoGeneral_3,
                child: Container(
                  width: 900,
                  height: 800,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    image: DecorationImage(
                      image: FileImage(appState.imagen3_Info_General!),
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
                              _pointsImg3 = List.from(_pointsImg3)..add(localPosition);
                            }
                          });
                        },
                        onPanEnd: (_) => setState(() => _pointsImg3.add(null)),
                        child: CustomPaint(
                          painter: DibujoPainter(_pointsImg3),
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
                    canvasKey: canvasKey_InfoGeneral_3,
                    imgnum: 3,
                    nombreArchivo: "Imagen3_Info_General",
                    onGuardado: (file) {
                      setState(() {
                        appState.imagen3GuardadaInfoGeneral = file;
                        appState.cantFotos++;
                        print("HAY UN TOTAL DE " + appState.cantFotos.toString() + " FOTOS");
                        _pointsImg3.clear();
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

          if (appState.imagen3GuardadaInfoGeneral != null) ...[
              Text(
                "Imagen 3 guardada:",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
             ),

            const SizedBox(height: 10),

            Center(
              child: Image.file(
                appState.imagen3GuardadaInfoGeneral!,
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
                    imgnum: 3,
                  );
                  setState(() {
                    print("HAY UN TOTAL DE " + appState.cantFotos.toString() + " FOTOS");
                    _pointsImg3.clear();
                  });
                },
                icon: Icon(Icons.delete),
                label: Text("Eliminar dibujo"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ),
          ],







          // -------------------------------------------------------------------
          // SECCIÓN DE FOTO 4
          // -------------------------------------------------------------------


          Text(
            "Fotografía 4:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => appState.obtenerImagenInfoGeneral(
                  fuente: ImageSource.camera,
                  imgnum: 4,
                  onImagenSeleccionada: (img) {
                    setState(() {
                      appState.imagen4_Info_General = img;
                      appState.imagen4GuardadaInfoGeneral = null;
                      print("Se tomo la foto 4 y se guardon en: " + appState.imagen4_Info_General!.path.toString());
                      _pointsImg4.clear();
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

          if (appState.imagen4_Info_General != null && appState.imagen4GuardadaInfoGeneral == null) ...[
            Text(
              "Dibuja observaciones sobre la imagen:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Center(
              child: RepaintBoundary(
                key: canvasKey_InfoGeneral_4,
                child: Container(
                  width: 900,
                  height: 800,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    image: DecorationImage(
                      image: FileImage(appState.imagen4_Info_General!),
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
                              _pointsImg4 = List.from(_pointsImg4)..add(localPosition);
                            }
                          });
                        },
                        onPanEnd: (_) => setState(() => _pointsImg4.add(null)),
                        child: CustomPaint(
                          painter: DibujoPainter(_pointsImg4),
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
                    canvasKey: canvasKey_InfoGeneral_4,
                    imgnum: 4,
                    nombreArchivo: "Imagen4_Info_General",
                    onGuardado: (file) {
                      setState(() {
                        appState.imagen4GuardadaInfoGeneral = file;
                        appState.cantFotos++;
                        print("HAY UN TOTAL DE " + appState.cantFotos.toString() + " FOTOS");
                        _pointsImg4.clear();
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

          if (appState.imagen4GuardadaInfoGeneral != null) ...[
            Text(
              "Imagen 4 guardada:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Center(
              child: Image.file(
                appState.imagen4GuardadaInfoGeneral!,
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
                    imgnum: 4,
                  );
                  setState(() {
                    print("HAY UN TOTAL DE " + appState.cantFotos.toString() + " FOTOS");
                    _pointsImg4.clear();
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
