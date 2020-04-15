

import 'package:flutter/widgets.dart';

class CountProviders extends ChangeNotifier{

  int _count = 0;

  int get count => this._count;

  void incrementarCount(){
    _count ++;
    notifyListeners();
  }

}