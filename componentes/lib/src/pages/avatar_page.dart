import 'package:flutter/material.dart';


class AvatarPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avatar Page'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://firebasestorage.googleapis.com/v0/b/clubspeedy-dev.appspot.com/o/avatars%2Fdavgui242011%40gmail.com.jpg?alt=media&token=55f44a6f-d4d4-4a32-9c46-0bf76d1eecb5'),
              radius: 25.0,
            ),
          ),

          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              child: Text('SL'),
              backgroundColor: Colors.purple
            ),
          )
        ],
      ),
      body: Center(
        child: FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif.gif'), 
          image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/clubspeedy-dev.appspot.com/o/avatars%2Fdavgui242011%40gmail.com.jpg?alt=media&token=55f44a6f-d4d4-4a32-9c46-0bf76d1eecb5'),
          fadeInDuration: Duration(milliseconds: 200),
          )
      ),
    );
  }
}