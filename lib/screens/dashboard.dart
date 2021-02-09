import 'package:firebolt/screens/friends.dart';
import 'package:firebolt/screens/profile.dart';
import 'package:firebolt/screens/run.dart';
import 'package:firebolt/screens/steps_counter.dart';
import 'package:firebolt/screens/today.dart';
import 'package:firebolt/style/color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../services/usermngmt.dart';

class DashboardPage extends StatefulWidget {
  final email;
  DashboardPage({this.email});
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

  void openTheBox() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    await Hive.openBox<int>('steps');
  }

  @override
  void initState() {
    _children = [
      Today(),
      Run(),
      Friends(
        email: widget.email,
      ),
      Profile(),
      DailyStepsPage(),
    ];
    openTheBox();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _children = [
      Today(email: widget.email),
      Run(),
      Friends(
        email: widget.email,
      ),
      Profile(email: widget.email),
      DailyStepsPage(),
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
          BottomNavigationBarItem(
              label: "Steps", icon: FaIcon(FontAwesomeIcons.shoePrints)),
        ],
      ),
    );
  }
}
