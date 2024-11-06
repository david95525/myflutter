import 'package:flutter/material.dart';
import 'package:flutter_example/localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            key: scaffoldKey,
            body: Center(
                child: Text(
                    CustomLocalizations.of(context)?.text('HomeTitle') ??
                        'home page'))));
  }
}
