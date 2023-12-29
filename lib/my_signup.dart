import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'my_login.dart';
import 'my_utils.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isloding = false;
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void Signin() {
    setState(() => isloding = false);
    _firebaseAuth
        .createUserWithEmailAndPassword(
        email: emailcontroller.text.toString(),
        password: passcontroller.text.toString())
        .then((value) {
      setState(() {
        isloding = false;
      });
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign_In"),
      ),
      body: Column(
        children: [
          Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    hintText: "Email".padLeft(40),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) {
                    if (email == null || email.trim().isEmpty) {
                      return "Enter Valide Email";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passcontroller,
                  decoration: InputDecoration(
                    hintText: "Password".padLeft(40),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (password) {
                    if (password == null || password.isEmpty) {
                      return "Enter Valide Password";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                TextButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        Signin();
                      }
                    },
                    child: Text("Sign in")),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Text("Alrady have an Account"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Text("Log In"))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
