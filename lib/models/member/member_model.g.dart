// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberModel _$MemberModelFromJson(Map<String, dynamic> json) => MemberModel(
      code: json['code'] as int?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      sex: json['sex'] as String?,
      age: (json['age'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MemberModelToJson(MemberModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'email': instance.email,
      'name': instance.name,
      'sex': instance.sex,
      'age': instance.age,
      'height': instance.height,
      'weight': instance.weight,
    };
