// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temrinnot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TemrinNotModel _$TemrinNotModelFromJson(Map<String, dynamic> json) =>
    TemrinNotModel(
      id: json['id'] as int?,
      temrinId: json['temrinId'] as int?,
      ogrenciId: json['ogrenciId'] as int?,
      puanBir: json['puanBir'] as int?,
      puanIki: json['puanIki'] as int?,
      puanUc: json['puanUc'] as int?,
      puanDort: json['puanDort'] as int?,
      puanBes: json['puanBes'] as int?,
      aciklama: json['aciklama'] as String?,
      notTarih: json['notTarih'] as String?,
    );

Map<String, dynamic> _$TemrinNotModelToJson(TemrinNotModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'temrinId': instance.temrinId,
      'ogrenciId': instance.ogrenciId,
      'puanBir': instance.puanBir,
      'puanIki': instance.puanIki,
      'puanUc': instance.puanUc,
      'puanDort': instance.puanDort,
      'puanBes': instance.puanBes,
      'aciklama': instance.aciklama,
      'notTarih': instance.notTarih,
    };
