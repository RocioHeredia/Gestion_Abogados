import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:app_gestion_abogados/src/models/consulta.dart';
import 'package:app_gestion_abogados/src/services/firebase_service.dart';
import '../widgets/menu.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

//Variables
DateTime _focusedDay = DateTime.now();
DateTime? _selectedDay;
List<Consulta> consultasDelDia = [];
  //Métodos
    DateTime convertirFecha(String fecha) {
      final partes = fecha.split('/');

      return DateTime(
        int.parse(partes[2]),
        int.parse(partes[1]),
        int.parse(partes[0]),
      );
    }
    Color colorEstadoFondo(String estado) {
      switch (estado) {
        case 'Pendiente':
          return Colors.orange.shade100;
        case 'Resuelto':
          return Colors.green.shade100;
        case 'En análisis':
          return Colors.blue.shade100;
        default:
          return Colors.grey.shade200;
      }
      }

    Color colorEstadoTexto(String estado) {
      switch (estado) {
        case 'Pendiente':
          return Colors.orange;
        case 'Resuelto':
          return Colors.green;
        case 'En análisis':
          return Colors.blue;
        default:
          return Colors.grey;
      }
    }
    Widget tarjetaEstadistica({
          required IconData icono,
          required Color color,
          required String titulo,
          required String subtitulo,
        }) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Icon(icono, size: 40, color: color),
                const SizedBox(height: 10),
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(subtitulo),
              ],
            ),
          );
        }
        Widget tarjetaConsulta(Consulta consulta) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        consulta.cliente,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: colorEstadoFondo(consulta.estado),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        consulta.estado,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: colorEstadoTexto(consulta.estado),
                        ),
                      ),
                    ),
                  ],
                ),
          const SizedBox(height: 10),
          Text(
            consulta.tema,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20), 
          const Divider(),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 16),
              const SizedBox(width: 8),
              Text(consulta.fecha),
                    ],
                  ),
                ],
              ),
            );
          }
        Widget botonVerConsultas(BuildContext context) {
          return SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/Consultas');
              },
              child: const Text('Ver todas las consultas'),
                ),
            );
          }
          Widget? marcadorCalendario(
            BuildContext context,
              DateTime day,
              List<dynamic> events,
            ) {
              if (events.isEmpty) return null;

              final consulta = events.first as Consulta;

              return Positioned(
                bottom: 4,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: colorEstadoTexto(consulta.estado),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }
            Widget tituloCalendario(BuildContext context, DateTime day) {
              String titulo = DateFormat.yMMMM('es_ES').format(day);
              titulo = titulo[0].toUpperCase() + titulo.substring(1);

              return Text(
                titulo,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A2B4B),
                ),
              );
            }
            List<Consulta> eventosDelDia(
              DateTime day,
              List<Consulta> consultas,
            ) {
              return consultas.where((consulta) {
                return isSameDay(
                  convertirFecha(consulta.fecha),
                  day,
                );
              }).toList();
            }
Widget calendario(List<Consulta> consultas) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TableCalendar(
          locale: 'es_ES',
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2035, 12, 31),
          focusedDay: _focusedDay,

          eventLoader: (day) => eventosDelDia(day, consultas),

          calendarBuilders: CalendarBuilders(
            headerTitleBuilder: tituloCalendario,
            markerBuilder: marcadorCalendario,
          ),

          selectedDayPredicate: (day) => false,

          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _focusedDay = focusedDay;
              consultasDelDia = eventosDelDia(selectedDay, consultas);
            });
          },
        ),
      );
    }

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Gestor Jurídico'),
actions: const [
Padding(
  padding: EdgeInsets.only(right: 16.0),
  child: CircleAvatar(
    radius: 16,
    backgroundColor: Color(0xFF1A2B4B),
    child: Icon(
      Icons.person,
      color: Colors.white,
      size: 20,
    ),
  ),
),
],
),
body: StreamBuilder<List<Consulta>>(
  stream: FirebaseService.streamConsultas(),
  builder: (context, snapshot) {
    if (snapshot.hasError) {
      return const Center(child: Text('Error al cargar datos'));
    }

    if (!snapshot.hasData) {
      return const Center(child: CircularProgressIndicator());
    }

    //variables
    final consultas = snapshot.data!;
    final total = consultas.length;
    final pendientes = consultas.where((c) => c.estado == 'Pendiente').length;
    final resueltas = consultas.where((c) => c.estado == 'Resuelto').length;
    final recientes = consultas.reversed.take(3).toList();

    return SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bienvenido, Abogado García',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Aquí está el resumen de sus consultas.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
        const SizedBox(height: 30),

        tarjetaEstadistica(
            icono: Icons.folder_open,
            color: Colors.black,
            titulo: 'Total: $total',
            subtitulo: 'Consultas Registradas',
          ),

        const SizedBox(height: 20),

        tarjetaEstadistica(
            icono: Icons.hourglass_empty,
            color: Colors.orange,
            titulo: 'Pendientes: $pendientes',
            subtitulo: 'Requieren Acción',
          ),

        const SizedBox(height: 20),

        tarjetaEstadistica(
            icono: Icons.check_circle,
            color: Colors.green,
            titulo: 'Resueltas: $resueltas',
            subtitulo: 'Casos Cerrados',
          ),

        SizedBox(height: 20),
        
        Column(
          children: recientes
              .map((consulta) => tarjetaConsulta(consulta))
              .toList(),
          ),
  
        SizedBox(height: 20),

        botonVerConsultas(context),

        SizedBox(height: 20),

        calendario(consultas),

const Divider(),

const SizedBox(height: 20),

consultasDelDia.isEmpty
    ? const Center(
        child: Text("Seleccione una fecha"),
      )
    : Column(
        children: consultasDelDia.map((consulta) {
          return Card(
            child: ListTile(
              title: Text(consulta.cliente),
              subtitle: Text(consulta.tema),
              trailing: Text(consulta.estado),
            ),
          );
        }).toList(),
      ),

      const SizedBox(height: 70),
          ], // children
        ), // Column
      ); // SingleChildScrollView
    }, // builder
  ),
      floatingActionButton: FloatingActionButton(
    backgroundColor: const Color(0xFF001F54),
    foregroundColor: Colors.white,
    elevation: 8,
    onPressed: () {},
    child: const Icon(Icons.add),
  ),

  bottomNavigationBar: const Menu(index: 0),
); } // Fin del build

} 