import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';

class GuardarArchivo extends StatefulWidget {
  const GuardarArchivo({super.key});

  @override
  State<GuardarArchivo> createState() => _GuardarArchivoState();
}

class _GuardarArchivoState extends State<GuardarArchivo> {


  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: appState.guardando
            ? const CircularProgressIndicator()
            : Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Text(
              "Hora de inicio: " + appState.horaInicio,
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "Hora de Fin: " + appState.horaFin,
              style: TextStyle(fontSize: 18),
            ),

            const Text(
              "Ingrese el nombre del archivo:",
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: appState.nombreArchivoController,
              decoration: const InputDecoration(
                labelText: "Nombre del archivo (sin .xlsx)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                final appState = context.read<AppState>();
                await appState.guardarExcel(context);
              },
              icon: const Icon(Icons.save),
              label: const Text("Guardar Excel"),
            ),

            const SizedBox(height: 20),

            //Eliminar desde aqui, prueba de flags

            const SizedBox(height: 20),

            Text(
              "pantalla A=" +appState.muro_eje_p_r1.toString(),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Text(
              "pantalla  B=" +appState.muro_eje_b_r1.toString(),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Text(
              "pantalla  C=" +appState.muro_eje_c_r1.toString(),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Text(
              "pantalla  D=" +appState.muro_eje_d_r1.toString(),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Text(
              "pantalla piso cielo=" +appState.piso_cielo_r1.toString(),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
