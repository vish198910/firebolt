import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebolt/screens/invitations.dart';
import 'package:firebolt/screens/users.dart';
import 'package:firebolt/style/color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Friends extends StatefulWidget {
  final email;
  Friends({this.email});
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Stream friends = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.email)
        .collection("friends")
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Friends"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return Users(
                      email: widget.email,
                    );
                  }));
                },
                child: Icon(
                  Icons.add_circle,
                )),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Invites(
                        email: widget.email,
                      );
                    },
                  ),
                );
              },
              child: Icon(
                Icons.mail,
              ),
            ),
          )
        ],
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
                              title: new Text(document.data()['name']),
                              subtitle: new Text(document.data()['email']),
                            )
                          : Center(
                              child: Container(
                                child: Text("Add your Friends"),
                              ),
                            ),
                    ),
                  );
                }).toList(),
              );
            },
            stream: friends,
          ),
        ),
      ),
    );
  }
}
