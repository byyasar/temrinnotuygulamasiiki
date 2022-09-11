import 'package:temrinnotuygulamasiiki/core/init/database/database_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'sinif_model.g.dart';

@JsonSerializable()
class SinifModel extends DatabaseModel<SinifModel> {
  int? id;
  String? sinifAd;

  SinifModel({this.id, this.sinifAd});

  @override
  SinifModel fromJson(Map<String, Object> json) {
    return _$SinifModelFromJson(json);
  }

  @override
  Map<String, Object?> toJson() {
    return _$SinifModelToJson(this);
  }
}
