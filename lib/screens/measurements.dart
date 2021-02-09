import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MeasurementData extends StatefulWidget {
  @override
  _MeasurementDataState createState() => _MeasurementDataState();
}

class _MeasurementDataState extends State<MeasurementData> {
  DateTime todaysDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor: Colors.black,
            accentColor: Colors.black,
            colorScheme: ColorScheme.light(primary: Colors.black),
          ),
          child: child,
        );
      },
      initialDate: todaysDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != todaysDate)
      setState(() {
        todaysDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Measurement"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 20),
            color: Colors.black,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.height / 6,
                    height: MediaQuery.of(context).size.height / 6,
                    decoration: new BoxDecoration(
                      gradient: RadialGradient(colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.3),
                        Colors.white.withOpacity(0.3),
                        Colors.white.withOpacity(0.3),
                        Colors.white.withOpacity(0.3),
                        Colors.white.withOpacity(0.3),
                        Colors.black.withOpacity(0.3),
                        Colors.white.withOpacity(0.3),
                      ]),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.flash_on,
                        color: Colors.white.withOpacity(0.5),
                        size: 30,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height / 4,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          child: Text(
                        "${todaysDate.year}-${todaysDate.month}-${todaysDate.day}",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      )),
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: FaIcon(
                            FontAwesomeIcons.calendar,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(100.0),
            child: Container(
              child: Column(
                children: [
                  FaIcon(
                    FontAwesomeIcons.satelliteDish,
                    size: 100,
                  ),
                  Text(
                    "No Data !",
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
