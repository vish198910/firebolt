import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebolt/screens/dashboard.dart';
import 'package:firebolt/services/usermngmt.dart';
import 'package:firebolt/style/color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserSettings extends StatefulWidget {
  final data;
  UserSettings({this.data});
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
  List<double> heightItems = [1, 2, 3, 4];
  List<double> _weightItems = [];

  List<DropdownMenuItem<double>> _dropdownMenuItems;
  double _selectedItem;

  List<double> loadHeights() {}

  void initState() {
    super.initState();
    genderType = -1;
    unitType = 0;
    _dropdownMenuItems = buildHeights(heightItems);
    _selectedItem = _dropdownMenuItems[0].value;
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

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
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
    FirebaseFirestore.instance.collection("users").doc(widget.data.email).set(
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
        actions: [
          GestureDetector(
            onTap: () {
              userManagement.signOut();
            },
            child: Icon(Icons.logout),
          ),
        ],
        title: Text(
          "User Settings",
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
                  Text("Height"),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<double>(
                        value: _selectedItem,
                        items: _dropdownMenuItems,
                        onChanged: (value) {
                          setState(() {
                            _selectedItem = value;
                          });
                        }),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Weight"),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<double>(
                        value: _selectedItem,
                        items: _dropdownMenuItems,
                        onChanged: (value) {
                          setState(() {
                            _selectedItem = value;
                          });
                        }),
                  ),
                ],
              ),
            ),
            GestureDetector(
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
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
            Center(
              child: ButtonTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () {
                      addUserData(
                          name: nameController.text,
                          height: _selectedItem,
                          weight: _selectedItem,
                          birthDate: birthdate,
                          gender: genderType);

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DashboardPage();
                      }));
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
