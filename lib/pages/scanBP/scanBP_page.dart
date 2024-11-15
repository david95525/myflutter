import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

Uri uri = Uri.https('flutterexample.azurewebsites.net', '/AzureAIVision/Index',
    {'redirect_uri': 'flutterwebauth-flutterproject-com://'});

class ScanBPPage extends StatefulWidget {
  const ScanBPPage({super.key});
  @override
  State<ScanBPPage> createState() => _ScanBPPageState();
}

class _ScanBPPageState extends State<ScanBPPage> {
  String? sys = "";

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              actions: [],
            ),
            body: Column(children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () => _scanbp(),
                    child: const Text('test'),
                  )
                ],
              ),
              Text("$sys")
            ])));
  }

  void _scanbp() async {
    String url = uri.toString();
    final result = await FlutterWebAuth2.authenticate(
        url: url, callbackUrlScheme: 'flutterwebauth-flutterproject-com');
    debugPrint(result);
    String? sysResult = Uri.parse(result).queryParameters['sys'];
    debugPrint(sysResult);
    setState(() {
      sys = sysResult ?? "";
    });
  }
}
