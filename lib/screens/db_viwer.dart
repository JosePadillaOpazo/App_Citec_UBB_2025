import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../db_local/db_local.dart';
import 'inicio.dart'; // 👈 ajusta el import si la ruta cambia

class DB_Viewer extends StatefulWidget {
  const DB_Viewer({super.key});

  @override
  State<DB_Viewer> createState() => _DB_ViewerState();
}

class _DB_ViewerState extends State<DB_Viewer> {
  List<Map<String, dynamic>> inspecciones = [];
  List<Map<String, dynamic>> proyectos = [];
  List<Map<String, dynamic>> viviendas = [];
  List<Map<String, dynamic>> recintos = [];
  List<Map<String, dynamic>> muros = [];
  List<Map<String, dynamic>> pisocielo = [];
  List<Map<String, dynamic>> sistemas_ventilacion =[];
  List<Map<String, dynamic>> ventilacion_recintos =[];
  List<Map<String, dynamic>> patologias =[];
  List<Map<String, dynamic>> patologias_muro =[];
  List<Map<String, dynamic>> patologias_pisocielo =[];

  bool cargando = true;


  @override
  void initState() {
    super.initState();
    _cargarTodo();
  }

  Future<void> _cargarTodo() async {
    await _cargarInspecciones();
    await _cargarProyectos();
    await _cargarViviendas();
    await _cargarRecintos();
    await _cargarMuros();
    await _cargarPisoCielo();
    await _cargarSistemaVentilacion();
    await _cargarRecinto_Ventilacion();
    await _cargarPatologia();
    await _cargarPatologias_Muro();
    await _cargarPatologias_PisoCielo();


    setState(() {
      cargando = false;
    });
  }

  Future<void> _cargarInspecciones() async {
    final db = await LocalDatabase.database;

    final result = await db.query(
      'inspecciones',
      orderBy: 'inspeccion_uuid ASC',
    );

    inspecciones = result;
  }

  Future<void> _cargarProyectos() async {
    final db = await LocalDatabase.database;

    final result = await db.query(
      'proyectos',
      orderBy: 'proyecto_uuid ASC',
    );

    proyectos = result;
  }

  Future<void> _cargarViviendas() async {
    final db = await LocalDatabase.database;

    final result = await db.query(
      'viviendas',
      orderBy: 'vivienda_uuid ASC',
    );

    viviendas = result;
  }

  Future<void> _cargarRecintos() async {
    final db = await LocalDatabase.database;

    final result = await db.query(
      'recintos',
      orderBy: 'recinto_uuid ASC',
    );

    recintos = result;
  }

  Future<void> _cargarMuros() async {
    final db = await LocalDatabase.database;

    final result = await db.query(
      'muros',
      orderBy: 'muro_uuid ASC',
    );

    muros = result;
  }

  Future<void> _cargarPisoCielo() async {
    final db = await LocalDatabase.database;

    final result = await db.query(
      'pisocielo',
      orderBy: 'pisocielo_uuid ASC',
    );

    pisocielo = result;
  }

  Future<void> _cargarSistemaVentilacion() async {
    final db = await LocalDatabase.database;

    final result = await db.query(
      'sistemas_ventilacion',
      orderBy: 'sistema_ventilacion_uuid ASC',
    );

    sistemas_ventilacion = result;
  }

  Future<void> _cargarRecinto_Ventilacion() async {
    final db = await LocalDatabase.database;

    final result = await db.query(
      'ventilacion_recintos',
      orderBy: 'ventilacion_recinto_uuid ASC',
    );

    ventilacion_recintos = result;
  }

  Future<void> _cargarPatologia() async {
    final db = await LocalDatabase.database;

    final result = await db.query(
      'patologias',
      orderBy: 'patologia_uuid ASC',
    );

    patologias = result;
  }

  Future<void> _cargarPatologias_Muro() async {
    final db = await LocalDatabase.database;

    final result = await db.query(
      'patologias_muro',
      orderBy: 'id ASC',
    );

    patologias_muro = result;
  }

