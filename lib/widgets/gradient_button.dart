import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  GradientButton({@required this.label, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.pink, Colors.pink[300], Colors.amber]),
      ),
      child: FlatButton(
          //color: Colors.pink,
          onPressed: onPressed,
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 18),
          )),
    );
  }
}
