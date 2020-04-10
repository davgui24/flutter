import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:advanced_map/utils/map_style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  GoogleMapController _mapController;
  StreamSubscription<Position> _positionStream;
  Map<MarkerId, Marker> _markers = Map();

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _startTracking();
  }

  // ---------------------------------------------
// HACE SEGUIMIENTO A LA UBICACION ACTUAL
  _startTracking() {
    final geolocator = Geolocator();
    // LocationAccuracy.high  == LA PRESICION MAS ALTA POSIBLE
    // distanceFilter: 2   ==  NOTIFICAR CADA 5 METRO EL CAMBI DE LA UBICACION
    final locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 2);

    _positionStream = geolocator.getPositionStream(locationOptions).listen( _onLocationUpdate);
  }

//  ACTUALIZA LA POSICION DEL MARCADOR DE GOLOCATION (MI UBICACION)
  _onLocationUpdate(Position posittion) {
    if (posittion != null) {
      // print('position ${posittion.latitude}, --  ${posittion.longitude}');
      _move(posittion);
    }
  }


// MOVER LA CAMARA DE MAPA CUANDO SE CAMBIA DE POSISION
  _move(Position posittion){
    final cameraUpdate = CameraUpdate.newLatLng(LatLng(posittion.latitude, posittion.longitude));
    _mapController.animateCamera(cameraUpdate);
  }


// ACTUALIZAR POSICICION DEL LOS MARCADORES AL ARRASTRARLO
  _upDatemarkerPosition(MarkerId markerId, LatLng p){
    _markers[markerId] = _markers[markerId].copyWith(positionParam: p);
    print('Nueva posicion: ${p.longitude}, ${p.longitude}');
  }

// MOSTARR VENTANA DE INFOWINDOWS CUANDO SE TOCA EL MARCADOR
  _onTap(LatLng p){
    final id = '${_markers.length}';
    final markerId = MarkerId(id);
    final infowindow = InfoWindow(
      title: 'Marker: $id',
      snippet: '${p.latitude}, ${p.longitude}',
      anchor: Offset(0.5, 0.5),
      onTap: (){
        print('Info: $id');
      }
    );

    // final marker = Marker(markerId: markerId, position: p, infoWindow: infowindow);
    final marker = Marker(markerId: markerId, 
    position: p, 
    draggable: true, 
    infoWindow: infowindow,
    onDragEnd: (nP) => _upDatemarkerPosition(markerId, nP),
    );

    setState(() {
      _markers[markerId] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: _kGooglePlex,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onTap: _onTap,
              markers: Set.of(_markers.values),
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
                _mapController.setMapStyle(json.encode(mapStyle));
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_positionStream != null) {
      _positionStream.cancel();
      _positionStream = null;
    }
    super.dispose();
  }
}
