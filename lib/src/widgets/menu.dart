import 'package:flutter/material.dart';
class Menu extends StatelessWidget {
  final int index;

  const Menu({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      type: BottomNavigationBarType.fixed, //Para mantener los titulo fijos
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: (otherIndex) {
        if (otherIndex == index) return;

        switch (otherIndex) {
          case 0:
            //colocar nombre de ruta correspondiente
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/Consultas');
            break;
          case 2:
            Navigator.pushNamed(context, '/NuevaConsulta').then((_) {
              
              if (context.mounted) {
                (context as Element).markNeedsBuild(); 
              }
            });
            break;
          case 3:
            //colocar nombre de ruta correspondiente
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.folder_open_outlined),
          activeIcon: Icon(Icons.folder),
          label: 'Consultas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline),
          activeIcon: Icon(Icons.add_circle),
          label: 'Nueva',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
    );
  }
}
