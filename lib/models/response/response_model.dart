import 'package:equatable/equatable.dart';
import 'package:flutter_example/models/bloodpressure/bloodpressure_model.dart';
import 'package:flutter_example/models/user/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart';

@JsonSerializable()
class ResponseModel extends Equatable {
  final int code;
  final String info;
  final UserModel? data;
  final List<BloodPressureModel>? bpmData;
  const ResponseModel(
      {required this.code, required this.info, this.data, this.bpmData});
  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
  @override
  String toString() {
    String? name = data?.name == "" ? "no data" : data?.name;
    return "code:$code info:$info name:$name";
  }

  @override
  List<Object?> get props => [code, info, data];
}
