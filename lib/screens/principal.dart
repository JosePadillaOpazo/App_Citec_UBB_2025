import 'package:flutter/material.dart';
import 'info_general.dart';
import '../../providers/recinto1_screens.dart';
import '../../providers/recinto2_screens.dart';
import '../../providers/recinto3_screens.dart';
import '../../providers/recinto4_screens.dart';
import '../../providers/recinto5_screens.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final pantallas = [
      const InformacionGeneral(key: ValueKey('info_General')),// ==> 0

      //Recinto 1
      const Info_Recinto_1(key: ValueKey('info_Recinto_1')),// ==> 1
      const Muro_Principal_R1(key: ValueKey('muro_Eje_A_R1')),// ==> 2 Principal
      const Muro_Eje_B_R1(key: ValueKey('muro_Eje_B_R1')),// ==> 3 Muros
      const Muro_Eje_C_R1(key: ValueKey('muro_Eje_C_R1')),// ==> 4
      const Muro_Eje_D_R1(key: ValueKey('muro_Eje_D_R1')),// ==> 5
      const Muro_Eje_E_R1(key: ValueKey('muro_Eje_E_R1')),// ==> 6
      const Muro_Eje_F_R1(key: ValueKey('muro_Eje_F_R1')),// ==> 7
      const Muro_Eje_G_R1(key: ValueKey('muro_Eje_G_R1')),// ==> 8
      const Piso_Cielo_R1(key: ValueKey('piso_cielo_R1')),// ==> 9 Piso cielo

      //Recinto 2
      const Info_Recinto_2(key: ValueKey('info_Recinto_1')),// ==> 10
      const Muro_Principal_R2(key: ValueKey('muro_Eje_A_R2')),// ==> 11 Principal
      const Muro_Eje_B_R2(key: ValueKey('muro_Eje_B_R2')),// ==> 12 Muros
      const Muro_Eje_C_R2(key: ValueKey('muro_Eje_C_R2')),// ==> 13
      const Muro_Eje_D_R2(key: ValueKey('muro_Eje_D_R2')),// ==> 14
      const Muro_Eje_E_R2(key: ValueKey('muro_Eje_E_R2')),// ==> 15
      const Muro_Eje_F_R2(key: ValueKey('muro_Eje_F_R2')),// ==> 16
      const Muro_Eje_G_R2(key: ValueKey('muro_Eje_G_R2')),// ==> 17
      const Piso_Cielo_R2(key: ValueKey('piso_cielo_R2')),// ==> 18 Piso Cielo

      //Recinto 3
      const Info_Recinto_3(key: ValueKey('info_Recinto_3')),// ==> 19
      const Muro_Principal_R3(key: ValueKey('muro_Eje_A_R3')),// ==> 20 Principal
      const Muro_Eje_B_R3(key: ValueKey('muro_Eje_B_R3')),// ==> 21 Muros
      const Muro_Eje_C_R3(key: ValueKey('muro_Eje_C_R3')),// ==> 22
      const Muro_Eje_D_R3(key: ValueKey('muro_Eje_D_R3')),// ==> 23
      const Muro_Eje_E_R3(key: ValueKey('muro_Eje_D_R3')),// ==> 24
      const Muro_Eje_F_R3(key: ValueKey('muro_Eje_D_R3')),// ==> 25
      const Muro_Eje_G_R3(key: ValueKey('muro_Eje_D_R3')),// ==> 26
      const Piso_Cielo_R3(key: ValueKey('piso_cielo_R3')),// ==> 27 Piso Cielo

      //Recinto 4
      const Info_Recinto_4(key: ValueKey('info_Recinto_4')),// ==> 28
      const Muro_Principal_R4(key: ValueKey('muro_Eje_A_R4')),// ==> 29 Principal
      const Muro_Eje_B_R4(key: ValueKey('muro_Eje_B_R4')),// ==> 30 Muros
      const Muro_Eje_C_R4(key: ValueKey('muro_Eje_C_R4')),// ==> 31
      const Muro_Eje_D_R4(key: ValueKey('muro_Eje_D_R4')),// ==> 32
      const Muro_Eje_E_R4(key: ValueKey('muro_Eje_D_R4')),// ==> 33
      const Muro_Eje_F_R4(key: ValueKey('muro_Eje_D_R4')),// ==> 34
      const Muro_Eje_G_R4(key: ValueKey('muro_Eje_D_R4')),// ==> 35
      const Piso_Cielo_R4(key: ValueKey('piso_cielo_R4')),// ==> 36 Piso Cielo

      //Recinto 5
      const Info_Recinto_5(key: ValueKey('info_Recinto_5')),// ==> 37
      const Muro_Principal_R5(key: ValueKey('muro_Eje_A_R5')),// ==> 38 Principal
      const Muro_Eje_B_R5(key: ValueKey('muro_Eje_B_R5')),// ==> 39 Muros
      const Muro_Eje_C_R5(key: ValueKey('muro_Eje_C_R5')),// ==> 40
      const Muro_Eje_D_R5(key: ValueKey('muro_Eje_D_R5')),// ==> 41
      const Muro_Eje_E_R5(key: ValueKey('muro_Eje_D_R5')),// ==> 42
      const Muro_Eje_F_R5(key: ValueKey('muro_Eje_D_R5')),// ==> 43
      const Muro_Eje_G_R5(key: ValueKey('muro_Eje_D_R5')),// ==> 44
      const Piso_Cielo_R5(key: ValueKey('piso_cielo_R5')),// ==> 45 Piso Cielo

    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App Citec Ubb',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.white),
            onPressed: () async {
              // Verifica si está vacío
              if (appState.direccionController.text.isEmpty) {

                // Muestra alerta
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Falta Información"),
                      content: const Text("Debe ingresar la dirección antes de guardar el Excel."),
                      actions: [
                        TextButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                            if (appState.pantallaActual != 0){
                              setState(() => appState.pantallaActual = 0);
                            }
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  },
                );

                return; // No continúa
              }
              appState.HoraFin();
              await appState.guardarExcel(context);
            },
          ),

          if (appState.pantallaActual != 0
              && appState.pantallaActual != 1
              && appState.pantallaActual != 10
              && appState.pantallaActual != 19
              && appState.pantallaActual != 28
              && appState.pantallaActual != 37)
            IconButton(
              icon: Icon(Icons.delete, color: Colors.white),
              onPressed: () async {
                if(
                  appState.pantallaActual == 2
                  || appState.pantallaActual == 11
                  || appState.pantallaActual == 20
                  || appState.pantallaActual == 29
                  || appState.pantallaActual == 38
                  || appState.pantallaActual == 42
                )
                  await appState.eliminarPantallaPrincipalActual(context);
                if(
                  appState.pantallaActual == 3
                  || appState.pantallaActual == 4
                  || appState.pantallaActual == 5
                  || appState.pantallaActual == 6
                  || appState.pantallaActual == 7
                  || appState.pantallaActual == 8

                  || appState.pantallaActual == 12
                  || appState.pantallaActual == 13
                  || appState.pantallaActual == 14
                  || appState.pantallaActual == 15
                  || appState.pantallaActual == 16
                  || appState.pantallaActual == 17

                  || appState.pantallaActual == 21
                  || appState.pantallaActual == 22
                  || appState.pantallaActual == 23
                  || appState.pantallaActual == 24
                  || appState.pantallaActual == 25
                  || appState.pantallaActual == 26

                  || appState.pantallaActual == 30
                  || appState.pantallaActual == 31
                  || appState.pantallaActual == 32
                  || appState.pantallaActual == 33
                  || appState.pantallaActual == 34
                  || appState.pantallaActual == 35

                  || appState.pantallaActual == 39
                  || appState.pantallaActual == 40
                  || appState.pantallaActual == 41
                  || appState.pantallaActual == 42
                  || appState.pantallaActual == 43
                  || appState.pantallaActual == 44
                )
                  await appState.eliminarPantallaMuroActual(context);

                if(
                  appState.pantallaActual == 9
                  || appState.pantallaActual == 18
                  || appState.pantallaActual == 22
                  || appState.pantallaActual == 36
                  || appState.pantallaActual == 45
                  )
                  await appState.eliminarPantallaPisoCieloActual(context);
              },
            ),


          IconButton(
            icon: Icon(Icons.cancel, color: Colors.white),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Reiniciar el proceso'),
                  content: Text(
                    '¿Estás seguro de que deseas cancelar la inspección? '
                        'Se perderán todos los datos.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text('Cancelar'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                      ),
                      onPressed: () => Navigator.pop(context, true),
                      child: Text('Reiniciar'),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                context.read<AppState>().resetApp(context);
              }
            },
          ),
        ],
      ),

      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Row(
                children: [
                  Icon(Icons.description, color: Colors.white, size: 40),
                  SizedBox(width: 10),
                  Text(
                    'Hojas del archivo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                children: [
                  ListTile(
                    leading: Icon(Icons.info, color: Colors.blueAccent),
                    title: Text('Información de Proyecto'),
                    selected: appState.pantallaActual == 0,
                    onTap: () {
                      setState(() => appState.pantallaActual = 0);
                      Navigator.pop(context);
                    },
                  ),

                  //-- Recinto 1
                  ExpansionTile(
                    leading: Icon(Icons.looks_one, color: Colors.blueAccent),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            appState.recinto1_nombreController.text,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blueAccent),
                          onPressed: () async {
                            final nuevoNombre = await appState.EditarNombre(
                              context,
                              appState.recinto1_nombreController.text,
                            );
                            if (nuevoNombre != null && nuevoNombre.isNotEmpty) {
                              appState.actualizarNombreRecinto(1, nuevoNombre);
                            }
                          },
                        ),
                      ],
                    ),

                    childrenPadding: const EdgeInsets.only(left: 30),
                    children: [
                      ListTile(
                        title: Text("- Información " + appState.recinto1_nombreController.text), //--> Informacion de Recinto 1
                        selected: appState.pantallaActual == 1,
                        onTap: () {
                          setState(() => appState.pantallaActual = 1);
                          appState.muro_eje_p_info_r1 = true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje Principal - Recinto 1");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_p_info_r1
                            ? Icon(Icons.edit_document, color: Colors.green)
                            : Icon(Icons.edit_off, color: Colors.grey),
                      ),
                      ListTile(
                        title: Text("- Muro Principal Eje "+ appState.r1_murop_nombreController.text +" (Obligatorio)"), //--> Muros principal (Muro Eje A - Reciento 1)
                        selected: appState.pantallaActual == 2,
                        onTap: () {
                          setState(() => appState.pantallaActual = 2);
                          appState.muro_eje_p_r1 = true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje Principal - Recinto 1");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_p_r1
                          ? Icon(Icons.edit_document, color: Colors.green)
                          : Icon(Icons.edit_off, color: Colors.grey),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r1_murob_nombreController.text), //--> Muros B (Muro Eje B - Reciento 1)
                        selected: appState.pantallaActual == 3,
                        onTap: () {
                          setState(() => appState.pantallaActual = 3);
                          appState.muro_eje_b_r1=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje B - Recinto 1");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_b_r1
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r1_muroc_nombreController.text), //--> Muros C (Muro Eje C - Reciento 1)
                        selected: appState.pantallaActual == 4,
                        onTap: () {
                          setState(() => appState.pantallaActual = 4);
                          appState.muro_eje_c_r1=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje C - Recinto 1");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_c_r1
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r1_murod_nombreController.text), //--> Muros D (Muro Eje D - Reciento 1)
                        selected: appState.pantallaActual == 5,
                        onTap: () {
                          setState(() => appState.pantallaActual = 5);
                          appState.muro_eje_d_r1=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje D - Recinto 1");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_d_r1
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r1_muroe_nombreController.text), //--> Muros E (Muro Eje E - Reciento 1)
                        selected: appState.pantallaActual == 6,
                        onTap: () {
                          setState(() => appState.pantallaActual = 6);
                          appState.muro_eje_e_r1=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje E - Recinto 1");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_e_r1
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r1_murof_nombreController.text), //--> Muros F (Muro Eje F - Reciento 1)
                        selected: appState.pantallaActual == 7,
                        onTap: () {
                          setState(() => appState.pantallaActual = 7);
                          appState.muro_eje_f_r1=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje F - Recinto 1");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_f_r1
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r1_murog_nombreController.text), //--> Muros G (Muro Eje G - Reciento 1)
                        selected: appState.pantallaActual == 8,
                        onTap: () {
                          setState(() => appState.pantallaActual = 8);
                          appState.muro_eje_g_r1=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje g - Recinto 1");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_g_r1
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- "+appState.r1_pisocielo_nombreController.text), //--> Piso Cielo (Piso Cielo - Reciento 1)
                        selected: appState.pantallaActual == 9,
                        onTap: () {
                          setState(() => appState.pantallaActual = 9);
                          appState.obtenerHojaPisoCielo("Piso Cielo - Recinto 1");
                          appState.piso_cielo_r1=true;
                          Navigator.pop(context);
                        },
                        trailing: appState.piso_cielo_r1
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      )
                    ],
                  ),

                  //-- Recinto 2
                  ExpansionTile(
                    leading: Icon(Icons.looks_one, color: Colors.blueAccent),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            appState.recinto2_nombreController.text,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blueAccent),
                          onPressed: () async {
                            final nuevoNombre = await appState.EditarNombre(
                              context,
                              appState.recinto2_nombreController.text,
                            );
                            if (nuevoNombre != null && nuevoNombre.isNotEmpty) {
                              appState.actualizarNombreRecinto(2, nuevoNombre);
                            }
                          },
                        ),
                      ],
                    ),

                    childrenPadding: const EdgeInsets.only(left: 30),
                    children: [
                      ListTile(
                        title: Text("- Información " + appState.recinto2_nombreController.text), //--> Informacion de Recinto 2
                        selected: appState.pantallaActual == 10,
                        onTap: () {
                          setState(() => appState.pantallaActual = 10);
                          appState.muro_eje_p_info_r2 = true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje Principal - Recinto 2");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_p_info_r2
                            ? Icon(Icons.edit_document, color: Colors.green)
                            : Icon(Icons.edit_off, color: Colors.grey),
                      ),
                      ListTile(
                        title: Text("- Muro Principal Eje "+ appState.r2_murop_nombreController.text +" (Obligatorio)"), //--> Muros principal (Muro Eje A - Reciento 1)
                        selected: appState.pantallaActual == 11,
                        onTap: () {
                          setState(() => appState.pantallaActual = 11);
                          appState.muro_eje_p_r2 = true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje Principal - Recinto 2");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_p_r2
                            ? Icon(Icons.edit_document, color: Colors.green)
                            : Icon(Icons.edit_off, color: Colors.grey),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r2_murob_nombreController.text), //--> Muros B (Muro Eje B - Reciento 1)
                        selected: appState.pantallaActual == 12,
                        onTap: () {
                          setState(() => appState.pantallaActual = 12);
                          appState.muro_eje_b_r2=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje B - Recinto 2");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_b_r2
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r2_muroc_nombreController.text), //--> Muros C (Muro Eje C - Reciento 1)
                        selected: appState.pantallaActual == 13,
                        onTap: () {
                          setState(() => appState.pantallaActual = 13);
                          appState.muro_eje_c_r2=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje C - Recinto 2");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_c_r2
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r2_murod_nombreController.text), //--> Muros D (Muro Eje D - Reciento 1)
                        selected: appState.pantallaActual == 14,
                        onTap: () {
                          setState(() => appState.pantallaActual = 14);
                          appState.muro_eje_d_r2=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje D - Recinto 2");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_d_r2
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r2_muroe_nombreController.text), //--> Muros E (Muro Eje E - Reciento 1)
                        selected: appState.pantallaActual == 15,
                        onTap: () {
                          setState(() => appState.pantallaActual = 15);
                          appState.muro_eje_e_r2=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje E - Recinto 2");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_e_r2
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r2_murof_nombreController.text), //--> Muros F (Muro Eje F - Reciento 1)
                        selected: appState.pantallaActual == 16,
                        onTap: () {
                          setState(() => appState.pantallaActual = 16);
                          appState.muro_eje_f_r2=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje F - Recinto 2");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_f_r2
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r2_murog_nombreController.text), //--> Muros G (Muro Eje G - Reciento 1)
                        selected: appState.pantallaActual == 17,
                        onTap: () {
                          setState(() => appState.pantallaActual = 17);
                          appState.muro_eje_g_r2=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje G - Recinto 2");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_g_r2
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- "+appState.r2_pisocielo_nombreController.text), //--> Piso Cielo (Piso Cielo - Reciento 1)
                        selected: appState.pantallaActual == 18,
                        onTap: () {
                          setState(() => appState.pantallaActual = 18);
                          appState.obtenerHojaPisoCielo("Piso Cielo - Recinto 2");
                          appState.piso_cielo_r2=true;
                          Navigator.pop(context);
                        },
                        trailing: appState.piso_cielo_r2
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      )
                    ],
                  ),

                  //-- Recinto 3
                  ExpansionTile(
                    leading: Icon(Icons.looks_one, color: Colors.blueAccent),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            appState.recinto3_nombreController.text,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blueAccent),
                          onPressed: () async {
                            final nuevoNombre = await appState.EditarNombre(
                              context,
                              appState.recinto3_nombreController.text,
                            );
                            if (nuevoNombre != null && nuevoNombre.isNotEmpty) {
                              appState.actualizarNombreRecinto(3, nuevoNombre);
                            }
                          },
                        ),
                      ],
                    ),

                    childrenPadding: const EdgeInsets.only(left: 30),
                    children: [
                      ListTile(
                        title: Text("- Información " + appState.recinto3_nombreController.text), //--> Informacion de Recinto 2
                        selected: appState.pantallaActual == 19,
                        onTap: () {
                          setState(() => appState.pantallaActual = 19);
                          appState.muro_eje_p_info_r3 = true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje Principal - Recinto 3");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_p_info_r3
                            ? Icon(Icons.edit_document, color: Colors.green)
                            : Icon(Icons.edit_off, color: Colors.grey),
                      ),
                      ListTile(
                        title: Text("- Muro Principal Eje "+ appState.r3_murop_nombreController.text +" (Obligatorio)"), //--> Muros principal (Muro Eje A - Reciento 1)
                        selected: appState.pantallaActual == 20,
                        onTap: () {
                          setState(() => appState.pantallaActual = 20);
                          appState.muro_eje_p_r3 = true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje Principal - Recinto 3");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_p_r3
                            ? Icon(Icons.edit_document, color: Colors.green)
                            : Icon(Icons.edit_off, color: Colors.grey),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r3_murob_nombreController.text), //--> Muros B (Muro Eje B - Reciento 1)
                        selected: appState.pantallaActual == 21,
                        onTap: () {
                          setState(() => appState.pantallaActual = 21);
                          appState.muro_eje_b_r3=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje B - Recinto 3");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_b_r3
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r3_muroc_nombreController.text), //--> Muros C (Muro Eje C - Reciento 1)
                        selected: appState.pantallaActual == 22,
                        onTap: () {
                          setState(() => appState.pantallaActual = 22);
                          appState.muro_eje_c_r3=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje C - Recinto 3");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_c_r3
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r3_murod_nombreController.text), //--> Muros D (Muro Eje D - Reciento 1)
                        selected: appState.pantallaActual == 23,
                        onTap: () {
                          setState(() => appState.pantallaActual = 23);
                          appState.muro_eje_d_r3=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje D - Recinto 3");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_d_r3
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r3_muroe_nombreController.text), //--> Muros E (Muro Eje E - Reciento 1)
                        selected: appState.pantallaActual == 24,
                        onTap: () {
                          setState(() => appState.pantallaActual = 24);
                          appState.muro_eje_e_r3=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje E - Recinto 3");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_e_r3
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r3_murof_nombreController.text), //--> Muros F (Muro Eje F - Reciento 1)
                        selected: appState.pantallaActual == 25,
                        onTap: () {
                          setState(() => appState.pantallaActual = 25);
                          appState.muro_eje_f_r3=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje F - Recinto 3");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_f_r3
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r3_murog_nombreController.text), //--> Muros G (Muro Eje G - Reciento 1)
                        selected: appState.pantallaActual == 26,
                        onTap: () {
                          setState(() => appState.pantallaActual = 26);
                          appState.muro_eje_g_r3=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje G - Recinto 3");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_g_r3
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- "+appState.r3_pisocielo_nombreController.text), //--> Piso Cielo (Piso Cielo - Reciento 1)
                        selected: appState.pantallaActual == 27,
                        onTap: () {
                          setState(() => appState.pantallaActual = 27);
                          appState.obtenerHojaPisoCielo("Piso Cielo - Recinto 3");
                          appState.piso_cielo_r3=true;
                          Navigator.pop(context);
                        },
                        trailing: appState.piso_cielo_r3
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      )
                    ],
                  ),


                  //-- Recinto 4
                  ExpansionTile(
                    leading: Icon(Icons.looks_one, color: Colors.blueAccent),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            appState.recinto4_nombreController.text,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blueAccent),
                          onPressed: () async {
                            final nuevoNombre = await appState.EditarNombre(
                              context,
                              appState.recinto4_nombreController.text,
                            );
                            if (nuevoNombre != null && nuevoNombre.isNotEmpty) {
                              appState.actualizarNombreRecinto(4, nuevoNombre);
                            }
                          },
                        ),
                      ],
                    ),

                    childrenPadding: const EdgeInsets.only(left: 30),
                    children: [
                      ListTile(
                        title: Text("- Información " + appState.recinto4_nombreController.text), //--> Informacion de Recinto 2
                        selected: appState.pantallaActual == 28,
                        onTap: () {
                          setState(() => appState.pantallaActual = 28);
                          appState.muro_eje_p_info_r4= true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje Principal - Recinto 4");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_p_info_r4
                            ? Icon(Icons.edit_document, color: Colors.green)
                            : Icon(Icons.edit_off, color: Colors.grey),
                      ),
                      ListTile(
                        title: Text("- Muro Principal Eje "+ appState.r4_murop_nombreController.text +" (Obligatorio)"), //--> Muros principal (Muro Eje A - Reciento 1)
                        selected: appState.pantallaActual == 29,
                        onTap: () {
                          setState(() => appState.pantallaActual = 29);
                          appState.muro_eje_p_r4= true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje Principal - Recinto 4");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_p_r4
                            ? Icon(Icons.edit_document, color: Colors.green)
                            : Icon(Icons.edit_off, color: Colors.grey),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r4_murob_nombreController.text), //--> Muros B (Muro Eje B - Reciento 1)
                        selected: appState.pantallaActual == 30,
                        onTap: () {
                          setState(() => appState.pantallaActual = 30);
                          appState.muro_eje_b_r4=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje B - Recinto 4");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_b_r4
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r4_muroc_nombreController.text), //--> Muros C (Muro Eje C - Reciento 1)
                        selected: appState.pantallaActual == 31,
                        onTap: () {
                          setState(() => appState.pantallaActual = 31);
                          appState.muro_eje_c_r4=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje C - Recinto 4");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_c_r4
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r4_murod_nombreController.text), //--> Muros D (Muro Eje D - Reciento 1)
                        selected: appState.pantallaActual == 32,
                        onTap: () {
                          setState(() => appState.pantallaActual = 32);
                          appState.muro_eje_d_r4=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje D - Recinto 4");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_d_r4
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r4_muroe_nombreController.text), //--> Muros E (Muro Eje E - Reciento 1)
                        selected: appState.pantallaActual == 33,
                        onTap: () {
                          setState(() => appState.pantallaActual = 33);
                          appState.muro_eje_e_r4=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje E - Recinto 4");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_e_r4
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r4_murof_nombreController.text), //--> Muros F (Muro Eje F - Reciento 1)
                        selected: appState.pantallaActual == 34,
                        onTap: () {
                          setState(() => appState.pantallaActual = 34);
                          appState.muro_eje_f_r4=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje F - Recinto 4");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_f_r4
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r4_murog_nombreController.text), //--> Muros G (Muro Eje G - Reciento 1)
                        selected: appState.pantallaActual == 35,
                        onTap: () {
                          setState(() => appState.pantallaActual = 35);
                          appState.muro_eje_g_r4=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje G - Recinto 4");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_g_r4
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- "+appState.r4_pisocielo_nombreController.text), //--> Piso Cielo (Piso Cielo - Reciento 1)
                        selected: appState.pantallaActual == 36,
                        onTap: () {
                          setState(() => appState.pantallaActual = 36);
                          appState.obtenerHojaPisoCielo("Piso Cielo - Recinto 4");
                          appState.piso_cielo_r4=true;
                          Navigator.pop(context);
                        },
                        trailing: appState.piso_cielo_r4
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      )
                    ],
                  ),


                  //-- Recinto 5
                  ExpansionTile(
                    leading: Icon(Icons.looks_one, color: Colors.blueAccent),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            appState.recinto5_nombreController.text,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blueAccent),
                          onPressed: () async {
                            final nuevoNombre = await appState.EditarNombre(
                              context,
                              appState.recinto5_nombreController.text,
                            );
                            if (nuevoNombre != null && nuevoNombre.isNotEmpty) {
                              appState.actualizarNombreRecinto(5, nuevoNombre);
                            }
                          },
                        ),
                      ],
                    ),

                    childrenPadding: const EdgeInsets.only(left: 30),
                    children: [
                      ListTile(
                        title: Text("- Información " + appState.recinto5_nombreController.text), //--> Informacion de Recinto 2
                        selected: appState.pantallaActual == 37,
                        onTap: () {
                          setState(() => appState.pantallaActual = 37);
                          appState.muro_eje_p_info_r5= true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje Principal - Recinto 5");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_p_info_r5
                            ? Icon(Icons.edit_document, color: Colors.green)
                            : Icon(Icons.edit_off, color: Colors.grey),
                      ),
                      ListTile(
                        title: Text("- Muro Principal Eje "+ appState.r5_murop_nombreController.text +" (Obligatorio)"), //--> Muros principal (Muro Eje A - Reciento 1)
                        selected: appState.pantallaActual == 38,
                        onTap: () {
                          setState(() => appState.pantallaActual = 38);
                          appState.muro_eje_p_r5= true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje Principal - Recinto 5");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_p_r5
                            ? Icon(Icons.edit_document, color: Colors.green)
                            : Icon(Icons.edit_off, color: Colors.grey),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r5_murob_nombreController.text), //--> Muros B (Muro Eje B - Reciento 1)
                        selected: appState.pantallaActual == 39,
                        onTap: () {
                          setState(() => appState.pantallaActual = 39);
                          appState.muro_eje_b_r5=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje B - Recinto 5");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_b_r5
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r5_muroc_nombreController.text), //--> Muros C (Muro Eje C - Reciento 1)
                        selected: appState.pantallaActual == 40,
                        onTap: () {
                          setState(() => appState.pantallaActual = 40);
                          appState.muro_eje_c_r5=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje C - Recinto 5");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_c_r5
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r5_murod_nombreController.text), //--> Muros D (Muro Eje D - Reciento 1)
                        selected: appState.pantallaActual == 41,
                        onTap: () {
                          setState(() => appState.pantallaActual = 41);
                          appState.muro_eje_d_r5=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje D - Recinto 5");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_d_r5
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r5_muroe_nombreController.text), //--> Muros E (Muro Eje E - Reciento 1)
                        selected: appState.pantallaActual == 42,
                        onTap: () {
                          setState(() => appState.pantallaActual = 42);
                          appState.muro_eje_e_r5=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje E - Recinto 5");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_e_r5
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r5_murof_nombreController.text), //--> Muros F (Muro Eje F - Reciento 1)
                        selected: appState.pantallaActual == 43,
                        onTap: () {
                          setState(() => appState.pantallaActual = 43);
                          appState.muro_eje_f_r5=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje F - Recinto 5");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_f_r5
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- Muro Eje "+appState.r5_murog_nombreController.text), //--> Muros G (Muro Eje G - Reciento 1)
                        selected: appState.pantallaActual == 44,
                        onTap: () {
                          setState(() => appState.pantallaActual = 44);
                          appState.muro_eje_g_r5=true;
                          appState.obtenerHojaMuroPrincipal("Muro Eje G - Recinto 5");
                          Navigator.pop(context);
                        },
                        trailing: appState.muro_eje_g_r5
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      ),
                      ListTile(
                        title: Text("- "+appState.r5_pisocielo_nombreController.text), //--> Piso Cielo (Piso Cielo - Reciento 1)
                        selected: appState.pantallaActual == 45,
                        onTap: () {
                          setState(() => appState.pantallaActual = 45);
                          appState.obtenerHojaPisoCielo("Piso Cielo - Recinto 5");
                          appState.piso_cielo_r5=true;
                          Navigator.pop(context);
                        },
                        trailing: appState.piso_cielo_r5
                            ? Icon(Icons.edit_document, color: Colors.green, size: 24.0)
                            : Icon(Icons.edit_off, color: Colors.grey, size: 24.0),
                      )
                    ],
                  ),

                  const SizedBox(height: 50),

                ],
              ),
            ),
          ],
        ),
      ),

      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: pantallas[appState.pantallaActual],
      ),
    );
  }


}
