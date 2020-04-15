import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pruebanavigationbar/src/widgets/boton_bar.dart';


class HomePage extends StatefulWidget {
  // const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String tipo = 'motoYcarro';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página de inicio'),
        ),
        body: Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                CupertinoButton(
                  child: Text('Cambiar', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),), 
                  color: Colors.blue,
                  onPressed: (){
                    setState(() {
                      if(tipo == 'motoYcarro'){
                         tipo = 'moto';
                      }else if(tipo == 'moto'){
                         tipo = 'carro';
                      }else if(tipo == 'carro'){
                         tipo = 'motoYcarro';
                      }
                    });
                  }
                  ),
                _crearNavigationButtons(context)
              ],
            )
          ),
        ),
    );
  }

  Widget _crearNavigationButtons(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.15,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: listaBotonesBar(tipo),
      ),
    );
  }
}