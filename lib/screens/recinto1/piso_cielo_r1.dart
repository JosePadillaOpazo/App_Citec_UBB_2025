import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/app_state.dart';
import 'package:image_picker/image_picker.dart';

class Piso_Cielo_R1 extends StatefulWidget {
  const Piso_Cielo_R1({super.key});

  @override
  State<Piso_Cielo_R1> createState() => _Piso_Cielo_R1State();
}

class _Piso_Cielo_R1State extends State<Piso_Cielo_R1> {
  GlobalKey canvaskeyPiso_R1 = GlobalKey();
  GlobalKey canvaskeyCielo_R1 = GlobalKey();

  List<Offset?> _pointsPiso = [];
  List<Offset?> _pointsCielo = [];

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final hojaActual = appState.obtenerHojaPisoCielo("Piso Cielo - Recinto 1"); //---------------------------------------------------------------------> Editar al copiar la hoja


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
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, decoration: TextDecoration.underline,),
                ),
                IconButton(
                  onPressed:() async {
                    final nuevoNombre = await appState.EditarNombre(
                      context,
                      appState.r1_pisocielo_nombreController.text,//------------------------------------------------------------------------------> Editar al copiar la hoja
                    );

                    if (nuevoNombre != null && nuevoNombre.isNotEmpty) {
                      appState.actualizarNombreMuro(8,nuevoNombre);//--------------------------------------------------------------------------> Editar al copiar la hoja
                    }
                  },
                  icon: Icon(Icons.edit, color: Colors.blueAccent),
                )
              ]
            )
          ),


          const SizedBox(height: 40),

          // -------------------------------------------------------------------
          // INFORMACION DEL PISO
          // -------------------------------------------------------------------

          Text(
            "Superficie Piso",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: hojaActual.supPisoController,
            decoration: const InputDecoration(
              labelText: "Asignar Eje al Muro",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una asignacion para el muro';
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
              final seleccion = value.text;
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
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Text(
            "▪️Manchas de humedad / moho",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.mh_perimetroPisoController.text = newSelection.first;
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

          TextFormField(
            controller: hojaActual.mh_supperimetroPisoController,
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
            "Área central",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.mh_aCentralPisoController,
            builder: (context, TextEditingValue value, _) {
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.mh_aCentralPisoController.text = newSelection.first;
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

          TextFormField(
            controller: hojaActual.mh_supaCentralPisoController,
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
            "Puntual localizada y/o extendida",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.mh_punlocPisoController,
            builder: (context, TextEditingValue value, _) {
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.mh_punlocPisoController.text = newSelection.first;
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

          TextFormField(
            controller: hojaActual.mh_supPunlocPisoController,
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
            "▪️Daño físico mecánico",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.df_perimetroPisoController.text = newSelection.first;
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

          TextFormField(
            controller: hojaActual.df_supperimetroPisoController,
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
            "Área central",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.df_aCentralPisoController,
            builder: (context, TextEditingValue value, _) {
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.df_aCentralPisoController.text = newSelection.first;
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

          TextFormField(
            controller: hojaActual.df_supaCentralPisoController,
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
            "Puntual localizada y/o extendida",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.df_punlocPisoController,
            builder: (context, TextEditingValue value, _) {
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.df_punlocPisoController.text = newSelection.first;
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

          TextFormField(
            controller: hojaActual.df_supPunlocPisoController,
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

          Text(
            "▪️Total superficie de piso afectada",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                      canvaskeyPiso_R1 = GlobalKey();
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
                key: canvaskeyPiso_R1, //---------------------------------------------------------------------------> Editar al copiar la hoja
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
                    canvasKey: canvaskeyPiso_R1, //---------------------------------------------------------------------> Editar al copiar la hoja
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
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, decoration: TextDecoration.underline,),
                ),
              ]
            )
          ),


          const SizedBox(height: 40),

          Text(
            "Superficie Cielo",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

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
              final seleccion = value.text;
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
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Text(
            "▪️Manchas de humedad / moho",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.mh_perimetroCieloController.text = newSelection.first;
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

          TextFormField(
            controller: hojaActual.mh_supperimetroCieloController,
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
            "Área central",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.mh_aCentralCieloController,
            builder: (context, TextEditingValue value, _) {
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.mh_aCentralCieloController.text = newSelection.first;
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

          TextFormField(
            controller: hojaActual.mh_supaCentralCieloController,
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
            "Puntual localizada y/o extendida",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.mh_punlocCieloController,
            builder: (context, TextEditingValue value, _) {
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.mh_punlocCieloController.text = newSelection.first;
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

          TextFormField(
            controller: hojaActual.mh_supPunlocCieloController,
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
            "▪️Daño físico mecánico",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.df_perimetroCieloController.text = newSelection.first;
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

          TextFormField(
            controller: hojaActual.df_supperimetroCieloController,
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
            "Área central",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.df_aCentralCieloController,
            builder: (context, TextEditingValue value, _) {
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.df_aCentralCieloController.text = newSelection.first;
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

          TextFormField(
            controller: hojaActual.df_supaCentralCieloController,
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
            "Puntual localizada y/o extendida",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.df_punlocCieloController,
            builder: (context, TextEditingValue value, _) {
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.df_punlocCieloController.text = newSelection.first;
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

          TextFormField(
            controller: hojaActual.df_supPunlocCieloController,
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

          Text(
            "▪️Total superficie de cielo afectada",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                      canvaskeyCielo_R1 = GlobalKey();
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
                key: canvaskeyCielo_R1, //---------------------------------------------------------------------------> Editar al copiar la hoja
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
                    canvasKey: canvaskeyCielo_R1, //---------------------------------------------------------------------> Editar al copiar la hoja
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
