import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";

class InvitationWidget extends StatefulWidget {
  bool isFriend = false;
  final String name;
  final String email;
  final String emailofFriend;
  InvitationWidget({this.isFriend, this.email, this.emailofFriend, this.name});
  @override
  _InvitationWidgetState createState() => _InvitationWidgetState();
}

class _InvitationWidgetState extends State<InvitationWidget> {
  CollectionReference collection =
      FirebaseFirestore.instance.collection("users");
  void addSubscriptions() {
    if (widget.isFriend == true) {
      print(widget.emailofFriend);
      collection
          .doc(widget.email)
          .collection("friends")
          .doc(widget.emailofFriend)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        print(documentSnapshot.data());
        print("I am printing document snapshot");
        if (!documentSnapshot.exists) {
          collection
              .doc(widget.email)
              .collection("friends")
              .doc(widget.emailofFriend)
              .set({
            "name": "hello",
            "email": widget.emailofFriend,
          });
        } else {
          print('Document does not exist on the database');
        }
      });

      collection
          .doc(widget.email)
          .collection("invites")
          .doc(widget.emailofFriend)
          .delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          trailing: GestureDetector(
            onTap: () {
              setState(() {
                widget.isFriend = true;
                addSubscriptions();
              });
            },
            child: Icon(
              Icons.offline_share,
              color: widget.isFriend ? Colors.blue : Colors.grey,
              size: 30,
            ),
          ),
          title: Text(
            widget.name,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            widget.emailofFriend,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
