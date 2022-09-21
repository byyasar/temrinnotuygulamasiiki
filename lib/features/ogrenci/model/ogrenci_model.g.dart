// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ogrenci_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OgrenciModel _$OgrenciModelFromJson(Map<String, dynamic> json) => OgrenciModel(
      id: json['id'] as int?,
      ogrenciAdSoyad: json['ogrenciAdSoyad'] as String?,
      ogrenciNu: json['ogrenciNu'] as int?,
      sinifId: json['sinifId'] as int?,
      ogrenciResim: json['ogrenciResim'] as String?,
    );

Map<String, dynamic> _$OgrenciModelToJson(OgrenciModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ogrenciAdSoyad': instance.ogrenciAdSoyad,
      'ogrenciNu': instance.ogrenciNu,
      'sinifId': instance.sinifId,
      'ogrenciResim': instance.ogrenciResim,
    };
