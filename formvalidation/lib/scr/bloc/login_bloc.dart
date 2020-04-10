import 'dart:async';

import 'package:formvalidation/scr/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {

  final _emailCtrl = BehaviorSubject<String>();
  final _passwordCtrl = BehaviorSubject<String>();



  // Insertar valores al Stream
  Function(String) get chabgeEmail => _emailCtrl.sink.add;
  Function(String) get chabgePassword => _passwordCtrl.sink.add;


  // Recuperar los datos del Stream
  Stream<String> get emailStream => _emailCtrl.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordCtrl.stream.transform(validarPassword);


  Stream<bool> get formValidStream =>
     CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true);


    //  Obtener el ultimo balor ingresados de los Streams
    String get email => _emailCtrl.value;
    String get password => _passwordCtrl.value;

 dispose(){
   _emailCtrl?.close();
   _passwordCtrl?.close();
 }

}