import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  bool get _isUserLoggedIn => Supabase.instance.client.auth.currentSession != null;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
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
            leading: const Icon(Icons.movie),
            title: const Text('Catálogo'),
            onTap: () {
              if (_isUserLoggedIn) {
                Navigator.pushNamed(context, "/catalogo_screen");
              } else {
                Navigator.pushNamed(context, "/login_screen");
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () => Navigator.pushNamed(context, "/home"),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar Sesión'),
            onTap: () async {
              await Supabase.instance.client.auth.signOut();
              Navigator.pushNamedAndRemoveUntil(
                context,
                "/login_screen",
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
