import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Me"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.account_box_rounded),
            title: Text("Name"),
            subtitle: Text("ID : 3428928"),
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text("Connect a device"),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.stepForward),
            title: Text("Target"),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.moon),
            title: Text("Sleep Target"),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Device Management"),
          ),
          ListTile(
            leading: Icon(Icons.camera),
            title: Text("Shake Snapshot"),
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text("Find device"),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("Operating Instructions"),
          ),
        ],
      ),
    );
  }
}
