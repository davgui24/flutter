import 'dart:async';

import 'package:qareaderapp/src/bloc/validator.dart';
import 'package:qareaderapp/src/providers/db_provider.dart';

class ScansBloc with validators {

     static final ScansBloc _singleton = ScansBloc._internal();

     factory ScansBloc(){
       return _singleton;
     }

    ScansBloc._internal(){
      // Obtener los Scans de la base de datos
      obtenerScans();
    }


    final _scansController = StreamController<List<ScanModel>>.broadcast();

    Stream<List<ScanModel>> get scansStreams => _scansController.stream.transform(validarGeo);
    Stream<List<ScanModel>> get scansStreamsHttp => _scansController.stream.transform(validarHttp);

    dispose(){
      _scansController?.close();
    }


    obtenerScans() async {
      _scansController.sink.add(await DBProvider.db.getTodosScans());
    }


    agregarScan(ScanModel scan) async{
      await DBProvider.db.nuevoScan(scan);
      obtenerScans();
    }

    borrarScan(int id) async {
      await DBProvider.db.deleteScan(id);
      obtenerScans();
    }


    borrarScansTodos() async {
      await DBProvider.db.deleteScansAll();
      obtenerScans();
    }


}