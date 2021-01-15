import 'package:flutter/material.dart';
import 'feedback.dart' as FeedBack;

class OperatingInstructions extends StatefulWidget {
  final email;
  final versionName;
  OperatingInstructions({this.email, this.versionName});
  @override
  _OperatingInstructionsState createState() => _OperatingInstructionsState();
}

class _OperatingInstructionsState extends State<OperatingInstructions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Operating Instructions"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            child: Center(
              child: Container(child: Image.asset("images/logo.png")),
            ),
          ),
          GestureDetector(
            child: ListTile(
              title: Text("APP"),
              leading: Icon(Icons.update),
              trailing: Text("Latest ${widget.versionName}"),
            ),
          ),
          GestureDetector(
            child: ListTile(
              title: Text("Instructions"),
              leading: Icon(Icons.details),
            ),
          ),
          GestureDetector(
            child: ListTile(
              title: Text("FAQ"),
              leading: Icon(Icons.question_answer),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return FeedBack.Feedback();
              }));
            },
            child: ListTile(
              title: Text("Feedback"),
              leading: Icon(Icons.feedback),
            ),
          ),
        ],
      ),
    );
  }
}
