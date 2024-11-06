import 'package:flutter/material.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import '../app_index.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen.navigate(
      name: 'assets/splash.flr', // flr動畫檔路徑
      next: (_) => const IndexApp(),
      // const HomePage(title: 'Flutter Home Page'),
      until: () => Future.delayed(const Duration(seconds: 3)), //等待3秒
      startAnimation: 'rotate_scale_color', // 動畫名稱
    );
  }
}
