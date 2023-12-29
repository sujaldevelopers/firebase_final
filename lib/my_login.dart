import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'my_second.dart';
import 'my_signup.dart';
import 'my_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isloding = false;
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  void isLogin() {
    setState(() => isloding = true);
    _auth
        .signInWithEmailAndPassword(
        email: emailcontroller.text.toString(),
        password: passcontroller.text.toString())
        .then((value) {
      Utils().toastMessage(value.user!.email.toString());
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SecondPage(),
          ));
      setState(() {
        isloding = false;
      });
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
        isloding = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login Page"),
        ),
        body: WillPopScope(
          onWillPop: () async {
            await SystemNavigator.pop();
            return true;
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
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
                              isLogin();
                            }
                          },
                          child: Text("Login")),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Text("Creat an Account"),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignInPage(),
                                  ),
                                );
                              },
                              child: Text("Sign-In"))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
