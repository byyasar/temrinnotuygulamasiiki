import 'package:temrinnotuygulamasiiki/core/init/database/database_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'ogrenci_model.g.dart';

@JsonSerializable()
class OgrenciModel extends DatabaseModel<OgrenciModel> {
  int? id;
  String? ogrenciAdSoyad;
  int? ogrenciNu;
  int? sinifId;
  String? ogrenciResim;

  OgrenciModel({this.id, this.ogrenciAdSoyad, this.ogrenciNu, this.sinifId, this.ogrenciResim});

  @override
  OgrenciModel fromJson(Map<String, Object> json) {
    return _$OgrenciModelFromJson(json);
  }

  @override
  Map<String, Object?> toJson() {
    return _$OgrenciModelToJson(this);
  }
}
