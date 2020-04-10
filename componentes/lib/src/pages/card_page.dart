import 'package:flutter/material.dart';


class CardPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
        ),
        body: ListView(
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            _cardTipo1(),
            SizedBox(height: 30.0),
            _cardTipo2(),
          ]
        ),
    );
  }

 Widget _cardTipo1() {

   return Card(
     elevation: 10.0,
     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
     child: Column(
       children: <Widget>[
         ListTile(
           leading: Icon(Icons.photo_album, color: Colors.blue),
           title: Text('Soy el titulo de esta tarjeta'),
           subtitle: Text('Esta es la descripción de la tarjeta que quiero que ustedes vea para tener una idea de lo que quiero mostrarles.'),
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.end,
           children: <Widget>[
             FlatButton(
               child: Text('Cancelar'),
               onPressed: () {}
             ),
             FlatButton(
               child: Text('Ok'),
               onPressed: () {}
             ),
           ],
         ),
       ]
     )
   );
  }

  Widget _cardTipo2() {
      final card = Container(
        // clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            FadeInImage(
              image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/b/bc/Tunisian_Landscape.jpg'),
              placeholder: AssetImage('assets/jar-loading.gif.gif'),
              fadeInDuration: Duration(milliseconds: 200),
              height: 300.0,
              fit: BoxFit.cover,
            ),
            // Image(
            //   image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTnzsJfnlBbhZPcG9EJfoRUB9G7Z_0tx41nf6SZvofVogEXwXrN&usqp=CAU')
            //   ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text(' no tengo idea de que poner')
                )
          ],
        ),
      );
      
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              spreadRadius: 2.0,
              offset: Offset(2.0, 10.0)
            )
          ]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: card,
          ),
      );
  }

  
}