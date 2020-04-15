import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pruebaprovider/src/providers/count_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  CountProviders _countProvider = new CountProviders();

  @override
  void initState() {
    super.initState();
    
    // _countProvider.addListener((){
    //   print('Nuevo valor ${_countProvider.count}');
    // });
  }

  @override
  Widget build(BuildContext context) {
    print('Build');
    return ChangeNotifierProvider.value(
      value: _countProvider,
      child: Container(
       child: Scaffold(
         appBar: AppBar(
           title: Text('Provider Apps')
           ),
           body: Center(
             child: Consumer<CountProviders>(
               builder: (BuildContext context,provider, widget){
                 return Text(provider.count.toString(), style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),);
               },
               ),
           ),
           floatingActionButton: FloatingActionButton(
             child: Icon(Icons.add),
             onPressed: (){
                 _countProvider.incrementarCount();
             }
            ),
       ),
     ),
   );
  }
}