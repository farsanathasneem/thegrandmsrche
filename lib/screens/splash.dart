import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thegrandemarche/main.dart';
import 'package:thegrandemarche/screens/home.dart';
import 'package:thegrandemarche/screens/login.dart';

class TgmSplash extends StatefulWidget {
  const TgmSplash({super.key});

  @override
  State<TgmSplash> createState() => _TgmSplashState();
}

class _TgmSplashState extends State<TgmSplash> {
  void splashMethod() {
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => TgmLogin()));
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashMethod();
    checkUserLoggin();
  }

  Future<void> checkUserLoggin() async {
    final sharedprefe = await SharedPreferences.getInstance();
    final preference = sharedprefe.getBool(sharedPreferenceKey);
    if (preference == null || preference == false) {
      // login
      TgmLogin();
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (cxt) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          "assets/logo.png",
          height: 400,
          width: 400,
        ),
      ),
    );
  }
}
