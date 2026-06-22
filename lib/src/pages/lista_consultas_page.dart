import 'package:flutter/material.dart';
import '../widgets/menu.dart';
import '../models/consulta.dart';
import '../provider/consultas_provider.dart';

class ListaConsultasPage extends StatefulWidget {
  const ListaConsultasPage({super.key});

  @override
  State<ListaConsultasPage> createState() => _ListaConsultasPageState();
}

class _ListaConsultasPageState extends State<ListaConsultasPage> {
  final Color primaryColor = const Color(0xFF1A2B4B);
  final Color secondaryColor = const Color(0xFF64748B);
  final Color tertiaryColor = const Color(0xFFC5A059);
  final Color neutralColor = const Color(0xFF77777A);

  int filtroSeleccionado = 0;

  final List<String> opcionesFiltro = [
    'Todo',

    'Pendiente',

    'En análisis',

    'Resuelto',
  ];

  String textoBusqueda = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),

      appBar: AppBar(
        backgroundColor: Colors.white,

        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Gestor Jurídico',

          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),

            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/perfil'),
              child: CircleAvatar(
                radius: 16,

                backgroundColor: primaryColor,

                child: const Icon(Icons.person, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const SizedBox(height: 16),

            Text(
              'Consultas',

              style: TextStyle(
                fontSize: 24,

                fontWeight: FontWeight.bold,

                color: primaryColor,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Gestione y revise el estado de los expedientes actuales.',

              style: TextStyle(fontSize: 14, color: secondaryColor),
            ),

            const SizedBox(height: 16),

            // Buscador reactivo
            TextField(
              onChanged: (valor) => setState(() => textoBusqueda = valor),
              decoration: InputDecoration(
                hintText: 'Buscar por cliente, tema o expediente...',

                hintStyle: TextStyle(color: neutralColor),

                prefixIcon: Icon(Icons.search, color: secondaryColor),

                filled: true,

                fillColor: Colors.white,

                contentPadding: const EdgeInsets.symmetric(vertical: 0),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),

                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),

                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Chips de filtrado
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: Row(
                children: List.generate(opcionesFiltro.length, (index) {
                  bool isSelected = filtroSeleccionado == index;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),

                    child: ChoiceChip(
                      label: Text(opcionesFiltro[index]),

                      selected: isSelected,
                      onSelected: (bool selected) =>
                          setState(() => filtroSeleccionado = index),
                      selectedColor: primaryColor,

                      backgroundColor: Colors.white,

                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : secondaryColor,

                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),

                        side: BorderSide(
                          color: isSelected
                              ? primaryColor
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 16),

            // Consumo de datos asíncronos mediante el patrón de la cátedra
            Expanded(child: _crearListaFutura()),
          ],
        ),
      ),

      bottomNavigationBar: const Menu(index: 1),
    );
  }

  Widget _crearListaFutura() {
    return FutureBuilder(
      future: consultasProvider.cargarData(),
      initialData: const <Consulta>[],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          List<Consulta> dataCompleta = snapshot.data;

          // Aplicación de filtros de lógica local (Buscador + Estado)
          List<Consulta> dataFiltrada = dataCompleta.where((consulta) {
            final matchTexto =
                consulta.cliente.toLowerCase().contains(
                  textoBusqueda.toLowerCase(),
                ) ||
                consulta.tema.toLowerCase().contains(
                  textoBusqueda.toLowerCase(),
                ) ||
                consulta.expediente.toLowerCase().contains(
                  textoBusqueda.toLowerCase(),
                );
            final estadoFiltro = opcionesFiltro[filtroSeleccionado];
            final matchEstado =
                estadoFiltro == 'Todo' || consulta.estado == estadoFiltro;
            return matchTexto && matchEstado;
          }).toList();

          if (dataFiltrada.isEmpty) {
            return Center(
              child: Text(
                'No se encontraron resultados',
                style: TextStyle(color: secondaryColor),
              ),
            );
          }

          return ListView.builder(
            itemCount: dataFiltrada.length,
            itemBuilder: (context, index) =>
                _construirTarjetaExpediente(dataFiltrada[index]),
          );
        } else {
          return const Center(child: Text('No hay datos disponibles.'));
        }
      },
    );
  }

  Widget _construirTarjetaExpediente(Consulta consulta) {
    Color bgColor = Colors.grey.shade100;

    Color textColor = Colors.grey.shade700;

    IconData icono = Icons.info_outline;

    if (consulta.estado == 'En análisis') {
      bgColor = Colors.blue.shade50;

      textColor = Colors.blue.shade700;

      icono = Icons.hourglass_empty;
    } else if (consulta.estado == 'Pendiente') {
      bgColor = Colors.orange.shade50;

      textColor = Colors.orange.shade800;

      icono = Icons.access_time;
    } else if (consulta.estado == 'Resuelto') {
      bgColor = Colors.green.shade50;

      textColor = Colors.green.shade700;

      icono = Icons.check_circle_outline;
    }

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/detalle'),
      child: Card(
        elevation: 0,

        margin: const EdgeInsets.only(bottom: 16),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),

          side: BorderSide(color: Colors.grey.shade300),
        ),

        color: Colors.white,

        child: Padding(
          padding: const EdgeInsets.all(16.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Expanded(
                    child: Text(
                      consulta.cliente,

                      style: TextStyle(
                        fontSize: 18,

                        fontWeight: FontWeight.bold,

                        color: primaryColor,
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,

                      vertical: 6,
                    ),

                    decoration: BoxDecoration(
                      color: bgColor,

                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Row(
                      children: [
                        Icon(icono, size: 14, color: textColor),

                        const SizedBox(width: 4),

                        Text(
                          consulta.estado.toUpperCase(),

                          style: TextStyle(
                            fontSize: 10,

                            fontWeight: FontWeight.bold,

                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 4),

              Text(
                consulta.tema,

                style: TextStyle(fontSize: 14, color: secondaryColor),
              ),

              const SizedBox(height: 16),

              const Divider(height: 1, thickness: 1),

              const SizedBox(height: 12),

              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,

                    size: 16,

                    color: neutralColor,
                  ),

                  const SizedBox(width: 6),

                  Text(
                    consulta.fecha,

                    style: TextStyle(color: neutralColor, fontSize: 12),
                  ),

                  const SizedBox(width: 16),

                  Icon(Icons.folder_open, size: 16, color: neutralColor),

                  const SizedBox(width: 6),

                  Text(
                    consulta.expediente,

                    style: TextStyle(color: neutralColor, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
