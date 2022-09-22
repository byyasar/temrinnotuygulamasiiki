import 'package:sqflite/sqflite.dart';
import 'package:temrinnotuygulamasiiki/core/database_helper.dart';
import 'package:temrinnotuygulamasiiki/core/init/database/database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/temrin/model/temrin_model.dart';

class TemrinDatabaseProvider extends DatabaseProvider<TemrinModel> {
  final String _temrinTableName = "tblTemrin";
  final int _version = 1;
  Database? _database;
  List<TemrinModel> _temrinMaps = [];

  String columnId = "id";
  String columnTemrinAd = "temrinAd";

  @override
  Future<Database?> open() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    _database = await databaseHelper.getDatabase();
    return _database;
  }

  @override
  Future<TemrinModel> getItem(int id) async {
    _database ??= await open();
    var userMaps = await _database!.query(_temrinTableName, where: '$columnId = ?', whereArgs: [id]);
    if (userMaps.isNotEmpty) {
      return TemrinModel().fromJson(userMaps.first);
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<List<TemrinModel>> getList() async {
    _database ??= await open();
    var sonuc = await _database!.query(_temrinTableName);

    if (sonuc.isNotEmpty) {
      _temrinMaps = sonuc.map((e) => TemrinModel().fromJson(e)).toList();
      return _temrinMaps;
    } else {
      return _temrinMaps;
    }
  }

  Future<void> createTable(Database db) async {
    await db.execute(
      '''CREATE TABLE $_temrinTableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
        $columnTemrinAd VARCHAR(20),
        ''',
    );
  }

  @override
  Future<bool> insertItem(TemrinModel model) async {
    _database ??= await open();
    if (_database != null) {
      await _database!.insert(_temrinTableName, model.toJson());
      return true;
    }
    return false;
  }

  @override
  Future<bool> removeItem(int id) async {
    _database ??= await open();
    if (_database != null) {
      await _database!.delete(_temrinTableName, where: '$columnId=?', whereArgs: [id]);
      return true;
    }
    return false;
  }

  @override
  Future<void> close() async {
    await _database!.close();
  }

  @override
  Future<bool> updateItem(int id, TemrinModel model) async {
    _database ??= await open();
    if (_database != null) {
      await _database!.update(_temrinTableName, model.toJson(), where: '$columnId = ?', whereArgs: [id]);
      return true;
    }
    return false;
  }
}
