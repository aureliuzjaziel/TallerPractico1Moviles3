import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taller_practico/navigations/buttom_navigation.dart';

class CatalogoScreen extends StatelessWidget {
  const CatalogoScreen({super.key});

  Future<Map<String, dynamic>> _cargarPeliculas() async {
    final jsonString = await rootBundle.loadString('assets/data/peliculas.json');
    return json.decode(jsonString) as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Catálogo")),
      drawer: const AppDrawer(),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _cargarPeliculas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error al cargar catálogo"));
          }

          final categorias = snapshot.data?['categorias'] as Map<String, dynamic>? ?? {};

          return ListView(
            padding: const EdgeInsets.all(16),
            children: categorias.entries.map((entry) {
              final categoria = entry.value as Map<String, dynamic>;
              final peliculas = List<Map<String, dynamic>>.from(categoria['peliculas']);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    categoria['nombre'] ?? entry.key,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: peliculas.length,
                      itemBuilder: (context, index) {
                        final movie = peliculas[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/reproduccion_screen", arguments: movie);
                          },
                          child: Container(
                            width: 160,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                    child: Image.network(
                                      movie['imagen'] ?? '',
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 48),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    movie['titulo'] ?? 'Título',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
