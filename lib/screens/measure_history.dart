import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MeasureHistory extends StatefulWidget {
  @override
  _MeasureHistoryState createState() => _MeasureHistoryState();
}

class _MeasureHistoryState extends State<MeasureHistory> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.black,
              height: 300,
              child: Column(
                children: [
                  Text(
                    "Measure History",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            Container(child: Text("No data"),)
          ],
        ),
      ),
    );
  }
}
