import 'package:flutter/material.dart';
import 'package:pruebanavigationbar/src/pages/home_page.dart';
import 'package:pruebanavigationbar/src/routes/routes.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: 'home',
      routes: rutas
    );
  }
}