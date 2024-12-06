import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

Uri uri = Uri.https('ocrresearch.azurewebsites.net', '/AiVision/Index',
    {'redirect_uri': 'flutterwebauth-flutterproject-com://'});

class ScanBPPage extends StatefulWidget {
  const ScanBPPage({super.key});
  @override
  State<ScanBPPage> createState() => _ScanBPPageState();
}

class _ScanBPPageState extends State<ScanBPPage> {
  String? sys = "0";
  String? dia = "0";
  String? pul = "0";
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
              Text("sys:$sys"),
              Text("dia:$dia"),
              Text("pul:$pul"),
            ])));
  }

  void _scanbp() async {
    String url = uri.toString();
    final result = await FlutterWebAuth2.authenticate(
        url: url, callbackUrlScheme: 'flutterwebauth-flutterproject-com');
    debugPrint(result);
    String? sysResult = Uri.parse(result).queryParameters['sys'];
    String? diaResult = Uri.parse(result).queryParameters['dia'];
    String? pulResult = Uri.parse(result).queryParameters['pul'];
    debugPrint(sysResult);
    setState(() {
      sys = sysResult ?? "0";
      dia = diaResult ?? "0";
      pul = pulResult ?? "0";
    });
  }
}
