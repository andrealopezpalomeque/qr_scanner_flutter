import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:qr_scanner/models/models.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart'; //! permite unir path

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    //path de donde se almacena la base de datos
    Directory documentsDirectory =
        await getApplicationDocumentsDirectory(); //! obtiene el directorio de la aplicacion
    final path = join(documentsDirectory.path,
        'ScansDB.db'); //! une el path con el nombre de la base de datos
    //! creacion de la base de datos
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      //! creacion de las tablas
      await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
    });
  }

// insertar registros en la base de datos // ! (1ra forma)
  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    //! verificar la base de datos
    final db = await database;
    // ! insertar
    final res = await db!.rawInsert('''
      INSERT INTO Scans(id, tipo, valor)
        VALUES($id, '$tipo', '$valor')
    ''');
    return res;
  }

// insertar registros en la base de datos // ! (2da forma)
  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database; //! verificar la base de datos
    final res = await db!
        .insert('Scans', nuevoScan.toJson()); //! insertar en la base de datos

    return res; //? id del ultimo registro insertado
  }

// obtener por id
  Future<ScanModel?> getScanById(int id) async {
    final db = await database; //! verificar la base de datos
    final res = await db!.query('Scans', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty // chequeo si esta vacio
        ? ScanModel.fromJson(res.first) // primer elemento de la lista
        : null;
  }

  //obtener todos los scans
  Future<List<ScanModel>> getTodosScans() async {
    final db = await database; //! verificar la base de datos
    final res = await db!.query('Scans');
    return res.isNotEmpty // chequeo si esta vacio
        ? res
            .map((s) => ScanModel.fromJson(s))
            .toList() // primer elemento de la lista
        : [];
  }

  //obtener todos los scans por tipo
  Future<List<ScanModel>> getScansPorTipo(String tipo) async {
    final db = await database; //! verificar la base de datos
    final res = await db!.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'
    ''');
    return res.isNotEmpty // chequeo si esta vacio
        ? res
            .map((s) => ScanModel.fromJson(s))
            .toList() // primer elemento de la lista
        : [];
  }

  //actualizar registros
  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database; //! verificar la base de datos
    final res = await db!.update('Scans', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }

  //eliminar registro
  Future<int> deleteScan(int id) async {
    final db = await database; //! verificar la base de datos
    final res = await db!.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  //eliminar todos los registros
  Future<int> deleteAllScans() async {
    final db = await database; //! verificar la base de datos
    final res = await db!.rawDelete('''
      DELETE FROM Scans
    ''');
    return res;
  }
}
