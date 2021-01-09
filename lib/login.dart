import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebolt/sign_up.dart';
import 'package:firebolt/style/color.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Bolt",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black),
                  ),
                  padding: EdgeInsets.all(6),
                  child: ListTile(
                    title: TextFormField(
                      cursorColor: boltPrimaryColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Enter your Email",
                          labelText: "Email",
                          labelStyle: TextStyle(color: boltPrimaryColor)),
                      controller: emailController,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(6),
                  child: ListTile(
                    title: TextFormField(
                      controller: passwordController,
                      cursorColor: boltPrimaryColor,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: passwordVisible ? false : true,
                      decoration: InputDecoration(
                        hintText: "Enter your Password",
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color: boltPrimaryColor,
                        ),
                      ),
                    ),
                    trailing: GestureDetector(
                      child: Icon(passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onTap: () {
                        setState(() {
                          if (passwordVisible) {
                            passwordVisible = false;
                          } else {
                            passwordVisible = true;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),
              ButtonTheme(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () async {
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                        Navigator.pop(context);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      }
                    },
                    elevation: 5.0,
                    color: Colors.black,
                    textColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Are you a new User?  ",
                        style: TextStyle(fontSize: 15),
                      ),
                      GestureDetector(
                        child: Text(
                          "Signup Here",
                          style: TextStyle(
                            color: boltPrimaryColor,
                            fontSize: 15,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SignUpPage();
                          }));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
