import 'package:flutter/material.dart';
import '../widgets/menu.dart';
import '../models/consulta.dart';

class ListaConsultasPage extends StatefulWidget {
  const ListaConsultasPage({super.key});

  static final List<Consulta> baseDeDatos = [
    Consulta(
      idConsulta: '1',
      cliente: 'Elena Martínez Valdés',
      tema: 'Litigio Sucesorio Internacional',
      fecha: '14 Oct 2023',
      expediente: 'Exp. 511-C',
      estado: 'Pendiente',
      descripcion:
          'El cliente solicita una revisión exhaustiva del contrato de prestación de servicios tecnológicos propuesto por su nuevo proveedor de infraestructura en la nube. Se requiere especial atención a las cláusulas de responsabilidad civil, acuerdos de nivel de servicio (SLA) y jurisdicción aplicable en caso de disputa.\n\nAdicionalmente, solicitan evaluar si las penalizaciones por incumplimiento de SLA son proporcionales y si existe alguna cláusula abusiva respecto a la retención de datos post-terminación.',
      contacto: 'María Fernández',
    ),
    Consulta(
      idConsulta: '2',
      cliente: 'TechNova Solutions S.A.',
      tema: 'Revisión de Patentes',
      fecha: '05 Oct 2023',
      expediente: 'Exp. 309-A',
      estado: 'Resuelto',
      descripcion:
          'Análisis de las patentes solicitadas ante el registro nacional de propiedad intelectual.',
      contacto: 'contacto@technova.com',
    ),
    Consulta(
      idConsulta: '3',
      cliente: 'Constructora Horizonte',
      tema: 'Contrato de Licitación Pública',
      fecha: '15 Oct 2023',
      expediente: 'Exp. 415-D',
      estado: 'En análisis',
      descripcion:
          'Evaluación técnica de los términos y pliegos de bases para la licitación de obras públicas de infraestructura vial.',
      contacto: 'cd@constructorahorizonte.com',
    ),
  ];

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

  List<Consulta> get consultasFiltradas {
    return ListaConsultasPage.baseDeDatos.where((consulta) {
      final matchTexto =
          consulta.cliente.toLowerCase().contains(
            textoBusqueda.toLowerCase(),
          ) ||
          consulta.tema.toLowerCase().contains(textoBusqueda.toLowerCase()) ||
          consulta.expediente.toLowerCase().contains(
            textoBusqueda.toLowerCase(),
          );

      final estadoFiltro = opcionesFiltro[filtroSeleccionado];
      final matchEstado =
          estadoFiltro == 'Todo' || consulta.estado == estadoFiltro;

      return matchTexto && matchEstado;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Gestor Jurídico',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/perfil');
              },
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
            TextField(
              onChanged: (valor) {
                setState(() {
                  textoBusqueda = valor;
                });
              },
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
                      onSelected: (bool selected) {
                        setState(() {
                          filtroSeleccionado = index;
                        });
                      },
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
            Expanded(
              child: consultasFiltradas.isEmpty
                  ? Center(
                      child: Text(
                        'No se encontraron resultados',
                        style: TextStyle(color: secondaryColor),
                      ),
                    )
                  : ListView.builder(
                      itemCount: consultasFiltradas.length,
                      itemBuilder: (context, index) {
                        return _construirTarjetaExpediente(
                          consultasFiltradas[index],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Menu(index: 1),
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
      onTap: () {
        Navigator.pushNamed(context, '/detalle', arguments: consulta);
      },
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
