import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/app_state.dart';
import 'package:image_picker/image_picker.dart';

class Info_Recinto_2 extends StatefulWidget {
  const Info_Recinto_2({super.key});

  @override
  State<Info_Recinto_2> createState() => _Info_Recinto_2();
}

class _Info_Recinto_2 extends State<Info_Recinto_2> {
  GlobalKey canvaskeyImg1_Murop_R2 = GlobalKey();

  List<Offset?> _pointsImg1_PR2 = [];

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final hojaActual = appState.obtenerHojaMuroPrincipal("Muro Eje Principal - Recinto 2");


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
                  "Información de " + appState.recinto2_nombreController.text,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, decoration: TextDecoration.underline,),
                ),

              ]
            )
          ),


          const SizedBox(height: 40),

          Text(
            "🛠️  Patologias y Modificaciones",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Text(
            "¿Presenta patologías visibles?",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.patvisibleController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                hojaActual.patvisibleController.text = "No";
              }
              final seleccion = hojaActual.patvisibleController.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.patvisibleController.text = newSelection.first;
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
            valueListenable: hojaActual.pinOlimpController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                hojaActual.pinOlimpController.text = "No";
              }
              final seleccion = hojaActual.pinOlimpController.text;
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
                      hojaActual.pinOlimpController.text = newSelection.first;
                      if (newSelection.first != 'Si') {
                        hojaActual.cualpolController.clear();
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
                    controller: hojaActual.cualpolController,
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
            valueListenable: hojaActual.olorhumController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                hojaActual.olorhumController.text = "No";
              }
              final seleccion = hojaActual.olorhumController.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.olorhumController.text = newSelection.first;
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
            valueListenable: hojaActual.modifController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                hojaActual.modifController.text = "No";
              }
              final seleccion = hojaActual.modifController.text;
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
                      hojaActual.modifController.text = newSelection.first;
                      if (newSelection.first != 'Si') {
                        hojaActual.cualmodController.clear();
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
                    controller: hojaActual.cualmodController,
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
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Text(
            "Sistema de Calefacción",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.sistcalefController,
            builder: (context, TextEditingValue value, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(
                        value: 'Eléctrico (seca)',
                        label: Text('Eléctrico (seca)'),
                      ),
                      ButtonSegment(
                        value: 'Gas / parafina con evacuacipon exterior (seca)',
                        label: Text('Gas / parafina con evacuacipon exterior (seca)'),
                      ),
                      ButtonSegment(
                        value: 'Biomasa con evacuación exterior (seca)',
                        label: Text('Biomasa con evacuación exterior (seca)'),
                      ),
                      ButtonSegment(
                        value: 'Parafina/gas móvil (húmeda)',
                        label: Text('Parafina/gas móvil (húmeda)'),
                      ),
                      ButtonSegment(
                        value: 'Otro ¿cuál?',
                        label: Text('Otro ¿cuál?'),
                      )
                    ],
                    selected: {value.text},
                    onSelectionChanged: (Set<String> newSelection) {
                      hojaActual.sistcalefController.text = newSelection.first;
                      if (newSelection.first != 'Otro ¿cuál?') {
                        hojaActual.otrocalefController.clear();
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
                    controller: hojaActual.otrocalefController,
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
            "¿Cuánto tiempo calefacciona? (Hrs)",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: hojaActual.tiemcalefController,
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
                return 'Por favor ingrese una superficie';
              }
              return null;
            },
          ),

          const SizedBox(height: 40),

          Text(
            "𖣘 Sistema de ventilación",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Text(
            "Aireador",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.aireadorController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                hojaActual.aireadorController.text = "No Operativo";
              }
              final seleccion = hojaActual.aireadorController.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Operativo', label: Text('Operativo')),
                  ButtonSegment(value: 'No Operativo', label: Text('No Operativo')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.aireadorController.text = newSelection.first;
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
            valueListenable: hojaActual.extractorController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                hojaActual.extractorController.text = "No Operativo";
              }
              final seleccion = hojaActual.extractorController.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Operativo', label: Text('Operativo')),
                  ButtonSegment(value: 'No Operativo', label: Text('No Operativo')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.extractorController.text = newSelection.first;
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
            valueListenable: hojaActual.campanaController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                hojaActual.campanaController.text = "No Operativo";
              }
              final seleccion = hojaActual.campanaController.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Operativo', label: Text('Operativo')),
                  ButtonSegment(value: 'No Operativo', label: Text('No Operativo')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.campanaController.text = newSelection.first;
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
            valueListenable: hojaActual.celosiapueController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                hojaActual.celosiapueController.text = "No Operativo";
              }
              final seleccion = hojaActual.celosiapueController.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Operativo', label: Text('Operativo')),
                  ButtonSegment(value: 'No Operativo', label: Text('No Operativo')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.celosiapueController.text = newSelection.first;
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
            valueListenable: hojaActual.rebajepueController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                hojaActual.rebajepueController.text = "No Operativo";
              }
              final seleccion = hojaActual.rebajepueController.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Operativo', label: Text('Operativo')),
                  ButtonSegment(value: 'No Operativo', label: Text('No Operativo')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.rebajepueController.text = newSelection.first;
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
            valueListenable: hojaActual.otroequipController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                hojaActual.otroequipController.text = "No Operativo";
              }
              final seleccion = hojaActual.otroequipController.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Operativo', label: Text('Operativo')),
                  ButtonSegment(value: 'No Operativo', label: Text('No Operativo')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.otroequipController.text = newSelection.first;
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
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => appState.obtenerImagenHojaPrincipal(
                  fuente: ImageSource.camera,
                  hoja: hojaActual,
                  imgnum: 1,
                  onImagenSeleccionada: (img) {
                    setState(() {
                      hojaActual.imgpatol = img;
                      hojaActual.imgpatolGuardada = null;
                      _pointsImg1_PR2.clear();
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

          if (hojaActual.imgpatol != null && hojaActual.imgpatolGuardada == null) ...[
            Text(
              "Dibuja observaciones sobre la imagen:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Center(
              child: RepaintBoundary(
                key: canvaskeyImg1_Murop_R2,
                child: Container(
                  width: 900,
                  height: 800,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    image: DecorationImage(
                      image: FileImage(hojaActual.imgpatol!),
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
                              _pointsImg1_PR2 = List.from(_pointsImg1_PR2)..add(localPosition);
                            }
                          });
                        },
                        onPanEnd: (_) => setState(() => _pointsImg1_PR2.add(null)),
                        child: CustomPaint(
                          painter: DibujoPainter(_pointsImg1_PR2),
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
                  await appState.guardarDibujoHojaPrincipal(
                    canvasKey: canvaskeyImg1_Murop_R2,
                    hoja: hojaActual,
                    imgnum: 1,
                    onGuardado: (file) {
                      setState(() {
                        hojaActual.imgpatolGuardada= file;
                        _pointsImg1_PR2.clear();
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

          if (hojaActual.imgpatolGuardada != null) ...[
            Text(
              "Imagen guardada:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Center(
              child: Image.file(
                hojaActual.imgpatolGuardada!,
                width: 900,
                height: 800,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 15),

            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  await appState.eliminarDibujoHojaPrincipal(
                    context: context,
                    hoja: hojaActual,
                    imgnum: 1,
                  );
                  setState(() {
                    _pointsImg1_PR2.clear();
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
