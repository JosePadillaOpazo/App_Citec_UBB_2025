import 'package:app_citec_2025/screens/inicio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/app_state.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
  }

  final appState = AppState();
  await appState.initApp();
  //await appState.resetNumeroFicha();

  runApp(
    ChangeNotifierProvider.value(
      value: appState,
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'App Citec UBB',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF014898),
        ),
        segmentedButtonTheme: SegmentedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                  (states) {
                if (states.contains(WidgetState.selected)) return Colors.lightBlue;
                if (states.contains(WidgetState.pressed)) return Colors.green.shade700;
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
      ),
      home: const Inicio(),
    );
  }
}
