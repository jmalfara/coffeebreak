import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WhiteSubtitleText extends StatelessWidget {
  String text;

  WhiteSubtitleText(String text) {
    this.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16
      ),
    );
  }
}