import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'services/usermngmt.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserManagement userObj = new UserManagement();
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;
  // Define an async function to initialize FlutterFire

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      print(e);
      setState(() {
        _error = true;
      });
    }
  }
  Future<bool> showLogo() async
  {
    await Future.delayed(Duration(seconds: 2));
    return true;
  }
  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
// Show error message if initialization failed
    if (_error) {
      print(_error);
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.black,
          accentColor: Colors.black
        ),
        home: Scaffold(
          body: Center(
            child: Container(
              child: Text("Loading.......",
                  style: TextStyle(color: Colors.lightBlue, fontSize: 50)),
            ),
          ),
        ),
      );
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Container(
              color: Colors.white,
              child: Text("Loading.......",
                  style: TextStyle(color: Colors.lightBlue, fontSize: 50)),
            ),
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
      future: showLogo(),
      builder:(context,AsyncSnapshot<bool>snapshot)
      {
        if(snapshot.hasData)
          return  userObj.handleAuth();
        else{
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Image.asset('images/logo.png'),
            ),
          );
        
        }  
      }
    ));
  }
}
