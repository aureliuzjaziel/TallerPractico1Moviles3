import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static SupabaseClient get client => Supabase.instance.client;

  // Usuario actual
  static User? get currentUser => client.auth.currentUser;

  // Verificar si hay sesión activa
  static bool isLoggedIn() => currentUser != null;

  // Iniciar sesión con correo y contraseña
  static Future<AuthResponse> signIn(String email, String password) async {
    return client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Registrar usuario con correo y contraseña
  static Future<AuthResponse> signUp(String email, String password) async {
    return client.auth.signUp(
      email: email,
      password: password,
    );
  }
}
