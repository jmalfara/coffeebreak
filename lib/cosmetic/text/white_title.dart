import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WhiteTitleText extends StatelessWidget {
  String text;

  WhiteTitleText(String text) {
    this.text = text;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 32
      ),
    );
  }
}