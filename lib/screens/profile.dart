import 'dart:convert';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebolt/screens/connect_device.dart';
import 'package:firebolt/screens/operating_instructions.dart';
import 'package:firebolt/screens/sleep_target.dart';
import 'package:firebolt/screens/steps_target.dart';
import 'package:firebolt/services/secrets.dart';
import 'package:firebolt/services/usermngmt.dart';
import 'package:firebolt/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:http/http.dart" as http;

class Profile extends StatefulWidget {
  final email;
  Profile({this.email});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserManagement userManage = new UserManagement();
  FlutterBlue flutterBlue = FlutterBlue.instance;
  int targetSteps = 0;

  fetchSteps(email) {}
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  addAppTag() async {
    var client = http.Client();
    try {
      var baseUrl = '${Secrets.FIXED_URL}';
      var response = await client.get(baseUrl + "//${Secrets.CUSTOMERS}");
      var jsonBody = json.decode(response.body);
      var customers = jsonBody["customers"];
      for (int i = 0; i < customers.length; i++) {
        if (customers[i]["email"] == widget.email) {
          print(customers[i]);
          var tagsUrl = baseUrl + "customers/${customers[i]["id"]}.json";
          var newResponse = await client.put(tagsUrl,
              headers: {"Content-Type": "application/json"},
              body: jsonEncode(
                {
                  "customer": {
                    "id": customers[i]["id"],
                    "tags": "Signed up for App",
                  },
                },
              ),
              encoding: Encoding.getByName('utf-8'));
          print(newResponse.statusCode);
        }
      }
    } finally {
      client.close();
    }
  }

  @override
  void initState() {
    super.initState();
    addAppTag();
  }

  @override
  Widget build(BuildContext context) {
    Stream user = users.doc(widget.email).snapshots();

    Stream steps = users
        .doc(widget.email)
        .collection("fitness")
        .doc("stepsData")
        .snapshots();

    Stream sleepTime = users
        .doc(widget.email)
        .collection("fitness")
        .doc("sleepData")
        .snapshots();

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
                userManage.signOut();
              })
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: user,
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return ListTile(
                leading: Container(
                  child: Icon(
                    FontAwesomeIcons.user,
                    size: 40,
                    color: Colors.black,
                  ),
                ),
                title: Text(
                  "${snapshot.data.data()['name']}",
                ),
                subtitle: Text("${widget.email}"),
              );
            },
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return ConnectWatch();
              }));
            },
            child: ListTile(
              leading: Icon(Icons.add),
              title: Text("Connect Your Bolt"),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return StepsTarget(
                  email: widget.email,
                );
              }));
            },
            child: ListTile(
              leading: FaIcon(FontAwesomeIcons.stepForward),
              title: Text("Target"),
              trailing: StreamBuilder<DocumentSnapshot>(
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return Text(
                      "${snapshot.data.data() != null ? snapshot.data.data()["steps_target"].toString().toUpperCase() : ''} steps",
                      style: TextStyle(color: boltPrimaryColor));
                },
                stream: steps,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return SleepTarget(
                  email: widget.email,
                );
              }));
            },
            child: ListTile(
              leading: FaIcon(FontAwesomeIcons.moon),
              title: Text("Sleep Target"),
              trailing: StreamBuilder<DocumentSnapshot>(
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return Text(
                    "${snapshot.data.data() != null ? snapshot.data.data()["sleep_hours"] : ''} Hours" +
                        " ${snapshot.data.data() != null ? snapshot.data.data()["sleep_minutes"] : ''} Minutes",
                    style: TextStyle(
                      color: boltPrimaryColor,
                    ),
                  );
                },
                stream: sleepTime,
              ),
            ),
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text("Device Management"),
            ),
          ),
          GestureDetector(
            onTap: () {
              showAlertDialog(BuildContext context) {
                Widget okButton = FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
                AlertDialog alert = AlertDialog(
                  backgroundColor: Colors.black,
                  title: Text(
                    "Device Info",
                    style: TextStyle(color: Colors.white),
                  ),
                  content: Text("No Device Connected",
                      style: TextStyle(color: Colors.white)),
                  actions: [
                    okButton,
                  ],
                );
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              }

              showAlertDialog(context);
            },
            child: ListTile(
              leading: Icon(Icons.camera),
              title: Text("Shake Snapshot"),
            ),
          ),
          GestureDetector(
            onTap: () => {
              // startScan(),
              showDialog(
                  context: context,
                  useSafeArea: true,
                  builder: (contex) {
                    return Dialog(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: Column(
                          children: [
                            SizedBox(height: 30),
                            Text(
                              'Finding nearby devices ...',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 25),
                            ),
                            SizedBox(height: 30),
                            Expanded(
                              child: StreamBuilder<List<ScanResult>>(
                                  stream: flutterBlue.scanResults,
                                  builder: (context,
                                      AsyncSnapshot<List<ScanResult>>
                                          snapshot) {
                                    return ListView.builder(
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            onTap: () {
                                              print(snapshot
                                                  .data[index].device.services);
                                            },
                                            title: Text(snapshot
                                                .data[index].device.name),
                                          );
                                        });
                                  }),
                            ),
                            StreamBuilder<bool>(
                                stream: flutterBlue.isScanning,
                                builder:
                                    (context, AsyncSnapshot<bool> snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data == true) {
                                    return RaisedButton(
                                        onPressed: () {
                                          flutterBlue.startScan();
                                        },
                                        color: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            height: 50,
                                            child: Center(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation(
                                                          Colors.white),
                                                ),
                                                SizedBox(width: 20),
                                                Text(
                                                  'Scanning...',
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ))));
                                  } else {
                                    return RaisedButton(
                                        onPressed: () {
                                          flutterBlue.startScan(
                                              timeout: Duration(seconds: 5));
                                        },
                                        color: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            height: 50,
                                            child: Center(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Scan',
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ))));
                                  }
                                }),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            },
            child: ListTile(
              leading: Icon(Icons.search),
              title: Text("Find device"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return OperatingInstructions(
                    email: widget.email,
                  );
                }),
              );
            },
            child: ListTile(
              leading: Icon(Icons.info),
              title: Text("Operating Instructions"),
            ),
          ),
        ],
      ),
    );
  }

  // Future startScan() async {
  //   if(await flutterBlue.isOn )
  //   {
  //     flutterBlue.scan(timeout: Duration(seconds:5));
  //     flutterBlue.startScan();
  //   }else{

  //   }
  // }
}
