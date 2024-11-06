part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

final class AppState extends Equatable {
  const AppState({User user = User.empty})
      : this._(
          status: user == User.empty
              ? AppStatus.unauthenticated
              : AppStatus.authenticated,
          user: user,
        );

  const AppState._({required this.status, this.user = User.empty});

  const AppState.authenticated(User user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);
  final AppStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}
