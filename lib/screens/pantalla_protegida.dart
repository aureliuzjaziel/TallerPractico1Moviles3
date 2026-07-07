import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PantallaProtegida extends StatelessWidget {
  final Widget child;
  const PantallaProtegida({super.key, required this.child});

  bool get _isUserLoggedIn => Supabase.instance.client.auth.currentSession != null;

  @override
  Widget build(BuildContext context) {
    return _isUserLoggedIn
        ? child
        : Scaffold(
            appBar: AppBar(title: const Text("Acceso restringido")),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Debes iniciar sesión para acceder a esta sección.",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, "/login_screen"),
                    child: const Text("Ir al Login"),
                  ),
                ],
              ),
            ),
          );
  }
}
