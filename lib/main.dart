// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_king/src/screens/welcome.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white, // You can use this as well
        statusBarIconBrightness:
            Brightness.dark, // OR Vice Versa for ThemeMode.dark
        statusBarBrightness:
            Brightness.light, // OR Vice Versa for ThemeMode.dark
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Welcome();
  }
}
