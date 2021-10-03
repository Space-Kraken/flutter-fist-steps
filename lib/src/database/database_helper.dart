import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:practica2/src/models/notas_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _DBName = "NOTASBD";
  static final _DBVersion = 1;
  static final _TBLName = "tblNotas";

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    Directory carpeta = await getApplicationDocumentsDirectory();
    // String rutaBD = "$carpeta.path/$_DBName";
    String rutaBD = join(carpeta.path, _DBName);
    return openDatabase(
      rutaBD,
      version: _DBVersion,
      onCreate: _createTable,
    );
  }

  Future<void> _createTable(Database db, int version) async {
    // await db.execute("CREATE TABLE $_TBLName (id INTEGER PRIMARY KEY, titulo VARCHAR(50), detalle VARCHAR(100))");
    String script =
        "CREATE TABLE $_TBLName (id INTEGER PRIMARY KEY, titulo VARCHAR(50), detalle VARCHAR(100))";
    await db.execute(script);
  }

  Future<int> insert(Map<String, dynamic> row) async {
    var connection = await database;
    return connection!.insert(_TBLName, row);
  }

  Future<int> update(Map<String, dynamic> row) async {
    var connection = await database;
    return connection!
        .update(_TBLName, row, where: "id = ?", whereArgs: [row['id']]);
  }

  Future<int> delete(int id) async {
    var connection = await database;
    return connection!.delete(_TBLName, where: "id = ?", whereArgs: [id]);
  }

  Future<List<NotasModel>> getAllNotes() async {
    var connection = await database;
    var notesList = await connection!.query(_TBLName);
    return notesList.map((note) => NotasModel.fromMap(note)).toList();
  }

  Future<NotasModel> getNote(int id) async {
    var connection = await database;
    var note =
        await connection!.query(_TBLName, where: "id = ?", whereArgs: [id]);
    return NotasModel.fromMap(note.first);
  }
}
