import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class SpashPage extends StatefulWidget {
  SpashPage({Key key}) : super(key: key);

  @override
  _SpashPageState createState() => _SpashPageState();
}

class _SpashPageState extends State<SpashPage> with WidgetsBindingObserver {


  PermissionHandler _permissionHandler = PermissionHandler();
  var _isChechind=true;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _chech();
  }

  _chech() async {
    final status = await _permissionHandler.checkPermissionStatus(PermissionGroup.locationWhenInUse);

    if(status == PermissionStatus.granted){
      Navigator.pushReplacementNamed(context, 'home');
    }{
      setState(() {
        _isChechind=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: _isChechind ? Center(
          child: CupertinoActivityIndicator(radius: 15.0,)
          ) : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
                'MISSING PERMISSION', 
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  letterSpacing: 1
                ),
              ),
              SizedBox(height: 10,),
              CupertinoButton(
                child: Text('Allow'), 
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30.0),
                onPressed: _request
                )
          ],
        )
      ),
    );
  }




  _request() async {
    final result = await _permissionHandler.requestPermissions([PermissionGroup.locationWhenInUse]);
    if(result.containsKey(PermissionGroup.locationWhenInUse)){
      final status = result[PermissionGroup.locationWhenInUse];
      if(status == PermissionStatus.granted){
        Navigator.pushReplacementNamed(context, 'home');
      }else if(status == PermissionStatus.denied){
        final result = await _permissionHandler.openAppSettings();
      }
    }
  }



  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('ESTADO --> $state');
    if(state == AppLifecycleState.resumed){
      _chech();
    }
  }
}