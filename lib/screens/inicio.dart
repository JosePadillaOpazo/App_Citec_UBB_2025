import 'package:flutter/material.dart';
import '../db_local/db_local.dart';
import 'principal.dart';
import 'db_viwer.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppState>();

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isTablet = constraints.maxWidth >= 600;

          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 900,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(isTablet ? 32 : 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Image.asset(
                          'assets/logo_citec.png',
                          width: isTablet
                              ? 400
                              : constraints.maxWidth * 0.7,
                          height: isTablet
                              ? 300
                              : constraints.maxWidth * 0.5,
                          fit: BoxFit.contain,
                        ),

                        SizedBox(height: isTablet ? 48 : 32),

                        /// BOTÓN
                        SizedBox(
                          width: isTablet ? 320 : double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              appState.HoraInicio();
                              appState.iniciarNuevaInspeccion();
                              Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                  transitionDuration: const Duration(milliseconds: 400),
                                  pageBuilder: (_, __, ___) => const PantallaPrincipal(),
                                  transitionsBuilder: (_, animation, __, child) {
                                    const begin = Offset(1.0, 0.0);
                                    const end = Offset.zero;
                                    final tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: Curves.easeInOut));

                                    return SlideTransition(
                                      position: animation.drive(tween),
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: isTablet ? 18 : 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: Colors.green,
                            ),
                            child: Text(
                              'Inicio de Inspección',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isTablet ? 20 : 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                transitionDuration: const Duration(milliseconds: 400),
                                pageBuilder: (_, __, ___) => const DB_Viewer(),
                                transitionsBuilder: (_, animation, __, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  final tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: Curves.easeInOut));

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: Text("Ver Base de Datos"),
                        ),

                        const SizedBox(height: 20),

                        ElevatedButton.icon(
                          icon: const Icon(Icons.delete_forever),
                          label: const Text("Borrar Base de Datos"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () async {
                            final confirmar = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('⚠️ Confirmar'),
                                content: const Text(
                                  'Esto eliminará TODA la base de datos local.\n\n¿Deseas continuar?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, false),
                                    child: const Text('Cancelar'),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                    onPressed: () => Navigator.pop(context, true),
                                    child: const Text('Eliminar'),
                                  ),
                                ],
                              ),
                            );

                            if (confirmar == true) {
                              await LocalDatabase.borrarBaseDeDatos();

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('🗑️ Base de datos eliminada correctamente'),
                                ),
                              );
                            }
                          },
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );

  }
}
