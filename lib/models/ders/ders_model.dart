import 'package:json_annotation/json_annotation.dart';
import 'package:temrinnotuygulamasiiki/core/init/database/database_model.dart';

part 'ders_model.g.dart';

@JsonSerializable()
class DersModel extends DatabaseModel<DersModel> {
  int? id;
  String? dersAd;
  int? sinifId;

  DersModel({this.id, this.dersAd, this.sinifId});

  @override
  DersModel fromJson(Map<String, Object?> json) {
    return _$DersModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$DersModelToJson(this);
  }
}
