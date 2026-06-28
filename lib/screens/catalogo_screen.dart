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
      appBar: AppBar(
        title: const Text('Catálogo'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _cargarPeliculas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error al cargar el catálogo: ${snapshot.error}'));
          }

          final categorias = (snapshot.data?['categorias'] as Map<String, dynamic>?) ?? {};
          final entries = categorias.entries;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Explora el catálogo',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Películas organizadas por categoría para que elijas tu favorito.',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 16),
                ...entries.map((entry) {
                  final category = entry.value as Map<String, dynamic>;
                  final peliculas = List<Map<String, dynamic>>.from(category['peliculas'] as List<dynamic>);
                  return Column(
                    children: [
                      _categorySection(
                        context: context,
                        title: category['nombre'] as String? ?? entry.key,
                        movies: peliculas,
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget _categorySection({
  required BuildContext context,
  required String title,
  required List<Map<String, dynamic>> movies,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Ver todo'),
          ),
        ],
      ),
      const SizedBox(height: 8),
      SizedBox(
        height: 250,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          separatorBuilder: (context, index) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final movie = movies[index];
            return _movieCard(context, movie);
          },
        ),
      ),
    ],
  );
}

Widget _movieCard(BuildContext context, Map<String, dynamic> movie) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, '/reproduccion_screen', arguments: movie);
    },
    borderRadius: BorderRadius.circular(16),
    child: Container(
      width: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                movie['imagen'] as String? ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(Icons.image, size: 48, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie['titulo'] as String? ?? 'Título',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  movie['genero'] as String? ?? '',
                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                ),
                const SizedBox(height: 8),
                Text(
                  movie['descripcion'] as String? ?? '',
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
