import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlackNormalText extends StatelessWidget {
  String text;

  BlackNormalText(String text) {
    this.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20
      ),
    );
  }
}