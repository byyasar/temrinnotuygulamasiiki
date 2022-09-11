// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temrin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TemrinModel _$TemrinModelFromJson(Map<String, dynamic> json) => TemrinModel(
      id: json['id'] as int?,
      temrinKonusu: json['temrinKonusu'] as String?,
      dersId: json['dersId'] as int?,
    );

Map<String, dynamic> _$TemrinModelToJson(TemrinModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'temrinKonusu': instance.temrinKonusu,
      'dersId': instance.dersId,
    };
