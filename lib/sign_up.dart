import 'package:firebolt/login.dart';
import 'package:firebolt/screens/user_settings.dart';
import 'package:flutter/material.dart';
import 'package:firebolt/style/color.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  bool passwordVisible = false;
  bool confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Create Account",
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
                  padding: EdgeInsets.all(8),
                  child: ListTile(
                    title: TextFormField(
                      cursorColor: boltPrimaryColor,
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
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(6),
                  child: ListTile(
                    title: TextFormField(
                      cursorColor: boltPrimaryColor,
                      controller: passwordController,
                      obscureText: passwordVisible ? false : true,
                      decoration: InputDecoration(
                        hintText: "Enter your Password",
                        labelText: "Password",
                        labelStyle: TextStyle(color: boltPrimaryColor),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(6),
                  child: ListTile(
                    title: TextFormField(
                      obscureText: confirmPasswordVisible ? false : true,
                      cursorColor: boltPrimaryColor,
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        hintText: "Enter your Password",
                        labelText: "Confirm Password",
                        labelStyle: TextStyle(color: boltPrimaryColor),
                      ),
                    ),
                    trailing: GestureDetector(
                      child: Icon(confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onTap: () {
                        setState(() {
                          if (confirmPasswordVisible) {
                            confirmPasswordVisible = false;
                          } else {
                            confirmPasswordVisible = true;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),
              ButtonTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return UserSettings(
                          email: emailController.text,
                          password: passwordController.text,
                          confirmPassword: confirmPasswordController.text,
                        );
                      }));
                    },
                    elevation: 5.0,
                    color: Colors.black,
                    textColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 18, 40, 18),
                      child: Text(
                        'Register',
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
                        "Already a user?  ",
                        style: TextStyle(fontSize: 15),
                      ),
                      GestureDetector(
                        child: Text(
                          "Login Here",
                          style: TextStyle(
                            color: boltPrimaryColor,
                            fontSize: 15,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginPage();
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
