import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final int? id;
  final String? email;
  final String? name;
  const UserModel({this.id, this.email, this.name});
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  @override
  String toString() => "id:$id email:$email name:$name";

  @override
  List<Object?> get props => [id, email, name];
}
