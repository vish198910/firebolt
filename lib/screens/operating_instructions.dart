import 'package:firebolt/screens/faq.dart';
import 'package:firebolt/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'feedback.dart' as FeedBack;
import 'package:package_info/package_info.dart';

class OperatingInstructions extends StatefulWidget {
  final email;
  final versionName;
  OperatingInstructions({this.email, this.versionName});
  @override
  _OperatingInstructionsState createState() => _OperatingInstructionsState();
}

class _OperatingInstructionsState extends State<OperatingInstructions> {
  String version = "";

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        version = packageInfo.version;
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Operating Instructions"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  border: Border.all(
                    width: 0.5,
                    color: Colors.white,
                  ),
                ),
                child: Center(
                  child: LOGO(),
                ),
              ),
              GestureDetector(
                child: ListTile(
                  title: Text("APP"),
                  leading: Icon(Icons.update),
                  trailing: Text("Latest $version"),
                ),
              ),
              GestureDetector(
                child: ListTile(
                  title: Text("Instructions"),
                  leading: Icon(Icons.details),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return FAQ();
                      },
                    ),
                  );
                },
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
        ),
      ),
    );
  }
}
