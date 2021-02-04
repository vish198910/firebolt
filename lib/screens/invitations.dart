import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebolt/style/color.dart';
import 'package:firebolt/widgets/invitation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Invites extends StatefulWidget {
  final email;
  Invites({this.email});
  @override
  _InvitesState createState() => _InvitesState();
}

class _InvitesState extends State<Invites> {
  TextEditingController emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Stream invites = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.email)
        .collection("invites")
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Invites"),
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
              } else {
                print(snapshot.data.docs);
                return snapshot.data.docs.length != 0
                    ? ListView(
                        padding: EdgeInsets.all(10),
                        children:
                            snapshot.data.docs.map((DocumentSnapshot document) {
                          print(document.data());
                          return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: InvitationWidget(
                                isFriend: false,
                                email: widget.email,
                                emailofFriend: document.data()["email"],
                                name: document.data()["name"],
                              ));
                        }).toList(),
                      )
                    : Container(
                        child: Text("Your Invites will be here"),
                      );
              }
            },
            stream: invites,
          ),
        ),
      ),
    );
  }
}
