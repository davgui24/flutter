import 'package:flutter/material.dart';
import 'package:preferenciasusuarioapp/src/pages/share_pref/preferencias_usuario.dart';

import 'package:preferenciasusuarioapp/src/pages/widgets/menu_widget.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);


  static final String routeName = 'home';

  @override
  Widget build(BuildContext context) {

    final pref = new PreferenciasUsuario();
    pref.ultimaPagina = HomePage.routeName;

    return Scaffold(
      appBar: AppBar(
        title: Text('Preferencias del usuario'),
        backgroundColor: (pref.colorSecunsario) ? Colors.teal : Colors.blue,
      ),
      drawer: MenuWidget(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Color secundario: ${pref.colorSecunsario}'),
          Divider(),
          Text('Género: ${pref.genero}'),
          Divider(),
          Text('Nombre usuario: ${pref.nombre}'),
          Divider(),
        ],
      ),
    );
  }


}