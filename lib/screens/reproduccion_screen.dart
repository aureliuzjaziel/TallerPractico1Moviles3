import 'package:flutter/material.dart';
import 'package:taller_practico/navigations/buttom_navigation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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

  bool get _isUserLoggedIn => Supabase.instance.client.auth.currentSession != null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pelicula = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
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
      appBar: AppBar(title: Text(pelicula?['titulo'] ?? "Reproducción")),
      drawer: const AppDrawer(),
      body: pelicula == null
          ? const Center(child: Text("No se encontró la película"))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    pelicula['titulo'] ?? "Película",
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      pelicula['imagen'] ?? '',
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image, size: 64),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _isUserLoggedIn
                      ? _buildVideoPlayer(pelicula)
                      : _buildLoginNotice(context),
                  const SizedBox(height: 20),
                  Text(pelicula['descripcion'] ?? "", style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
    );
  }

  Widget _buildVideoPlayer(Map<String, dynamic>? pelicula) {
    final videoUrl = pelicula?['video'] ?? '';
    if (videoUrl.isEmpty) return const Text("No hay video disponible");

    _videoController ??= VideoPlayerController.network(videoUrl);
    _initializeVideoPlayerFuture ??= _videoController!.initialize();

    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: [
              AspectRatio(
                aspectRatio: _videoController!.value.aspectRatio,
                child: VideoPlayer(_videoController!),
              ),
              ElevatedButton(
                onPressed: () => setState(() {
                  _videoController!.value.isPlaying
                      ? _videoController!.pause()
                      : _videoController!.play();
                }),
                child: Text(_videoController!.value.isPlaying ? "Pausar" : "Reproducir"),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildLoginNotice(BuildContext context) => Column(
        children: [
          const Text(
            "Debes iniciar sesión para reproducir la película.",
            style: TextStyle(color: Colors.black87),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, "/login_screen"),
            child: const Text("Iniciar sesión"),
          ),
        ],
      );
}
