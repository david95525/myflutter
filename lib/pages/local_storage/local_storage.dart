import 'package:flutter/material.dart';
import 'package:flutter_example/pages/local_storage/hive_page.dart';
import 'package:flutter_example/pages/local_storage/shared_preferences_page.dart';

class LocalStorageApp extends StatefulWidget {
  const LocalStorageApp({super.key});
  @override
  State<LocalStorageApp> createState() => _LocalStorageAppState();
}

class _LocalStorageAppState extends State<LocalStorageApp> {
  final navigationitems = const [
    BottomNavigationBarItem(
        icon: Icon(Icons.storage), label: "SharedPreferences"),
    BottomNavigationBarItem(icon: Icon(Icons.storage), label: "Hive"),
  ];
  int _selectedIndex = 0;
  void _onItemTap(int index) {
    setState(() => _selectedIndex = index);
  }

  final _bodyList = [const SharedPreferencesPage(),const HivePage()];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: navigationitems,
                onTap: _onItemTap,
                currentIndex: _selectedIndex),
            body: _bodyList[_selectedIndex]));
  }
}
