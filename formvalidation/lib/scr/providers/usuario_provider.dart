
import 'dart:convert';
import 'package:formvalidation/scr/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {

  final String firebaseToken = 'AIzaSyB_ePkAUO8UQrhOMu6IzBpNh2lchUZa_08';
  final _prefs = new PreferenciasUsuario();




// REGISTRO
  Future<Map<String, dynamic>> nuevoUsuario(String email, String password) async {

    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returSecureToken': true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$firebaseToken',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodeResp = json.decode(resp.body);

    print(decodeResp);

    if(decodeResp.containsKey('idToken')){
      // TODO Guardar el token en el estorage

      _prefs.token = decodeResp['idToken'];
      
      return {
        'ok': true, 
        'token': decodeResp['idToken']
        };
    }else{
        return {
        'ok': false, 
        'mensaje': decodeResp['error']['message']
        };
    }
  }


// LOGIN

  Future<Map<String, dynamic>> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returSecureToken': true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$firebaseToken',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodeResp = json.decode(resp.body);

    print(decodeResp);

    if(decodeResp.containsKey('idToken')){
      // TODO Guardar el token en el estorage

      _prefs.token = decodeResp['idToken'];

      return {
        'ok': true, 
        'token': decodeResp['idToken']
        };
    }else{
        return {
        'ok': false, 
        'mensaje': decodeResp['error']['message']
        };
    }
  }

}