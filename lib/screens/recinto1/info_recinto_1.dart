import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/app_state.dart';
import 'package:image_picker/image_picker.dart';

class Info_Recinto_1 extends StatefulWidget {
  const Info_Recinto_1({super.key});

  @override
  State<Info_Recinto_1> createState() => _Info_Recinto_1();
}

class _Info_Recinto_1 extends State<Info_Recinto_1> {
  GlobalKey canvaskeyImg1_Murop_R1 = GlobalKey();

  List<Offset?> _pointsImg1_PR1 = [];

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final recintoActual = appState.obtenerRecinto("Recinto 1");


    return SingleChildScrollView(
      padding: const EdgeInsets.all(50),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Información de " + appState.recinto1_nombreController.text,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, decoration: TextDecoration.underline,),
                ),

              ]
            )
          ),


          const SizedBox(height: 40),

          Text(
            "🛠️  Patologias y Modificaciones",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Text(
            "¿Presenta patologías visibles?",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: recintoActual.patvisibleController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                recintoActual.patvisibleController.text = "No";
              }
              final seleccion = recintoActual.patvisibleController.text;
              return SegmentedButton<String>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  recintoActual.patvisibleController.text = newSelection.first;
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
            "Manifestaciones ocultas ¿fue pintado o limpiado últimamente?",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: recintoActual.pinOlimpController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                recintoActual.pinOlimpController.text = "No";
              }
              final seleccion = recintoActual.pinOlimpController.text;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SegmentedButton<String>(
                    showSelectedIcon: false,
                    segments: const [
                      ButtonSegment(value: 'Si', label: Text('Sí')),
                      ButtonSegment(value: 'No', label: Text('No')),
                    ],
                    selected: {seleccion},
                    onSelectionChanged: (Set<String> newSelection) {
                      recintoActual.pinOlimpController.text = newSelection.first;
                      if (newSelection.first != 'Si') {
                        recintoActual.cualpolController.clear();
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
                    "¿Cual?",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  TextFormField(
                    controller: recintoActual.cualpolController,
                    enabled: seleccion == 'Si',
                    decoration: const InputDecoration(
                      labelText: "Detalles de Manifestaciones Ocultas",
                      border: OutlineInputBorder(),
                    ),
                    enableInteractiveSelection: false,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ, ]'),
                      ),
                      PegarDisabled(),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese la información reuqerida';
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

          const SizedBox(height: 10),

          Text(
            "¿Olor a humedad?",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: recintoActual.olorhumController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                recintoActual.olorhumController.text = "No";
              }
              final seleccion = recintoActual.olorhumController.text;
              return SegmentedButton<String>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  recintoActual.olorhumController.text = newSelection.first;
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
            "¿Modificaciones?",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: recintoActual.modifController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                recintoActual.modifController.text = "No";
              }
              final seleccion = recintoActual.modifController.text;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SegmentedButton<String>(
                    showSelectedIcon: false,
                    segments: const [
                      ButtonSegment(value: 'Si', label: Text('Sí')),
                      ButtonSegment(value: 'No', label: Text('No')),
                    ],
                    selected: {seleccion},
                    onSelectionChanged: (Set<String> newSelection) {
                      recintoActual.modifController.text = newSelection.first;
                      if (newSelection.first != 'Si') {
                        recintoActual.cualmodController.clear();
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
                    "¿Cuál?",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  TextFormField(
                    controller: recintoActual.cualmodController,
                    enabled: seleccion == 'Si',
                    decoration: const InputDecoration(
                      labelText: "Detalles de Manifestaciones Ocultas",
                      border: OutlineInputBorder(),
                    ),
                    enableInteractiveSelection: false,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ, ]'),
                      ),
                      PegarDisabled(),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese la información reuqerida';
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

          const SizedBox(height: 40),

          Text(
            "♨️  Calefacción",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Text(
            "Sistema de Calefacción",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: recintoActual.sistcalefController,
            builder: (context, TextEditingValue value, _) {
              final seleccion = value.text.isEmpty ? null : value.text;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    isExpanded: true, // 🔑 CLAVE
                    value: seleccion,
                    decoration: const InputDecoration(
                      labelText: 'Sistema de calefacción',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Eléctrico (seca)',
                        child: Text(
                          'Eléctrico (seca)',
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Gas / parafina con evacuación exterior (seca)',
                        child: Text(
                          'Gas / parafina con evacuación exterior (seca)',
                          softWrap: true,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Biomasa con evacuación exterior (seca)',
                        child: Text(
                          'Biomasa con evacuación exterior (seca)',
                          softWrap: true,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Parafina/gas móvil (húmeda)',
                        child: Text(
                          'Parafina/gas móvil (húmeda)',
                          softWrap: true,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Otro ¿cuál?',
                        child: Text(
                          'Otro ¿cuál?',
                          softWrap: true,
                        ),
                      ),
                    ],
                    onChanged: (newValue) {
                      if (newValue == null) return;
                      recintoActual.sistcalefController.text = newValue;
                      if (newValue != 'Otro ¿cuál?') {
                        recintoActual.otrocalefController.clear();
                      }
                    },
                  ),


                  const SizedBox(height: 10),

                  Text(
                    "¿Cuál?",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  TextFormField(
                    controller: recintoActual.otrocalefController,
                    enabled: value.text == 'Otro ¿cuál?',
                    decoration: const InputDecoration(
                      labelText: "Detalle",
                      border: OutlineInputBorder(),
                    ),
                    enableInteractiveSelection: false,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ, ]'),
                      ),
                      PegarDisabled(),
                    ],
                    validator: (campo) {
                      if (value.text == 'Otro ¿cuál?' &&
                          (campo == null || campo.isEmpty)) {
                        return 'Por favor ingrese la información requerida';
                      }
                      return null;
                    },
                  ),
                ],
              );
            },
          ),



          const SizedBox(height: 10),

          Text(
            "¿Cuánto tiempo calefacciona? (Hrs)",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: recintoActual.tiemcalefController,
            decoration: const InputDecoration(
              labelText: "Tiempo",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$')),
              PegarDisabled(),
            ],
            enableInteractiveSelection: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la información requerida';
              }
              return null;
            },
          ),

          const SizedBox(height: 40),

          Text(
            "𖣘 Sistema de ventilación",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Text(
            "Aireador",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: recintoActual.aireadorController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                recintoActual.aireadorController.text = "No Operativo";
              }
              final seleccion = recintoActual.aireadorController.text;
              return SegmentedButton<String>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(value: 'Operativo', label: Text('Operativo')),
                  ButtonSegment(value: 'No Operativo', label: Text('No Operativo')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  recintoActual.aireadorController.text = newSelection.first;
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                        (states) {
                      if (states.contains(WidgetState.selected)) {
                        return seleccion == 'No Operativo' ? Colors.red : Colors.green;
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
            "Extractor",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: recintoActual.extractorController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                recintoActual.extractorController.text = "No Operativo";
              }
              final seleccion = recintoActual.extractorController.text;
              return SegmentedButton<String>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(value: 'Operativo', label: Text('Operativo')),
                  ButtonSegment(value: 'No Operativo', label: Text('No Operativo')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  recintoActual.extractorController.text = newSelection.first;
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                        (states) {
                      if (states.contains(WidgetState.selected)) {
                        return seleccion == 'No Operativo' ? Colors.red : Colors.green;
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
            "Campana",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: recintoActual.campanaController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                recintoActual.campanaController.text = "No Operativo";
              }
              final seleccion = recintoActual.campanaController.text;
              return SegmentedButton<String>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(value: 'Operativo', label: Text('Operativo')),
                  ButtonSegment(value: 'No Operativo', label: Text('No Operativo')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  recintoActual.campanaController.text = newSelection.first;
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                        (states) {
                      if (states.contains(WidgetState.selected)) {
                        return seleccion == 'No Operativo' ? Colors.red : Colors.green;
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

          const Text(
            "Celosía puerta",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: recintoActual.celosiapueController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                recintoActual.celosiapueController.text = "No Operativo";
              }
              final seleccion = recintoActual.celosiapueController.text;
              return SegmentedButton<String>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(value: 'Operativo', label: Text('Operativo')),
                  ButtonSegment(value: 'No Operativo', label: Text('No Operativo')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  recintoActual.celosiapueController.text = newSelection.first;
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                        (states) {
                      if (states.contains(WidgetState.selected)) {
                        return seleccion == 'No Operativo' ? Colors.red : Colors.green;
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
            "Rebaje puerta",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: recintoActual.rebajepueController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                recintoActual.rebajepueController.text = "No Operativo";
              }
              final seleccion = recintoActual.rebajepueController.text;
              return SegmentedButton<String>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(value: 'Operativo', label: Text('Operativo')),
                  ButtonSegment(value: 'No Operativo', label: Text('No Operativo')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  recintoActual.rebajepueController.text = newSelection.first;
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                        (states) {
                      if (states.contains(WidgetState.selected)) {
                        return seleccion == 'No Operativo' ? Colors.red : Colors.green;
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
            "Otro",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: recintoActual.otroequipController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                recintoActual.otroequipController.text = "No Operativo";
              }
              final seleccion = recintoActual.otroequipController.text;
              return SegmentedButton<String>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(value: 'Operativo', label: Text('Operativo')),
                  ButtonSegment(value: 'No Operativo', label: Text('No Operativo')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  recintoActual.otroequipController.text = newSelection.first;
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                        (states) {
                      if (states.contains(WidgetState.selected)) {
                        return seleccion == 'No Operativo' ? Colors.red : Colors.green;
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

          const SizedBox(height: 40),

          // -------------------------------------------------------------------
          // SECCIÓN DE FOTO PATOLOGIA
          // -------------------------------------------------------------------

          Text(
            "Plano",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => appState.obtenerImagenRecinto(
                  fuente: ImageSource.camera,
                  recinto: recintoActual,
                  onImagenSeleccionada: (img) {
                    setState(() {
                      recintoActual.imgPlano = img;
                      recintoActual.imgPlanoGuardada = null;
                      _pointsImg1_PR1.clear();
                    });
                  },
                ),
                icon: Icon(Icons.camera_alt),
                label: Text("Tomar Foto"),
              ),
              // const SizedBox(width: 10),
            ],
          ),

          const SizedBox(height: 20),

          // -------------------------------------------------------------------
          // SECCIÓN DIBUJO
          // -------------------------------------------------------------------

          if (recintoActual.imgPlano != null && recintoActual.imgPlanoGuardada == null) ...[
            Text(
              "Dibuja observaciones sobre la imagen:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Center(
              child: RepaintBoundary(
                key: canvaskeyImg1_Murop_R1,
                child: Container(
                  width: 900,
                  height: 800,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    image: DecorationImage(
                      image: FileImage(recintoActual.imgPlano!),
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
                              _pointsImg1_PR1 = List.from(_pointsImg1_PR1)..add(localPosition);
                            }
                          });
                        },
                        onPanEnd: (_) => setState(() => _pointsImg1_PR1.add(null)),
                        child: CustomPaint(
                          painter: DibujoPainter(_pointsImg1_PR1),
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
                  await appState.guardarDibujoRecinto(
                    canvasKey: canvaskeyImg1_Murop_R1,
                    recinto: recintoActual,
                    onGuardado: (file) {
                      setState(() {
                        recintoActual.imgPlanoGuardada= file;
                        _pointsImg1_PR1.clear();
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

          if (recintoActual.imgPlanoGuardada != null) ...[
            Text(
              "Imagen guardada:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Center(
              child: Image.file(
                recintoActual.imgPlanoGuardada!,
                width: 900,
                height: 800,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 15),

            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  await appState.eliminarDibujoRecinto(
                    context: context,
                    recinto: recintoActual,
                  );
                  setState(() {
                    _pointsImg1_PR1.clear();
                  });
                },
                icon: Icon(Icons.delete),
                label: Text("Eliminar dibujo"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ),

          ],

          const SizedBox(height: 20),

        ],
      ),
    );
  }
}
