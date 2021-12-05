import 'package:cripto_moeda/pages/home.dart';
import 'package:cripto_moeda/pages/navigation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class SplashPage extends StatefulWidget {
  const SplashPage({ Key? key }) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}


class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NavigationPage(),
          ));
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          constraints: BoxConstraints.tightForFinite(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height),
          color: Colors.deepPurple[400],
        ),
        Center(
            child: Lottie.asset("lottie/crypto-coins.json"),
          )
      ]
    );
    
  }
}