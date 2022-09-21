import 'package:sqflite/sqflite.dart';
import 'package:temrinnotuygulamasiiki/core/database_helper.dart';
import 'package:temrinnotuygulamasiiki/core/init/database/database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/ogrenci/model/ogrenci_model.dart';

class OgrenciDatabaseProvider extends DatabaseProvider<OgrenciModel> {
  final String _ogrenciTableName = "tblOgrenci";
  final int _version = 1;
  Database? _database;
  List<OgrenciModel> _ogrenciMaps = [];

  String columnId = "id";
  String columnOgrenciAd = "ogrenciAd";

  @override
  Future<Database?> open() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    _database = await databaseHelper.getDatabase();
    return _database;
  }

  @override
  Future<OgrenciModel> getItem(int id) async {
    _database ??= await open();
    var userMaps = await _database!.query(_ogrenciTableName, where: '$columnId = ?', whereArgs: [id]);
    if (userMaps.isNotEmpty) {
      return OgrenciModel().fromJson(userMaps.first);
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<List<OgrenciModel>> getList() async {
    _database ??= await open();
    var sonuc = await _database!.query(_ogrenciTableName);

    if (sonuc.isNotEmpty) {
      _ogrenciMaps = sonuc.map((e) => OgrenciModel().fromJson(e)).toList();
      return _ogrenciMaps;
    } else {
      return _ogrenciMaps;
    }
  }

  Future<void> createTable(Database db) async {
    await db.execute(
      '''CREATE TABLE $_ogrenciTableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
        $columnOgrenciAd VARCHAR(20),
        ''',
    );
  }

  @override
  Future<bool> insertItem(OgrenciModel model) async {
    _database ??= await open();
    if (_database != null) {
      await _database!.insert(_ogrenciTableName, model.toJson());
      return true;
    }
    return false;
  }

  @override
  Future<bool> removeItem(int id) async {
    _database ??= await open();
    if (_database != null) {
      await _database!.delete(_ogrenciTableName, where: '$columnId=?', whereArgs: [id]);
      return true;
    }
    return false;
  }

  @override
  Future<void> close() async {
    await _database!.close();
  }

  @override
  Future<bool> updateItem(int id, OgrenciModel model) async {
    _database ??= await open();
    if (_database != null) {
      await _database!.update(_ogrenciTableName, model.toJson(), where: '$columnId = ?', whereArgs: [id]);
      return true;
    }
    return false;
  }
}
