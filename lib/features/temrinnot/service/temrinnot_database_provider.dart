import 'package:sqflite/sqflite.dart';
import 'package:temrinnotuygulamasiiki/core/database_helper.dart';
import 'package:temrinnotuygulamasiiki/core/init/database/database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/model/temrinnot_model.dart';

class TemrinNotDatabaseProvider extends DatabaseProvider<TemrinNotModel> {
  final String _temrinTableName = "tblTemrinNot";
  final int _version = 1;
  Database? _database;
  List<TemrinNotModel> _temrinMaps = [];

  String columnId = "id";
  String columnTemrinId = "temrinId";
  String columnDersId = "ogrenciId";
  String columnPuanBir = "puanBir";
  String columnPuanIki = "puanIki";
  String columnPuanUc = "puanUc";
  String columnPuanDort = "puanDort";
  String columnPuanBes = "puanBes";
  String columnAciklama = "aciklama";
  String columnNotTarih = "notTarih";

  @override
  Future<Database?> open() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    _database = await databaseHelper.getDatabase();
    return _database;
  }

  @override
  Future<TemrinNotModel> getItem(int id) async {
    _database ??= await open();
    var userMaps = await _database!
        .query(_temrinTableName, where: '$columnId = ?', whereArgs: [id]);
    if (userMaps.isNotEmpty) {
      return TemrinNotModel().fromJson(userMaps.first);
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<List<TemrinNotModel>> getList() async {
    _database ??= await open();
    var sonuc = await _database!.query(_temrinTableName);

    if (sonuc.isNotEmpty) {
      _temrinMaps = sonuc.map((e) => TemrinNotModel().fromJson(e)).toList();
      return _temrinMaps;
    } else {
      return _temrinMaps;
    }
  }

  @override
  Future<List<TemrinNotModel>> getFilterList(int id) async {
    _database ??= await open();
    var sonuc = await _database!
        .query(_temrinTableName, where: '$columnDersId = ?', whereArgs: [id]);
    if (sonuc.isNotEmpty) {
      _temrinMaps = sonuc.map((e) => TemrinNotModel().fromJson(e)).toList();
      return _temrinMaps;
    } else {
      return [];
    }
  }

  Future<void> createTable(Database db) async {
    await db.execute(
      '''CREATE TABLE $_temrinTableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
        $columnTemrinId VARCHAR(20),
        ''',
    );
  }

  @override
  Future<bool> insertItem(TemrinNotModel model) async {
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
      await _database!
          .delete(_temrinTableName, where: '$columnId=?', whereArgs: [id]);
      return true;
    }
    return false;
  }

  @override
  Future<void> close() async {
    await _database!.close();
  }

  @override
  Future<bool> updateItem(int id, TemrinNotModel model) async {
    _database ??= await open();
    if (_database != null) {
      await _database!.update(_temrinTableName, model.toJson(),
          where: '$columnId = ?', whereArgs: [id]);
      return true;
    }
    return false;
  }
}
