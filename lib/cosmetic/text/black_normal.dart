import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlackNormalText extends StatelessWidget {
  final String text;

  BlackNormalText({this.text});

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