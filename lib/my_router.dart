import 'package:flutter/material.dart';
import 'package:flutter_example/app_index.dart';
import 'package:flutter_example/app_member.dart';
import 'package:flutter_example/pages/Oauth2/oauth2_page.dart';
import 'package:flutter_example/pages/firebase/firebase_login/firebase_login_page.dart';
import 'package:flutter_example/pages/local_storage/local_storage.dart';
import 'package:flutter_example/pages/widget_example/indx.dart';
import 'package:flutter_example/provider/member_provider.dart';
import 'package:provider/provider.dart';

class RouteName {
  static const String index = '/';
  static const String member = '/member';
  static const String firebase = '/firebase';
  static const String localstorage = '/localstorage';
  static const String widgets = '/widgets';
  static const String oauth2 = '/oauth2';
}

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.index:
        return NoAnimRouteBuilder(const IndexApp(), RouteName.index);
      case RouteName.member:
        return NoAnimRouteBuilder(
            MultiProvider(providers: [
              ChangeNotifierProvider<MemberProvider>(
                create: (context) => MemberProvider(),
              ),
            ], builder: (context, child) => const MemberApp()),
            RouteName.member);
      case RouteName.firebase:
        return NoAnimRouteBuilder(
            const FirebaseLoginPage(), RouteName.firebase);
      case RouteName.widgets:
        return NoAnimRouteBuilder(const WidgetsPage(), RouteName.widgets);
      case RouteName.localstorage:
        return MaterialPageRoute(
            builder: (context) => const LocalStorageApp(),
            settings: const RouteSettings(name: RouteName.localstorage));
      case RouteName.oauth2:
        return NoAnimRouteBuilder(const Oauth2Page(), RouteName.oauth2);
      default:
        return NoAnimRouteBuilder(const IndexApp(), RouteName.index);
    }
  }
}

class NoAnimRouteBuilder extends PageRouteBuilder {
  final Widget page;
  final String routename;

  NoAnimRouteBuilder(this.page, this.routename)
      : super(
            opaque: false,
            settings: RouteSettings(name: routename),
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionDuration: const Duration(milliseconds: 1),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) => child);
}
