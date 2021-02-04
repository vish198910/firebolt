import 'package:flutter/material.dart';

class FAQ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          GestureDetector(
            child: ListTile(
              title: Text("Change phone to operate:"),
            ),
          ),
          GestureDetector(
            child: ListTile(
              title: Text(
                  "Why need to measure high blood pressure after input blood pressure refernce value calibration?"),
            ),
          ),
          GestureDetector(
            child: ListTile(
              title: Text(
                  "About device Direct Blood Pressure Data Display Problem:"),
            ),
          ),
        ],
      ),
    );
  }
}
