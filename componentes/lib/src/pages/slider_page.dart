import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  SliderPage({Key key}) : super(key: key);

  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {

double _valorSlider = 100.0;
bool _blockearCheck = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slider')
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50.0),
        child: Column(
          children: <Widget>[
            _crearSlider(),
            _crearCheckBox(),
            _crearSwitch(),
            Expanded(
              child: _crearImagen()
              )
          ],
        )
      ),
    );
  }

 Widget _crearSlider() {
   return Slider(
     activeColor: Colors.indigoAccent,
     label: 'Tamaño de la imagen',
    //  divisions: 20,
     value: _valorSlider, 
     min: 10.0,
     max: 400.0,
     onChanged: (_blockearCheck) ? null : (valor){
      setState(() {
         _valorSlider = valor;
      });
       }
     );
 }

 Widget _crearImagen() {
   return Image(
      image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/clubspeedy-dev.appspot.com/o/avatars%2Fdavgui242011%40gmail.com.jpg?alt=media&token=55f44a6f-d4d4-4a32-9c46-0bf76d1eecb5'),
      width: _valorSlider,
     );
 }

 Widget _crearCheckBox() {
  //  return Checkbox(
  //     value: _blockearCheck, 
  //     onChanged: (valor){
  //       setState(() {
  //         _blockearCheck = valor;
  //       });
  //     }
  //    );

  return CheckboxListTile(
    title: Text('Blockear slider'),
      value: _blockearCheck, 
      onChanged: (valor){
        setState(() {
          _blockearCheck = valor;
        });
      }
  );
 }

  Widget _crearSwitch() {
    return SwitchListTile(
      title: Text('Blockear slider'),
      value: _blockearCheck, 
      onChanged: (valor){
        setState(() {
          _blockearCheck = valor;
        });
      }
      );
  }
}