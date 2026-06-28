import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/consulta.dart';
class FirebaseService {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<void> guardarConsulta(
    Consulta consulta,
  ) async {
    await db
        .collection('consultas')
        .doc(consulta.idConsulta)
        .set(consulta.toJson());
  }
  static Future<List<Consulta>> obtenerConsultas() async {
    final snapshot = await db.collection('consultas').get();

    return snapshot.docs.map((doc) {
      final data = doc.data();

      return Consulta.fromJson(data, doc.id);
    }).toList();
  }
  static Stream<List<Consulta>> streamConsultas() {
    return db.collection('consultas').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Consulta.fromJson(doc.data(), doc.id);
      }).toList();
    });
  }
  static Future<void> actualizarEstado(String idConsulta, String nuevoEstado) async {
  await db.collection('consultas').doc(idConsulta).update({
    'estado': nuevoEstado,
    'updatedAt': FieldValue.serverTimestamp(),
  });
}
}