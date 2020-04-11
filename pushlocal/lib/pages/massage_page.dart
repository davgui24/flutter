import 'package:flutter/material.dart';


class MessagePage extends StatelessWidget {
  const MessagePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

        final String arg = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Menssage Page'),
      ),
      body: Center(
        child: Text(arg),
      )
    );
  }
}