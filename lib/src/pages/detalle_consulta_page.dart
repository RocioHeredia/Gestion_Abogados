import 'package:flutter/material.dart';
import '../models/consulta.dart';

class DetalleConsultaPage extends StatefulWidget {
  const DetalleConsultaPage({super.key});

  @override
  State<DetalleConsultaPage> createState() => _DetalleConsultaPageState();
}

class _DetalleConsultaPageState extends State<DetalleConsultaPage> {
  // Paleta de colores oficial unificada con el grupo
  final Color primaryColor = const Color(0xFF1A2B4B);
  final Color secondaryColor = const Color(0xFF64748B);
  final Color neutralColor = const Color(0xFF77777A);

  // Variable para manejar el estado mutable del expediente localmente
  String? _estadoMutado;

  @override
  Widget build(BuildContext context) {
    //Recibe la consulta enviada desde otra pantalla.
    final Consulta consulta =
        ModalRoute.of(context)!.settings.arguments as Consulta;

    // Si es null, asignale este valor.
    _estadoMutado ??= consulta.estado;

    // Colores según el estado
    Color statusBgColor = Colors.blue.shade50;
    Color statusTextColor = Colors.blue.shade700;

    if (_estadoMutado == 'Pendiente') {
      statusBgColor = Colors.orange.shade50;
      statusTextColor = Colors.orange.shade800;
    } else if (_estadoMutado == 'Resuelto') {
      statusBgColor = Colors.green.shade50;
      statusTextColor = Colors.green.shade700;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Detalle del Caso',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.account_circle_outlined,
              color: secondaryColor,
              size: 28,
            ),
          ),
        ],
      ),

      body: ListView(
        // Evita el desbordamiento RenderFlex Overflow(Permite hacer scroll.)
        padding: const EdgeInsets.all(16.0),
        children: [
          // tarjeta principal
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                24.0,
              ), // Curvatura pronunciada según WhatsApp
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      //que ocupe todo
                      child: Text(
                        consulta.tema, // Lee el JSON
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          height: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    //
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: statusBgColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _estadoMutado!.toUpperCase(), //convierte a mayúsculas
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: statusTextColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                Text(
                  consulta.expediente, //expediente
                  style: TextStyle(fontSize: 14, color: secondaryColor),
                ),
                const SizedBox(height: 20),
                const Divider(height: 1, thickness: 0.5),
                const SizedBox(height: 20),

                Text(
                  'CLIENTE', //cliente
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: secondaryColor,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  consulta.cliente, //cliente del JSON
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  'Contacto:  ${consulta.contacto}', //contacto del JSON
                  style: TextStyle(fontSize: 14, color: secondaryColor),
                ),
                const SizedBox(height: 20),

                // Sección: FECHAS
                Text(
                  'FECHAS',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: secondaryColor,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: secondaryColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Ingreso: ${consulta.fecha}',
                      style: TextStyle(fontSize: 14, color: primaryColor),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: secondaryColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Vencimiento: Estimado 30 días',
                      style: TextStyle(fontSize: 14, color: primaryColor),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                Text(
                  'DESCRIPCIÓN COMPLETA',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: secondaryColor,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Text(
                    consulta.descripcion,
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Botones
          SizedBox(
            width: double.infinity,
            height: 46,
            child: OutlinedButton.icon(
              // Botón para volver al listado
              onPressed: () =>
                  Navigator.pop(context), //vuelve a la pantalla anterior
              icon: Icon(Icons.dehaze, color: primaryColor, size: 16),
              label: Text(
                'Volver al listado',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            height: 46,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/NuevaConsulta',
                  arguments: consulta,
                );
              },
              icon: Icon(Icons.edit_outlined, color: primaryColor, size: 16),
              label: Text(
                'Editar información',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  //El estado cambió, redibuja la pantalla.
                  if (_estadoMutado == 'En análisis') {
                    _estadoMutado = 'Resuelto';
                  } else if (_estadoMutado == 'Resuelto') {
                    _estadoMutado = 'Pendiente';
                  } else {
                    _estadoMutado = 'En análisis';
                  }
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  //mensaje temporal.
                  SnackBar(
                    content: Text('Estado modificado a: $_estadoMutado'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              icon: const Icon(Icons.update, size: 16, color: Colors.white),
              label: const Text(
                'Cambiar estado',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
