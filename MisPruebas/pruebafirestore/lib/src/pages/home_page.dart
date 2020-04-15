import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:pruebafirestore/src/providers/usuario-provider.dart';



class HomePage extends StatefulWidget {
  // const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}



// ================================


class _HomePageState extends State<HomePage> {

  UsusariosProvider _usuariosPrvider = UsusariosProvider();

  @override
  void initState() {
    super.initState();
    _usuariosPrvider.addListener((){
      
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ChangeNotifierProvider.value(
            value: _usuariosPrvider,
            child: Scaffold(
            appBar: AppBar(
              title: Text('Prueba de Firestore'),
            ),
            body: Consumer<UsusariosProvider>(
              builder: (BuildContext context, usuarioProvider, widget){
                return StreamBuilder(
                      stream: usuarioProvider.usuarios.snapshots(),
                      builder: (BuildContext context, snapshot){
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Center( child: CircularProgressIndicator());
                            break;
                          default: 
                          final usuarios = snapshot.data.documents;
                            return ListView.builder(
                              itemCount: usuarios.length,
                              itemBuilder: (BuildContext context, index){
                          return ListTile(
                                  title: Text(usuarios[index]['nombres']),
                                  subtitle: Text(usuarios[index]['email']),
                                  leading: Icon(Icons.person),
                                  trailing: Icon(Icons.arrow_right),
                                  onTap: (){},
                                  onLongPress: (){},
                                );
                              }
                            );
                        }
                      },
                    );
              },
            )
          ),
        )
    );
  }
}