  Future<void> _cargarPatologias_PisoCielo() async {
    final db = await LocalDatabase.database;

    final result = await db.query(
      'patologias_pisocielo',
      orderBy: 'id ASC',
    );

    patologias_pisocielo = result;
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Base de Datos – Inspecciones'),
        automaticallyImplyLeading: false, // sin flecha por defecto
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'Volver a Inicio',
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const Inicio(),
                ),
                    (route) => false,
              );
            },
          ),
        ],
      ),


      body: cargando
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// ================= PROYECTOS =================
            const Text(
              'Proyectos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            proyectos.isEmpty
                ? const Text('No hay proyectos')
                : _tablaProyectos(),

            const SizedBox(height: 30),

            /// ================= INSPECCIONES =================
            const Text(
              'Inspecciones',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            inspecciones.isEmpty
                ? const Text('No hay inspecciones')
                : _tablaInspecciones(),

            const SizedBox(height: 30),


            /// ================= VIVIENDAS =================
            const Text(
              'Viviendas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            viviendas.isEmpty
                ? const Text('No hay viviendas')
                : _tablaViviendas(),

            const SizedBox(height: 30),

              /// ================= RECINTOS =================

            const Text(
                "Recintos",
              style: TextStyle (
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )
            ),

            const SizedBox(height:10),

            recintos.isEmpty
                ? const Text("No hay recintos")
                : _tablaRecintos(),

            const SizedBox(height: 30),

            /// ================= Recintos y ventilacion =================
            const Text(
              'Recintos y su Sistema de Ventilacion',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            ventilacion_recintos.isEmpty
                ? const Text('No hay sistema de ventilacion')
                : _tablaVentilacion_Recintos(),

            const SizedBox(height: 50),

            /// ================= Muros =================
            const Text(
              'Muros',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            muros.isEmpty
                ? const Text('No hay Muros')
                : _tablaMuros(),

            const SizedBox(height: 30),

            /// ================= Patologias Muro=================
            const Text(
              'Muros con Patologias',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            patologias_muro.isEmpty
                ? const Text('No hay Muros con Patologias')
                : _tablaPatologias_Muro(),

            const SizedBox(height: 50),

            /// ================= Piso Cielo =================
            const Text(
              'Pisos y Cielos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),
            pisocielo.isEmpty
                ? const Text('No hay Pisos y Cielos')
                : _tablaPisoCielo(),

            const SizedBox(height: 50),




            /// ================= Patologias Piso Cielo=================
            const Text(
              'Pisos y Cielos con Patologias',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            patologias_pisocielo.isEmpty
                ? const Text('No hay Pisos ni Cielos con Patologias')
                : _tablaPatologias_PisoCielo(),

            const SizedBox(height: 50),



          /// ================= Sistema Ventilacion =================
            const Text(
              'Sistema de Ventilación',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            sistemas_ventilacion.isEmpty
                ? const Text('No hay sistema de ventilacion')
                : _tablaSistemaVentilacion(),

            const SizedBox(height: 50),

            /// ================= Patologias =================
            const Text(
              'Patologias',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            patologias.isEmpty
                ? const Text('No hay patologias')
                : _tablaPatologias(),

            const SizedBox(height: 50),



          ],
        ),
      ),


    );
  }

  Widget _tablaInspecciones() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        border: TableBorder.all(color: Colors.grey),
        headingRowColor:
        MaterialStateProperty.all(Colors.grey.shade300),
        columns: const [
          DataColumn(label: Text('Eliminar')),
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('PROYECTO UUID')),
          DataColumn(label: Text('INSPECCION UUID')),
          DataColumn(label: Text('N Ficha')),
          DataColumn(label: Text('Fecha')),
          DataColumn(label: Text('Ingreso')),
          DataColumn(label: Text('Salida')),
          DataColumn(label: Text('Recibido por')),
          DataColumn(label: Text('Nombre Receptor')),
          DataColumn(label: Text('Nombre Inspector')),
          DataColumn(label: Text('Rut Inspector')),
          DataColumn(label: Text('Clima')),
          DataColumn(label: Text('Estado')),
          DataColumn(label: Text('Sync')),
        ],
        rows: inspecciones.map((item) {
          return DataRow(
            cells: [
              DataCell(
                _botonBorrar(
                  tabla: 'inspecciones',
                  idColumn: 'inspeccion_uuid',
                  uuid: item['inspeccion_uuid'],
                  descripcion: 'inspeccion ${item['inspeccion_uuid']}',
                ),
              ),
              DataCell(Text('${item['id'] ?? '-'}')),
              DataCell(Text('${item['proyecto_uuid'] ?? '-'}')),
              DataCell(Text('${item['inspeccion_uuid'] ?? '-'}')),
              DataCell(Text('${item['n_ficha'] ?? '-'}')),
              DataCell(Text('${item['fecha'] ?? '-'}')),
              DataCell(Text('${item['hora_ingreso'] ?? '-'}')),
              DataCell(Text('${item['hora_salida'] ?? '-'}')),
              DataCell(Text('${item['recibido_por'] ?? '-'}')),
              DataCell(Text('${item['nombre_receptor'] ?? '-'}')),
              DataCell(Text('${item['nombre_inspector'] ?? '-'}')),
              DataCell(Text('${item['rut_inspector'] ?? '-'}')),
              DataCell(Text('${item['clima'] ?? '-'}')),
              DataCell(
                Text(
                  item['estado'] ?? '-',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: item['estado'] == 'sincronizado'
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ),
              DataCell(
                Icon(
                  item['sync_status'] == 1
                      ? Icons.cloud_done
                      : Icons.cloud_off,
                  color: item['sync_status'] == 1
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _tablaProyectos() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        border: TableBorder.all(color: Colors.grey),
        headingRowColor:
        MaterialStateProperty.all(Colors.grey.shade300),
        columns: const [
          DataColumn(label: Text('Eliminar')),
          DataColumn(label: Text('PROYECTO UUID')),
          DataColumn(label: Text('Nombre Proyecto')),
          DataColumn(label: Text('Región')),
          DataColumn(label: Text('Comuna')),
          DataColumn(label: Text('Etapa')),
          DataColumn(label: Text('Sync')),
        ],
        rows: proyectos.map((item) {
          return DataRow(
            cells: [
             DataCell(
                _botonBorrar(
                  tabla: 'proyectos',
                  idColumn: 'proyecto_uuid',
                  uuid: item['proyecto_uuid'],
                  descripcion: 'proyecto ${item['proyecto_uuid']}',
                ),
              ),
              DataCell(Text('${item['proyecto_uuid'] ?? '-'}')),
              DataCell(Text('${item['nombre_proyecto'] ?? '-'}')),
              DataCell(Text('${item['region'] ?? '-'}')),
              DataCell(Text('${item['comuna'] ?? '-'}')),
              DataCell(Text('${item['etapa'] ?? '-'}')),
              DataCell(
                Icon(
                  item['sync_status'] == 1
                      ? Icons.cloud_done
                      : Icons.cloud_off,
                  color: item['sync_status'] == 1
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _tablaViviendas() {
    if (viviendas.isEmpty) {
      return const Center(child: Text('No hay viviendas registradas'));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        border: TableBorder.all(color: Colors.grey),
        headingRowColor:
        MaterialStateProperty.all(Colors.grey.shade300),
        columns: const [
          DataColumn(label: Text('Eliminar')),
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('INSPECCION UUID')),
          DataColumn(label: Text('VIVIENDA UUID')),
          DataColumn(label: Text('Tipología')),
          DataColumn(label: Text('Dirección')),
          DataColumn(label: Text('Superficie')),
          DataColumn(label: Text('Pisos')),
          DataColumn(label: Text('Ori. Fachada')),
          DataColumn(label: Text('Ori. Acceso')),
          DataColumn(label: Text('Temp Ext')),
          DataColumn(label: Text('Hum Ext')),
          DataColumn(label: Text('Temp Int')),
          DataColumn(label: Text('Hum Int')),
          DataColumn(label: Text('Años Uso')),
          DataColumn(label: Text('Reparaciones')),
          DataColumn(label: Text('Det. Reparaciones')),
          DataColumn(label: Text('Ampliaciones')),
          DataColumn(label: Text('Det. Ampliaciones')),
          DataColumn(label: Text('Observaciones')),
          DataColumn(label: Text('Recintos')),
          DataColumn(label: Text('Total Hab.')),
          DataColumn(label: Text('Adultos')),
          DataColumn(label: Text('Menores')),
          DataColumn(label: Text('Adultos May.')),
          DataColumn(label: Text('Ocup. Día')),
          DataColumn(label: Text('Ocup. Interm.')),
          DataColumn(label: Text('Dens. Prev')),
          DataColumn(label: Text('Dens. Real')),
          DataColumn(label: Text('Obs. Ocupación')),
          DataColumn(label: Text('Sync')),
        ],
        rows: viviendas.map((item) {
          return DataRow(
            cells: [
              DataCell(
                _botonBorrar(
                  tabla: 'viviendas',
                  idColumn: 'vivienda_uuid',
                  uuid: item['vivienda_uuid'],
                  descripcion: 'vivienda ${item['vivienda_uuid']}',
                ),
              ),
              DataCell(Text('${item['id'] ?? '-'}')),
              DataCell(Text('${item['inspeccion_uuid'] ?? '-'}')),
              DataCell(Text('${item['vivienda_uuid'] ?? '-'}')),
              DataCell(Text(item['tipologia_vivienda'] ?? '-')),
              DataCell(Text(item['direccion'] ?? '-')),
              DataCell(Text('${item['superficie'] ?? '-'}')),
              DataCell(Text('${item['n_pisos'] ?? '-'}')),
              DataCell(Text(item['orientacion_fachada'] ?? '-')),
              DataCell(Text(item['orientacion_acceso'] ?? '-')),
              DataCell(Text('${item['temp_exterior'] ?? '-'}')),
              DataCell(Text('${item['hum_exterior'] ?? '-'}')),
              DataCell(Text('${item['temp_interior'] ?? '-'}')),
              DataCell(Text('${item['hum_interior'] ?? '-'}')),
              DataCell(Text('${item['a_de_uso'] ?? '-'}')),
              DataCell(Text(
                item['reparaciones'] == 1 ? 'Sí' : 'No',
              )),
              DataCell(Text(item['detalle_reparaciones'] ?? '-')),
              DataCell(Text(
                item['ampliaciones'] == 1 ? 'Sí' : 'No',
              )),
              DataCell(Text(item['detalle_ampliaciones'] ?? '-')),
              DataCell(Text(item['observaciones'] ?? '-')),
              DataCell(Text('${item['n_recintos'] ?? '-'}')),
              DataCell(Text('${item['total_habitantes'] ?? '-'}')),
              DataCell(Text('${item['num_adultos'] ?? '-'}')),
              DataCell(Text('${item['num_menores'] ?? '-'}')),
              DataCell(Text('${item['num_adul_mayores'] ?? '-'}')),
              DataCell(Text('${item['ocup_dia_comp'] ?? '-'}')),
              DataCell(Text('${item['ocup_intermitente'] ?? '-'}')),
              DataCell(Text('${item['dens_ocup_prev'] ?? '-'}')),
              DataCell(Text('${item['dens_ocup_real'] ?? '-'}')),
              DataCell(Text(item['observaciones_ocupacion'] ?? '-')),
              DataCell(
                Icon(
                  item['sync_status'] == 1
                      ? Icons.cloud_done
                      : Icons.cloud_off,
                  color: item['sync_status'] == 1
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _tablaRecintos() {

    if (recintos.isEmpty) {
      return const Center(child: Text('No hay Recintos registradas'));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        border: TableBorder.all(color: Colors.grey),
        headingRowColor:
        MaterialStateProperty.all(Colors.grey.shade300),
        columns: const [
          DataColumn(label: Text('Eliminar')),
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('RECINTO UUID')),
          DataColumn(label: Text('VIVIENDA UUID')),
          DataColumn(label: Text('Nombre Recinto')),
          DataColumn(label: Text('Patologias Visibles')),
          DataColumn(label: Text('Manifestaciones Ocultas')),
          DataColumn(label: Text('Detalles Manifestaciones')),
          DataColumn(label: Text('Olor Humedad')),
          DataColumn(label: Text('Modificaciones')),
          DataColumn(label: Text('Detalles Modificaciones')),
          DataColumn(label: Text('Calefacción')),
          DataColumn(label: Text('Tiempo Calefacción')),
          DataColumn(label: Text('Sync')),
        ],
        rows: recintos.map((item) {
          return DataRow(
            cells: [
              DataCell(
                _botonBorrar(
                  tabla: 'recintos',
                  idColumn: 'recinto_uuid',
                  uuid: item['recinto_uuid'],
                  descripcion: 'recinto ${item['recinto_uuid']}',
                ),
              ),
              DataCell(Text('${item['id'] ?? '-'}')),
              DataCell(Text('${item['recinto_uuid'] ?? '-'}')),
              DataCell(Text('${item['vivienda_uuid'] ?? '-'}')),
              DataCell(Text(item['nombre_recinto'] ?? '-')),
              DataCell(Text(
                item['patologias_visibles'] == 1 ? 'Sí' : 'No',
              )),
              DataCell(Text(
                item['manifestaciones_ocultas'] == 1 ? 'Sí' : 'No',
              )),
              DataCell(Text(item['detalles_manifestaciones'] ?? '-')),
              DataCell(Text(
                item['olor_humedad'] == 1 ? 'Sí' : 'No',
              )),
              DataCell(Text(
                item['modificaciones'] == 1 ? 'Sí' : 'No',
              )),
              DataCell(Text(item['detalles_modificaciones'] ?? '-')),
              DataCell(Text(item['calefaccion'] ?? '-')),
              DataCell(Text('${item['tiempo_calefaccion'] ?? '-'}')),
              DataCell(
                Icon(
                  item['sync_status'] == 1
                      ? Icons.cloud_done
                      : Icons.cloud_off,
                  color: item['sync_status'] == 1
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _tablaMuros() {
    if (muros.isEmpty) {
      return const Center(child: Text('No hay Muros registrados'));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        border: TableBorder.all(color: Colors.grey),
        headingRowColor:
        MaterialStateProperty.all(Colors.grey.shade300),
        columns: const [
          DataColumn(label: Text('Eliminar')),
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('MURO UUID')),
          DataColumn(label: Text('RECINTO UUID')),
          DataColumn(label: Text('Eje Muro')),
          DataColumn(label: Text('Tipo de Muro')),
          DataColumn(label: Text('Superficie')),
          DataColumn(label: Text('Superficie de Ventana')),
          DataColumn(label: Text('Nivel Afectación')),
          DataColumn(label: Text('Sync')),
        ],
        rows: muros.map((item) {
          return DataRow(
            cells: [
              DataCell(
                _botonBorrar(
                  tabla: 'muros',
                  idColumn: 'muro_uuid',
                  uuid: item['muro_uuid'],
                  descripcion: 'muro ${item['muro_uuid']}',
                ),
              ),
              DataCell(Text('${item['id'] ?? '-'}')),
              DataCell(Text('${item['muro_uuid'] ?? '-'}')),
              DataCell(Text('${item['recinto_uuid'] ?? '-'}')),
              DataCell(Text('${item['nombre_muro'] ?? '-'}')),
              DataCell(Text(
                item['tipo_muro'] == 1 ? 'Muro interior' : 'Muro perimetral',
              )),
              DataCell(Text('${item['superficie'] ?? '-'}')),
              DataCell(Text('${item['superficie_ventana'] ?? '-'}')),
              DataCell(Text(textoNivelAfectacion(item['nivel_afectacion']))),
              DataCell(
                Icon(
                  item['sync_status'] == 1
                      ? Icons.cloud_done
                      : Icons.cloud_off,
                  color: item['sync_status'] == 1
                      ? Colors.green
                      : Colors.red,
                ),
              ),

            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _tablaPisoCielo() {
    if (pisocielo.isEmpty) {
      return const Center(child: Text('No hay Pisos y Cielos registrados'));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        border: TableBorder.all(color: Colors.grey),
        headingRowColor:
        MaterialStateProperty.all(Colors.grey.shade300),
        columns: const [
          DataColumn(label: Text('Eliminar')),
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('PISO CIELO UUID')),
          DataColumn(label: Text('RECINTO ID')),
          DataColumn(label: Text('Tipo')),
          DataColumn(label: Text('Superficie')),
          DataColumn(label: Text('Nivel Afectación')),
          DataColumn(label: Text('Sync')),
        ],
        rows: pisocielo.map((item) {
          return DataRow(
            cells: [
              DataCell(
                _botonBorrar(
                  tabla: 'pisocielo',
                  idColumn: 'pisocielo_uuid',
                  uuid: item['pisocielo_uuid'],
                  descripcion: 'pisocielo ${item['pisocielo_uuid']}',
                ),
              ),

              DataCell(Text('${item['id'] ?? '-'}')),
              DataCell(Text('${item['pisocielo_uuid'] ?? '-'}')),
              DataCell(Text('${item['recinto_uuid'] ?? '-'}')),
              DataCell(Text('${item['tipo'] ?? '-'}')),
              DataCell(Text('${item['superficie'] ?? '-'}')),
              DataCell(Text(textoNivelAfectacion(item['nivel_afectacion']))),
              DataCell(
                Icon(
                  item['sync_status'] == 1
                      ? Icons.cloud_done
                      : Icons.cloud_off,
                  color: item['sync_status'] == 1
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _tablaSistemaVentilacion() {
    if (sistemas_ventilacion.isEmpty) {
      return const Center(child: Text('No hay sistema de ventilacion registrados'));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        border: TableBorder.all(color: Colors.grey),
        headingRowColor:
        MaterialStateProperty.all(Colors.grey.shade300),
        columns: const [
          DataColumn(label: Text('Sistema UUID')),
          DataColumn(label: Text('Nombre de Sistema')),
          DataColumn(label: Text('Sync')),
        ],
        rows: sistemas_ventilacion.map((item) {
          return DataRow(
            cells: [
              DataCell(Text('${item['sistema_ventilacion_uuid'] ?? '-'}')),
              DataCell(Text('${item['nombre_sistema'] ?? '-'}')),
              DataCell(
                Icon(
                  item['sync_status'] == 1
                      ? Icons.cloud_done
                      : Icons.cloud_off,
                  color: item['sync_status'] == 1
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _tablaVentilacion_Recintos() {
    if (ventilacion_recintos.isEmpty) {
      return const Center(child: Text('No hay recintos con sistemas de ventilacion registrados'));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        border: TableBorder.all(color: Colors.grey),
        headingRowColor:
        MaterialStateProperty.all(Colors.grey.shade300),
        columns: const [
          DataColumn(label: Text('VENT RECINTO UUID')),
          DataColumn(label: Text('RECINTO UUID')),
          DataColumn(label: Text('SIST VENT UUID')),
          DataColumn(label: Text('Estado')),
          DataColumn(label: Text('Sync')),
        ],
        rows: ventilacion_recintos.map((item) {
          return DataRow(
            cells: [
              DataCell(Text('${item['ventilacion_recinto_uuid'] ?? '-'}')),
              DataCell(Text('${item['recinto_uuid'] ?? '-'}')),
              DataCell(Text('${item['sistema_ventilacion_uuid'] ?? '-'}')),
              DataCell(Text(
                item['estado'] == 1 ? 'Operativo' : 'No Operativo',
              )),
              DataCell(
                Icon(
                  item['sync_status'] == 1
                      ? Icons.cloud_done
                      : Icons.cloud_off,
                  color: item['sync_status'] == 1
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _tablaPatologias() {
    if (patologias.isEmpty) {
      return const Center(child: Text('No hay patologias registrados'));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        border: TableBorder.all(color: Colors.grey),
        headingRowColor:
        MaterialStateProperty.all(Colors.grey.shade300),
        columns: const [
          DataColumn(label: Text('PATOLOGIAS UUID')),
          DataColumn(label: Text('Tipo')),
          DataColumn(label: Text('Ubicación')),
          DataColumn(label: Text('Sync')),
        ],
        rows: patologias.map((item) {
          return DataRow(
            cells: [
              DataCell(Text('${item['patologia_uuid'] ?? '-'}')),
              DataCell(Text('${item['tipo'] ?? '-'}')),
              DataCell(Text('${item['ubicacion'] ?? '-'}')),
              DataCell(
                Icon(
                  item['sync_status'] == 1
                      ? Icons.cloud_done
                      : Icons.cloud_off,
                  color: item['sync_status'] == 1
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _tablaPatologias_Muro() {
    if (patologias_muro.isEmpty) {
      return const Center(child: Text('No hay Muros con patologias registrados'));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        border: TableBorder.all(color: Colors.grey),
        headingRowColor:
        MaterialStateProperty.all(Colors.grey.shade300),
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('PATOOGIAS MURO UUID')),
          DataColumn(label: Text('MURO UUID')),
          DataColumn(label: Text('PATOLOGIA UUID')),
          DataColumn(label: Text('Estado')),
          DataColumn(label: Text('Superficie')),
          DataColumn(label: Text('Sync')),
        ],
        rows: patologias_muro.map((item) {
          return DataRow(
            cells: [
              DataCell(Text('${item['id'] ?? '-'}')),
              DataCell(Text('${item['patologia_muro_uuid'] ?? '-'}')),
              DataCell(Text('${item['muro_uuid'] ?? '-'}')),
              DataCell(Text('${item['patologia_uuid'] ?? '-'}')),
              DataCell(Text(
                item['estado'] == 1 ? 'Si' : 'No',
              )),
              DataCell(Text('${item['superficie'] ?? '-'}')),
              DataCell(
                Icon(
                  item['sync_status'] == 1
                      ? Icons.cloud_done
                      : Icons.cloud_off,
                  color: item['sync_status'] == 1
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _tablaPatologias_PisoCielo() {
    if (patologias_pisocielo.isEmpty) {
      return const Center(child: Text('No hay Pisos ni Cielos con patologias registrados'));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        border: TableBorder.all(color: Colors.grey),
        headingRowColor:
        MaterialStateProperty.all(Colors.grey.shade300),
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('PAT PISO CIELO UUID')),
          DataColumn(label: Text('PISO CIELO UUID')),
          DataColumn(label: Text('PATOLOGIA UUID')),
          DataColumn(label: Text('Tipo')),
          DataColumn(label: Text('Estado')),
          DataColumn(label: Text('Superficie')),
          DataColumn(label: Text('Sync')),
        ],
        rows: patologias_pisocielo.map((item) {
          return DataRow(
            cells: [
              DataCell(Text('${item['id'] ?? '-'}')),
              DataCell(Text('${item['patologia_pisocielo_uuid'] ?? '-'}')),
              DataCell(Text('${item['pisocielo_uuid'] ?? '-'}')),
              DataCell(Text('${item['patologia_uuid'] ?? '-'}')),
              DataCell(Text('${item['tipo'] ?? '-'}')),
              DataCell(Text(
                item['estado'] == 1 ? 'Si' : 'No',
              )),
              DataCell(Text('${item['superficie'] ?? '-'}')),
              DataCell(
                Icon(
                  item['sync_status'] == 1
                      ? Icons.cloud_done
                      : Icons.cloud_off,
                  color: item['sync_status'] == 1
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }


  Widget _botonBorrar({
    required String tabla,
    required String idColumn,
    required String uuid,
    required String descripcion,
  }) {
    return IconButton(
      icon: const Icon(Icons.delete, color: Colors.red),
      tooltip: 'Eliminar',
      onPressed: () async {
        final bool? confirmar = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Eliminar $tabla'),
            content: Text('¿Estás seguro de eliminar $descripcion?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Eliminar'),
              ),
            ],
          ),
        );

        if (confirmar == true) {
          await LocalDatabase.borrarDato(
            tabla: tabla,
            idColumn: idColumn,
            uuid: uuid,
          );

          // 🔥 Recarga todo (respeta CASCADE)
          await _cargarTodo();

          setState(() {});
        }
      },
    );
  }




  String textoNivelAfectacion(int? value) {
    switch (value) {
      case 0:
        return 'Nulo';
      case 1:
        return 'Bajo';
      case 2:
        return 'Medio';
      case 3:
        return 'Alto';
      default:
        return '-';
    }
  }





}
