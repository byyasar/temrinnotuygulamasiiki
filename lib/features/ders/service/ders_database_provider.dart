import 'package:sqflite/sqflite.dart';
import 'package:temrinnotuygulamasiiki/core/database_helper.dart';
import 'package:temrinnotuygulamasiiki/core/init/database/database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/ders/model/ders_model.dart';

class DersDatabaseProvider extends DatabaseProvider<DersModel> {
  final String _dersTableName = "tblDers";
  final int _version = 1;
  Database? _database;
  List<DersModel> _dersMaps = [];

  String columnId = "id";
  String columnDersAd = "dersAd";
  String columnSinifId = "sinifId";

  @override
  Future<Database?> open() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    _database = await databaseHelper.getDatabase();
    return _database;
  }

  @override
  Future<DersModel> getItem(int id) async {
    _database ??= await open();
    var userMaps = await _database!.query(_dersTableName, where: '$columnId = ?', whereArgs: [id]);
    if (userMaps.isNotEmpty) {
      return DersModel().fromJson(userMaps.first);
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<List<DersModel>> getList() async {
    _database ??= await open();
    var sonuc = await _database!.query(_dersTableName);

    if (sonuc.isNotEmpty) {
      _dersMaps = sonuc.map((e) => DersModel().fromJson(e)).toList();
      return _dersMaps;
    } else {
      return _dersMaps;
    }
  }

  Future<void> createTable(Database db) async {
    await db.execute(
      '''CREATE TABLE $_dersTableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
        $columnDersAd VARCHAR(20),
        $columnSinifId INTEGER)
        ''',
    );
  }

  @override
  Future<bool> insertItem(DersModel model) async {
    _database ??= await open();
    if (_database != null) {
      await _database!.insert(_dersTableName, model.toJson());
      return true;
    }
    return false;
  }

  @override
  Future<bool> removeItem(int id) async {
    _database ??= await open();
    if (_database != null) {
      await _database!.delete(_dersTableName, where: '$columnId=?', whereArgs: [id]);
      return true;
    }
    return false;
  }

  @override
  Future<void> close() async {
    await _database!.close();
  }

  @override
  Future<bool> updateItem(int id, DersModel model) async {
    _database ??= await open();
    if (_database != null) {
      await _database!.update(_dersTableName, model.toJson(), where: '$columnId = ?', whereArgs: [id]);
      return true;
    }
    return false;
  }
}
