import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_authentication_repository/index.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AppState.authenticated(authenticationRepository.currentUser)
              : const AppState.unauthenticated(),
        ) {
    on<AppLogoutRequested>(_onLogoutRequested);
    on<AppUserSubscriptionRequested>(_onUserSubscriptionRequested);
  }

  final AuthenticationRepository _authenticationRepository;

  Future<void> _onUserSubscriptionRequested(
    AppUserSubscriptionRequested event,
    Emitter<AppState> emit,
  ) {
    return emit.onEach(
      _authenticationRepository.user,
      onData: (user) => emit(user.isNotEmpty
          ? AppState.authenticated(user)
          : const AppState.unauthenticated()),
      onError: addError,
    );
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
  }
}
