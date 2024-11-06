// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bodytemperature_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BodyTemperatureModel _$BodyTemperatureModelFromJson(
        Map<String, dynamic> json) =>
    BodyTemperatureModel(
      btId: json['btId'] as int,
      bodytemp: (json['bodytemp'] as num?)?.toDouble(),
      updateDate: json['updateDate'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$BodyTemperatureModelToJson(
        BodyTemperatureModel instance) =>
    <String, dynamic>{
      'btId': instance.btId,
      'updateDate': instance.updateDate,
      'bodytemp': instance.bodytemp,
      'note': instance.note,
    };
