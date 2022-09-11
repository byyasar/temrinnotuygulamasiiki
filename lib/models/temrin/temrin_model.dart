import 'package:temrinnotuygulamasiiki/core/init/database/database_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'temrin_model.g.dart';

@JsonSerializable()
class TemrinModel extends DatabaseModel<TemrinModel> {
  int? id;
  String? temrinKonusu;
  int? dersId;
  

  TemrinModel({this.id,this.temrinKonusu,this.dersId});

  @override
  TemrinModel fromJson(Map<String, Object> json) {
    return _$TemrinModelFromJson(json);
  }

  @override
  Map<String, Object?> toJson() {
    return _$TemrinModelToJson(this);
  }
}
