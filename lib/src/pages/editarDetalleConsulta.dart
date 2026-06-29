import 'package:flutter/material.dart';
import '../models/consulta.dart';
import '../services/firebase_service.dart';

class editarDetalleConsulta extends StatefulWidget {
  const editarDetalleConsulta({super.key});

  @override
  State<editarDetalleConsulta> createState() => _editarDetalleConsultaState();
}

class _editarDetalleConsultaState extends State<editarDetalleConsulta> {
  // Paleta de colores oficial unificada
  final Color primaryColor = const Color(0xFF1A2B4B);
  final Color secondaryColor = const Color(0xFF64748B);

  late TextEditingController clienteController;
  late TextEditingController temaController;
  late TextEditingController expedienteController;
  late TextEditingController descripcionController;
  late TextEditingController contactoController;

  bool _isInitialized = false;
  late Consulta consulta;
  bool _estaGuardando = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Solo inicializamos los controladores la primera vez que se construye la pantalla
    if (!_isInitialized) {
      consulta = ModalRoute.of(context)!.settings.arguments as Consulta;

      clienteController = TextEditingController(text: consulta.cliente);
      temaController = TextEditingController(text: consulta.tema);
      expedienteController = TextEditingController(text: consulta.expediente);
      descripcionController = TextEditingController(text: consulta.descripcion);
      contactoController = TextEditingController(text: consulta.contacto);

      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    clienteController.dispose();
    temaController.dispose();
    expedienteController.dispose();
    descripcionController.dispose();
    contactoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Editar Información',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: primaryColor,
        ), // Color de la flecha de volver
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
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
                _construirCampoTexto('NOMBRE DEL CLIENTE', clienteController),
                const SizedBox(height: 20),
                _construirCampoTexto('TIPO DE CONSULTA / TEMA', temaController),
                const SizedBox(height: 20),
                _construirCampoTexto('NRO. EXPEDIENTE', expedienteController),
                const SizedBox(height: 20),
                _construirCampoTexto('CONTACTO', contactoController),
                const SizedBox(height: 20),
                _construirCampoTexto(
                  'DESCRIPCIÓN COMPLETA',
                  descripcionController,
                  maxLines: 6,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: _estaGuardando
                  ? null
                  : () async {
                      setState(() {
                        _estaGuardando = true;
                      });

                      // 1. Creamos un nuevo objeto con los datos frescos (sin pisar las variables final)
                      Consulta consultaActualizada = Consulta(
                        idConsulta: consulta.idConsulta,
                        cliente: clienteController.text,
                        tema: temaController.text,
                        expediente: expedienteController.text,
                        contacto: contactoController.text,
                        descripcion: descripcionController.text,
                        estado: consulta.estado,
                        fecha: consulta.fecha,
                      );

                      try {
                        // 2. Lo mandamos a guardar a Firebase (Llamada estática directa)
                        await FirebaseService.actualizarConsulta(
                          consultaActualizada,
                        );

                        if (!context.mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Consulta actualizada con éxito'),
                          ),
                        );

                        // 3. Volvemos a la pantalla anterior
                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error al actualizar: $e')),
                        );
                        setState(() {
                          _estaGuardando = false;
                        });
                      }
                    },
              icon: _estaGuardando
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.save_outlined, color: Colors.white),
              label: Text(
                _estaGuardando ? 'GUARDANDO...' : 'GUARDAR CAMBIOS',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
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
        ],
      ),
    );
  }

  // Widget auxiliar para mantener el código limpio y no repetir los TextField
  Widget _construirCampoTexto(
    String etiqueta,
    TextEditingController controlador, {
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          etiqueta,
          style: TextStyle(
            color: secondaryColor,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controlador,
          maxLines: maxLines,
          style: TextStyle(
            fontSize: 15,
            color: primaryColor,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF8F9FA),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primaryColor, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
