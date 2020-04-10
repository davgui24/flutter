import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';


import 'package:qareaderapp/src/model/scan_model.dart';
import 'package:qareaderapp/src/pages/direcciones_page.dart';
import 'package:qareaderapp/src/pages/mapas_page.dart';
import 'package:qareaderapp/src/bloc/scans_bloc.dart';

import 'package:qareaderapp/src/utils/utils.dart' as utils;


class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scanBloc = new ScansBloc();
  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(icon: 
          Icon(Icons.delete_forever), 
          onPressed: scanBloc.borrarScansTodos
          )
        ],
      ),
      body: _callpage(currentIndex),
      bottomNavigationBar: _bottomNavitationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => _scanQR(context)
        ),
    );
  }

  Widget _callpage(int paginaActual) {
    switch( paginaActual ){
      case 0: return MapasPage();
      case 1: return DireccionesPage();
      default:
      return MapasPage();
    }
  }

  Widget _bottomNavitationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index){
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas')
          ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones')
          ),
      ],
      );
  }

  _scanQR(BuildContext context) async {
    // https://www.sertrucingenieria.co/
    // geo:10.386348988155989,-75.47261610468753
    String futureString;


    try{
       futureString = await  BarcodeScanner.scan();
    }catch(err){
       futureString = err.toString();
    }


    if(futureString != null){
      final scan = ScanModel(valor: futureString);
      scanBloc.agregarScan(scan);

      if(Platform.isIOS){
        Future.delayed(Duration(milliseconds: 750), (){
         utils.abrirScan(context, scan);
        });
      }else{
        utils.abrirScan(context, scan);
      }
    }


  }
 
}