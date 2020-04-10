import 'dart:math';

import 'package:flutter/material.dart';

class ImputPage extends StatefulWidget {
  ImputPage({Key key}) : super(key: key);

  @override
  _ImputPageState createState() => _ImputPageState();
}

class _ImputPageState extends State<ImputPage> {


String _nombre = '';
String _email = '';
String _password = '';
String _fecha = '';

String _opcionSelecionada = 'Volar';

List<String> _poderes = ['Volar', 'Rayos X', 'Super aliento', 'Super fuerza'];

TextEditingController _inputFieldController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inputs de texto')
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          _crearInput(),
          Divider(),
          _crearEmail(),
          Divider(),
          _crearPassword(),
          Divider(),
          _crearFecha(context),
          Divider(),
          _crearDropdown(),
          Divider(),
          _crearPersona()
        ],
      )
    );
  }

  Widget _crearInput() {
    return TextField(
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        counter: Text('Letras ${_nombre.length}'),
        hintText: 'Nombre de la persona',
        labelText: 'Nombre',
        helperText: 'Solo es el nombre',
        suffixIcon: Icon(Icons.accessibility),
        icon: Icon(Icons.account_circle),
      ),
      onChanged: (valor){
        setState(() {
            _nombre = valor;
        });
      },
    );
  }

  Widget _crearEmail() {
       return TextField(
         keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Email',
        labelText: 'Email',
        suffixIcon: Icon(Icons.alternate_email),
        icon: Icon(Icons.email),
      ),
      onChanged: (valor) => setState(() {
            _email = valor;
        })
      
    );
  }

  Widget _crearPassword() {
       return TextField(
       obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Password',
        labelText: 'Password',
        suffixIcon: Icon(Icons.lock_open),
        icon: Icon(Icons.lock),
      ),
      onChanged: (valor) => setState(() {
            _password = valor;
        })
      
    );
  }



List<DropdownMenuItem<String>> getOpcionesDropdown(){
List<DropdownMenuItem<String>> lista = new List();
  _poderes.forEach((poder){
    lista.add(DropdownMenuItem(
      child: Text(poder),
      value: poder,
      ));
  });

  return lista;
}
  Widget _crearDropdown(){
    return Row(
      children: <Widget>[
        Icon(Icons.select_all),
        SizedBox(width: 30.0),
        Expanded(
          child: DropdownButton(
          value: _opcionSelecionada,
          items: getOpcionesDropdown(), 
          onChanged: (opt){
            setState(() {
              _opcionSelecionada = opt;
            });
          }),
        )
      ],
    );
  }
  
  Widget _crearFecha(BuildContext context) {
     return TextField(
       enableInteractiveSelection: false,
       controller: _inputFieldController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Fecha de nacimiento',
        labelText: 'Fecha',
        suffixIcon: Icon(Icons.calendar_view_day),
        icon: Icon(Icons.calendar_view_day),
      ),
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
      
    );
  }



    Widget _crearPersona() {
    return ListTile(
      title: Text('El nombre es: $_nombre'),
      subtitle: Text('Email: $_email'),
      trailing: Text(_opcionSelecionada),
    );
  }


  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context, 
      initialDate: new DateTime.now(), 
      firstDate: new DateTime(2020),
      lastDate: new DateTime(2021),
      locale: Locale('es', 'CO'));

      if(picked != null){
        setState(() {
          _fecha = picked.toString();
          _inputFieldController.text = _fecha;
        });
      }
  }

}