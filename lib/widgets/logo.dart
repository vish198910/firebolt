import 'package:flutter/material.dart';

class LOGO extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: Center(
              child: Text(
                "BOLT",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 80
                ),
              ),
            ),
          ),
          ListTile(
            title: Center(
              child: Text(
                "Watches",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
