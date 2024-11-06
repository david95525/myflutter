// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bloodpressure_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloodPressureModel _$BloodPressureModelFromJson(Map<String, dynamic> json) =>
    BloodPressureModel(
      bpmid: json['bpmid'] as int,
      updatedate: json['updatedate'] as String?,
      source: json['source'] as int?,
      sys: json['sys'] as int?,
      dia: json['dia'] as int?,
      pul: json['pul'] as int?,
      afib: json['afib'] as int?,
      pad: json['pad'] as int?,
      mode: json['mode'] as int?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$BloodPressureModelToJson(BloodPressureModel instance) =>
    <String, dynamic>{
      'bpmid': instance.bpmid,
      'updatedate': instance.updatedate,
      'source': instance.source,
      'sys': instance.sys,
      'dia': instance.dia,
      'pul': instance.pul,
      'afib': instance.afib,
      'pad': instance.pad,
      'mode': instance.mode,
      'note': instance.note,
    };
