import 'package:cripto_moeda/repositories/favorite_repository.dart';
import 'package:flutter/material.dart';
import 'package:cripto_moeda/pages/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoriteRepository(),
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.purple),
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
      ),
    ),
  );
}
