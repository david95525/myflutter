import 'package:flutter/material.dart';
import 'package:flutter_example/localizations.dart';
import 'package:flutter_example/pages/widget_example/events_page.dart';
import 'package:flutter_example/pages/widget_example/layout_page.dart';
import 'package:flutter_example/pages/widget_example/progressIndicator_page.dart';
import 'package:flutter_example/pages/widget_example/input_page.dart';
import 'package:flutter_example/pages/widget_example/listview_page.dart';

class WidgetsPage extends StatefulWidget {
  const WidgetsPage({super.key});
  @override
  State<WidgetsPage> createState() => _WidgetsPageState();
}

class _WidgetsPageState extends State<WidgetsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  CustomLocalizations localizations = CustomLocalizations();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
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
            title: const TabBar(
              tabs: [
                Tab(text: 'ProgressIndicator'),
                Tab(text: 'Input'),
                Tab(text: 'Layout'),
                Tab(text: 'ListView'),
                Tab(text: 'Events')
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              ProgressPage(),
              InputPage(),
              LayoutPage(),
              ListViewPage(),
              EventsPage()
            ],
          ),
        ));
  }

  Future<void> changeLanguage() async {
    await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(CustomLocalizations.of(context)?.text("language") ??
                "language"),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  localizations.setLocale(context, const Locale("en", "US"));
                  Navigator.pop(context, 1);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(CustomLocalizations.of(context)?.text("en_us") ??
                      "English"),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  localizations.setLocale(context, const Locale("zh", "TW"));
                  Navigator.pop(context, 2);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(CustomLocalizations.of(context)?.text("zh_tw") ??
                      "Chinese(Taiwan)"),
                ),
              ),
            ],
          );
        });
  }
}
