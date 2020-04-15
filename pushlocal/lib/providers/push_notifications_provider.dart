import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsProvider{

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String>  get mensajes => _mensajesStreamController.stream;

  initNotificatiosn(){
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token){
      print('===== FCM Token ======');
      print(token);
    });

    _firebaseMessaging.configure(
// cuando la app esta abierta
      onMessage: (info){
        print('=====  On Message =====');
        print(info);

        String argumento = 'no_data';
        if(Platform.isAndroid){
          // gaseosa es la clave del mensaje que se envia en firebase
          argumento = info['data']['gaseosa'] ?? 'no_data';
        }
        _mensajesStreamController.sink.add(argumento);
      },



// cuando la app esta en segundo plano
      onLaunch: (info){
        print('===== On Launch ======');
        print(info);
      
        final noti = info['data']['gaseosa'];
        _mensajesStreamController.sink.add(noti);
      },




// cuando la app estaba en segundo plano y se reanuda
      onResume: (info){
      print('===== On Resume ======');
      print(info);

      final noti = info['data']['gaseosa'];
      _mensajesStreamController.sink.add(noti);
      }
    );
  }


  dispose(){
    _mensajesStreamController?.close();
  }

}



// doCkHPqunTE:APA91bE48CkYSg7j1M4SQB1xxRpztMm8VtXc9IzOlN87QV7kCPqSn1OsA8gGBg6-ltZdMjLDvGzyQ3KWU6dnBpM19H3XbqvcKagPn7HI2JJVco9P6HW6DuUaS-Bu_6JTKVo-P7XKVNJr