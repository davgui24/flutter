import 'package:flutter/material.dart';
import 'package:preferenciasusuarioapp/src/pages/share_pref/preferencias_usuario.dart';
import 'package:preferenciasusuarioapp/src/pages/widgets/menu_widget.dart';



class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);


  static final String routeName = 'settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

    bool _colorSecundario;
    int _genero;
    String _nombre;

    TextEditingController _textCtrl;

    PreferenciasUsuario pref = new PreferenciasUsuario();


@override
  void initState(){
    // TODO: implement initState
    super.initState();

    pref.ultimaPagina = SettingsPage.routeName;

    _genero = pref.genero;
    _colorSecundario = pref.colorSecunsario;
    _nombre = pref.nombre;
    _textCtrl  = new TextEditingController(text: pref.nombre);
  }





   _setSelectedRadio(int valor){
       pref.genero = valor;
       _genero = valor;
       setState(() {});
     }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
        backgroundColor: (pref.colorSecunsario) ? Colors.teal : Colors.blue,
      ),
      drawer: MenuWidget(),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text('Settings', style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold)),
          ), 
          Divider(),
          SwitchListTile(
            value: _colorSecundario,
            title: Text('Color secundario'),
            onChanged: (value){
              setState(() {
                pref.colorSecunsario = value;
              _colorSecundario = pref.colorSecunsario;
              });
            }
          ),
          RadioListTile(
            value: 1, 
            title: Text('Maculino'),
            groupValue: _genero, 
            onChanged: _setSelectedRadio
          ),
          RadioListTile(
            value: 2, 
            title: Text('Femenino'),
            groupValue: _genero, 
            onChanged: _setSelectedRadio
          ),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _textCtrl,
              decoration: InputDecoration(
                labelText: 'Nombre: ${pref.nombre}',
                helperText: 'Persona usando el teléfono'
              ),
              onChanged: (value){
                pref.nombre = value;
                _nombre = pref.nombre;
              },
            ),
          )
        ],
      )
    );
  }
}