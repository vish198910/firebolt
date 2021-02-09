import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebolt/screens/dashboard.dart';
import 'package:firebolt/services/usermngmt.dart';
import 'package:firebolt/style/color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';

class UserSettings extends StatefulWidget {
  final data;
  final email;
  final password;
  final confirmPassword;
  UserSettings({this.data, this.email, this.password, this.confirmPassword});
  @override
  _UserSettingsState createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  UserManagement userManagement = new UserManagement();
  TextEditingController nameController = new TextEditingController();

  //By default 0 is set and 0 is for Imperial and 1 is for Metric
  int unitType = 0;
//By default 0 is set and 0 is for Male and 1 is for Female
  int genderType = -1;
  Color enabledColor = boltPrimaryColor;

  DateTime birthdate = DateTime.now();
  List<double> heightItems = [];
  List<double> _weightItems = [];

  bool showLoader = true;

  List<DropdownMenuItem<double>> _dropdownHeightItems;
  double _selectedHeight;
  List<DropdownMenuItem<double>> _dropdownWeightItems;
  double _selectedWeight;

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  void loadHeights(int scale) async {
    heightItems = [];
    double heightValue = 0;
    int counter = 0;
    if (scale == 0) {
      while (counter <= 12) {
        showLoader = true;
        for (int i = 1; i < 12; i++) {
          heightItems.add(roundDouble(counter + heightValue, 1));
          heightValue += 0.1;
        }
        counter++;
        heightValue = 0;
      }
      showLoader = false;
    } else {
      for (int i = 50; i < 200; i++) {
        showLoader = true;
        heightItems.add(roundDouble(i * 1.0, 1));
      }
      showLoader = false;
    }
    _dropdownHeightItems = buildHeights(heightItems);
    _selectedHeight = _dropdownHeightItems[0].value;
  }

  void loadWeights(int scale) async {
    _weightItems = [];
    double weightValue = 0;
    int counter = 20;
    if (scale == 0) {
      while (counter <= 220) {
        showLoader = true;
        for (int i = 1; i < 10; i++) {
          _weightItems.add(roundDouble(counter + weightValue, 1));
          weightValue += 0.1;
        }
        counter++;
        weightValue = 0;
      }
      showLoader = false;
    } else {
      while (counter <= 100) {
        showLoader = true;
        for (int i = 1; i < 10; i++) {
          _weightItems.add(roundDouble(counter + weightValue, 1));
          weightValue += 0.1;
        }
        counter++;
        weightValue = 0;
      }
      showLoader = false;
    }
    _dropdownWeightItems = buildWeights(_weightItems);
    _selectedWeight = _dropdownWeightItems[0].value;
  }

  void initState() {
    super.initState();
    genderType = -1;
    unitType = 0;
    loadHeights(unitType);
    loadWeights(unitType);
  }

  List<DropdownMenuItem<double>> buildHeights(List listItems) {
    List<DropdownMenuItem<double>> items = List();
    for (double listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.toString()),
          value: listItem,
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<double>> buildWeights(List listItems) {
    List<DropdownMenuItem<double>> items = List();
    for (double listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.toString()),
          value: listItem,
        ),
      );
    }
    return items;
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor: Colors.black,
            accentColor: Colors.black,
            colorScheme: ColorScheme.light(primary: Colors.black),
          ),
          child: child,
        );
      },
      initialDate: birthdate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != birthdate)
      setState(() {
        birthdate = picked;
      });
  }

  void addUserData({
    String name,
    double height,
    double weight,
    DateTime birthDate,
    int gender,
  }) {
    FirebaseFirestore.instance.collection("users").doc(widget.email).set(
      {
        "name": name,
        "height": height,
        "weight": weight,
        "birthdate": birthdate,
        "gender": gender == 0 ? "Male" : "Female",
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Set up your Bolt",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: TextFormField(
                cursorColor: boltPrimaryColor,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "Enter your Name",
                    labelText: "Name",
                    labelStyle: TextStyle(color: boltPrimaryColor)),
                controller: nameController,
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Units"),
                  Row(
                    children: [
                      ButtonTheme(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0.5, 0),
                          child: RaisedButton(
                            onPressed: () {
                              setState(() {
                                unitType = 1;
                                loadHeights(unitType);
                                loadWeights(unitType);
                              });
                            },
                            color:
                                unitType == 1 ? boltPrimaryColor : Colors.black,
                            child: Text(
                              "Metric",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      ButtonTheme(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.5, 0, 0, 0),
                          child: RaisedButton(
                            color:
                                unitType == 0 ? boltPrimaryColor : Colors.black,
                            onPressed: () {
                              setState(() {
                                unitType = 0;
                                loadHeights(unitType);
                                loadWeights(unitType);
                              });
                            },
                            child: Text(
                              "Imperial",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Height"),
                  Row(
                    children: [
                      Text("${unitType == 0 ? " ft" : "cm"}  "),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<double>(
                            value: _selectedHeight,
                            items: _dropdownHeightItems,
                            onChanged: (value) {
                              setState(() {
                                _selectedHeight = value;
                              });
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Weight"),
                  Row(
                    children: [
                      Text("${unitType == 0 ? "lb" : "kg"}  "),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<double>(
                            value: _selectedWeight,
                            items: _dropdownWeightItems,
                            onChanged: (value) {
                              setState(() {
                                _selectedWeight = value;
                              });
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Theme(
              data: Theme.of(context).copyWith(
                primaryColor: Colors.black,
                accentColor: Colors.black,
              ),
              child: GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Birthdate",
                      ),
                      Text(
                        "${birthdate.toLocal()}".split(' ')[0],
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Gender"),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            genderType = 0;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FaIcon(
                            FontAwesomeIcons.male,
                            size: 40,
                            color: genderType == -1
                                ? Colors.grey
                                : genderType == 0
                                    ? boltPrimaryColor
                                    : Colors.black,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            genderType = 1;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FaIcon(FontAwesomeIcons.female,
                              size: 40,
                              color: genderType == -1
                                  ? Colors.grey
                                  : genderType == 1
                                      ? boltPrimaryColor
                                      : Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: ButtonTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () async {
                      try {
                        if (widget.password == widget.confirmPassword) {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                                  email: widget.email,
                                  password: widget.password);
                          print(userCredential.toString());
                        } else {}
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }

                      addUserData(
                          name: nameController.text,
                          height: _selectedHeight,
                          weight: _selectedHeight,
                          birthDate: birthdate,
                          gender: genderType);

                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return DashboardPage(email: widget.email);
                      }), (route) => false);
                    },
                    elevation: 5.0,
                    color: Colors.black,
                    textColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 18, 40, 18),
                      child: Text(
                        'Complete',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
