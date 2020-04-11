import 'package:flutter/material.dart';
import 'package:pushlocal/pages/home_page.dart';
import 'package:pushlocal/pages/massage_page.dart';
import 'package:pushlocal/providers/push_notifications_provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}




class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

      final pushProvider = new PushNotificationsProvider();
      pushProvider.initNotificatiosn();
      pushProvider.mensajes.listen((data){
        navigatorKey.currentState.pushNamed('message', arguments: data);
      });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Push local',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'message': (BuildContext context) => MessagePage()
      },
    );
  }
}