import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import 'package:image_picker/image_picker.dart';

class InformacionGeneral extends StatefulWidget {
  const InformacionGeneral({super.key});

  @override
  State<InformacionGeneral> createState() => _InformacionGeneralState();
}

class _InformacionGeneralState extends State<InformacionGeneral> {
  final GlobalKey canvasKey_InfoGeneral_2 = GlobalKey();
  final GlobalKey canvasKey_InfoGeneral_3 = GlobalKey();
  final GlobalKey canvasKey_InfoGeneral_4 = GlobalKey();

  List<Offset?> _pointsImg2 = [];
  List<Offset?> _pointsImg3 = [];
  List<Offset?> _pointsImg4 = [];

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(50),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Title(
              color: Colors.blue,
              child: const Text(
                "Información General",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),


          Text(
            "Plano de la Vivienda:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => appState.obtenerImagenInfoGeneral(
                  fuente: ImageSource.camera,
                  imgnum: 1,
                  onImagenSeleccionada: (img) {
                    setState(() {
                      appState.imagen1_Info_General = img;
                      appState.imagen1GuardadaInfoGeneral = img;
                      appState.cantFotos++;
                      print("HAY UN TOTAL DE " + appState.cantFotos.toString() + " FOTOS");
                    });
                  },
                ),
                icon: Icon(Icons.camera_alt),
                label: Text("Tomar Foto"),
              ),
            ],
          ),

          const SizedBox(height: 20),

          if (appState.imagen1GuardadaInfoGeneral != null) ...[
            Center(
              child: Image.file(
                appState.imagen1GuardadaInfoGeneral!,
                width: 900,
                height: 800,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  await appState.eliminarDibujoInfoGeneral(
                    context: context,
                    imgnum: 1,
                  );
                  setState(() {
                    print("HAY UN TOTAL DE " + appState.cantFotos.toString() + " FOTOS");
                  });

                },
                icon: Icon(Icons.delete),
                label: Text("Eliminar"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ),
          ],

          const SizedBox(height: 30),

          Text(
            "ℹ️ Información General del Proyecto",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Nombre del proyecto",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),

              Text(
                " *",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red),
              ),

              IconButton(
                icon: Icon(Icons.info_rounded),
                color: Colors.grey,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Campos obligatorios"),
                        content: Text("El símbolo * indica los campos obligatorios."),
                        actions: [
                          ElevatedButton(
                            child: Text("Aceptar"),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),


          TextFormField(
            controller: appState.nombreProyectoController,
            decoration: const InputDecoration(
              labelText: "Nombre de Proyecto",
              border: OutlineInputBorder(),
            ),
            enableInteractiveSelection: false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ, ]'),
              ),
              PegarDisabled(),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la información requerida';              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Tipología de Vivienda:" ,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.tipologiaViviendaController,
            decoration: const InputDecoration(
              labelText: "Tipología de Vivienda",
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
              return null;
            },
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Dirección",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),

              Text(
                " *",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red),
              ),

              IconButton(
                icon: Icon(Icons.info),
                color: Colors.grey,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Uso de dirección"),
                        content: Text("El campo de direccion tambien es utilizada para nombrar el archivo al guardar."),
                        actions: [
                          ElevatedButton(
                            child: Text("Aceptar"),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),


          ValueListenableBuilder(
            valueListenable: appState.regionController,
            builder: (context, value, _) {

              final region = appState.regionController.text;

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
                    (item) => item.value == appState.comunasController.text,
              )
                  ? appState.comunasController.text
                  : null;


              return Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: appState.regionController.text.isEmpty
                        ? null
                        : appState.regionController.text,
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
                        appState.comunasController.text = "";
                        appState.regionController.text = value;
                        appState.direccionController.clear();
                      }
                    },
                    validator: (_) {
                      if (appState.regionController.text.isEmpty) {
                        return "Seleccione una Región";
                      }
                      return null;
                    },

                  ),

                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    key: ValueKey(appState.regionController.text),
                    value: comunasValue,
                    decoration: const InputDecoration(
                      labelText: "Provincia",
                      border: OutlineInputBorder(),
                    ),
                    items: comunas,
                    onChanged: comunas.isEmpty
                      ? null
                      : (value) {
                        if (value != null) {
                          appState.comunasController.text = value;
                          appState.direccionController.clear();
                        }
                      },
                    validator: (_) =>
                      appState.comunasController.text.isEmpty
                      ? "Seleccione una Provincia"
                      : null,
                  ),

                  const SizedBox(height: 20),

                  ValueListenableBuilder(
                    valueListenable: appState.comunasController,
                    builder: (context, _, __) {

                      final datosCompletados =
                          appState.regionController.text.isNotEmpty &&
                          appState.comunasController.text.isNotEmpty;

                      return TextFormField(
                        controller: appState.direccionController,
                        enabled: datosCompletados,
                        enableInteractiveSelection: false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: "Dirección",
                          border: OutlineInputBorder(),
                        ),
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
                          return null;
                        },
                      );
                    },
                  ),


                ],
              );
            },
          ),


          const SizedBox(height: 20),

          Text(
            "Etapa:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.etapaController,
            decoration: const InputDecoration(
              labelText: "Etapa",
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
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Superficie de Vivienda (m²)",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.supViviendaController,
            decoration: const InputDecoration(
              labelText: "Superficie de Vivienda",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$')),
              PegarDisabled(),
            ],
            enableInteractiveSelection: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la información requerida';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Número de Pisos:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.nPisosController,
            decoration: const InputDecoration(
              labelText: "Número de Pisos",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*$')),
              PegarDisabled(),
            ],
            enableInteractiveSelection: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la información requerida';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Orientación Fachada",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          DropdownButtonFormField<String>(
            value: appState.oriFachadaController.text.isEmpty
              ? null
              : appState.oriFachadaController.text,
            decoration: const InputDecoration(
              labelText: "Orientación de fachada",
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: "Norte", child: Text("Norte")),
              DropdownMenuItem(value: "Sur", child: Text("Sur")),
              DropdownMenuItem(value: "Este", child: Text("Este")),
              DropdownMenuItem(value: "Oeste", child: Text("Oeste")),
              DropdownMenuItem(value: "Noreste", child: Text("Noreste")),
              DropdownMenuItem(value: "Noroeste", child: Text("Noroeste")),
              DropdownMenuItem(value: "Sureste", child: Text("Sureste")),
              DropdownMenuItem(value: "Suroeste", child: Text("Suroeste")),
            ],
            onChanged: (value) {
              if (value != null) {
                appState.oriFachadaController.text = value;
              }
            },
            validator: (value) {
              if (appState.oriFachadaController.text.isEmpty) {
                return "Seleccione una orientación";
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Información adicional de Orientación Fachada",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: appState.oriFachadaController,
            builder: (context, value, _) {
              final estaSeleccionado = value.text.isNotEmpty;

              return TextFormField(
                controller: appState.oriFachadainfoController,
                enabled: estaSeleccionado,
                enableInteractiveSelection: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  labelText: "Ingrese información como grados, etc",
                  border: OutlineInputBorder(),
                ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ, °]'),
                    ),
                    PegarDisabled(),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la información requerida';
                    }
                    return null;
                  }
              );
            },
          ),



          const SizedBox(height: 20),

          Text(
            "Orientación Acceso",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          DropdownButtonFormField<String>(
            value: appState.oriAccesoController.text.isEmpty
                ? null
                : appState.oriAccesoController.text,
            decoration: const InputDecoration(
              labelText: "Orientación de acceso",
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: "Norte", child: Text("Norte")),
              DropdownMenuItem(value: "Sur", child: Text("Sur")),
              DropdownMenuItem(value: "Este", child: Text("Este")),
              DropdownMenuItem(value: "Oeste", child: Text("Oeste")),
              DropdownMenuItem(value: "Noreste", child: Text("Noreste")),
              DropdownMenuItem(value: "Noroeste", child: Text("Noroeste")),
              DropdownMenuItem(value: "Sureste", child: Text("Sureste")),
              DropdownMenuItem(value: "Suroeste", child: Text("Suroeste")),
            ],
            onChanged: (value) {
              if (value != null) {
                appState.oriAccesoController.text = value;
              }
            },
            validator: (value) {
              if (appState.oriAccesoController.text.isEmpty) {
                return "Seleccione una orientación";
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Información adicional de Orientación Acceso",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: appState.oriAccesoController,
            builder: (context, value, _) {
              final estaSeleccionado = value.text.isNotEmpty;

              return TextFormField(
                controller: appState.oriAccesoinfoController,
                enabled: estaSeleccionado,
                enableInteractiveSelection: false,
                decoration: const InputDecoration(
                  labelText: "Ingrese información como grados, etc",
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ, °]'),
                  ),
                  PegarDisabled(),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la información requerida';
                  }
                  return null;
                }
              );
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Clima",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          DropdownButtonFormField<String>(
            value: appState.climaController.text.isEmpty
              ? null
                : appState.climaController.text,
            decoration: const InputDecoration(
              labelText: "Clima",
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(
                value: 'Soleado',
                child: Row(
                  children: [
                    Icon(Icons.sunny, size: 20),
                    SizedBox(width: 8),
                    Text('Soleado'),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: 'Parcialmente Nublado',
                child: Row(
                  children: [
                    Icon(Icons.cloud_queue, size: 20),
                    SizedBox(width: 8),
                    Text('Parcialmente Nublado'),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: 'Nublado',
                child: Row(
                  children: [
                    Icon(Icons.cloud, size: 20),
                    SizedBox(width: 8),
                    Text('Nublado'),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: 'Lluvioso',
                child: Row(
                  children: [
                    Icon(Icons.cloudy_snowing, size: 20),
                    SizedBox(width: 8),
                    Text('Lluvioso'),
                  ],
                ),
              ),
            ],

            onChanged: (value) {
              if (value != null) {
                appState.climaController.text = value;
              }
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Temperatura Exterior: (°C)",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.tempExteriorController,
            decoration: const InputDecoration(
              labelText: "Temperatura Exterior",
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
                return 'Por favor ingrese la información requerida';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Humedad Exterior: (%)",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.humExteriorController,
            decoration: const InputDecoration(
              labelText: "Humedad Exterior",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$')),
            ],
            enableInteractiveSelection: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la información requerida';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Temperatura Interior: (°C)",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.tempInteriorController,
            decoration: const InputDecoration(
              labelText: "Temperatura Interior",
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
                return 'Por favor ingrese la información requerida';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Humedad Interior: (%)",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.humInteriorController,
            decoration: const InputDecoration(
              labelText: "Humedad Interior",
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
                return 'Por favor ingrese la información requerida';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Recibido por:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.reciPorController,
            decoration: const InputDecoration(
              labelText: "Recibido por",
              border: OutlineInputBorder(),
            ),
            enableInteractiveSelection: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚñÑ ]'),
              ),
              PegarDisabled(),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la información requerida';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Nombre de la persona que lo recibió",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.nombreReciController,
            decoration: const InputDecoration(
              labelText: "Nombre de la persona que lo recibió",
              border: OutlineInputBorder(),
            ),
            enableInteractiveSelection: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚñÑ ]'),
              ),
              PegarDisabled(),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un nombre';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Años de uso de la vivienda:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.usoViviendaController,
            decoration: const InputDecoration(
              labelText: "Años de uso de la vivienda",
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
                return 'Por favor ingrese una cantidad de años';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Nombre Inspector:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.nombreInspectorController,
            decoration: const InputDecoration(
              labelText: "Nombre de Inspector",
              border: OutlineInputBorder(),
            ),
            enableInteractiveSelection: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚñÑ ]'),
              ),
              PegarDisabled(),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un nombre';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Rut Inspector (ej: 12345678-9)",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Row(
            children: [

              Expanded(
                flex: 3,
                child:
                TextFormField(
                  controller: appState.rutInspectorController,
                  decoration: const InputDecoration(
                    labelText: "RUT Inspector",
                    border: OutlineInputBorder(),
                  ),
                  enableInteractiveSelection: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // solo números
                    LengthLimitingTextInputFormatter(8),    // máximo 8 caracteres
                    PegarDisabled(),
                  ],
                ),

              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "-",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: appState.digVerifController,
                  decoration: const InputDecoration(
                    labelText: "DV",
                    border: OutlineInputBorder(),
                  ),
                  enableInteractiveSelection: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9kK]'),
                    ),
                    LengthLimitingTextInputFormatter(1),
                    PegarDisabled(),
                  ],
                ),
              ),
            ],
          ),


          const SizedBox(height: 20),

          Text(
            "Reparaciones",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: appState.reparacionesController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                appState.reparacionesController.text = "No";
              }
              final seleccion = appState.reparacionesController.text;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SegmentedButton<String>(
                    showSelectedIcon: false,
                    segments: const [
                      ButtonSegment(value: 'Si', label: Text('Sí')),
                      ButtonSegment(value: 'No', label: Text('No')),
                    ],
                    selected: {seleccion},
                    onSelectionChanged: (Set<String> newSelection) {
                      appState.reparacionesController.text = newSelection.first;
                      if (newSelection.first != 'Si') {
                        appState.detalleReparacionesController.clear();
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
                    controller: appState.detalleReparacionesController,
                    enabled: seleccion == 'Si',
                    decoration: const InputDecoration(
                      labelText: "Detalles de reparaciones",
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
                        return 'Por favor ingrese los detalles de Reparaciones';
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
            "Ampliaciones",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: appState.ampliacionesController,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isEmpty) {
                appState.ampliacionesController.text = "No";
              }
              final seleccion = appState.ampliacionesController.text;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SegmentedButton<String>(
                    showSelectedIcon: false,
                    segments: const [
                      ButtonSegment(value: 'Si', label: Text('Sí')),
                      ButtonSegment(value: 'No', label: Text('No')),
                    ],
                    selected: {seleccion},
                    onSelectionChanged: (Set<String> newSelection) {
                      appState.ampliacionesController.text = newSelection.first;
                      if (newSelection.first != 'Si') {
                        appState.detalleAmpliacionesController.clear();
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
                    controller: appState.detalleAmpliacionesController,
                    enabled: seleccion == 'Si',
                    decoration: const InputDecoration(
                      labelText: "Detalles de Amplaciones",
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
                        return 'Por favor ingrese los detalles de Amplaciones';
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
            "Observación:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.obsInfoGeneralController,
            decoration: const InputDecoration(
              labelText: "Observación",
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
                return 'Por favor ingrese observación';
              }
              return null;
            },
          ),

          const SizedBox(height: 40),

          Text(
            "🏠 Información Ocupación de Vivienda",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Text(
            "N° de recintos vivienda",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.numRecintosController,
            decoration: const InputDecoration(
              labelText: "N° de recintos vivienda",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*$')),
              PegarDisabled(),
            ],
            enableInteractiveSelection: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el N° de recintos vivienda';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Total número de habitantes:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.totalHabitantesController,
            decoration: const InputDecoration(
              labelText: "Total número de habitantes",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*$')),
              PegarDisabled(),
            ],
            enableInteractiveSelection: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el Total número de habitantes';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Adultos:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.numAdultosController,
            decoration: const InputDecoration(
              labelText: "Numero de Adultos",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*$')),
              PegarDisabled(),
            ],
            enableInteractiveSelection: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la cantidad de Adultos';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Niños en edad escolar:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.numMenoresController,
            decoration: const InputDecoration(
              labelText: "Niños en edad escolar",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*$')),
              PegarDisabled(),
            ],
            enableInteractiveSelection: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la cantidad de Niños en edad escolar';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Adultos mayores:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.numAdulMayoresController,
            decoration: const InputDecoration(
              labelText: "Adultos mayores",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*$')),
              PegarDisabled(),
            ],
            enableInteractiveSelection: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la cantidad de Adultos Mayores';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Ocupación todo el día:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.ocupDiaCompController,
            decoration: const InputDecoration(
              labelText: "Ocupación todo el día",
              border: OutlineInputBorder(),
            ),
            enableInteractiveSelection: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ,:/ ]'),
              ),
              PegarDisabled(),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la Ocupación todo el día';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Ocupación intermitente:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.ocupIntermitenteController,
            decoration: const InputDecoration(
              labelText: "Ocupación intermitente",
              border: OutlineInputBorder(),
            ),
            enableInteractiveSelection: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ,:/ ]'),
              ),
              PegarDisabled(),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la ocupacion intermitente';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Densidad ocupacional prevista:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.densOcupPrevController,
            enabled: false,
            decoration: const InputDecoration(
              labelText: "Densidad ocupacional prevista",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la Densidad ocupacional prevista';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Densidad ocupacional real:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.densOcupRealController,
            enabled: false,
            decoration: const InputDecoration(
              labelText: "Densidad ocupacional real",
              border: OutlineInputBorder(),
            ),
            enableInteractiveSelection: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ,:/ ]'),
              ),
              PegarDisabled(),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la Densidad ocupacional real';
              }
              if (!RegExp(r'^[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ,:/ ]+$').hasMatch(value)) {
                return 'Solo se permiten letras, números y comas';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            "Observaciones de ocupación de vivienda:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: appState.obsOcupVivController,
            decoration: const InputDecoration(
              labelText: "Observaciones de ocupación de vivienda",
              border: OutlineInputBorder(),
            ),
            enableInteractiveSelection: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ,:/ ]'),
              ),
              PegarDisabled(),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese obbservaciones de ser necesario';
              }
              return null;
            },
          ),

          const SizedBox(height: 40),

          Text(
            "📷 Identificación tipología de vivienda ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 30),


          // -------------------------------------------------------------------
          // SECCIÓN DE FOTO 2
          // -------------------------------------------------------------------
          Text(
          "Fotografía 2:",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => appState.obtenerImagenInfoGeneral(
                  fuente: ImageSource.camera,
                  imgnum: 2,
                  onImagenSeleccionada: (img) {
                    setState(() {
                      appState.imagen2_Info_General = img;
                      appState.imagen2GuardadaInfoGeneral = null;
                      print("Se tomo la foto 2 y se guardon en: " + appState.imagen2_Info_General!.path.toString());
                      _pointsImg2.clear();
                    });
                  },
                ),
                icon: Icon(Icons.camera_alt),
                label: Text("Tomar Foto"),
              ),
            ],
          ),

          const SizedBox(height: 20),

         // -------------------------------------------------------------------
         // SECCIÓN DIBUJO
         // -------------------------------------------------------------------

          if (appState.imagen2_Info_General != null && appState.imagen2GuardadaInfoGeneral == null) ...[
            Text(
              "Dibuja observaciones sobre la imagen:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Center(
              child: RepaintBoundary(
                key: canvasKey_InfoGeneral_2,
                child: Container(
                  width: 900,
                  height: 800,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    image: DecorationImage(
                      image: FileImage(appState.imagen2_Info_General!),
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
                              _pointsImg2 = List.from(_pointsImg2)..add(localPosition);
                            }
                          });
                        },
                        onPanEnd: (_) => setState(() => _pointsImg2.add(null)),
                        child: CustomPaint(
                          painter: DibujoPainter(_pointsImg2),
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
                  await appState.guardarDibujoInfoGeneral(
                    canvasKey: canvasKey_InfoGeneral_2,
                    imgnum: 2,
                    nombreArchivo: "Imagen2_Info_General",
                    onGuardado: (file) {
                      setState(() {
                        appState.imagen2GuardadaInfoGeneral = file;
                        appState.cantFotos++;
                        print("HAY UN TOTAL DE " + appState.cantFotos.toString() + " FOTOS");
                        _pointsImg2.clear();
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

          if (appState.imagen2GuardadaInfoGeneral != null) ...[
            Text(
              "Imagen 2 guardada:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Center(
              child: Image.file(
                appState.imagen2GuardadaInfoGeneral!,
                width: 900,
                height: 800,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 15),

            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  await appState.eliminarDibujoInfoGeneral(
                    context: context,
                    imgnum: 2,
                  );
                  setState(() {
                    print("HAY UN TOTAL DE " + appState.cantFotos.toString() + " FOTOS");
                    _pointsImg2.clear();
                  });
                },
                icon: Icon(Icons.delete),
                label: Text("Eliminar dibujo"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ),

          ],










          // -------------------------------------------------------------------
          // SECCIÓN DE FOTO 3
          // -------------------------------------------------------------------

          Text(
            "Fotografía 3:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => appState.obtenerImagenInfoGeneral(
                  fuente: ImageSource.camera,
                  imgnum: 3,
                  onImagenSeleccionada: (img) {
                    setState(() {
                      appState.imagen3_Info_General = img;
                      appState.imagen3GuardadaInfoGeneral = null;
                      print("Se tomo la foto 3 y se guardon en: " + appState.imagen3_Info_General!.path.toString());
                      _pointsImg3.clear();
                    });
                  },
                ),
                icon: Icon(Icons.camera_alt),
                label: Text("Tomar Foto"),
              ),
            ],
          ),

          const SizedBox(height: 20),




          // -------------------------------------------------------------------
          // SECCIÓN DIBUJO
          // -------------------------------------------------------------------

          if (appState.imagen3_Info_General != null && appState.imagen3GuardadaInfoGeneral == null) ...[
            Text(
              "Dibuja observaciones sobre la imagen:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Center(
              child: RepaintBoundary(
                key: canvasKey_InfoGeneral_3,
                child: Container(
                  width: 900,
                  height: 800,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    image: DecorationImage(
                      image: FileImage(appState.imagen3_Info_General!),
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
                              _pointsImg3 = List.from(_pointsImg3)..add(localPosition);
                            }
                          });
                        },
                        onPanEnd: (_) => setState(() => _pointsImg3.add(null)),
                        child: CustomPaint(
                          painter: DibujoPainter(_pointsImg3),
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
                  await appState.guardarDibujoInfoGeneral(
                    canvasKey: canvasKey_InfoGeneral_3,
                    imgnum: 3,
                    nombreArchivo: "Imagen3_Info_General",
                    onGuardado: (file) {
                      setState(() {
                        appState.imagen3GuardadaInfoGeneral = file;
                        appState.cantFotos++;
                        print("HAY UN TOTAL DE " + appState.cantFotos.toString() + " FOTOS");
                        _pointsImg3.clear();
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

          if (appState.imagen3GuardadaInfoGeneral != null) ...[
              Text(
                "Imagen 3 guardada:",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
             ),

            const SizedBox(height: 10),

            Center(
              child: Image.file(
                appState.imagen3GuardadaInfoGeneral!,
                width: 900,
                height: 800,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 15),

            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  await appState.eliminarDibujoInfoGeneral(
                    context: context,
                    imgnum: 3,
                  );
                  setState(() {
                    print("HAY UN TOTAL DE " + appState.cantFotos.toString() + " FOTOS");
                    _pointsImg3.clear();
                  });
                },
                icon: Icon(Icons.delete),
                label: Text("Eliminar dibujo"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ),
          ],







          // -------------------------------------------------------------------
          // SECCIÓN DE FOTO 4
          // -------------------------------------------------------------------


          Text(
            "Fotografía 4:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => appState.obtenerImagenInfoGeneral(
                  fuente: ImageSource.camera,
                  imgnum: 4,
                  onImagenSeleccionada: (img) {
                    setState(() {
                      appState.imagen4_Info_General = img;
                      appState.imagen4GuardadaInfoGeneral = null;
                      print("Se tomo la foto 4 y se guardon en: " + appState.imagen4_Info_General!.path.toString());
                      _pointsImg4.clear();
                    });
                  },
                ),
                icon: Icon(Icons.camera_alt),
                label: Text("Tomar Foto"),
              ),
            ],
          ),

          const SizedBox(height: 20),



          // -------------------------------------------------------------------
          // SECCIÓN DIBUJO
          // -------------------------------------------------------------------

          if (appState.imagen4_Info_General != null && appState.imagen4GuardadaInfoGeneral == null) ...[
            Text(
              "Dibuja observaciones sobre la imagen:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Center(
              child: RepaintBoundary(
                key: canvasKey_InfoGeneral_4,
                child: Container(
                  width: 900,
                  height: 800,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    image: DecorationImage(
                      image: FileImage(appState.imagen4_Info_General!),
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
                              _pointsImg4 = List.from(_pointsImg4)..add(localPosition);
                            }
                          });
                        },
                        onPanEnd: (_) => setState(() => _pointsImg4.add(null)),
                        child: CustomPaint(
                          painter: DibujoPainter(_pointsImg4),
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
                  await appState.guardarDibujoInfoGeneral(
                    canvasKey: canvasKey_InfoGeneral_4,
                    imgnum: 4,
                    nombreArchivo: "Imagen4_Info_General",
                    onGuardado: (file) {
                      setState(() {
                        appState.imagen4GuardadaInfoGeneral = file;
                        appState.cantFotos++;
                        print("HAY UN TOTAL DE " + appState.cantFotos.toString() + " FOTOS");
                        _pointsImg4.clear();
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

          if (appState.imagen4GuardadaInfoGeneral != null) ...[
            Text(
              "Imagen 4 guardada:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Center(
              child: Image.file(
                appState.imagen4GuardadaInfoGeneral!,
                width: 900,
                height: 800,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 15),

            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  await appState.eliminarDibujoInfoGeneral(
                    context: context,
                    imgnum: 4,
                  );
                  setState(() {
                    print("HAY UN TOTAL DE " + appState.cantFotos.toString() + " FOTOS");
                    _pointsImg4.clear();
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
