import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'my_login.dart';
import 'my_utils.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      )).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                  });
                });
              },
              icon: Icon(Icons.logout)),
        ],
      ),
    );
  }
}
