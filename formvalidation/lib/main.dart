import 'package:flutter/material.dart';

import 'package:formvalidation/scr/bloc/provider.dart';
import 'package:formvalidation/scr/pages/home_page.dart';
import 'package:formvalidation/scr/pages/login_page.dart';
import 'package:formvalidation/scr/pages/producto_page.dart';
import 'package:formvalidation/scr/pages/registro_page.dart';
import 'package:formvalidation/scr/preferencias_usuario/preferencias_usuario.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = new PreferenciasUsuario();
  await pref.initPrefs();
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    print(prefs.token);
    return Provider(child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Formulario login',
      initialRoute: 'login',
      routes: {
       'login': (BuildContext context) => LoginPage(),
       'home': (BuildContext context) => HomePage(),
       'producto': (BuildContext context) => ProductoPage(),
       'registro': (BuildContext context) => RegistroPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple
      ),
    )
  );
    
    

  }
}