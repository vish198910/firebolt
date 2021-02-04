import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebolt/screens/invitations.dart';
import 'package:firebolt/style/color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Users extends StatefulWidget {
  final email;
  Users({this.email});
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Stream users = FirebaseFirestore.instance.collection('users').snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Users"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return ListView(
                padding: EdgeInsets.all(10),
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: document.data() != null
                          ? ListTile(
                              title: new Text(document.id),
                              trailing: Icon(Icons.offline_share),
                            )
                          : Center(
                              child: Container(
                                child: Text("Add your Users"),
                              ),
                            ),
                    ),
                  );
                }).toList(),
              );
            },
            stream: users,
          ),
        ),
      ),
    );
  }
}
