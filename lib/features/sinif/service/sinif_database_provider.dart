import 'package:sqflite/sqflite.dart';
import 'package:temrinnotuygulamasiiki/core/database_helper.dart';
import 'package:temrinnotuygulamasiiki/core/init/database/database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/model/sinif_model.dart';

class SinifDatabaseProvider extends DatabaseProvider<SinifModel> {
  final String _sinifTableName = "tblSinif";
  final int _version = 1;
  Database? _database;
  List<SinifModel> _sinifMaps = [];

  String columnId = "id";
  String columnSinifAd = "sinifAd";

  @override
  Future<Database?> open() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    _database = await databaseHelper.getDatabase();
    return _database;
  }

  @override
  Future<SinifModel> getItem(int id) async {
    _database ??= await open();
    var userMaps = await _database!.query(_sinifTableName, where: '$columnId = ?', whereArgs: [id]);
    if (userMaps.isNotEmpty) {
      return SinifModel().fromJson(userMaps.first);
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<List<SinifModel>> getList() async {
    _database ??= await open();
    var sonuc = await _database!.query(_sinifTableName);

    if (sonuc.isNotEmpty) {
      _sinifMaps = sonuc.map((e) => SinifModel().fromJson(e)).toList();
      return _sinifMaps;
    } else {
      return _sinifMaps;
    }
  }

  Future<void> createTable(Database db) async {
    await db.execute(
      '''CREATE TABLE $_sinifTableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
        $columnSinifAd VARCHAR(20),
        ''',
    );
  }

  @override
  Future<bool> insertItem(SinifModel model) async {
    _database ??= await open();
    if (_database != null) {
      await _database!.insert(_sinifTableName, model.toJson());
      return true;
    }
    return false;
  }

  @override
  Future<bool> removeItem(int id) async {
    _database ??= await open();
    if (_database != null) {
      await _database!.delete(_sinifTableName, where: '$columnId=?', whereArgs: [id]);
      return true;
    }
    return false;
  }

  @override
  Future<void> close() async {
    await _database!.close();
  }

  @override
  Future<bool> updateItem(int id, SinifModel model) async {
    _database ??= await open();
    if (_database != null) {
      await _database!.update(_sinifTableName, model.toJson(), where: '$columnId = ?', whereArgs: [id]);
      return true;
    }
    return false;
  }
  
  @override
  Future<List<SinifModel>> getFilterList(int id) {
    // TODO: implement getFilterList
    throw UnimplementedError();
  }
}
