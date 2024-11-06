import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'bodytemperature_model.g.dart';
@JsonSerializable()
class BodyTemperatureModel extends Equatable {
  final int btId;
  final String? updateDate;
  final double? bodytemp;
  final String? note;
  const BodyTemperatureModel(
      {required this.btId, this.bodytemp, this.updateDate, this.note});
  factory BodyTemperatureModel.fromJson(Map<String, dynamic> json) =>
      _$BodyTemperatureModelFromJson(json);
  Map<String, dynamic> toJson() => _$BodyTemperatureModelToJson(this);
  @override
  String toString() =>
      "bpmbtIdId:$btId bodytemp:$bodytemp  updateDate:$updateDate note:$note";

  @override
  List<Object?> get props => [btId, bodytemp, updateDate, note];
}
