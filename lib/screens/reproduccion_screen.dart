import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taller_practico/navigations/buttom_navigation.dart';
import 'package:video_player/video_player.dart';

class ReproduccionScreen extends StatefulWidget {
  const ReproduccionScreen({super.key});

  @override
  State<ReproduccionScreen> createState() => _ReproduccionScreenState();
}

class _ReproduccionScreenState extends State<ReproduccionScreen> {
  VideoPlayerController? _videoController;
  Future<void>? _initializeVideoPlayerFuture;
  Map<String, dynamic>? _pelicula;

  bool get _isUserLoggedIn => Supabase.instance.client.auth.currentUser != null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_pelicula != null) return;

    _pelicula = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (_isUserLoggedIn && _pelicula != null) {
      final videoUrl = (_pelicula!['video'] as String?)?.trim() ?? '';
      if (videoUrl.isNotEmpty) {
        _videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
        _initializeVideoPlayerFuture = _videoController!.initialize().then((_) {
          if (mounted) setState(() {});
        });
      }
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pelicula = _pelicula;
    return Scaffold(
      appBar: AppBar(
        title: Text(pelicula != null ? pelicula['titulo'] as String : 'Reproducción'),
      ),
      drawer: const AppDrawer(),
      body: pelicula == null
          ? const Center(child: Text('No se encontró la película.'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    pelicula['titulo'] as String? ?? 'Película',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${pelicula['genero'] ?? ''} • ${pelicula['anio'] ?? ''} • ${pelicula['duracion'] ?? ''}',
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      pelicula['imagen'] as String? ?? '',
                      height: 220,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 220,
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: Icon(Icons.image, size: 64, color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_isUserLoggedIn && _videoController != null)
                    _buildVideoPlayer()
                  else
                    _buildLoginNotice(context),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
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
                        Text(
                          pelicula['descripcion'] as String? ?? '',
                          style: const TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                        const SizedBox(height: 16),
                        if (_isUserLoggedIn && _videoController != null)
                          ElevatedButton.icon(
                            onPressed: _toggleVideoPlayback,
                            icon: Icon(_videoController!.value.isPlaying ? Icons.pause : Icons.play_arrow),
                            label: Text(_videoController!.value.isPlaying ? 'Pausar' : 'Reproducir'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                          )
                        else
                          const Text(
                            'Inicia sesión para ver el video de la película.',
                            style: TextStyle(color: Colors.black54),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _detalleFila('Calificación', '${pelicula['calificacion'] ?? '-'}'),
                  const SizedBox(height: 8),
                  _detalleFila('Trailer', pelicula['trailer'] as String? ?? ''),
                  const SizedBox(height: 8),
                  _detalleFila('Video', pelicula['video'] as String? ?? ''),
                ],
              ),
            ),
    );
  }

  Widget _buildVideoPlayer() {
    return FutureBuilder<void>(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 220,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError || _videoController == null) {
          return const SizedBox(
            height: 220,
            child: Center(child: Text('No se pudo cargar el video.')),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: _videoController!.value.aspectRatio,
              child: VideoPlayer(_videoController!),
            ),
            VideoProgressIndicator(
              _videoController!,
              allowScrubbing: true,
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLoginNotice(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Debes estar registrado para reproducir el video.',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/login_screen');
            },
            icon: const Icon(Icons.login),
            label: const Text('Iniciar sesión'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleVideoPlayback() {
    final controller = _videoController;
    if (controller == null) return;

    setState(() {
      if (controller.value.isPlaying) {
        controller.pause();
      } else {
        controller.play();
      }
    });
  }
}

Widget _detalleFila(String etiqueta, String valor) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: 2,
        child: Text(
          etiqueta,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ),
      Expanded(
        flex: 5,
        child: Text(
          valor,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    ],
  );
}
