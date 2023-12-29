import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'my_login.dart';
import 'my_second.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

SplashServices splashServices = SplashServices();

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServices.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Fire"),
      ),
    );
  }
}

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(
        const Duration(seconds: 3),
            () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SecondPage(),
          ),
        ),
      );
    } else {
      Timer(
        const Duration(seconds: 3),
            () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        ),
      );
    }
  }
}
