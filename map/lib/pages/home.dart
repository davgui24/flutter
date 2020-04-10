import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'dart:math' as math;
import 'dart:ui' as ui;

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
  Map<PolylineId, Polyline> _polylines = Map();
  List<LatLng> _myRoute = List();

  Uint8List _motoPin;
  Marker _myMarker;
  Position _lastPosition;

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _loadMotodPin();
  }

  // ---------------------------------------------
// ANTES DE INICIAR EL WIDGET CARGA LA IMAGEN DE MI MARCADOR 
  _loadMotodPin() async {
    final byteData = await rootBundle.load('assets/icons/motocicleta.png');
    _motoPin = byteData.buffer.asUint8List();

    final codeC = await ui.instantiateImageCodec(_motoPin, targetHeight: 100, targetWidth: 100);
    final ui.FrameInfo frameInfo =  await codeC.getNextFrame();
    _motoPin = (await frameInfo.image.toByteData(format: ui.ImageByteFormat.png))
    .buffer.
    asUint8List();

    _startTracking();
  }

// HACE SEGUIMIENTO A LA UBICACION ACTUAL
  _startTracking() {
    final geolocator = Geolocator();
    // LocationAccuracy.high  == LA PRESICION MAS ALTA POSIBLE
    // distanceFilter: 2   ==  NOTIFICAR CADA 5 METRO EL CAMBI DE LA UBICACION
    final locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 2);

    _positionStream = geolocator.getPositionStream(locationOptions).listen( _onLocationUpdate);
  }

//  ACTUALIZA LA POSICION DEL MARCADOR DE GOLOCATION (MI UBICACION)
  _onLocationUpdate(Position position) {
    if (position != null) {
      // print('position ${position.latitude}, --  ${position.longitude}');

      final myposition = LatLng(position.latitude, position.longitude);
      _myRoute.add(myposition);

      final myPolyline = Polyline(
        polylineId: PolylineId('mi'), 
        points: _myRoute,
        color: Colors.cyanAccent,
        width: 8
        );

      if(_myMarker == null){

        final bitmap = BitmapDescriptor.fromBytes(_motoPin);
        final myMarkerId = MarkerId('mi');

        _myMarker = Marker(
          markerId: myMarkerId, 
          position: myposition,
          icon: bitmap,
          anchor: Offset(0.5, 0.5),
          rotation: 0
          );
      }else{
        final rotation = _getMyBearning(_lastPosition, position);
        _myMarker = _myMarker.copyWith(positionParam: myposition, rotationParam: rotation);
      }

      setState(() {
        _markers[_myMarker.markerId] = _myMarker;
        _polylines[myPolyline.polylineId] = myPolyline;
      });

      _lastPosition = position;
      _move(position);
    }
  }


// CAMBIAR LA ROTACIO (ORIENTACION) DE LA IMAGEN DEL MARCADOR AL MOVERSE
  _getMyBearning(Position lastPosition, Position currentPosition){
    final dx = math.cos((math.pi/180 * lastPosition.latitude) * (currentPosition.longitude - lastPosition.longitude));
    final dy = currentPosition.latitude - lastPosition.latitude;
    final angulo = math.atan2(dy, dx);
    return 90 - angulo * 180 / math.pi;
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
              polylines: Set.of(_polylines.values),
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
