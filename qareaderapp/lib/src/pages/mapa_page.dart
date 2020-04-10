import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';


import 'package:qareaderapp/src/model/scan_model.dart';

class MapaPage extends StatefulWidget {
  // const MapaPage({Key key}) : super(key: key);


  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final mapCtrl = new MapController();

  String tipoMapa = 'streets';

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenada QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location), 
            onPressed: (){
              mapCtrl.move(
                scan.getLatLng(), 15
                );
            }
          )
        ],
      ),
      body: Center(child: _crearFlutterMap(scan)),
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  Widget _crearBotonFlotante(BuildContext context) {
     return FloatingActionButton(
       child: Icon(Icons.repeat),
       backgroundColor: Theme.of(context).primaryColor,
       onPressed: (){
         setState(() {
          if(tipoMapa == 'streets'){
          tipoMapa = 'dark';
         }else if(tipoMapa == 'dark'){
            tipoMapa = 'light';
         }else if(tipoMapa == 'light'){
            tipoMapa = 'outdoors';
         }else if(tipoMapa == 'outdoors'){
            tipoMapa = 'satellite';
         }else if(tipoMapa == 'satellite'){
            tipoMapa = 'streets';
         }
         });
       },
     );
  }

  Widget _crearFlutterMap(ScanModel scan) {
      return FlutterMap(
        mapController: mapCtrl,
        options: MapOptions(
          center: scan.getLatLng(),
          zoom: 15
        ),
        layers: [
          _crearMapa(),
          _crearmarcadores(scan)
        ],
      );
  }

  _crearMapa() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken': 'pk.eyJ1IjoiZGF2Z3VpMjQiLCJhIjoiY2s4cDExNHBvMDE3MTNmbzlkeHhnbXgwdiJ9.jVYxZ-jgbltX6HpTFtVYTA',
        'id': 'mapbox.$tipoMapa'  // dark light outdoors  satellite
      }
    );
  }

  _crearmarcadores(ScanModel scan) {
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(),
          builder: (context) =>Container(
            child: Icon(Icons.location_on, size: 70.0, color: Theme.of(context).primaryColor,),
          )
        )
      ]
    );

  }
}