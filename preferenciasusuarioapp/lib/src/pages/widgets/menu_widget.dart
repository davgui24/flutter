import 'package:flutter/material.dart';

import '../home_page.dart';
import '../settings_page.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/menu-img.jpg'),
                  fit: BoxFit.cover
                  )
              ),
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home, color: Colors.blue,),
            onTap: (){
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            },
          ),
          ListTile(
            title: Text('Páginas'),
            leading: Icon(Icons.pages, color: Colors.blue,),
            onTap: (){},
          ),
          ListTile(
            title: Text('Configuraciones'),
            leading: Icon(Icons.settings, color: Colors.blue,),
            onTap: (){
              // Navigator.pop(context);
              Navigator.pushReplacementNamed(context, SettingsPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}