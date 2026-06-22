import 'package:flutter/material.dart';
import 'package:taller_practico/navigations/buttom_navigation.dart';

class ReproduccionScreen extends StatelessWidget {
  const ReproduccionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reproducción'),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Reproductor de película',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Aquí puedes ver la película y usar los controles de reproducción.',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 16),
            Container(
              height: 220,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Icon(
                      Icons.play_circle_outline,
                      color: Colors.white54,
                      size: 72,
                    ),
                  ),
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 16,
                    child: Column(
                      children: const [
                        LinearProgressIndicator(
                          value: 0.3,
                          color: Colors.red,
                          backgroundColor: Colors.white24,
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('00:12', style: TextStyle(color: Colors.white70)),
                            Text('1:45:32', style: TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _controlButton(Icons.play_arrow, 'Reproducir'),
                      _controlButton(Icons.pause, 'Pausa'),
                      _controlButton(Icons.fast_forward, 'Adelantar'),
                      _controlButton(Icons.fast_rewind, 'Retroceder'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _optionChip('Subtítulos'),
                      _optionChip('Calidad'),
                      _optionChip('Volumen'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ajustes de reproducción',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _infoRow('Formato', 'HD 1080p'),
            const SizedBox(height: 8),
            _infoRow('Subtítulos', 'Español'),
            const SizedBox(height: 8),
            _infoRow('Velocidad', 'Normal'),
          ],
        ),
      ),
    );
  }
}

Widget _controlButton(IconData icon, String label) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(icon, color: Colors.blue),
          onPressed: () {},
        ),
      ),
      const SizedBox(height: 8),
      Text(label, style: const TextStyle(fontSize: 12)),
    ],
  );
}

Widget _optionChip(String label) {
  return Chip(
    label: Text(label),
    backgroundColor: Colors.grey.shade200,
  );
}

Widget _infoRow(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: const TextStyle(fontSize: 14, color: Colors.black54)),
      Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
    ],
  );
}
