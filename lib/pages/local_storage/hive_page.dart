import 'package:flutter/material.dart';
import 'package:flutter_example/pages/local_storage/hiveuser_model.dart';
import 'package:hive_flutter/adapters.dart';

class HivePage extends StatefulWidget {
  const HivePage({super.key});

  @override
  State<HivePage> createState() => _HivePageState();
}

class _HivePageState extends State<HivePage> {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _savedemail = "";
  String _savedpassword = "";
  @override
  void initState() {
    super.initState();
    Hive.initFlutter();
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(HiveUserAdapter());
    }
    _loadHive();
  }

  @override
  void dispose() {
    Hive.close();
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
                controller: _emailcontroller..text = "test@hive.com",
              ),
              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: "password",
                  hintText: "password",
                  prefixIcon: Icon(Icons.lock),
                ),
                controller: _passwordcontroller..text = "hive1234",
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
                onPressed: () => _saveHive(),
                child: const Text('save'),
              ),
              ElevatedButton(
                key: const Key('loadButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () => _loadHive(),
                child: const Text('load'),
              )
            ],
          ),
        ));
  }

  void _saveHive() async {
    var box = await Hive.openBox<HiveUser>('userbox');
    var user = HiveUser(
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
    );
    await box.put('hiveuser', user);
  }

  void _loadHive() async {
    var box = await Hive.openBox<HiveUser>('userbox');
    HiveUser? user = box.get('hiveuser');
    setState(() {
      if (user != null) {
        _savedemail = user.email;
        _savedpassword = user.password;
      }
    });
  }
}
