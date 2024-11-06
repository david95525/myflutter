import 'dart:async';
import 'dart:convert';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

String clientSecret = const String.fromEnvironment('client_secret');
String clientId = const String.fromEnvironment('client_id');
bool _initialUriIsHandled = false;
Uri devAuthuri =
    Uri.https('accountdev.microlifecloud.com', '/AccountV2/NewLogin', {
  'client_id': clientId,
  'response_type': 'code',
  'redirect_uri': 'flutterwebauth-flutterproject-com://',
  'lang': 'en',
  'region': 'tw'
});

class Oauth2Page extends StatefulWidget {
  const Oauth2Page({super.key});
  @override
  State<Oauth2Page> createState() => _Oauth2PageState();
}

class _Oauth2PageState extends State<Oauth2Page> {
  StreamSubscription? _sub;
  Object? _err;
  //display
  String code = "";
  String token = "";
  String saveToken = "";
  late AppLinks _appLinks;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _loadsaveToken();
    _handleIncomingLinks();
  }

  @override
  void dispose() {
    _sub?.cancel();
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
              actions: [
                TextButton(
                  onPressed: () =>
                      _gettoken('flutterwebauth-flutterproject-com://'),
                  child: const Text('FlutterWebAuth_getToken'),
                ),
                TextButton(
                  onPressed: () =>
                      _gettoken('my-research-flutterproject-com://'),
                  child: const Text('urllink_getToken'),
                )
              ],
            ),
            body: Column(children: [
              Row(
                children: [
                  TextButton(
                      onPressed: () => _testAPI(),
                      child: const Text('TestAPI')),
                ],
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () => _browserLogin(),
                    child: const Text('urlLink'),
                  ),
                  TextButton(
                    onPressed: () => _devLogin(),
                    child: const Text('FlutterWebAuth'),
                  )
                ],
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () => _oauth2clientWithoutHelper(),
                      child: const Text('oauth2_WithoutHelper')),
                  TextButton(
                      onPressed: () => _oauth2clientWithHelper(),
                      child: const Text('oauth2_WithHelper'))
                ],
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () => _clearsaveToken(),
                      child: const Text('Clear Token')),
                ],
              ),
              Text("code:$code"),
              Text("token:$token"),
              Text("save_token:$saveToken"),
              Text("$_err")
            ])));
  }

  void _testAPI() async {
    String url =
        Uri.https('flutterexample.azurewebsites.net', '/api/Account/GetCode', {
      'redirect_uri': 'flutterwebauth-flutterproject-com://',
    }).toString();
    final result = await FlutterWebAuth2.authenticate(
        url: url, callbackUrlScheme: 'flutterwebauth-flutterproject-com');
    debugPrint(result);
    String? resultcode = Uri.parse(result).queryParameters['code'];
    setState(() {
      code = resultcode ?? "";
    });
  }

  void _devLogin() async {
    String url = devAuthuri.toString();
    final result = await FlutterWebAuth2.authenticate(
        url: url, callbackUrlScheme: 'flutterwebauth-flutterproject-com');
    debugPrint(result);
    String? resultcode = Uri.parse(result).queryParameters['code'];
    setState(() {
      code = resultcode ?? "";
    });
  }

  void _browserLogin() async {
    Uri uri =
        Uri.https('accountdev.microlifecloud.com', '/AccountV2/NewLogin', {
      'client_id': clientId,
      'response_type': 'code',
      'redirect_uri': 'my-research-flutterproject-com://',
      'state': 'flutter',
      'lang': 'en',
      'region': 'tw'
    });
    await launchUrl(uri, mode: LaunchMode.platformDefault);
  }

  void _oauth2clientWithoutHelper() async {
    var client = MyOAuth2Client(
        redirectUri: 'flutterwebauth-flutterproject-com://',
        customUriScheme: 'flutterwebauth-flutterproject-com');
    AccessTokenResponse tknResp = await client.getTokenWithAuthCodeFlow(
        clientId: clientId,
        clientSecret: clientSecret,
        scopes: ['email'],
        state: 'flutter');
    if (tknResp.isExpired()) {
      tknResp = await client.refreshToken(tknResp.refreshToken ?? "",
          clientId: clientId, clientSecret: clientSecret, scopes: ['email']);
    }
    final prefs = await SharedPreferences.getInstance();
    debugPrint(tknResp.toString());
    setState(() {
      token = tknResp.accessToken ?? "";
      prefs.setString('access_token', token);
    });
  }

  void _oauth2clientWithHelper() async {
    var client = MyOAuth2Client(
        redirectUri: 'flutterwebauth-flutterproject-com://',
        customUriScheme: 'flutterwebauth-flutterproject-com');
    OAuth2Helper oauth2Helper = OAuth2Helper(client,
        grantType: OAuth2Helper.authorizationCode,
        clientId: clientId,
        clientSecret: clientSecret,
        scopes: ['email'],
        enableState: false);
    // http.Response resp =
    //     oauth2Helper.get('https://www.googleapis.com/drive/v3/files');
    AccessTokenResponse? tknResp = await oauth2Helper.getToken();
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = tknResp?.accessToken ?? "";
      prefs.setString('access_token', token);
    });
  }

  void _gettoken(String redirectUri) async {
    final response = await http.post(
        Uri.https('accountdev.microlifecloud.com', '/OAuth2/Token'),
        body: {
          'client_id': clientId,
          'redirect_uri': redirectUri,
          'grant_type': 'authorization_code',
          'code': code,
          'client_secret': clientSecret
        });
    final accessToken = jsonDecode(response.body)['access_token'] as String;
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (accessToken.isNotEmpty) {
        token = accessToken;
        prefs.setString('access_token', accessToken);
      }
    });
  }

  void _loadsaveToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      saveToken = prefs.getString('access_token') ?? "";
    });
  }

  void _clearsaveToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    setState(() {
      saveToken = "";
    });
  }

  void _handleIncomingLinks() {
    if (!kIsWeb) {
      _appLinks=AppLinks();
      _sub = _appLinks.uriLinkStream.listen((Uri? uri) {
        if (!mounted) return;
        debugPrint('got uri: $uri');
        String? resultcode = Uri.parse(uri.toString()).queryParameters['code'];
        setState(() {
          code = resultcode ?? "";
          _err = null;
        });
      }, onError: (Object err) {
        if (!mounted) return;
        debugPrint('got err: $err');
        setState(() {
          if (err is FormatException) {
            _err = err;
          } else {
            _err = null;
          }
        });
      });
    }
  }
}

class MyOAuth2Client extends OAuth2Client {
  MyOAuth2Client({required this.redirectUri, required this.customUriScheme})
      : super(
            authorizeUrl: devAuthuri.toString(),
            tokenUrl:
                Uri.https('accountdev.microlifecloud.com', '/Oauth2/Token')
                    .toString(),
            redirectUri: redirectUri,
            customUriScheme: customUriScheme);
  @override
  final String redirectUri;
  @override
  final String customUriScheme;
}
