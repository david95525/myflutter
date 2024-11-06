import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(this.email, this.password);

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];

  static const empty = User('-', '-');
  @override
  String toString() {
    return '''User{
    email: $email,
    password: $password
    }''';
  }
}

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = const User("test@example.com", "test1234"),
    );
  }
}
