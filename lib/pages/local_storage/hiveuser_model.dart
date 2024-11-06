import 'package:hive/hive.dart';

part 'hiveuser_model.g.dart';

@HiveType(typeId: 1)
class HiveUser {
  const HiveUser({required this.email, required this.password});

  @HiveField(0)
  final String email;

  @HiveField(1)
  final String password;

  @override
  String toString() {
    return '$email: $password';
  }
}
