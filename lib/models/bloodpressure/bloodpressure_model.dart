import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bloodpressure_model.g.dart';

@JsonSerializable()
class BloodPressureModel extends Equatable {
  final int bpmid;
  final String? updatedate;
  final int? source;
  final int? sys;
  final int? dia;
  final int? pul;
  final int? afib;
  final int? pad;
  final int? mode;
  final String? note;
  const BloodPressureModel(
      {required this.bpmid,
      this.updatedate,
      this.source,
      this.sys,
      this.dia,
      this.pul,
      this.afib,
      this.pad,
      this.mode,
      this.note});
  factory BloodPressureModel.fromJson(Map<String, dynamic> json) =>
      _$BloodPressureModelFromJson(json);
  Map<String, dynamic> toJson() => _$BloodPressureModelToJson(this);
  @override
  String toString() =>
      "bpmId:$bpmid source:$source sys:$sys dia:$dia pul:$pul afib:$afib pad:$pad mode:$mode updateDate:$updatedate note:$note";

  @override
  List<Object?> get props =>
      [bpmid, source, sys, dia, pul, afib, pad, mode, updatedate, note];
}
