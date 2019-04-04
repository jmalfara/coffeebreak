import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WhiteSubtitleText extends StatelessWidget {
  final String text;

  WhiteSubtitleText({this.text});

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