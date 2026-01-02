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

    setState(() {
      cargando = false;
    });
  }

  Future<void> _cargarInspecciones() async {
    final db = await LocalDatabase.database;

    final result = await db.query(
      'inspecciones',
      orderBy: 'id DESC',
    );

    inspecciones = result;
  }


  Future<void> _cargarProyectos() async {
    final db = await LocalDatabase.database;

    final result = await db.query(
      'proyectos',
      orderBy: 'id DESC',
    );

    proyectos = result;
  }

  Future<void> _cargarViviendas() async {
    final db = await LocalDatabase.database;

    final result = await db.query(
      'viviendas',
      orderBy: 'id DESC',
    );

    viviendas = result;
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
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('UUID')),
          DataColumn(label: Text('Fecha')),
          DataColumn(label: Text('Ingreso')),
          DataColumn(label: Text('Salida')),
          DataColumn(label: Text('Estado')),
          DataColumn(label: Text('Sync')),
        ],
        rows: inspecciones.map((item) {
          return DataRow(
            cells: [
              _cell(item['id']),
              _cell(item['uuid']),
              _cell(item['fecha']),
              _cell(item['hora_ingreso']),
              _cell(item['hora_salida']),
              DataCell(
                Text(
                  item['estado'] ?? '-',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: item['estado'] == 'ok'
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
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Inspección ID')),
          DataColumn(label: Text('Región')),
          DataColumn(label: Text('Comuna')),
          DataColumn(label: Text('Etapa')),
        ],
        rows: proyectos.map((item) {
          return DataRow(
            cells: [
              _cell(item['id']),
              _cell(item['inspeccion_id']),
              _cell(item['region']),
              _cell(item['comuna']),
              _cell(item['etapa']),
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
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Proyecto ID')),
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
        ],
        rows: viviendas.map((item) {
          return DataRow(
            cells: [
              DataCell(Text('${item['id'] ?? '-'}')),
              DataCell(Text('${item['proyecto_id'] ?? '-'}')),
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
            ],
          );
        }).toList(),
      ),
    );
  }




  DataCell _cell(dynamic value) {
    return DataCell(
      Center(
        child: Text(
          value?.toString() ?? '-',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

}
