import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'member_model.g.dart';

@JsonSerializable()
class MemberModel extends Equatable {
  final int? code;
  final String? email;
  final String? name;
  final String? sex;
  final double? age;
  final double? height;
  final double? weight;
  const MemberModel(
      {this.code,
      this.email,
      this.name,
      this.sex,
      this.age,
      this.height,
      this.weight});
  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);
  Map<String, dynamic> toJson() => _$MemberModelToJson(this);
  @override
  String toString() =>
      "code:$code email:$email name:$name sex:$sex age:$age height: $height weight:$weight";

  @override
  List<Object?> get props => [code, email, name, sex, age, height, weight];
}
