import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesPage extends StatefulWidget {
  const SharedPreferencesPage({super.key});

  @override
  State<SharedPreferencesPage> createState() => _SharedPreferencesPageState();
}

class _SharedPreferencesPageState extends State<SharedPreferencesPage> {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _savedemail = "";
  String _savedpassword = "";
  @override
  void initState() {
    super.initState();
    _loadsharedPreference();
  }

  @override
  void dispose() {
    // _clean();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: "email",
                  hintText: "email",
                  prefixIcon: Icon(Icons.email),
                ),
                controller: _emailcontroller
                  ..text = "test@sharedpreferences.com",
              ),
              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: "password",
                  hintText: "password",
                  prefixIcon: Icon(Icons.lock),
                ),
                controller: _passwordcontroller..text = "sharedpreferences1234",
              ),
              Text("email:$_savedemail",
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.left),
              Text("password:$_savedpassword ",
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.left),
              ElevatedButton(
                key: const Key('saveButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () => _saveSharedPreference(),
                child: const Text('save'),
              ),
              ElevatedButton(
                key: const Key('loadButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () => _loadsharedPreference(),
                child: const Text('load'),
              ),
                  ElevatedButton(
                key: const Key('clearButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () => _clean(),
                child: const Text('clear'),
              )
            ],
          ),
        ));
  }

  void _saveSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', _emailcontroller.text);
    prefs.setString('password', _passwordcontroller.text);
  }

  void _loadsharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedemail = prefs.getString('email') ?? "";
      _savedpassword = prefs.getString('password') ?? "";
    });
  }

  void _clean() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
  }
}
