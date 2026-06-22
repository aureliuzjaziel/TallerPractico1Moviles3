import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Stream Movie',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Catálogo'),
            onTap: () {
              Navigator.pushNamed(context, "/catalogo_screen");
            },
          ),
          ListTile(
            leading: Icon(Icons.play_circle),
            title: Text('Reproducción'),
            onTap: () {
              Navigator.pushNamed(context, "/reproduccion_screen");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Cerrar Sesión'),
            onTap: () {
              Navigator.pushNamed(context, "/");
            },
          ),
        ],
      ),
    );
  }
}
