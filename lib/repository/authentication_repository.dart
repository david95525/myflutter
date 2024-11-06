import 'dart:async';

enum AppStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AppStatus>();

  Stream<AppStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AppStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AppStatus.authenticated),
    );
  }

  void logOut() {
    _controller.add(AppStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}