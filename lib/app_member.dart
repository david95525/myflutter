import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_example/app/bloc/app_bloc.dart';
import 'package:flutter_example/localizations.dart';
import 'package:flutter_example/models/login/login_model.dart';
import 'package:flutter_example/models/member/member_model.dart';
import 'package:flutter_example/my_router.dart';
import 'package:flutter_example/pages/bodytemperature/bodytemperature_page.dart';
import 'package:flutter_example/pages/home/home_page.dart';
import 'package:flutter_example/provider/member_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'pages/bloodpressure/bloodpressure_page.dart';
import 'pages/dashboard/dashboard_page.dart';

const String clientId = String.fromEnvironment('client_id');

class MemberApp extends StatefulWidget {
  const MemberApp({super.key});
  @override
  State<MemberApp> createState() => _MemberAppState();
}

class _MemberAppState extends State<MemberApp> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _emailController =
      TextEditingController(text: "test@test.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "test01");
  late MemberModel apidata;
  CustomLocalizations localizations = CustomLocalizations();

  @override
  void initState() {
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  int _selectedIndex = 0;
  void _onItemTap(int index) {
    setState(() => _selectedIndex = index);
  }

  final _bodyList = [
    const DashboardPage(),
    const BloodPressurePage(),
    const BodyTemperaturePage(),
    const HomePage()
  ];
  @override
  Widget build(BuildContext context) {
    Color? backcolor = Colors.grey[100];

    MemberProvider userProvider = Provider.of(context);
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              actions: [
                IconButton(
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      context.read<AppBloc>().add(AppLogoutRequested());
                      Navigator.pushNamed(context, RouteName.index);
                    }),
                TextButton(
                  child: const Text("login"),
                  onPressed: () async {
                    await _displayTextInputDialog(context, userProvider);
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await changeLanguage();
                  },
                ),
              ],
            ),
            body: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  NavigationRail(
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: _onItemTap,
                    labelType: NavigationRailLabelType.none,
                    minWidth: MediaQuery.of(context).size.width / 7,
                    backgroundColor: const Color.fromARGB(255, 29, 65, 133),
                    leading: Container(
                      height: MediaQuery.of(context).size.height / 6,
                      alignment: Alignment.center,
                      child: Text(
                        "Company",
                        style: TextStyle(fontSize: 40, color: backcolor),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ),
                    destinations: <NavigationRailDestination>[
                      NavigationRailDestination(
                        icon: Container(
                            height: MediaQuery.of(context).size.height / 7,
                            alignment: Alignment.center,
                            child: Icon(Icons.calculate,
                                size: MediaQuery.of(context).size.height / 10,
                                color: backcolor)),
                        selectedIcon: Container(
                            height: MediaQuery.of(context).size.height / 7,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(100),
                                    bottomLeft: Radius.circular(100)),
                                color: backcolor),
                            child: Icon(Icons.calculate,
                                size: MediaQuery.of(context).size.height / 10,
                                color: const Color.fromARGB(255, 18, 20, 22))),
                        label: const Text('Member'),
                      ),
                      NavigationRailDestination(
                        icon: Container(
                            height: MediaQuery.of(context).size.height / 7,
                            alignment: Alignment.center,
                            child: Icon(Icons.bloodtype_sharp,
                                size: MediaQuery.of(context).size.height / 10,
                                color: backcolor)),
                        selectedIcon: Container(
                            height: MediaQuery.of(context).size.height / 7,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(100),
                                    bottomLeft: Radius.circular(100)),
                                color: backcolor),
                            child: Icon(Icons.bloodtype_sharp,
                                size: MediaQuery.of(context).size.height / 10,
                                color: const Color.fromARGB(255, 29, 65, 133))),
                        label: const Text("BloodPressure"),
                      ),
                      NavigationRailDestination(
                        icon: Container(
                            height: MediaQuery.of(context).size.height / 7,
                            alignment: Alignment.center,
                            child: Icon(Icons.thermostat,
                                size: MediaQuery.of(context).size.height / 10,
                                color: backcolor)),
                        selectedIcon: Container(
                            height: MediaQuery.of(context).size.height / 7,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(100),
                                    bottomLeft: Radius.circular(100)),
                                color: backcolor),
                            child: Icon(Icons.thermostat,
                                size: MediaQuery.of(context).size.height / 10,
                                color: const Color.fromARGB(255, 29, 65, 133))),
                        label: const Text("BodyTemperature"),
                      ),
                      NavigationRailDestination(
                        icon: Container(
                            height: MediaQuery.of(context).size.height / 7,
                            alignment: Alignment.center,
                            child: Icon(Icons.home,
                                size: MediaQuery.of(context).size.height / 10,
                                color: backcolor)),
                        selectedIcon: Container(
                            height: MediaQuery.of(context).size.height / 7,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(100),
                                    bottomLeft: Radius.circular(100)),
                                color: backcolor),
                            child: Icon(Icons.home,
                                size: MediaQuery.of(context).size.height / 10,
                                color: const Color.fromARGB(255, 29, 65, 133))),
                        label: const Text("Home"),
                      ),
                    ],
                  ),
                  Expanded(child: _bodyList[_selectedIndex]),
                ])));
  }

  Future<void> changeLanguage() async {
    await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(CustomLocalizations.of(context)?.text("Language") ??
                "language"),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  localizations.setLocale(context, const Locale("en", "US"));
                  Navigator.pop(context, 1);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(CustomLocalizations.of(context)?.text("EnUS") ??
                      "English"),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  localizations.setLocale(context, const Locale("zh"));
                  Navigator.pop(context, 2);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(CustomLocalizations.of(context)?.text("ZhTW") ??
                      "Chinese(Taiwan)"),
                ),
              ),
            ],
          );
        });
  }

  Future<void> _displayTextInputDialog(
      BuildContext context, MemberProvider userProvider) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Login'),
            content: Column(children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    hintText: 'test@test.com/test02@test.com',
                    icon: Icon(Icons.email),
                    labelText: 'Email'),
              ),
              TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Password',
                      hintText: 'test01/test02'))
            ]),
            actions: <Widget>[
              MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('Login'),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircularProgressIndicator(),
                        Text("  Signing-In...")
                      ],
                    ),
                    backgroundColor: Colors.grey,
                  ));
                  _login(context, userProvider);
                },
              ),
            ],
          );
        });
  }

  void _onEmailChanged() {
    debugPrint("change");
  }

  void _onPasswordChanged() {
    debugPrint("change");
  }

  void _login(BuildContext context, MemberProvider userProvider) async {
    var client = http.Client();
    String email = _emailController.text;
    String password = _passwordController.text;
    try {
      final data = LoginModel(email: email, password: password);
      var response = await client.post(
          Uri.https(
              'flutterexample.azurewebsites.net', '/api/Account/MemberLogin'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data.toJson()));
      if (response.statusCode == 200) {
        apidata = MemberModel.fromJson(jsonDecode(response.body));
        if (apidata.code == 10000) {
          if (context.mounted) userProvider.set(apidata);
        } else {}
      }
    } finally {
      client.close();
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          Navigator.pop(context);
        });
      });
    }
  }
}
