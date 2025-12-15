import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/app_state.dart';
import 'package:image_picker/image_picker.dart';

class Piso_Cielo_R4 extends StatefulWidget {
  const Piso_Cielo_R4({super.key});

  @override
  State<Piso_Cielo_R4> createState() => _Piso_Cielo_R4();
}

class _Piso_Cielo_R4 extends State<Piso_Cielo_R4> {
  GlobalKey canvaskeyPiso_R4 = GlobalKey();
  GlobalKey canvaskeyCielo_R4 = GlobalKey();

  List<Offset?> _pointsPiso = [];
  List<Offset?> _pointsCielo = [];
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final hojaActual = appState.obtenerHojaPisoCielo("Piso Cielo - Recinto 4"); //---------------------------------------------------------------------> Editar al copiar la hoja


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
                  "Piso",//----------------------------------------------------------------------------------> Editar al copiar la hoja
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, decoration: TextDecoration.underline,),
                ),
              ]
            )
          ),


          const SizedBox(height: 20),

          // -------------------------------------------------------------------
          // INFORMACION DEL PISO
          // -------------------------------------------------------------------

          Text(
            "Superficie Piso: (m²)",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: hojaActual.supPisoController,
            decoration: const InputDecoration(
              labelText: "Superficie en m²",
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

          const SizedBox(height: 10),

          Text(
            "Nivel de afectacion",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.nivelafecPisoController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                hojaActual.nivelafecPisoController.text = "Nulo";
              }
              final seleccion = hojaActual.nivelafecPisoController.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Nulo', label: Text('Nulo')),
                  ButtonSegment(value: 'Bajo', label: Text('Bajo')),
                  ButtonSegment(value: 'Medio', label: Text('Medio')),
                  ButtonSegment(value: 'Alto', label: Text('Alto')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.nivelafecPisoController.text = newSelection.first;
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                        (states) {
                      if (states.contains(WidgetState.selected)) {
                        switch (seleccion) {
                          case 'Nulo':
                            return Colors.greenAccent;
                          case 'Bajo':
                            return Colors.green;
                          case 'Medio':
                            return Colors.amber;
                          case 'Alto':
                            return Colors.red;
                          default:
                            return Colors.grey;
                        }
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

          Text(
            "🎯  Ubicacion de Patologia Detectada",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Text(
            "▪️Manchas de humedad / moho",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Text(
            "Perímetro",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.mh_perimetroPisoController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                hojaActual.mh_perimetroPisoController.text = "No";
              }
              final seleccion = hojaActual.mh_perimetroPisoController.text;
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
                      hojaActual.mh_perimetroPisoController.text = newSelection.first;
                      if (newSelection.first != 'Si') {
                        hojaActual.mh_perimetroPisoController.clear();
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
                    controller: hojaActual.mh_supperimetroPisoController,
                    enabled: seleccion == 'Si',
                    decoration: const InputDecoration(
                      labelText: "Información",
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
                        return 'Por favor ingrese la información requerida';
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
            "Área central",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.mh_aCentralPisoController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                hojaActual.mh_aCentralPisoController.text = "No";
              }
              final seleccion = hojaActual.mh_aCentralPisoController.text;
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
                      hojaActual.mh_aCentralPisoController.text = newSelection.first;
                      if (newSelection.first != 'Si') {
                        hojaActual.mh_aCentralPisoController.clear();
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
                    controller: hojaActual.mh_supaCentralPisoController,
                    enabled: seleccion == 'Si',
                    decoration: const InputDecoration(
                      labelText: "Información",
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
                        return 'Por favor ingrese la información requerida';
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
            "Puntual localizada y/o extendida",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.mh_punlocPisoController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                hojaActual.mh_punlocPisoController.text = "No";
              }
              final seleccion = hojaActual.mh_punlocPisoController.text;
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
                      hojaActual.mh_punlocPisoController.text = newSelection.first;
                      if (newSelection.first != 'Si') {
                        hojaActual.mh_punlocPisoController.clear();
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
                    controller: hojaActual.mh_supPunlocPisoController,
                    enabled: seleccion == 'Si',
                    decoration: const InputDecoration(
                      labelText: "Información",
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
                        return 'Por favor ingrese la información requerida';
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
            "▪️Daño físico mecánico",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Text(
            "Perímetro",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.df_perimetroPisoController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                hojaActual.df_perimetroPisoController.text = "No";
              }
              final seleccion = hojaActual.df_perimetroPisoController.text;
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
                      hojaActual.df_perimetroPisoController.text = newSelection.first;
                      if (newSelection.first != 'Si') {
                        hojaActual.df_perimetroPisoController.clear();
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
                    controller: hojaActual.df_supperimetroPisoController,
                    enabled: seleccion == 'Si',
                    decoration: const InputDecoration(
                      labelText: "Información",
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
                        return 'Por favor ingrese la información requerida';
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
            "Área central",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.df_aCentralPisoController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                hojaActual.df_aCentralPisoController.text = "No";
              }
              final seleccion = hojaActual.df_aCentralPisoController.text;
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
                      hojaActual.df_aCentralPisoController.text = newSelection.first;
                      if (newSelection.first != 'Si') {
                        hojaActual.df_aCentralPisoController.clear();
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
                    controller: hojaActual.df_supaCentralPisoController,
                    enabled: seleccion == 'Si',
                    decoration: const InputDecoration(
                      labelText: "Información",
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
                        return 'Por favor ingrese la información requerida';
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
            "Puntual localizada y/o extendida",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.df_punlocPisoController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                hojaActual.df_punlocPisoController.text = "No";
              }
              final seleccion = hojaActual.df_punlocPisoController.text;
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
                      hojaActual.df_punlocPisoController.text = newSelection.first;
                      if (newSelection.first != 'Si') {
                        hojaActual.df_punlocPisoController.clear();
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
                    controller: hojaActual.df_supPunlocPisoController,
                    enabled: seleccion == 'Si',
                    decoration: const InputDecoration(
                      labelText: "Información",
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
                        return 'Por favor ingrese la información requerida';
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
            "Total superficie de piso afectada: (m²)",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: hojaActual.totpalsupafecPisoController,
            decoration: const InputDecoration(
              labelText: "Superficie en m²",
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

          // -------------------------------------------------------------------
          // SECCIÓN DE FOTO PISO
          // -------------------------------------------------------------------

          Text(
            "Respaldo Visual",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => appState.obtenerImagenHojaPisoCielo(
                  fuente: ImageSource.camera,
                  hoja: hojaActual,
                  imgnum: 1,
                  onImagenSeleccionada: (img) {
                    setState(() {
                      hojaActual.imgpiso = img;
                      hojaActual.imgPisoGuardada = null;
                      _pointsPiso.clear();
                      canvaskeyPiso_R4 = GlobalKey();
                    });
                  },

                ),
                icon: const Icon(Icons.camera_alt),
                label: const Text("Tomar Foto"),
              ),
              //const SizedBox(width: 10),
            ],
          ),

          const SizedBox(height: 20),

          // -------------------------------------------------------------------
          // SECCIÓN DIBUJO
          // -------------------------------------------------------------------

          if (hojaActual.imgpiso != null && hojaActual.imgPisoGuardada == null) ...[
            Text(
              "Dibuja observaciones sobre la imagen:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Center(
              child: RepaintBoundary(
                key: canvaskeyPiso_R4, //---------------------------------------------------------------------------> Editar al copiar la hoja
                child: Container(
                  width: 900,
                  height: 800,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    image: DecorationImage(
                      image: FileImage(hojaActual.imgpiso!),
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
                              _pointsPiso = List.from(_pointsPiso)..add(localPosition);
                            }
                          });
                        },
                        onPanEnd: (_) => setState(() => _pointsPiso.add(null)),
                        child: CustomPaint(
                          painter: DibujoPainter(_pointsPiso),
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
                  await appState.guardarDibujoHojaPisoCielo(
                    canvasKey: canvaskeyPiso_R4, //---------------------------------------------------------------------> Editar al copiar la hoja
                    hoja: hojaActual,
                    imgnum: 1,
                    onGuardado: (file) {
                      setState(() {
                        hojaActual.imgPisoGuardada= file;
                        _pointsPiso.clear();
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

          if (hojaActual.imgPisoGuardada != null) ...[
            Text(
              "Imagen guardada:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Center(
              child: Image.file(
                hojaActual.imgPisoGuardada!,
                width: 900,
                height: 800,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 15),

            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  await appState.eliminarDibujoHojaPisoCielo(
                    context: context,
                    hoja: hojaActual,
                    imgnum: 1,
                  );
                  setState(() {
                    _pointsPiso.clear();
                  });
                },
                icon: Icon(Icons.delete),
                label: Text("Eliminar dibujo"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ),
          ],

         //---------------------------------------------------------------------
         // INFORMACION DEL CIELO
         // --------------------------------------------------------------------

          const SizedBox(height: 50),

          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Cielo",//----------------------------------------------------------------------------------> Editar al copiar la hoja
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, decoration: TextDecoration.underline,),
                ),
              ]
            )
          ),


          const SizedBox(height: 20),

          Text(
            "Superficie Cielo: (m²)",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: hojaActual.supCieloController,
            decoration: const InputDecoration(
              labelText: "Superficie en m²",
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

          const SizedBox(height: 10),

          Text(
            "Nivel de afectacion",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.nivelafecCieloController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                hojaActual.nivelafecCieloController.text = "Nulo";
              }
              final seleccion = hojaActual.nivelafecCieloController.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Nulo', label: Text('Nulo')),
                  ButtonSegment(value: 'Bajo', label: Text('Bajo')),
                  ButtonSegment(value: 'Medio', label: Text('Medio')),
                  ButtonSegment(value: 'Alto', label: Text('Alto')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.nivelafecCieloController.text = newSelection.first;
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                        (states) {
                      if (states.contains(WidgetState.selected)) {
                        switch (seleccion) {
                          case 'Nulo':
                            return Colors.greenAccent;
                          case 'Bajo':
                            return Colors.green;
                          case 'Medio':
                            return Colors.amber;
                          case 'Alto':
                            return Colors.red;
                          default:
                            return Colors.grey;
                        }
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

          Text(
            "🎯  Ubicacion de Patologia Detectada",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Text(
            "▪️Manchas de humedad / moho",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Text(
            "Perímetro",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.mh_perimetroCieloController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                hojaActual.mh_perimetroCieloController.text = "No";
              }
              final seleccion = hojaActual.mh_perimetroCieloController.text;
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
                      hojaActual.mh_perimetroCieloController.text = newSelection.first;
                      if (newSelection.first != 'Si') {
                        hojaActual.mh_perimetroCieloController.clear();
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
                    controller: hojaActual.mh_supperimetroCieloController,
                    enabled: seleccion == 'Si',
                    decoration: const InputDecoration(
                      labelText: "Información",
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
                        return 'Por favor ingrese la información requerida';
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
            "Área central",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.mh_aCentralCieloController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                hojaActual.mh_aCentralCieloController.text = "No";
              }
              final seleccion = hojaActual.mh_aCentralCieloController.text;
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
                      hojaActual.mh_aCentralCieloController.text = newSelection.first;
                      if (newSelection.first != 'Si') {
                        hojaActual.mh_aCentralCieloController.clear();
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
                    controller: hojaActual.mh_supaCentralCieloController,
                    enabled: seleccion == 'Si',
                    decoration: const InputDecoration(
                      labelText: "Información",
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
                        return 'Por favor ingrese la información requerida';
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
            "Puntual localizada y/o extendida",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.mh_punlocCieloController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                hojaActual.mh_punlocCieloController.text = "No";
              }
              final seleccion = hojaActual.mh_punlocCieloController.text;
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
                      hojaActual.mh_punlocCieloController.text = newSelection.first;
                      if (newSelection.first != 'Si') {
                        hojaActual.mh_punlocCieloController.clear();
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
                    controller: hojaActual.mh_supPunlocCieloController,
                    enabled: seleccion == 'Si',
                    decoration: const InputDecoration(
                      labelText: "Información",
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
                        return 'Por favor ingrese la información requerida';
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
            "▪️Daño físico mecánico",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Text(
            "Perímetro",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.df_perimetroCieloController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                hojaActual.df_perimetroCieloController.text = "No";
              }
              final seleccion = hojaActual.df_perimetroCieloController.text;
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
                      hojaActual.df_perimetroCieloController.text = newSelection.first;
                      if (newSelection.first != 'Si') {
                        hojaActual.df_perimetroCieloController.clear();
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
                    controller: hojaActual.df_supperimetroCieloController,
                    enabled: seleccion == 'Si',
                    decoration: const InputDecoration(
                      labelText: "Información",
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
                        return 'Por favor ingrese la información requerida';
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
            "Área central",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.df_aCentralCieloController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                hojaActual.df_aCentralCieloController.text = "No";
              }
              final seleccion = hojaActual.df_aCentralCieloController.text;
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
                      hojaActual.df_aCentralCieloController.text = newSelection.first;
                      if (newSelection.first != 'Si') {
                        hojaActual.df_aCentralCieloController.clear();
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
                    controller: hojaActual.df_supaCentralCieloController,
                    enabled: seleccion == 'Si',
                    decoration: const InputDecoration(
                      labelText: "Información",
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
                        return 'Por favor ingrese la información requerida';
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
            "Puntual localizada y/o extendida",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.df_punlocCieloController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                hojaActual.df_punlocCieloController.text = "No";
              }
              final seleccion = hojaActual.df_punlocCieloController.text;
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
                      hojaActual.df_punlocCieloController.text = newSelection.first;
                      if (newSelection.first != 'Si') {
                        hojaActual.df_punlocCieloController.clear();
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
                    controller: hojaActual.df_supPunlocCieloController,
                    enabled: seleccion == 'Si',
                    decoration: const InputDecoration(
                      labelText: "Información",
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
                        return 'Por favor ingrese la información requerida';
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
            "Total superficie de cielo afectada: (m²)",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: hojaActual.totpalsupafecCieloController,
            decoration: const InputDecoration(
              labelText: "Superficie en m²",
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

          // -------------------------------------------------------------------
          // SECCIÓN DE FOTO CIELO
          // -------------------------------------------------------------------

          Text(
            "Respaldo Visual",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => appState.obtenerImagenHojaPisoCielo(
                  fuente: ImageSource.camera,
                  hoja: hojaActual,
                  imgnum: 2,
                  onImagenSeleccionada: (img) {
                    setState(() {
                      hojaActual.imgcielo = img;
                      hojaActual.imgCieloGuardada = null;
                      _pointsCielo.clear();
                      canvaskeyCielo_R4 = GlobalKey();
                    });
                  },

                ),
                icon: Icon(Icons.camera_alt),
                label: Text("Tomar Foto"),
              ),
              //const SizedBox(width: 10),
            ],
          ),

          const SizedBox(height: 20),

          // -------------------------------------------------------------------
          // SECCIÓN DIBUJO
          // -------------------------------------------------------------------

          if (hojaActual.imgcielo != null && hojaActual.imgCieloGuardada == null) ...[
            Text(
              "Dibuja observaciones sobre la imagen:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Center(
              child: RepaintBoundary(
                key: canvaskeyCielo_R4, //---------------------------------------------------------------------------> Editar al copiar la hoja
                child: Container(
                  width: 900,
                  height: 800,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    image: DecorationImage(
                      image: FileImage(hojaActual.imgcielo!),
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
                              _pointsCielo = List.from(_pointsCielo)..add(localPosition);
                            }
                          });
                        },
                        onPanEnd: (_) => setState(() => _pointsCielo.add(null)),
                        child: CustomPaint(
                          painter: DibujoPainter(_pointsCielo),
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
                  await appState.guardarDibujoHojaPisoCielo(
                    canvasKey: canvaskeyCielo_R4, //---------------------------------------------------------------------> Editar al copiar la hoja
                    hoja: hojaActual,
                    imgnum: 2,
                    onGuardado: (file) {
                      setState(() {
                        hojaActual.imgCieloGuardada= file;
                        _pointsCielo.clear();
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

          if (hojaActual.imgCieloGuardada != null) ...[
            Text(
              "Imagen guardada:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Center(
              child: Image.file(
                hojaActual.imgCieloGuardada!,
                width: 900,
                height: 800,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 15),

            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  await appState.eliminarDibujoHojaPisoCielo(
                    context: context,
                    hoja: hojaActual,
                    imgnum: 2,
                  );
                  setState(() {
                    _pointsCielo.clear();
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
