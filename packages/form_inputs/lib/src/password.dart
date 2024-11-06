import 'package:formz/formz.dart';

/// Validation errors for the [Password] [FormzInput].
enum PasswordValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template password}
/// Form input for an password input.
/// {@endtemplate}
class Password extends FormzInput<String, PasswordValidationError> {
  /// {@macro password}
  const Password.pure() : super.pure('test01');

  /// {@macro password}
  const Password.dirty([super.value = '']) : super.dirty();

  static final _passwordRegExp = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)[\S]{6,15}$');

  @override
  PasswordValidationError? validator(String? value) {
    return _passwordRegExp.hasMatch(value ?? '')
        ? null
        : PasswordValidationError.invalid;
  }
}
