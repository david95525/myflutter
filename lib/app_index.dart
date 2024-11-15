import 'package:flutter/material.dart';
import 'package:flutter_example/localizations.dart';
import 'package:flutter_example/my_router.dart';
import 'package:flutter_example/pages/bluetooth/bluetooth_page.dart';
import 'package:flutter_example/pages/local_storage/local_storage.dart';
import 'package:flutter_example/pages/scanBP/scanBP_page.dart';
import 'package:flutter_example/pages/sdktest/sdktest_page.dart';

import 'pages/home/home_page.dart';

class IndexApp extends StatefulWidget {
  const IndexApp({super.key});
  @override
  State<IndexApp> createState() => _IndexAppState();
}

class _IndexAppState extends State<IndexApp> {
  int _selectedIndex = 0;
  CustomLocalizations localizations = CustomLocalizations();
  final _bodyList = const [
    HomePage(),
    LocalStorageApp(),
    BluetoothPage(),
    SDKTestPage(),
    ScanBPPage()
  ];
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> navigationitems = [
      BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: CustomLocalizations.of(context)?.text("Home")),
      BottomNavigationBarItem(
          icon: const Icon(Icons.storage),
          label: CustomLocalizations.of(context)?.text("Localstorage")),
      const BottomNavigationBarItem(
          icon: Icon(Icons.bluetooth), label: "Bluetooth"),
      const BottomNavigationBarItem(
          icon: Icon(Icons.storage), label: "sdktest"),
      const BottomNavigationBarItem(
          icon: Icon(Icons.storage), label: "scanbp"),
    ];

    return DefaultTabController(
        length: 4,
        child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              actions: [
                IconButton(
                    tooltip: "Widgets",
                    onPressed: () =>
                        Navigator.pushNamed(context, RouteName.widgets),
                    icon: const Icon(Icons.now_widgets_outlined),
                    selectedIcon: const Icon(Icons.now_widgets)),
                TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, RouteName.firebase),
                    child: const Text('Firebase')),
                TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, RouteName.oauth2),
                    child: const Text('Oauth2')),
              ],
            ),
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                      decoration: const BoxDecoration(color: Colors.deepOrange),
                      child: Text(
                        CustomLocalizations.of(context)?.text("language") ?? "",
                        style: const TextStyle(color: Colors.white),
                      )),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: Text(CustomLocalizations.of(context)?.text("EnUS") ??
                        "English"),
                    onTap: () {
                      Navigator.pop(context);
                      localizations.setLocale(
                          context, const Locale("en", "US"));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: Text(CustomLocalizations.of(context)?.text("ZhTW") ??
                        "Chinese(Taiwan)"),
                    onTap: () {
                      Navigator.pop(context);
                      localizations.setLocale(context, const Locale("zh"));
                    },
                  )
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: navigationitems,
                onTap: _onItemTap,
                currentIndex: _selectedIndex),
            body: _bodyList[_selectedIndex]));
  }

  void _onItemTap(int index) {
    if (index == 1) {
      Navigator.pushNamed(context, RouteName.localstorage);
    } else {
      setState(() => _selectedIndex = index);
    }
  }
}
