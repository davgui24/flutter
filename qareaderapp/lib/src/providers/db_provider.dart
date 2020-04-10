import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qareaderapp/src/model/scan_model.dart';
export 'package:qareaderapp/src/model/scan_model.dart';


class DBProvider {

  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if(_database != null) return _database;
    _database = await initDB();

    return database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Scans ('
          ' id INTEGER PRIMARY KEY, '
          'tipo TEXT,'
          'valor TEXT'
          ')'
        );
      }
    );
  }


  // CREAR REGISTO DE BASE DE DATOS
  nuevoScanRaw(ScanModel nuevoScan) async {
    
    final db = await  database;
    
    final res = await db.rawInsert(
      "INSERT Into Scans (id, tipo, valor) "
      "VALUES ( ${nuevoScan.id}. '${nuevoScan.tipo}', '${nuevoScan.valor}' )"
    );

    return res;

  }


// Insertar registros
  nuevoScan(ScanModel nuevoScan) async {
    final db = await  database;
    final res = await db.insert('Scans', nuevoScan.toJson());

    return res;
  }

// SELECT Obtener registro por id
  Future<ScanModel>getScanId(int id) async {
      final db = await  database;
      final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

      return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }


// SELECT Obtener todos los registros
  Future<List<ScanModel>> getTodosScans() async {
      final db = await  database;
      final res = await db.query('Scans');

      List<ScanModel> list = res.isNotEmpty 
                           ? res.map((c) => ScanModel.fromJson(c)).toList()
                           : [];

     return list;
  }


// SELECT Obtener todos los registros pot tipo
    Future<List<ScanModel>> getScansporTipo(String tipo) async {
      final db = await  database;
      final res = await db.rawQuery("SELECT Scans WHERE tipo='$tipo'");

      List<ScanModel> list = res.isNotEmpty 
                           ? res.map((c) => ScanModel.fromJson(c)).toList()
                           : [];

     return list;
  }


// Actualizar registro
   Future<int>updateScan(ScanModel nuevoScan) async {
      final db = await  database;
      final res = await db.update('Scans', nuevoScan.toJson(), where: 'id = ?',  whereArgs: [nuevoScan.id]);

      return res;
   }


   // Borrar registro por id
    Future<int>deleteScan(int id) async {
        final db = await  database;
        final res = await db.delete('Scans', where: 'id = ?',  whereArgs: [id]);

        return res;
    }


      // Borrar todos los registros
    Future<int>deleteScansAll() async {
        final db = await  database;
        final res = await db.rawDelete('DELETE FROM Scans');

        return res;
    }

}