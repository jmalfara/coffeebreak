import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Background {
  static BoxDecoration decoration() {
    return BoxDecoration (
      // Box decoration takes a gradient
      gradient: LinearGradient(
        // Where the linear gradient begins and ends
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        // // Add one stop for each color. Stops should increase from 0 to 1
        stops: [0.0, 1.0],
        colors: [
          // Colors are easy thanks to Flutter's Colors class.
          Colors.indigo[800],
          Colors.indigo[300]
        ],
      ),
    );
  }
}