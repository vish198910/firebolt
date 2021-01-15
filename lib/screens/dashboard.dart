import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebolt/screens/friends.dart';
import 'package:firebolt/screens/profile.dart';
import 'package:firebolt/screens/run.dart';
import 'package:firebolt/screens/today.dart';
import 'package:firebolt/style/color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/usermngmt.dart';

class DashboardPage extends StatefulWidget {
  final data;
  DashboardPage({this.data});
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  UserManagement user = new UserManagement();

  int _currentIndex = 0;
  List<Widget> _children = [];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    _children = [
      Today(),
      Run(),
      Friends(),
      Profile(),
    ];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _children = [
      Today(),
      Run(),
      Friends(),
      Profile(email: widget.data.email),
    ];
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        onTap: onTabTapped, // new
        currentIndex: _currentIndex,
        selectedItemColor: boltPrimaryColor,
        items: [
          BottomNavigationBarItem(label: "Today", icon: Icon(Icons.bar_chart)),
          BottomNavigationBarItem(
              label: "Run", icon: FaIcon(FontAwesomeIcons.walking)),
          BottomNavigationBarItem(label: "Friends", icon: Icon(Icons.group)),
          BottomNavigationBarItem(label: "Me", icon: Icon(Icons.face)),
        ],
      ),
    );
  }
}
