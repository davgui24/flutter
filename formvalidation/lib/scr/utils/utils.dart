  
  
  import 'package:flutter/material.dart';

bool isNumeric(String s){
    if(s.isEmpty) return null;
    
    final n = num.tryParse(s);

    return (n == null) ? false : true;
  }




  mostrarAlerta(BuildContext context, String mensaje){
    showDialog(
      context: context,
      builder: (context){
       return AlertDialog(
          title: Text('Error al procesar!!'),
          content: Text(mensaje),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(), 
              )
          ],
        );
      }
      );
  }
  