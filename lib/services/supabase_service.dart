import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static SupabaseClient get client => Supabase.instance.client;

  static User? get currentUser => client.auth.currentUser;

  static bool isLoggedIn() => currentUser != null;

  static Future<AuthResponse> signIn(String email, String password) async {
    return client.auth.signInWithPassword(email: email, password: password);
  }

  static Future<AuthResponse> signUp(String email, String password) async {
    return client.auth.signUp(email: email, password: password);
  }

  // Placeholder for future signed URL fetching from Supabase Storage
  static Future<String?> getSignedUrl(String bucket, String path, {int expiresIn = 60}) async {
    try {
      final res = await client.storage.from(bucket).createSignedUrl(path, expiresIn);
      return res;
    } catch (_) {
      return null;
    }
  }
}
