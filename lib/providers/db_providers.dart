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

  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    //! verificar la base de datos
    final db = await database;

    final res = await db!.rawInsert('''
      INSERT INTO Scans(id, tipo, valor)
        VALUES($id, '$tipo', '$valor')
    ''');
    return res;
  }

  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database; //! verificar la base de datos
    final res = await db!
        .insert('Scans', nuevoScan.toJson()); //! insertar en la base de datos
    print(res);

    return res; //! id del ultimo registro insertado
  }
}
