import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class BotonesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _fondoApp(),

          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _titulos(),
                _botonesRedondeados()
              ],
            ),
            )
        ],
      ),
     bottomNavigationBar: _bottomNavigationBar(context)
    );
  }


  Widget _fondoApp(){

    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.6),
          end: FractionalOffset(0.0, 1.0),
          colors: [
             Color.fromRGBO(52, 54, 101, 1.0), 
             Color.fromRGBO(35, 37, 57, 1.0), 
            ],
        )
      ),
    );


    final cajaRosada = Transform.rotate(
      angle: -pi / 4.0,
      child:      Container(
        width: 360.0,
        height: 360.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(236, 98, 188, 1.0), 
            Color.fromRGBO(241, 142, 172, 1.0), 
          ]
          )
      ),
    ),
    );


    return Stack(
      children: <Widget>[
        gradiente,
        Positioned(
          top:  -90,
          child: cajaRosada
          )
      ],
    );
  }



  Widget _titulos(){
    return SafeArea(
          child: Container(
            padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Calssify transsaction', style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),),
            SizedBox(height: 10.0,),
            Text('Calssify this trasactio into a particulas categry', style: TextStyle(color: Colors.white, fontSize: 18.0),),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavigationBar(BuildContext context){
  return Theme(
    data: Theme.of(context).copyWith(
      canvasColor: Color.fromRGBO(55, 57, 84, 1.0),
      primaryColor: Colors.pinkAccent,
      textTheme: Theme.of(context).textTheme.copyWith(
        caption: TextStyle(color: Color.fromRGBO(116, 117, 152, 1.0))
      )
    ), 
    child: BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today, size: 30.0,),
          title: Container(
            child: ListTile(
              onTap: () => Navigator.pushNamed(context, 'scroll'),
            ),
          )
          ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bubble_chart, size: 30.0,),
          title: Container()
          ),
        BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle, size: 30.0,),
          title: Container()
          ),
      ]
      )
    );
}



  Widget _botonesRedondeados(){
    return Table(
      children: [
        TableRow(
          children: [
            _crearBotonRedondeado(Colors.blue, Icons.swap_calls, 'Caja 1'),
            _crearBotonRedondeado(Colors.greenAccent, Icons.switch_video, 'Caja 2')
          ]
        ),
        TableRow(
          children: [
            _crearBotonRedondeado(Colors.redAccent, Icons.table_chart, 'Caja 3'),
            _crearBotonRedondeado(Colors.pinkAccent, Icons.vertical_align_center, 'Caja 4')
          ]
        ),
        TableRow(
          children: [
            _crearBotonRedondeado(Colors.purple, Icons.videocam_off, 'Caja 5'),
            _crearBotonRedondeado(Colors.white38, Icons.view_day, 'Caja 6')
          ]
        ),
        TableRow(
          children: [
            _crearBotonRedondeado(Colors.cyan, Icons.volume_mute, 'Caja 7'),
            _crearBotonRedondeado(Colors.grey, Icons.wb_auto, 'Caja 8')
          ]
        ),
      ],
    );
  }


  Widget _crearBotonRedondeado(Color color, IconData icono, String texto){

    // filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
    return Container(
        height: 180.0,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(12, 66, 107, 1.7),
          borderRadius: BorderRadius.circular(20.0)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(height: 5.0,),
            CircleAvatar(
              backgroundColor: color,
              radius: 35.0,
              child: Icon(icono, color: Colors.white, size: 30.0,),
            ),
            Text(texto, style: TextStyle(color: color),),
            SizedBox(height: 5.0,)
          ],
        ),
      );
  }

}