import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";

class Feedback extends StatefulWidget {
  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback> {
  TextEditingController adviceController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  CollectionReference feebacks =
      FirebaseFirestore.instance.collection("feebacks");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("Your Advice"),
          ),
          ListTile(
            title: TextFormField(
              controller: adviceController,
              decoration: InputDecoration(
                  labelText: "Your Advice",
                  hintText:
                      "Please let us know what did you like and any advice to improve."),
            ),
          ),
          ListTile(
            title: Text("Contact Email"),
          ),
          ListTile(
            title: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: "Your email",
                  hintText: "Please leave your email here"),
            ),
          ),
          ButtonTheme(
            child: RaisedButton(
              onPressed: () {
                if (emailController.text != "") {
                  feebacks
                      .doc(emailController.text)
                      .set({"feedback": adviceController.text});
                  Navigator.pop(context);
                }
              },
              child: Text("Submit"),
            ),
          ),
        ],
      ),
    );
  }
}
