import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart';

class DPad extends StatefulWidget {
  final Function onChange;

  const DPad({Key key, this.onChange}) : super(key: key);

  @override
  _DPadState createState() => _DPadState();
}

class _DPadState extends State<DPad> {
  bool upButtonPressed = false;
  bool downButtonPressed = false;
  bool leftButtonPressed = false;
  bool rightButtonPressed = false;
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Icon(Icons.arrow_left), 
              onPressed: () { print("Left"); },
              onHighlightChanged: (pressed) { 
                leftButtonPressed = pressed; 
                handleDirectionChange();
              },
            )
          ]
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RaisedButton(
              child: Icon(Icons.arrow_drop_up), 
              onPressed: () { print("Up"); },
              onHighlightChanged: (pressed) { 
                print(pressed);
                upButtonPressed = pressed; 
                handleDirectionChange();
              },
            ),
            RaisedButton(
              child: Icon(Icons.arrow_drop_down), 
              onPressed: () { print("Down"); },
              onHighlightChanged: (pressed) { 
                downButtonPressed = pressed; 
                handleDirectionChange();
              },
            )
          ]
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Icon(Icons.arrow_right), 
              onPressed: () { print("Right"); },
              onHighlightChanged: (pressed) { 
                rightButtonPressed = pressed; 
                handleDirectionChange();
              },
            )
          ]
        )
      ],
    );
  }

  void handleDirectionChange() {
    Vector2 upVector = new Vector2(0, 0);
    Vector2 downVector = new Vector2(0, 0);
    Vector2 leftVector = new Vector2(0, 0);
    Vector2 rightVector = new Vector2(0, 0);

    if (upButtonPressed) {
      upVector = new Vector2(0, 1);
    }

    if (downButtonPressed) {
      downVector = new Vector2(0, -1);
    }

    if (leftButtonPressed) {
      leftVector = new Vector2(-1, 0);
    }

    if (rightButtonPressed) {
      rightVector = new Vector2(1, 0);
    }

    Vector2 directionVector = new Vector2(0, 0);
    directionVector.add(upVector);
    directionVector.add(downVector);
    directionVector.add(leftVector);
    directionVector.add(rightVector);

    if (widget.onChange != null)
      widget.onChange(directionVector);
  }
}

// class GestureDetectorButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new GestureDetector(
//       child: InkWell(
//         onHighlightChanged: ,
//       ),
//     );
//   }

// }