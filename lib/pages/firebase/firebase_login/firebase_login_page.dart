import 'package:firebase_authentication_repository/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/pages/firebase/firebase_login/cubit/login_cubit.dart';
import 'package:flutter_example/pages/firebase/firebase_login/firebase_login_form.dart';

class FirebaseLoginPage extends StatelessWidget {
  const FirebaseLoginPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: FirebaseLoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider(
          create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
          child: const FirebaseLoginForm(),
        ),
      ),
    );
  }
}