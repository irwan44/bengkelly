import 'package:bengkelly_apps/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'credential/login page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bengkelly',
      theme:  ThemeData(
        appBarTheme: const AppBarTheme(
        color: Colors.white,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
    ),),
      home: const SplashScreen(),
    );
  }
}
