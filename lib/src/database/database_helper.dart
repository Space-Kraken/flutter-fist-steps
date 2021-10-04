import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:practica2/src/models/notas_model.dart';
import 'package:practica2/src/models/profile_Model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _DBName = "NOTASBD";
  static final _DBVersion = 2;
  static final _TBLNotes = "tblNotas";
  static final _TBLProfile = "tblProfile";

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
      onUpgrade: _onUpgrade,
      onDowngrade: _onDowngrade,
    );
  }

  Future<void> _createTable(Database db, int version) async {
    // await db.execute("CREATE TABLE $_TBLNotes (id INTEGER PRIMARY KEY, titulo VARCHAR(50), detalle VARCHAR(100))");
    String script =
        "CREATE TABLE $_TBLNotes (id INTEGER PRIMARY KEY, titulo VARCHAR(50), detalle VARCHAR(100))";
    await db.execute(script);

    script =
        "CREATE TABLE $_TBLProfile (id INTEGER PRIMARY KEY, name VARCHAR(30), aPaterno VARCHAR(50), aMaterno VARCHAR(50), phoneNumber INT(10), email VARCHAR(50), image VARCHAR(250))";
    await db.execute(script);
  }

  Future<int> insert(Map<String, dynamic> row) async {
    var connection = await database;
    return connection!.insert(_TBLNotes, row);
  }

  Future<int> update(Map<String, dynamic> row) async {
    var connection = await database;
    return connection!
        .update(_TBLNotes, row, where: "id = ?", whereArgs: [row['id']]);
  }

  Future<int> delete(int id) async {
    var connection = await database;
    return connection!.delete(_TBLNotes, where: "id = ?", whereArgs: [id]);
  }

  Future<List<NotasModel>> getAllNotes() async {
    var connection = await database;
    var notesList = await connection!.query(_TBLNotes);
    return notesList.map((note) => NotasModel.fromMap(note)).toList();
  }

  Future<NotasModel> getNote(int id) async {
    var connection = await database;
    var note =
        await connection!.query(_TBLNotes, where: "id = ?", whereArgs: [id]);
    return NotasModel.fromMap(note.first);
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("Upgrading...");
    // Reestructuracion de la BD
    String script =
        "CREATE TABLE $_TBLProfile (id INTEGER PRIMARY KEY, name VARCHAR(30), aPaterno VARCHAR(50), aMaterno VARCHAR(50), phoneNumber INT(10), email VARCHAR(50), image VARCHAR(250))";
    await db.execute(script);
  }

  FutureOr<void> _onDowngrade(
      Database db, int oldVersion, int newVersion) async {
    print("Downgrading...");
    String script = "DROP TABLE $_TBLProfile";
    await db.execute(script);
  }

  Future<List<ProfileModel>> getUser() async {
    var connection = await database;
    var userData = await connection!.query(_TBLProfile);
    return userData.map((user) => ProfileModel.fromMap(user)).toList();
  }

  Future<int> insertUserInfo(Map<String, dynamic> row) async {
    var connection = await database;
    return connection!.insert(_TBLProfile, row);
  }

  Future<int> updateUser(Map<String, dynamic> row) async {
    var connection = await database;
    return connection!
        .update(_TBLProfile, row, where: "id = ?", whereArgs: [row['id']]);
  }
}
