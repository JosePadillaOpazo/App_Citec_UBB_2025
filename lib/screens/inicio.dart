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

                        const SizedBox(height: 20),

                        ElevatedButton.icon(
                            icon: const Icon(Icons.add),
                            label: const Text("Nuevo Proyecto"),
                            onPressed:() {
                              _mostrarDialogoNuevoProyecto(context);
                            }
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

  Future<void> _mostrarDialogoNuevoProyecto(BuildContext context) async {
    final nombreController = TextEditingController();
    final regionController = TextEditingController();
    final comunaController = TextEditingController();
    final etapaController = TextEditingController();

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nuevo Proyecto'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nombreController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre del proyecto',
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: etapaController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Etapa de proyecto',
                  ),
                ),
                const SizedBox(height: 16),

                ValueListenableBuilder(
                  valueListenable: regionController,
                  builder: (context, value, _) {

                    final region = regionController.text;

                    List<DropdownMenuItem<String>> comunas = [];

                    switch (region) {

                      case "Arica y Parinacota":
                        comunas = const [
                          DropdownMenuItem(value: "Arica", child: Text("Arica")),
                          DropdownMenuItem(value: "Camarones", child: Text("Camarones")),
                          DropdownMenuItem(value: "Putre", child: Text("Putre")),
                          DropdownMenuItem(value: "General Lagos", child: Text("General Lagos")),
                        ];
                        break;

                      case "Tarapacá":
                        comunas = const [
                          DropdownMenuItem(value: "Iquique", child: Text("Iquique")),
                          DropdownMenuItem(value: "Alto Hospicio", child: Text("Alto Hospicio")),
                          DropdownMenuItem(value: "Pozo Almonte", child: Text("Pozo Almonte")),
                          DropdownMenuItem(value: "Pica", child: Text("Pica")),
                          DropdownMenuItem(value: "Huara", child: Text("Huara")),
                          DropdownMenuItem(value: "Colchane", child: Text("Colchane")),
                          DropdownMenuItem(value: "Camiña", child: Text("Camiña")),
                        ];
                        break;

                      case "Antofagasta":
                        comunas = const [
                          DropdownMenuItem(value: "Antofagasta", child: Text("Antofagasta")),
                          DropdownMenuItem(value: "Mejillones", child: Text("Mejillones")),
                          DropdownMenuItem(value: "Sierra Gorda", child: Text("Sierra Gorda")),
                          DropdownMenuItem(value: "Taltal", child: Text("Taltal")),
                          DropdownMenuItem(value: "Calama", child: Text("Calama")),
                          DropdownMenuItem(value: "Ollagüe", child: Text("Ollagüe")),
                          DropdownMenuItem(value: "San Pedro de Atacama", child: Text("San Pedro de Atacama")),
                          DropdownMenuItem(value: "Tocopilla", child: Text("Tocopilla")),
                          DropdownMenuItem(value: "María Elena", child: Text("María Elena")),
                        ];
                        break;

                      case "Atacama":
                        comunas = const [
                          DropdownMenuItem(value: "Copiapó", child: Text("Copiapó")),
                          DropdownMenuItem(value: "Caldera", child: Text("Caldera")),
                          DropdownMenuItem(value: "Tierra Amarilla", child: Text("Tierra Amarilla")),
                          DropdownMenuItem(value: "Chañaral", child: Text("Chañaral")),
                          DropdownMenuItem(value: "Diego de Almagro", child: Text("Diego de Almagro")),
                          DropdownMenuItem(value: "Vallenar", child: Text("Vallenar")),
                          DropdownMenuItem(value: "Freirina", child: Text("Freirina")),
                          DropdownMenuItem(value: "Huasco", child: Text("Huasco")),
                          DropdownMenuItem(value: "Alto del Carmen", child: Text("Alto del Carmen")),
                        ];
                        break;

                      case "Coquimbo":
                        comunas = const [
                          DropdownMenuItem(value: "La Serena", child: Text("La Serena")),
                          DropdownMenuItem(value: "Coquimbo", child: Text("Coquimbo")),
                          DropdownMenuItem(value: "Andacollo", child: Text("Andacollo")),
                          DropdownMenuItem(value: "La Higuera", child: Text("La Higuera")),
                          DropdownMenuItem(value: "Vicuña", child: Text("Vicuña")),
                          DropdownMenuItem(value: "Paihuano", child: Text("Paihuano")),
                          DropdownMenuItem(value: "Ovalle", child: Text("Ovalle")),
                          DropdownMenuItem(value: "Monte Patria", child: Text("Monte Patria")),
                          DropdownMenuItem(value: "Combarbalá", child: Text("Combarbalá")),
                          DropdownMenuItem(value: "Punitaqui", child: Text("Punitaqui")),
                          DropdownMenuItem(value: "Río Hurtado", child: Text("Río Hurtado")),
                          DropdownMenuItem(value: "Illapel", child: Text("Illapel")),
                          DropdownMenuItem(value: "Salamanca", child: Text("Salamanca")),
                          DropdownMenuItem(value: "Los Vilos", child: Text("Los Vilos")),
                          DropdownMenuItem(value: "Canela", child: Text("Canela")),
                        ];
                        break;

                      case "Valparaíso":
                        comunas = const [
                          DropdownMenuItem(value: "Valparaíso", child: Text("Valparaíso")),
                          DropdownMenuItem(value: "Viña del Mar", child: Text("Viña del Mar")),
                          DropdownMenuItem(value: "Concón", child: Text("Concón")),
                          DropdownMenuItem(value: "Quilpué", child: Text("Quilpué")),
                          DropdownMenuItem(value: "Villa Alemana", child: Text("Villa Alemana")),
                          DropdownMenuItem(value: "Quillota", child: Text("Quillota")),
                          DropdownMenuItem(value: "La Calera", child: Text("La Calera")),
                          DropdownMenuItem(value: "Hijuelas", child: Text("Hijuelas")),
                          DropdownMenuItem(value: "Nogales", child: Text("Nogales")),
                          DropdownMenuItem(value: "La Cruz", child: Text("La Cruz")),
                          DropdownMenuItem(value: "San Antonio", child: Text("San Antonio")),
                          DropdownMenuItem(value: "Cartagena", child: Text("Cartagena")),
                          DropdownMenuItem(value: "El Quisco", child: Text("El Quisco")),
                          DropdownMenuItem(value: "El Tabo", child: Text("El Tabo")),
                          DropdownMenuItem(value: "Algarrobo", child: Text("Algarrobo")),
                          DropdownMenuItem(value: "Santo Domingo", child: Text("Santo Domingo")),
                          DropdownMenuItem(value: "San Felipe", child: Text("San Felipe")),
                          DropdownMenuItem(value: "Putaendo", child: Text("Putaendo")),
                          DropdownMenuItem(value: "Santa María", child: Text("Santa María")),
                          DropdownMenuItem(value: "Panquehue", child: Text("Panquehue")),
                          DropdownMenuItem(value: "Catemu", child: Text("Catemu")),
                          DropdownMenuItem(value: "Los Andes", child: Text("Los Andes")),
                          DropdownMenuItem(value: "Calle Larga", child: Text("Calle Larga")),
                          DropdownMenuItem(value: "Rinconada", child: Text("Rinconada")),
                          DropdownMenuItem(value: "San Esteban", child: Text("San Esteban")),
                          DropdownMenuItem(value: "La Ligua", child: Text("La Ligua")),
                          DropdownMenuItem(value: "Petorca", child: Text("Petorca")),
                          DropdownMenuItem(value: "Cabildo", child: Text("Cabildo")),
                          DropdownMenuItem(value: "Papudo", child: Text("Papudo")),
                          DropdownMenuItem(value: "Zapallar", child: Text("Zapallar")),
                          DropdownMenuItem(value: "Isla de Pascua", child: Text("Isla de Pascua")),
                        ];
                        break;

                      case "Metropolitana":
                        comunas = const [
                          DropdownMenuItem(value: "Santiago", child: Text("Santiago")),
                          DropdownMenuItem(value: "Cerrillos", child: Text("Cerrillos")),
                          DropdownMenuItem(value: "Cerro Navia", child: Text("Cerro Navia")),
                          DropdownMenuItem(value: "Conchalí", child: Text("Conchalí")),
                          DropdownMenuItem(value: "El Bosque", child: Text("El Bosque")),
                          DropdownMenuItem(value: "Estación Central", child: Text("Estación Central")),
                          DropdownMenuItem(value: "Huechuraba", child: Text("Huechuraba")),
                          DropdownMenuItem(value: "Independencia", child: Text("Independencia")),
                          DropdownMenuItem(value: "La Cisterna", child: Text("La Cisterna")),
                          DropdownMenuItem(value: "La Florida", child: Text("La Florida")),
                          DropdownMenuItem(value: "La Granja", child: Text("La Granja")),
                          DropdownMenuItem(value: "La Pintana", child: Text("La Pintana")),
                          DropdownMenuItem(value: "La Reina", child: Text("La Reina")),
                          DropdownMenuItem(value: "Las Condes", child: Text("Las Condes")),
                          DropdownMenuItem(value: "Lo Barnechea", child: Text("Lo Barnechea")),
                          DropdownMenuItem(value: "Lo Espejo", child: Text("Lo Espejo")),
                          DropdownMenuItem(value: "Lo Prado", child: Text("Lo Prado")),
                          DropdownMenuItem(value: "Macul", child: Text("Macul")),
                          DropdownMenuItem(value: "Maipú", child: Text("Maipú")),
                          DropdownMenuItem(value: "Ñuñoa", child: Text("Ñuñoa")),
                          DropdownMenuItem(value: "Pedro Aguirre Cerda", child: Text("Pedro Aguirre Cerda")),
                          DropdownMenuItem(value: "Peñalolén", child: Text("Peñalolén")),
                          DropdownMenuItem(value: "Providencia", child: Text("Providencia")),
                          DropdownMenuItem(value: "Pudahuel", child: Text("Pudahuel")),
                          DropdownMenuItem(value: "Quilicura", child: Text("Quilicura")),
                          DropdownMenuItem(value: "Quinta Normal", child: Text("Quinta Normal")),
                          DropdownMenuItem(value: "Recoleta", child: Text("Recoleta")),
                          DropdownMenuItem(value: "Renca", child: Text("Renca")),
                          DropdownMenuItem(value: "San Joaquín", child: Text("San Joaquín")),
                          DropdownMenuItem(value: "San Miguel", child: Text("San Miguel")),
                          DropdownMenuItem(value: "San Ramón", child: Text("San Ramón")),
                          DropdownMenuItem(value: "Vitacura", child: Text("Vitacura")),
                          DropdownMenuItem(value: "Puente Alto", child: Text("Puente Alto")),
                          DropdownMenuItem(value: "Pirque", child: Text("Pirque")),
                          DropdownMenuItem(value: "San José de Maipo", child: Text("San José de Maipo")),
                          DropdownMenuItem(value: "Colina", child: Text("Colina")),
                          DropdownMenuItem(value: "Lampa", child: Text("Lampa")),
                          DropdownMenuItem(value: "Tiltil", child: Text("Tiltil")),
                          DropdownMenuItem(value: "San Bernardo", child: Text("San Bernardo")),
                          DropdownMenuItem(value: "Buin", child: Text("Buin")),
                          DropdownMenuItem(value: "Paine", child: Text("Paine")),
                          DropdownMenuItem(value: "Calera de Tango", child: Text("Calera de Tango")),
                          DropdownMenuItem(value: "Talagante", child: Text("Talagante")),
                          DropdownMenuItem(value: "Peñaflor", child: Text("Peñaflor")),
                          DropdownMenuItem(value: "Isla de Maipo", child: Text("Isla de Maipo")),
                          DropdownMenuItem(value: "El Monte", child: Text("El Monte")),
                          DropdownMenuItem(value: "Melipilla", child: Text("Melipilla")),
                          DropdownMenuItem(value: "Curacaví", child: Text("Curacaví")),
                          DropdownMenuItem(value: "María Pinto", child: Text("María Pinto")),
                          DropdownMenuItem(value: "Alhué", child: Text("Alhué")),
                          DropdownMenuItem(value: "San Pedro", child: Text("San Pedro")),
                        ];
                        break;

                      case "O’Higgins":
                        comunas = const [
                          DropdownMenuItem(value: "Rancagua", child: Text("Rancagua")),
                          DropdownMenuItem(value: "Machalí", child: Text("Machalí")),
                          DropdownMenuItem(value: "Graneros", child: Text("Graneros")),
                          DropdownMenuItem(value: "Mostazal", child: Text("Mostazal")),
                          DropdownMenuItem(value: "Doñihue", child: Text("Doñihue")),
                          DropdownMenuItem(value: "Requínoa", child: Text("Requínoa")),
                          DropdownMenuItem(value: "Rengo", child: Text("Rengo")),
                          DropdownMenuItem(value: "Malloa", child: Text("Malloa")),
                          DropdownMenuItem(value: "Quinta de Tilcoco", child: Text("Quinta de Tilcoco")),
                          DropdownMenuItem(value: "San Vicente", child: Text("San Vicente")),
                          DropdownMenuItem(value: "Pichidegua", child: Text("Pichidegua")),
                          DropdownMenuItem(value: "Peumo", child: Text("Peumo")),
                          DropdownMenuItem(value: "Las Cabras", child: Text("Las Cabras")),
                          DropdownMenuItem(value: "Coltauco", child: Text("Coltauco")),
                          DropdownMenuItem(value: "San Fernando", child: Text("San Fernando")),
                          DropdownMenuItem(value: "Chimbarongo", child: Text("Chimbarongo")),
                          DropdownMenuItem(value: "Placilla", child: Text("Placilla")),
                          DropdownMenuItem(value: "Nancagua", child: Text("Nancagua")),
                          DropdownMenuItem(value: "Chépica", child: Text("Chépica")),
                          DropdownMenuItem(value: "Santa Cruz", child: Text("Santa Cruz")),
                          DropdownMenuItem(value: "Pichilemu", child: Text("Pichilemu")),
                          DropdownMenuItem(value: "Navidad", child: Text("Navidad")),
                          DropdownMenuItem(value: "Litueche", child: Text("Litueche")),
                          DropdownMenuItem(value: "Marchigüe", child: Text("Marchigüe")),
                          DropdownMenuItem(value: "Paredones", child: Text("Paredones")),
                        ];
                        break;

                      case "Maule":
                        comunas = const [
                          DropdownMenuItem(value: "Talca", child: Text("Talca")),
                          DropdownMenuItem(value: "San Clemente", child: Text("San Clemente")),
                          DropdownMenuItem(value: "Pelarco", child: Text("Pelarco")),
                          DropdownMenuItem(value: "Pencahue", child: Text("Pencahue")),
                          DropdownMenuItem(value: "Maule", child: Text("Maule")),
                          DropdownMenuItem(value: "Curepto", child: Text("Curepto")),
                          DropdownMenuItem(value: "Constitución", child: Text("Constitución")),
                          DropdownMenuItem(value: "Empedrado", child: Text("Empedrado")),
                          DropdownMenuItem(value: "Curicó", child: Text("Curicó")),
                          DropdownMenuItem(value: "Teno", child: Text("Teno")),
                          DropdownMenuItem(value: "Romeral", child: Text("Romeral")),
                          DropdownMenuItem(value: "Molina", child: Text("Molina")),
                          DropdownMenuItem(value: "Sagrada Familia", child: Text("Sagrada Familia")),
                          DropdownMenuItem(value: "Hualañé", child: Text("Hualañé")),
                          DropdownMenuItem(value: "Licantén", child: Text("Licantén")),
                          DropdownMenuItem(value: "Vichuquén", child: Text("Vichuquén")),
                          DropdownMenuItem(value: "Linares", child: Text("Linares")),
                          DropdownMenuItem(value: "Yerbas Buenas", child: Text("Yerbas Buenas")),
                          DropdownMenuItem(value: "Colbún", child: Text("Colbún")),
                          DropdownMenuItem(value: "Longaví", child: Text("Longaví")),
                          DropdownMenuItem(value: "Parral", child: Text("Parral")),
                          DropdownMenuItem(value: "Retiro", child: Text("Retiro")),
                          DropdownMenuItem(value: "Cauquenes", child: Text("Cauquenes")),
                          DropdownMenuItem(value: "Pelluhue", child: Text("Pelluhue")),
                          DropdownMenuItem(value: "Chanco", child: Text("Chanco")),
                        ];
                        break;

                      case "Ñuble":
                        comunas = const [
                          DropdownMenuItem(value: "Chillán", child: Text("Chillán")),
                          DropdownMenuItem(value: "Chillán Viejo", child: Text("Chillán Viejo")),
                          DropdownMenuItem(value: "Bulnes", child: Text("Bulnes")),
                          DropdownMenuItem(value: "San Ignacio", child: Text("San Ignacio")),
                          DropdownMenuItem(value: "El Carmen", child: Text("El Carmen")),
                          DropdownMenuItem(value: "Pemuco", child: Text("Pemuco")),
                          DropdownMenuItem(value: "Yungay", child: Text("Yungay")),
                          DropdownMenuItem(value: "San Carlos", child: Text("San Carlos")),
                          DropdownMenuItem(value: "Ñiquén", child: Text("Ñiquén")),
                          DropdownMenuItem(value: "San Fabián", child: Text("San Fabián")),
                          DropdownMenuItem(value: "Coihueco", child: Text("Coihueco")),
                          DropdownMenuItem(value: "Quirihue", child: Text("Quirihue")),
                          DropdownMenuItem(value: "Ninhue", child: Text("Ninhue")),
                          DropdownMenuItem(value: "Trehuaco", child: Text("Trehuaco")),
                          DropdownMenuItem(value: "Cobquecura", child: Text("Cobquecura")),
                          DropdownMenuItem(value: "Coelemu", child: Text("Coelemu")),
                          DropdownMenuItem(value: "Portezuelo", child: Text("Portezuelo")),
                          DropdownMenuItem(value: "Ránquil", child: Text("Ránquil")),
                        ];
                        break;

                      case "Biobío":
                        comunas = const [
                          DropdownMenuItem(value: "Concepción", child: Text("Concepción")),
                          DropdownMenuItem(value: "Talcahuano", child: Text("Talcahuano")),
                          DropdownMenuItem(value: "Hualpén", child: Text("Hualpén")),
                          DropdownMenuItem(value: "San Pedro de la Paz", child: Text("San Pedro de la Paz")),
                          DropdownMenuItem(value: "Chiguayante", child: Text("Chiguayante")),
                          DropdownMenuItem(value: "Penco", child: Text("Penco")),
                          DropdownMenuItem(value: "Tomé", child: Text("Tomé")),
                          DropdownMenuItem(value: "Florida", child: Text("Florida")),
                          DropdownMenuItem(value: "Hualqui", child: Text("Hualqui")),
                          DropdownMenuItem(value: "Santa Juana", child: Text("Santa Juana")),
                          DropdownMenuItem(value: "Coronel", child: Text("Coronel")),
                          DropdownMenuItem(value: "Lota", child: Text("Lota")),
                          DropdownMenuItem(value: "Lebu", child: Text("Lebu")),
                          DropdownMenuItem(value: "Arauco", child: Text("Arauco")),
                          DropdownMenuItem(value: "Cañete", child: Text("Cañete")),
                          DropdownMenuItem(value: "Contulmo", child: Text("Contulmo")),
                          DropdownMenuItem(value: "Tirúa", child: Text("Tirúa")),
                          DropdownMenuItem(value: "Los Álamos", child: Text("Los Álamos")),
                          DropdownMenuItem(value: "Curanilahue", child: Text("Curanilahue")),
                          DropdownMenuItem(value: "Los Ángeles", child: Text("Los Ángeles")),
                          DropdownMenuItem(value: "Mulchén", child: Text("Mulchén")),
                          DropdownMenuItem(value: "Nacimiento", child: Text("Nacimiento")),
                          DropdownMenuItem(value: "Negrete", child: Text("Negrete")),
                          DropdownMenuItem(value: "Laja", child: Text("Laja")),
                          DropdownMenuItem(value: "San Rosendo", child: Text("San Rosendo")),
                          DropdownMenuItem(value: "Cabrero", child: Text("Cabrero")),
                          DropdownMenuItem(value: "Tucapel", child: Text("Tucapel")),
                          DropdownMenuItem(value: "Quilleco", child: Text("Quilleco")),
                          DropdownMenuItem(value: "Santa Bárbara", child: Text("Santa Bárbara")),
                          DropdownMenuItem(value: "Antuco", child: Text("Antuco")),
                        ];
                        break;

                      case "La Araucanía":
                        comunas = const [
                          DropdownMenuItem(value: "Temuco", child: Text("Temuco")),
                          DropdownMenuItem(value: "Padre Las Casas", child: Text("Padre Las Casas")),
                          DropdownMenuItem(value: "Vilcún", child: Text("Vilcún")),
                          DropdownMenuItem(value: "Freire", child: Text("Freire")),
                          DropdownMenuItem(value: "Pitrufquén", child: Text("Pitrufquén")),
                          DropdownMenuItem(value: "Gorbea", child: Text("Gorbea")),
                          DropdownMenuItem(value: "Loncoche", child: Text("Loncoche")),
                          DropdownMenuItem(value: "Villarrica", child: Text("Villarrica")),
                          DropdownMenuItem(value: "Pucón", child: Text("Pucón")),
                          DropdownMenuItem(value: "Curarrehue", child: Text("Curarrehue")),
                          DropdownMenuItem(value: "Toltén", child: Text("Toltén")),
                          DropdownMenuItem(value: "Teodoro Schmidt", child: Text("Teodoro Schmidt")),
                          DropdownMenuItem(value: "Nueva Imperial", child: Text("Nueva Imperial")),
                          DropdownMenuItem(value: "Carahue", child: Text("Carahue")),
                          DropdownMenuItem(value: "Saavedra", child: Text("Saavedra")),
                          DropdownMenuItem(value: "Angol", child: Text("Angol")),
                          DropdownMenuItem(value: "Collipulli", child: Text("Collipulli")),
                          DropdownMenuItem(value: "Ercilla", child: Text("Ercilla")),
                          DropdownMenuItem(value: "Victoria", child: Text("Victoria")),
                          DropdownMenuItem(value: "Traiguén", child: Text("Traiguén")),
                          DropdownMenuItem(value: "Lumaco", child: Text("Lumaco")),
                          DropdownMenuItem(value: "Renaico", child: Text("Renaico")),
                          DropdownMenuItem(value: "Purén", child: Text("Purén")),
                          DropdownMenuItem(value: "Los Sauces", child: Text("Los Sauces")),
                        ];
                        break;

                      case "Los Ríos":
                        comunas = const [
                          DropdownMenuItem(value: "Valdivia", child: Text("Valdivia")),
                          DropdownMenuItem(value: "Mariquina", child: Text("Mariquina")),
                          DropdownMenuItem(value: "Máfil", child: Text("Máfil")),
                          DropdownMenuItem(value: "Los Lagos", child: Text("Los Lagos")),
                          DropdownMenuItem(value: "Panguipulli", child: Text("Panguipulli")),
                          DropdownMenuItem(value: "Corral", child: Text("Corral")),
                          DropdownMenuItem(value: "Lanco", child: Text("Lanco")),
                          DropdownMenuItem(value: "Paillaco", child: Text("Paillaco")),
                          DropdownMenuItem(value: "La Unión", child: Text("La Unión")),
                          DropdownMenuItem(value: "Río Bueno", child: Text("Río Bueno")),
                          DropdownMenuItem(value: "Lago Ranco", child: Text("Lago Ranco")),
                          DropdownMenuItem(value: "Futrono", child: Text("Futrono")),
                        ];
                        break;

                      case "Los Lagos":
                        comunas = const [
                          DropdownMenuItem(value: "Puerto Montt", child: Text("Puerto Montt")),
                          DropdownMenuItem(value: "Puerto Varas", child: Text("Puerto Varas")),
                          DropdownMenuItem(value: "Frutillar", child: Text("Frutillar")),
                          DropdownMenuItem(value: "Llanquihue", child: Text("Llanquihue")),
                          DropdownMenuItem(value: "Los Muermos", child: Text("Los Muermos")),
                          DropdownMenuItem(value: "Maullín", child: Text("Maullín")),
                          DropdownMenuItem(value: "Calbuco", child: Text("Calbuco")),
                          DropdownMenuItem(value: "Cochamó", child: Text("Cochamó")),
                          DropdownMenuItem(value: "Osorno", child: Text("Osorno")),
                          DropdownMenuItem(value: "Puerto Octay", child: Text("Puerto Octay")),
                          DropdownMenuItem(value: "Purranque", child: Text("Purranque")),
                          DropdownMenuItem(value: "Puyehue", child: Text("Puyehue")),
                          DropdownMenuItem(value: "Río Negro", child: Text("Río Negro")),
                          DropdownMenuItem(value: "San Pablo", child: Text("San Pablo")),
                          DropdownMenuItem(value: "Ancud", child: Text("Ancud")),
                          DropdownMenuItem(value: "Castro", child: Text("Castro")),
                          DropdownMenuItem(value: "Dalcahue", child: Text("Dalcahue")),
                          DropdownMenuItem(value: "Chonchi", child: Text("Chonchi")),
                          DropdownMenuItem(value: "Queilén", child: Text("Queilén")),
                          DropdownMenuItem(value: "Quellón", child: Text("Quellón")),
                          DropdownMenuItem(value: "Curaco de Vélez", child: Text("Curaco de Vélez")),
                          DropdownMenuItem(value: "Puqueldón", child: Text("Puqueldón")),
                          DropdownMenuItem(value: "Quemchi", child: Text("Quemchi")),
                          DropdownMenuItem(value: "Palena", child: Text("Palena")),
                          DropdownMenuItem(value: "Futaleufú", child: Text("Futaleufú")),
                          DropdownMenuItem(value: "Chaitén", child: Text("Chaitén")),
                          DropdownMenuItem(value: "Hualaihué", child: Text("Hualaihué")),
                        ];
                        break;

                      case "Aysén":
                        comunas = const [
                          DropdownMenuItem(value: "Coyhaique", child: Text("Coyhaique")),
                          DropdownMenuItem(value: "Lago Verde", child: Text("Lago Verde")),
                          DropdownMenuItem(value: "Aysén", child: Text("Aysén")),
                          DropdownMenuItem(value: "Cisnes", child: Text("Cisnes")),
                          DropdownMenuItem(value: "Guaitecas", child: Text("Guaitecas")),
                          DropdownMenuItem(value: "Chile Chico", child: Text("Chile Chico")),
                          DropdownMenuItem(value: "Río Ibáñez", child: Text("Río Ibáñez")),
                          DropdownMenuItem(value: "Cochrane", child: Text("Cochrane")),
                          DropdownMenuItem(value: "O’Higgins", child: Text("O’Higgins")),
                          DropdownMenuItem(value: "Tortel", child: Text("Tortel")),
                        ];
                        break;

                      case "Magallanes":
                        comunas = const [
                          DropdownMenuItem(value: "Punta Arenas", child: Text("Punta Arenas")),
                          DropdownMenuItem(value: "Laguna Blanca", child: Text("Laguna Blanca")),
                          DropdownMenuItem(value: "Río Verde", child: Text("Río Verde")),
                          DropdownMenuItem(value: "San Gregorio", child: Text("San Gregorio")),
                          DropdownMenuItem(value: "Puerto Natales", child: Text("Puerto Natales")),
                          DropdownMenuItem(value: "Torres del Paine", child: Text("Torres del Paine")),
                          DropdownMenuItem(value: "Porvenir", child: Text("Porvenir")),
                          DropdownMenuItem(value: "Primavera", child: Text("Primavera")),
                          DropdownMenuItem(value: "Timaukel", child: Text("Timaukel")),
                          DropdownMenuItem(value: "Cabo de Hornos", child: Text("Cabo de Hornos")),
                          DropdownMenuItem(value: "Antártica", child: Text("Antártica")),
                        ];
                        break;

                    }

                    final comunasValue = comunas.any(
                          (item) => item.value == comunaController.text,
                    )
                        ? comunaController.text
                        : null;


                    return Column(
                      children: [
                        DropdownButtonFormField<String>(
                          value: regionController.text.isEmpty
                              ? null
                              : regionController.text,
                          decoration: const InputDecoration(
                            labelText: "Región",
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(value: "Arica y Parinacota", child: Text("Arica y Parinacota")),
                            DropdownMenuItem(value: "Tarapacá", child: Text("Tarapacá")),
                            DropdownMenuItem(value: "Antofagasta", child: Text("Antofagasta")),
                            DropdownMenuItem(value: "Atacama", child: Text("Atacama")),
                            DropdownMenuItem(value: "Coquimbo", child: Text("Coquimbo")),
                            DropdownMenuItem(value: "Valparaíso", child: Text("Valparaíso")),
                            DropdownMenuItem(value: "Metropolitana", child: Text("Metropolitana")),
                            DropdownMenuItem(value: "O’Higgins", child: Text("O’Higgins")),
                            DropdownMenuItem(value: "Maule", child: Text("Maule")),
                            DropdownMenuItem(value: "Ñuble", child: Text("Ñuble")),
                            DropdownMenuItem(value: "Biobío", child: Text("Biobío")),
                            DropdownMenuItem(value: "La Araucanía", child: Text("La Araucanía")),
                            DropdownMenuItem(value: "Los Ríos", child: Text("Los Ríos")),
                            DropdownMenuItem(value: "Los Lagos", child: Text("Los Lagos")),
                            DropdownMenuItem(value: "Aysén", child: Text("Aysén")),
                            DropdownMenuItem(value: "Magallanes", child: Text("Magallanes")),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              comunaController.text = "";
                              regionController.text = value;

                            }
                          },
                          validator: (_) {
                            if (regionController.text.isEmpty) {
                              return "Seleccione una Región";
                            }
                            return null;
                          },

                        ),

                        const SizedBox(height: 16),

                        DropdownButtonFormField<String>(
                          key: ValueKey(regionController.text),
                          value: comunasValue,
                          decoration: const InputDecoration(
                            labelText: "Comuna",
                            border: OutlineInputBorder(),
                          ),
                          items: comunas,
                          onChanged: comunas.isEmpty
                              ? null
                              : (value) {
                            if (value != null) {
                              comunaController.text = value;

                            }
                          },
                          validator: (_) =>
                          comunaController.text.isEmpty
                              ? "Seleccione una Comuna"
                              : null,
                        ),

                        const SizedBox(height: 20),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nombreController.text.isEmpty) return;

                await LocalDatabase.insertarProyecto({
                  'nombre_proyecto': nombreController.text,
                  'region': regionController.text,
                  'comuna': comunaController.text,
                  'etapa': etapaController.text,
                });
                debugPrint('NOMBRE: ${nombreController.text}');
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }


}
