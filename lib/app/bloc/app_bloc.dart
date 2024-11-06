import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_example/repository/authentication_repository.dart';
import 'package:flutter_example/repository/user_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AppState.unauthenticated()) {
    on<_AppStatusChanged>(_onAppStatusChanged);
    on<AppLogoutRequested>(_onAppLogoutRequested);
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  Future<void> _onAppStatusChanged(
    _AppStatusChanged event,
    Emitter<AppState> emit,
  ) async {
    switch (event.status) {
      case AppStatus.unauthenticated:
        return emit(const AppState.unauthenticated());
      case AppStatus.authenticated:
        final user = await _tryGetUser();
        return emit(
          user != null
              ? AppState.authenticated(user)
              : const AppState.unauthenticated(),
        );
    }
  }

  void _onAppLogoutRequested(
    AppLogoutRequested event,
    Emitter<AppState> emit,
  ) {
    _authenticationRepository.logOut();
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }
}
