import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taller_practico/screens/home_screen.dart';
import 'package:taller_practico/screens/login_screen.dart';
import 'package:taller_practico/screens/register_screen.dart';
import 'package:taller_practico/screens/catalogo_screen.dart';
import 'package:taller_practico/screens/reproduccion_screen.dart';
import 'package:taller_practico/screens/pantalla_protegida.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://kylrypfmbklnbfgdwedh.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt5bHJ5cGZtYmtsbmJmZ2R3ZWRoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODI2NzU4ODIsImV4cCI6MjA5ODI1MTg4Mn0.OHFrxybDPZl5FaB-XYJFLRO64oK17UfcNQ4uqNni1hg',
  );

  runApp(const MiAplicacion());
}

class MiAplicacion extends StatelessWidget {
  const MiAplicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Movie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AuthGate(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/login_screen': (context) => const LoginScreen(),
        '/register_screen': (context) => const RegisterScreen(),
        '/catalogo_screen': (context) =>
            const PantallaProtegida(child: CatalogoScreen()),
        '/reproduccion_screen': (context) =>
            const PantallaProtegida(child: ReproduccionScreen()),
      },
    );
  }
}

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  Session? _currentSession;
  late final StreamSubscription<AuthState> _authSubscription;

  @override
  void initState() {
    super.initState();
    _currentSession = Supabase.instance.client.auth.currentSession;
    _authSubscription =
        Supabase.instance.client.auth.onAuthStateChange.listen((event) {
      setState(() {
        _currentSession = event.session;
      });
    });
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return const HomeScreen();
  }
}

