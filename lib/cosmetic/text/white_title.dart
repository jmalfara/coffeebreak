import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WhiteTitleText extends StatelessWidget {
  final String text;

  WhiteTitleText({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 32
      ),
    );
  }
}