import 'package:firebolt/services/usermngmt.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserManagement user = new UserManagement();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Me"),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.logout),
              ),
              onTap: () {
                user.signOut();
              })
        ],
      ),
      body: Column(
        children: [
          ListTile(
            leading: GestureDetector(
                child: CircleAvatar(
              child: Image.asset("images/logo.png"),
            )),
            title: Text("Name"),
            subtitle: Text("ID : 3428928"),
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.add),
              title: Text("Connect a device"),
            ),
          ),
          GestureDetector(
            child: ListTile(
              leading: FaIcon(FontAwesomeIcons.stepForward),
              title: Text("Target"),
            ),
          ),
          GestureDetector(
            child: ListTile(
              leading: FaIcon(FontAwesomeIcons.moon),
              title: Text("Sleep Target"),
            ),
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text("Device Management"),
            ),
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.camera),
              title: Text("Shake Snapshot"),
            ),
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.search),
              title: Text("Find device"),
            ),
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.info),
              title: Text("Operating Instructions"),
            ),
          ),
        ],
      ),
    );
  }
}
