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
              color: Colors.black.withOpacity(0.4),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/register_screen");
                  },
                  child: const Text("Registrate"),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/login_screen");
                  },
                  child: const Text("Iniciar Sesión"),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/catalogo_screen");
                  },
                  child: const Text("Ver Catálogo"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
