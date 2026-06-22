import 'package:flutter/material.dart';
import 'package:taller_practico/navigations/buttom_navigation.dart';

class CatalogoScreen extends StatelessWidget {
  const CatalogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo'),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
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
            _categorySection(
              title: 'Populares',
              movies: [
                {'title': 'Película 1', 'subtitle': 'Acción', 'image': 'assets/images/movie1.jpg'},
                {'title': 'Película 2', 'subtitle': 'Aventura', 'image': 'assets/images/movie2.jpg'},
                {'title': 'Película 3', 'subtitle': 'Comedia', 'image': 'assets/images/movie3.jpg'},
              ],
            ),
            const SizedBox(height: 16),
            _categorySection(
              title: 'Tendencias',
              movies: [
                {'title': 'Película 4', 'subtitle': 'Drama', 'image': 'assets/images/movie4.jpg'},
                {'title': 'Película 5', 'subtitle': 'Suspenso', 'image': 'assets/images/movie5.jpg'},
                {'title': 'Película 6', 'subtitle': 'Romance', 'image': 'assets/images/movie6.jpg'},
              ],
            ),
            const SizedBox(height: 16),
            _categorySection(
              title: 'Nuevas llegadas',
              movies: [
                {'title': 'Película 7', 'subtitle': 'Ciencia ficción', 'image': 'assets/images/movie7.jpg'},
                {'title': 'Película 8', 'subtitle': 'Animación', 'image': 'assets/images/movie8.jpg'},
                {'title': 'Película 9', 'subtitle': 'Documental', 'image': 'assets/images/movie9.jpg'},
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _categorySection({
  required String title,
  required List<Map<String, String>> movies,
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
        height: 240,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          separatorBuilder: (context, index) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final movie = movies[index];
            return _movieCard(movie);
          },
        ),
      ),
    ],
  );
}

Widget _movieCard(Map<String, String> movie) {
  return InkWell(
    onTap: () {},
    borderRadius: BorderRadius.circular(16),
    child: Container(
      width: 160,
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
              child: Image.asset(
                movie['image']!,
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
                  movie['title']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  movie['subtitle']!,
                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Descripción breve de la película para ver más detalles.',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
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