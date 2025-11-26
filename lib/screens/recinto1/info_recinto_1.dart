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
    final hojaActual = appState.obtenerHojaMuroPrincipal("Muro Eje Principal - Recinto 1");


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
              final seleccion = value.text;
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
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.pinOlimpController.text = newSelection.first;
                  print(hojaActual.pinOlimpController.text);
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
            "¿Cuál?" ,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: hojaActual.cualpolController,
            decoration: const InputDecoration(
              labelText: "Detalle",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la información';
              }
              return null;
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
              final seleccion = value.text;
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
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.modifController.text = newSelection.first;
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
            "¿Cuál?" ,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: hojaActual.cualmodController,
            decoration: const InputDecoration(
              labelText: "Detalle",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la información';
              }
              return null;
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
              return SegmentedButton<String>(
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
                  )
                ],
                selected: {value.text},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.sistcalefController.text = newSelection.first;
                },
              );
            },
          ),

          const SizedBox(height: 10),

          Text(
            "Otro ¿cuál?",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: hojaActual.otrocalefController,
            decoration: const InputDecoration(
              labelText: "Detalle",
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
            "¿Cuánto tiempo calefacciona?",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: hojaActual.tiemcalefController,
            decoration: const InputDecoration(
              labelText: "Tiempo",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el tiempo de calefacción';
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
              final seleccion = value.text;
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
              final seleccion = value.text;
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
              final seleccion = value.text;
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
              final seleccion = value.text;
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
              final seleccion = value.text;
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
              final seleccion = value.text;
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




          const SizedBox(height: 20),

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

          if (hojaActual.imgpatol != null && hojaActual.imgpatolGuardada == null) ...[
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
                  await appState.guardarDibujoHojaPrincipal(
                    canvasKey: canvaskeyImg1_Murop_R1,
                    hoja: hojaActual,
                    imgnum: 1,
                    onGuardado: (file) {
                      setState(() {
                        hojaActual.imgpatolGuardada= file;
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
