import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_authentication_repository/index.dart';
import 'package:flutter_example/models/login/login_model.dart';
import 'package:flutter_example/models/response/response_model.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart' as http;

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> logInWithPassword() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    var client = http.Client();
    try {
      final data =
          LoginModel(email: state.email.value, password: state.password.value);
      var response = await client.post(
          Uri.https('flutterexample.azurewebsites.net', '/api/Account/Login'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data.toJson()));
      if (response.statusCode == 200) {
        ResponseModel apidata =
            ResponseModel.fromJson(jsonDecode(response.body));
        if (apidata.code == 10000) {
          emit(state.copyWith(status: FormzSubmissionStatus.success));
        }
      }
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    } finally {
      client.close();
    }
  }

  Future<void> logInWithFirebaseCredentials() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository.logInWithGoogle();
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on LogInWithGoogleFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
