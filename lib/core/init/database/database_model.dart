abstract class DatabaseModel<T> {
  T fromJson(Map<String, Object> json);
  Map<String, dynamic> toJson();
}
