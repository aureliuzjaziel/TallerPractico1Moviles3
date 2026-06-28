import 'package:flutter/material.dart';
import 'package:taller_practico/navigations/buttom_navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stream Movie")),
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/steammovie.jpg',
              fit: BoxFit.cover,
              color: Colors.black.withValues(alpha: 0.4),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => irHome(context),
                  child: const Text("Registrate"),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => irLogin(context),
                  child: const Text('Iniciar Sesion'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => irCatalogo(context),
                  child: const Text('Ver Catálogo'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void irHome(BuildContext context) {
  Navigator.pushNamed(context, "/register_screen");
}

void irLogin(BuildContext context) {
  Navigator.pushNamed(context, "/login_screen");
}

void irCatalogo(BuildContext context) {
  Navigator.pushNamed(context, "/catalogo_screen");
}
