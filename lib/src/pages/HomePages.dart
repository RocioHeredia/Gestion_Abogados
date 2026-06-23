import 'package:flutter/material.dart';
import '../widgets/menu.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

        String clienteSeleccionado = '';
        String temaSeleccionado = '';
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
body: SingleChildScrollView(
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
    Container(    // Tarjeta de estadísticas: Total de consultas registradas
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Column(
          children: [
            Icon(Icons.folder_open, size: 40),
            SizedBox(height: 10),
            Text(
              'Total: 24',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Consultas Registradas'),
          ],
        ),
      ),

        const SizedBox(height: 20),

    Container( // Tarjeta que muestra la cantidad de consultas pendientes
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Column(
          children: [
            Icon(Icons.hourglass_empty,
                size: 40,
                color: Colors.orange),
            SizedBox(height: 10),
            Text(
              'Pendientes: 8',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Requieren Acción'),
          ],
        ),
      ),

      const SizedBox(height: 20),

    Container( // Tarjeta que muestra la cantidad de consultas resueltas
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Column(
          children: [
            Icon(Icons.check_circle,
                size: 40,
                color: Colors.green),
            SizedBox(height: 10),
            Text(
              'Resueltas: 16',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Casos Cerrados'),
            ],
          ),
        ),

        SizedBox(height: 30),

        Text( //Titulo consultas recientes
          'Consultas recientes',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A2B4B),
          ),
        ),
        SizedBox(height: 20),

    // Consulta reciente: Elena Martínez Valdés
    Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
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
            Text(
              'Elena Martínez Valdés',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
        ),
    Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Pendiente',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 10),

        Text(
          'Litigio Sucesorio Internacional',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
        ),

        SizedBox(height: 20),

        Divider(),

        SizedBox(height: 10),

        Row(
                children: [
                  Icon(Icons.calendar_today, size: 16),
                  SizedBox(width: 8),
                  Text('14 Junio 2026'),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 20),

    // Consulta reciente: TechNova Solutions
    Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
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
                Text(
                  'TechNova Solutions S.A.',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
    Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'Resuelto',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),

      SizedBox(height: 10),

      Text(
        'Revisión de Patentes',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 18,
        ),
      ),

      SizedBox(height: 20),

      Divider(),

      SizedBox(height: 10),

      Row(
        children: [
          Icon(Icons.calendar_today, size: 16),
          SizedBox(width: 8),
          Text('05 Junio 2026'),
              ],
            ),
          ],
        ),
      ),

      SizedBox(height: 20),

    // Consulta reciente: Constructora Horizonte
    Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
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
          Text(
            'Constructora Horizonte',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'En análisis',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),

      SizedBox(height: 10),

      Text(
        'Contrato de Licitación Pública',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 18,
        ),
      ),

      SizedBox(height: 20),

      Divider(),

      SizedBox(height: 10),

      Row(
            children: [
                Icon(Icons.calendar_today, size: 16),
                SizedBox(width: 8),
                Text('15 Junio 2026'),
              ],
            ),
          ],
        ),
      ),

      SizedBox(height: 20),

      SizedBox(
        width: double.infinity,
        height: 50,
        child: OutlinedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/Consultas');
          },
          child: Text('Ver todas las consultas'),
        ),
      ),

      SizedBox(height: 20),
  //Calendario
  Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            'Junio 2026',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A2B4B),
            ),
          ),

      SizedBox(height: 20),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('L'),
            Text('M'),
            Text('X'),
            Text('J'),
            Text('V'),
            Text('S'),
            Text('D'),
          ],
        ),

      SizedBox(height: 15),
      // Primera fila
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('4'),
          // Día 5 (TechNova)
          GestureDetector(
            onTap: () {
              setState(() {
                clienteSeleccionado = 'TechNova Solutions S.A.';
                temaSeleccionado = 'Revisión de Patentes';
              });
            },
            child: Column(
              children: [
                Text('5'),
                SizedBox(height: 2),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          Text('6'),
          Text('7'),
          Text('8'),
          Text('9'),
          Text('10'),
        ],
      ),

      SizedBox(height: 15),

      // Segunda fila
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('11'),
          Text('12'),
          Text('13'),

      // Día 14
      GestureDetector(
        onTap: () {
          setState(() {
            clienteSeleccionado = 'Elena Martínez Valdés';
            temaSeleccionado = 'Litigio Sucesorio Internacional';
          });
        },
        child: Column(
          children: [
            Text('14'),
            SizedBox(height: 2),
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),

      // Día 15
      GestureDetector(
        onTap: () {
          setState(() {
            clienteSeleccionado = 'Constructora Horizonte';
            temaSeleccionado = 'Contrato de Licitación Pública';
          });
        },
        child: Column(
          children: [
            Text('15'),
            SizedBox(height: 2),
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
      Text('16'),
      Text('17'),
              ],
            ),
          ],
        )
              ),
        SizedBox(height: 20),

        Divider(),

        SizedBox(height: 20),

        Center(
          child: Text(
            clienteSeleccionado.isEmpty
                ? 'Seleccione una fecha'
                : '$clienteSeleccionado\n$temaSeleccionado',
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 70),
        ],
        ),
        ),


  floatingActionButton: FloatingActionButton(
  backgroundColor: const Color(0xFF001F54),
  foregroundColor: Colors.white,
  elevation: 8,
  onPressed: () {},
  child: const Icon(Icons.add),
  ),
  bottomNavigationBar: const Menu(index: 0),
  );


  }
  }