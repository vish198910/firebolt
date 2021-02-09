import 'package:flutter/material.dart';

class PeriodWidget extends StatefulWidget {
  final String period;

  const PeriodWidget({Key key, this.period}) : super(key: key);

  @override
  _PeriodWidgetState createState() => _PeriodWidgetState();
}

class _PeriodWidgetState extends State<PeriodWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        child: Center(
          child: Text(
            "${widget.period}",
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.only(
            topLeft: widget.period == "Day"
                ? Radius.circular(10)
                : Radius.circular(0),
            bottomLeft: widget.period == "Day"
                ? Radius.circular(10)
                : Radius.circular(0),
            topRight: widget.period == "Month"
                ? Radius.circular(10)
                : Radius.circular(0),
            bottomRight: widget.period == "Month"
                ? Radius.circular(10)
                : Radius.circular(0),
          ),
        ),
        height: 30,
        width: 100,
      ),
    );
  }
}
