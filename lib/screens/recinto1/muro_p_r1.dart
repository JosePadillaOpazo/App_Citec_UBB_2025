import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/app_state.dart';
import 'package:image_picker/image_picker.dart';

class Muro_Principal_R1 extends StatefulWidget {
  const Muro_Principal_R1({super.key});

  @override
  State<Muro_Principal_R1> createState() => _Muro_Principal_R1();
}

class _Muro_Principal_R1 extends State<Muro_Principal_R1> {
  GlobalKey canvaskeyImg1_Murop_R1 = GlobalKey();
  GlobalKey canvaskeyImg2_Murop_R1 = GlobalKey();

  List<Offset?> _pointsImg1_PR1 = [];
  List<Offset?> _pointsImg2_PR1 = [];


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
                  appState.r1_murop_nombreController.text,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, decoration: TextDecoration.underline,),
                ),

                IconButton(
                  onPressed:() async {
                    final nuevoNombre = await appState.EditarNombre(
                      context,
                      appState.r1_murop_nombreController.text,
                    );

                    if (nuevoNombre != null && nuevoNombre.isNotEmpty) {
                      appState.actualizarNombreMuro(1,nuevoNombre);
                    }
                  },
                  icon: Icon(Icons.edit, color: Colors.blueAccent),
                )
              ]
            )
          ),


          const SizedBox(height: 20),

          // -------------------------------------------------------------------
          // INFORMACION DEL MURO
          // -------------------------------------------------------------------

          Text(
            "🧱  Informacion del Muro",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Text(
            "Muro Eje:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: hojaActual.muroejeController,
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
            "Superficie muro",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: hojaActual.supmuroController,
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
            "Superficie ventana",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: hojaActual.supventanaController,
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
            "Muro perimetral",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: hojaActual.muroperimetralController,
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
            "Muro interior",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: hojaActual.murointController,
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
            "Nivel de afectación",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.nivelafecController,
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
                  hojaActual.nivelafecController.text = newSelection.first;
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
            "Encuentro esquina muro",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.mh_encEsqMurController,
            builder: (context, TextEditingValue value, _) {
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.mh_encEsqMurController.text = newSelection.first;
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
            controller: hojaActual.mh_supencEsqMurController,
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
            "Encuentro cielo muro",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.mh_encCieMurController,
            builder: (context, TextEditingValue value, _) {
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.mh_encCieMurController.text = newSelection.first;
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
            controller: hojaActual.mh_supencCieMurController,
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
            "Encuentro piso muro",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.mh_encPisMurController,
            builder: (context, TextEditingValue value, _) {
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.mh_encPisMurController.text = newSelection.first;
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
            controller: hojaActual.mh_supencPisMurController,
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
            "Rasgo de ventana",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.mh_rasgventController,
            builder: (context, TextEditingValue value, _) {
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.mh_rasgventController.text = newSelection.first;
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
            controller: hojaActual.mh_suprasgventController,
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
            "Bajo ventana (antepecho)",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.mh_bajovenController,
            builder: (context, TextEditingValue value, _) {
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.mh_bajovenController.text = newSelection.first;
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
            controller: hojaActual.mh_supbajovenController,
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
            valueListenable: hojaActual.mh_aCentralController,
            builder: (context, TextEditingValue value, _) {
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.mh_aCentralController.text = newSelection.first;
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
            controller: hojaActual.mh_supaCentralController,
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
            valueListenable: hojaActual.mh_punLocController,
            builder: (context, TextEditingValue value, _) {
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.mh_punLocController.text = newSelection.first;
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
            controller: hojaActual.mh_suppunLocController,
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
            "▪️Daño físico mecánico",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Text(
            "Encuentro esquina muro",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.df_encEsqMurController,
            builder: (context, TextEditingValue value, _) {
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.df_encEsqMurController.text = newSelection.first;
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
            controller: hojaActual.df_supencEsqMurController,
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
            "Encuentro cielo muro",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.df_encCieMurController,
            builder: (context, TextEditingValue value, _) {
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.df_encCieMurController.text = newSelection.first;
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
            controller: hojaActual.df_supencCieMurController,
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
            "Encuentro piso muro",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.df_encPisMurController,
            builder: (context, TextEditingValue value, _) {
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.df_encPisMurController.text = newSelection.first;
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
            controller: hojaActual.df_supencPisMurController,
            decoration: const InputDecoration(
              labelText: "Superficie en m²",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number, // teclado numérico
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
            "Rasgo de ventana",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.df_rasgventController,
            builder: (context, TextEditingValue value, _) {
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.df_rasgventController.text = newSelection.first;
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
            controller: hojaActual.df_suprasgventController,
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
            "Bajo ventana (antepecho)",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: hojaActual.df_bajovenController,
            builder: (context, TextEditingValue value, _) {
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.df_bajovenController.text = newSelection.first;
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
            controller: hojaActual.df_supbajovenController,
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
            valueListenable: hojaActual.df_aCentralController,
            builder: (context, TextEditingValue value, _) {
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.df_aCentralController.text = newSelection.first;
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
            controller: hojaActual.df_supaCentralController,
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
            valueListenable: hojaActual.df_punLocController,
            builder: (context, TextEditingValue value, _) {
              final seleccion = value.text;
              return SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Si', label: Text('Sí')),
                  ButtonSegment(value: 'No', label: Text('No')),
                ],
                selected: {seleccion},
                onSelectionChanged: (Set<String> newSelection) {
                  hojaActual.df_punLocController.text = newSelection.first;
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
            controller: hojaActual.df_suppunLocController,
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

          const Text(
            "▪️Total superficie de muro afectada",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: hojaActual.totpalsupafecController,
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

          // -------------------------------------------------------------------
          // SECCIÓN DE FOTO ELEVACIONES
          // -------------------------------------------------------------------

          Text(
            "Respaldo Visual Elevaciones",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => appState.obtenerImagenHojaPrincipal(
                  fuente: ImageSource.camera,
                  hoja: hojaActual,
                  imgnum: 2,
                  onImagenSeleccionada: (img) {
                    setState(() {
                      hojaActual.imgelev = img;
                      hojaActual.imgelevGuardada = null;
                      _pointsImg2_PR1.clear();
                    });
                  },
                ),
                icon: Icon(Icons.camera_alt),
                label: Text("Tomar Foto"),
              ),
              const SizedBox(width: 10),
            ],
          ),

          const SizedBox(height: 20),

          // -------------------------------------------------------------------
          // SECCIÓN DIBUJO IMAGEN 2
          // -------------------------------------------------------------------
          if (hojaActual.imgelev != null && hojaActual.imgelevGuardada == null) ...[
            Text(
              "Dibuja observaciones sobre la imagen:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Center(
              child: RepaintBoundary(
                key: canvaskeyImg2_Murop_R1,
                child: Container(
                  width: 900,
                  height: 800,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    image: DecorationImage(
                      image: FileImage(hojaActual.imgelev!),
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
                              _pointsImg2_PR1 = List.from(_pointsImg2_PR1)..add(localPosition);
                            }
                          });
                        },
                        onPanEnd: (_) => setState(() => _pointsImg2_PR1.add(null)),
                        child: CustomPaint(
                          painter: DibujoPainter(_pointsImg2_PR1),
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
                    canvasKey: canvaskeyImg2_Murop_R1,
                    hoja: hojaActual,
                    imgnum: 2,
                    onGuardado: (file) {
                      setState(() {
                        hojaActual.imgelevGuardada= file;
                        _pointsImg2_PR1.clear();
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
          if (hojaActual.imgelevGuardada != null) ...[
            Text(
              "Imagen guardada:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Center(
              child: Image.file(
                hojaActual.imgelevGuardada!,
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
                    imgnum: 2,
                  );
                  setState(() {
                    _pointsImg2_PR1.clear();
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
