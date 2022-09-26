import 'package:temrinnotuygulamasiiki/core/init/database/database_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'temrinnot_model.g.dart';

@JsonSerializable()
class TemrinNotModel extends DatabaseModel<TemrinNotModel> {
  int? id;
  int? temrinId;
  int? ogrenciId;
  int? puanBir;
  int? puanIki;
  int? puanUc;
  int? puanDort;
  int? puanBes;
  String? aciklama;
  String? notTarih;

  TemrinNotModel(
      {this.id,
      this.temrinId,
      this.ogrenciId,
      this.puanBir,
      this.puanIki,
      this.puanUc,
      this.puanDort,
      this.puanBes,
      this.aciklama,
      this.notTarih});

  @override
  TemrinNotModel fromJson(Map<String, Object?> json) {
    return _$TemrinNotModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$TemrinNotModelToJson(this);
  }
}
