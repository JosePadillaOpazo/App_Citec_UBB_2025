import 'package:flutter/material.dart';
import 'principal.dart';
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
                              Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                  transitionDuration:
                                  const Duration(milliseconds: 500),
                                  pageBuilder: (_, __, ___) =>
                                  const PantallaPrincipal(),
                                  transitionsBuilder:
                                      (_, animation, __, child) =>
                                      FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      ),
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
