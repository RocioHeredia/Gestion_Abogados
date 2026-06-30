import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/consulta.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  //conexión a la base de datos de Firestore
  static final FirebaseFirestore db =
      FirebaseFirestore.instance; //para acceder a las consultas
  static final FirebaseAuth auth =
      FirebaseAuth.instance; //para acceder a la autenticación de usuarios
  static String get uid =>
      auth.currentUser!.uid; //para obtener el uid del usuario actual
  static CollectionReference<Map<String, dynamic>> get consultasRef => db
      .collection('users')
      .doc(uid)
      .collection(
        'lista_consultas',
      ); //variable para acceder a la colección de consultas del usuario actual

  //funcion para actualizar el nombre del usuario en la base de datos
  static Future<void> actualizarNombre(String nuevoNombre) async {
    await db.collection('users').doc(uid).update({'username': nuevoNombre});
  }

  //funcion para leer el nombre del usuario en la base de datos
  static Future<String> obtenerNombre() async {
    final snapshot = await db.collection('users').doc(uid).get();

    return snapshot.data()?['username'] ?? 'user';
  }

  //funcion para crear un usuario en la base de datos si no existe
  static Future<void> crearUsuarioSiNoExiste() async {
    final doc = db.collection('users').doc(uid);

    final snapshot = await doc.get();

    if (!snapshot.exists) {
      await doc.set({
        'username': 'user',
        'mail': auth.currentUser!.email,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  static Future<void> guardarConsulta(Consulta consulta) async {
    await consultasRef.doc(consulta.idConsulta).set(consulta.toJson());
  }

  static Future<List<Consulta>> obtenerConsultas() async {
    final snapshot = await consultasRef.get();

    return snapshot.docs.map((doc) {
      final data = doc.data();

      return Consulta.fromJson(data, doc.id);
    }).toList();
  }

  static Stream<List<Consulta>> streamConsultas() {
    return consultasRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Consulta.fromJson(doc.data(), doc.id);
      }).toList();
    });
  }

  static Future<void> actualizarEstado(
    String idConsulta,
    String nuevoEstado,
  ) async {
    await consultasRef.doc(idConsulta).update({
      'estado': nuevoEstado,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> actualizarConsulta(Consulta consultaActualizada) async {
    await consultasRef
        .doc(consultaActualizada.idConsulta)
        .update(consultaActualizada.toJson());
  }
}
