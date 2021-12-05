import 'package:flutter/material.dart';
import 'package:cripto_moeda/pages/splash.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.purple
    ),
    debugShowCheckedModeBanner: false,
    home: const SplashPage(),
  ));
}
