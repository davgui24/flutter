import 'dart:async';
import 'package:flutter/material.dart';

class ListViewPage extends StatefulWidget {
  ListViewPage({Key key}) : super(key: key);

  @override
  _ListViewPageState createState() => _ListViewPageState();
}



class _ListViewPageState extends State<ListViewPage> {

  ScrollController _scrollController = new ScrollController();

  List<int> _listaNumeros = new List();
  int _ultimoItem = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _agregar10();
    _scrollController.addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        // agregar10();
        fetchData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('Listas'),
       ),
       body: Stack(children: <Widget>[
       _crearLista(context),
       _crearLoading()
       ],)
    );
  }

  Widget _crearLista(context){
    return RefreshIndicator(
          onRefresh: obtenerPagina1,
            child: ListView.builder(
            controller: _scrollController,
            itemCount: _listaNumeros.length,
            itemBuilder: (BuildContext context, int index){

            final imagen = _listaNumeros[index];
            return FadeInImage(
              image: NetworkImage('https://picsum.photos/500/300/?image=$imagen'),
              placeholder: AssetImage('assets/jar-loading.gif.gif'),
            );
          }
        ),
    );
  }


  Future<Null> obtenerPagina1() async{
    final duration = new Duration(seconds: 2);
     new Timer(duration, (){
      _listaNumeros.clear();
      _ultimoItem ++;
      _agregar10();
    });

    return Future.delayed(duration);
  }


  Widget _crearLoading(){
    if(_isLoading){
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment:  MainAxisAlignment.center,
            children: <Widget>[
            CircularProgressIndicator(backgroundColor: Colors.orangeAccent,),
          ],),
          SizedBox(height: 20.0,)
        ],
      );
    }else{
      return Container();
    }
  }



  void _agregar10(){
    for (var i = 1; i < 10; i++) {
      _ultimoItem ++;
      _listaNumeros.add(_ultimoItem);
    }
    setState(() {});
  }


  Future<Null> fetchData() async {
    _isLoading = true;
    setState(() {});

    final duration = new Duration(seconds: 2);

    return new Timer(duration, respuestaHTTP);
  } 

  void respuestaHTTP(){
    _isLoading = false;

  _scrollController.animateTo(
    _scrollController.position.pixels + 150,
    curve: Curves.fastOutSlowIn,
    duration: new Duration(milliseconds: 250)
  );

    _agregar10();
  }


  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}

