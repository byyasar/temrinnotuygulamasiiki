class DatabaseConstants {
  static DatabaseConstants? _instance;
  static DatabaseConstants get instance {
    _instance ??= DatabaseConstants._init();
    return _instance!;
  }

  DatabaseConstants._init();
  final String databaseName = "deneme3";
}
