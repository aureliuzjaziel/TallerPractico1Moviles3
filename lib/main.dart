import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taller_practico/screens/catalogo_screen.dart';
import 'package:taller_practico/screens/home_screen.dart';
import 'package:taller_practico/screens/login_screen.dart';
import 'package:taller_practico/screens/register_screen.dart';
import 'package:taller_practico/screens/reproduccion_screen.dart';

Future<void> main() async {
  
  await Supabase.initialize(
    url: 'https://kylrypfmbklnbfgdwedh.supabase.co',
    publishableKey: 'sb_publishable_5cUpJo3yPx5bTLUK5V4Y7A_amGYp2CT',
  );

runApp(MiAplicacion());

}
final supabase = Supabase.instance.client;


 class MiAplicacion extends StatelessWidget {
  const MiAplicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      initialRoute: "/",
      routes: {
        "/":(context) => HomeScreen(),
        "/login_screen":(context) => LoginScreen(),
        "/register_screen":(context) => RegisterScreen(),
        "/catalogo_screen":(context) => CatalogoScreen(),
        "/reproduccion_screen":(context) => ReproduccionScreen()
        
        
      },
    );
  }
}

