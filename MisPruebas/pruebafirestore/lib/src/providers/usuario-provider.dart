
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsusariosProvider extends ChangeNotifier {

  final CollectionReference _usuarios = Firestore.instance.collection('usuarios');

  CollectionReference get usuarios{
    notifyListeners();
    return _usuarios;
  }

}