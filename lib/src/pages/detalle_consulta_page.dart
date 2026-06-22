import 'package:flutter/material.dart';
import '../models/consulta.dart';

class DetalleConsultaPage extends StatefulWidget {
  const DetalleConsultaPage({super.key});

  @override
  State<DetalleConsultaPage> createState() => _DetalleConsultaPageState();
}

class _DetalleConsultaPageState extends State<DetalleConsultaPage> {
  // Paleta de colores oficial unificada con el Integrante 4
  final Color primaryColor = const Color(0xFF1A2B4B);
  final Color secondaryColor = const Color(0xFF64748B);
  final Color neutralColor = const Color(0xFF77777A);

  // Variable para manejar el estado mutable del expediente localmente
  String? _estadoMutado;

  @override
  Widget build(BuildContext context) {
    // Captura de los argumentos dinámicos inyectados por el Integrante 4
    final Consulta consulta = ModalRoute.of(context)!.settings.arguments as Consulta;

    // Si es la primera vez que renderiza, adoptamos el estado original del objeto
    _estadoMutado ??= consulta.estado;

    // Mutación estética y transaccional del indicador según el estado actual
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
      // 1. APPBAR REQUERIDA POR EL TALLER
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.pop(context), // Destruye la vista de la pila y regresa
        ),
        title: Text(
          'Detalle del Caso',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.account_circle_outlined, color: secondaryColor, size: 28),
          ),
        ],
      ),
      // 2. LISTVIEW REQUERIDO POR EL TALLER (Evita el desbordamiento RenderFlex Overflow)
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          
          // 3. CONTENEDOR PRINCIPAL ESTILIZADO (Manejo de márgenes, rellenos y sombras)
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0), // Curvatura pronunciada según WhatsApp
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
                // Fila de Título Dinámico y Estado
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        consulta.tema,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          height: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Indicador de Estado Reactivo
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: statusBgColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _estadoMutado!.toUpperCase(),
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
                // Código del expediente o referencia externa
                Text(
                  consulta.expediente,
                  style: TextStyle(fontSize: 14, color: secondaryColor),
                ),
                const SizedBox(height: 20),
                const Divider(height: 1, thickness: 0.5),
                const SizedBox(height: 20),

                // Sección: CLIENTE
                Text(
                  'CLIENTE',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: secondaryColor, letterSpacing: 1),
                ),
                const SizedBox(height: 4),
                Text(
                  consulta.cliente,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor),
                ),
                Text(
                  consulta.contacto.isNotEmpty ? 'Contacto: ${consulta.contacto}' : 'Contacto: Sin registrar',
                  style: TextStyle(fontSize: 14, color: secondaryColor),
                ),
                const SizedBox(height: 20),

                // Sección: FECHAS
                Text(
                  'FECHAS',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: secondaryColor, letterSpacing: 1),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined, size: 14, color: secondaryColor),
                    const SizedBox(width: 6),
                    Text('Ingreso: ${consulta.fecha}', style: TextStyle(fontSize: 14, color: primaryColor)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined, size: 14, color: secondaryColor),
                    const SizedBox(width: 6),
                    Text('Vencimiento: Estimado 30 días', style: TextStyle(fontSize: 14, color: primaryColor)),
                  ],
                ),
                const SizedBox(height: 24),

                // Sección: DESCRIPCIÓN COMPLETA
                Text(
                  'DESCRIPCIÓN COMPLETA',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: secondaryColor, letterSpacing: 1),
                ),
                const SizedBox(height: 10),
                // Sub-contenedor con aspecto de bloque de lectura limpia
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Text(
                    consulta.descripcion.isNotEmpty 
                        ? consulta.descripcion 
                        : 'No se ha provisto una descripción detallada para este expediente jurídico actual.',
                    style: TextStyle(fontSize: 14, color: primaryColor, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),

          // 4. BOTONES DE ACCIÓN (ElevatedButtons requeridos por el práctico)
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.list, color: primaryColor, size: 18),
              label: Text('Volver al listado', style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600)),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade400),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 10),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton.icon(
              onPressed: () {
                // Futura conexión imperativa del Integrante 2 (Modo Edición)
              },
              icon: Icon(Icons.edit_outlined, color: primaryColor, size: 18),
              label: Text('Editar información', style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600)),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade400),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 10),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {
                // Mutación declarativa del estado de la interfaz (UI = f(state))
                setState(() {
                  if (_estadoMutado == 'En análisis') {
                    _estadoMutado = 'Resuelto';
                  } else if (_estadoMutado == 'Resuelto') {
                    _estadoMutado = 'Pendiente';
                  } else {
                    _estadoMutado = 'En análisis';
                  }
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Estado modificado a: $_estadoMutado'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              icon: const Icon(Icons.swap_horiz, size: 18),
              label: const Text('Cambiar estado', style: TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}