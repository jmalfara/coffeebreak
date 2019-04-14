import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:vector_math/vector_math_64.dart' as Vector;

// Digital version of the Joystick. On or Off
class DigitalJoystick extends StatelessWidget {
  final Function onChange;

  const DigitalJoystick({Key key, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deadZone = 0.05;

    return Joystick(
      onChanged: (Vector.Vector2 vector) {
        if (vector.x.abs() <= deadZone) {
          // Don't increase X
          vector.x = 0;
        }

        if (vector.y.abs() <= deadZone) {
          // Don't increase Y
          vector.y = 0;
        }

        if (vector.distanceTo(new Vector.Vector2(0, 0)) > 0) {
          double scaleValue = 1 / vector.distanceTo(new Vector.Vector2(0, 0));
          vector.scale(scaleValue);
          onChange(vector);
        } else {
          onChange(new Vector.Vector2(0, 0));
        }
      },
    );
  }

}

// Steteful widget
class Joystick extends StatefulWidget {
  final Function onChanged;

  const Joystick({Key key, this.onChanged}) : super(key: key);

  @override
  JoystickState createState() => new JoystickState();
}

// Draws a circle at supplied position.
class JoystickState extends State<Joystick> {
  final double width = 150;
  final double height = 150;

  double xPos = 0.0;
  double yPos = 0.0;

  void onChanged(Offset offset) {
    RenderBox referenceBox = context.findRenderObject();

    Offset position = referenceBox.globalToLocal(offset);

    double x = position.dx;
    double y = position.dy;

    if (x > width) {
      x = width;
    }
    else if (x < 0) {
      x = 0.0;
    }

    if (y > height) {
      y = height;
    } else if (y < 0) {
      y = 0.0;
    }

    // Update state for the draw.
    setState(() {
      xPos = x - (width / 2);
      yPos = y - (height / 2);
    });

    // Normalize the points between -1 and 1
    double normalWidth = (x / (width / 2)) - 1;
    double normalHeight = (y / (height / -2)) + 1;

    if (widget.onChanged != null)
      widget.onChanged(new Vector.Vector2(normalWidth, normalHeight));

  }

  void _handlePanStart(DragStartDetails details) {
    onChanged(details.globalPosition);
  }

  void _handlePanEnd(DragEndDetails details) {
    setState(() {
     xPos = 0;
     yPos = 0; 
    });
    
    if (widget.onChanged != null)
      widget.onChanged(new Vector.Vector2(0, 0));
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    onChanged(details.globalPosition);
  }

  @override
  Widget build(BuildContext context) {
    return new ConstrainedBox(
      constraints: new BoxConstraints.tightFor(height: height, width: width),
      child: new GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanStart:_handlePanStart,
        onPanEnd: _handlePanEnd,
        onPanUpdate: _handlePanUpdate,
        child: new CustomPaint(
          painter: new TouchPadGridPainter(),
          child: new Center(
            child:new CustomPaint(
              painter: new TouchPadPainter(xPos, yPos),
            ),
          ),
        ),
      ),
    );
  }
}

// Painter.
class TouchPadPainter extends CustomPainter {
  static const markerRadius = 10.0;

  Offset position;

  TouchPadPainter(final double x, final double y) {
    this.position = new Offset(x, y);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()
      ..color = Colors.blue[400]
      ..style = PaintingStyle.fill;

    canvas.drawCircle(new Offset(position.dx, position.dy), markerRadius, paint);
  }


  @override
  bool shouldRepaint(TouchPadPainter old) => position.dx != old.position.dx && position.dy !=old.position.dy;
}

// Grid Painter.
class TouchPadGridPainter extends CustomPainter {

  Offset position;

  TouchPadGridPainter() {
    this.position = new Offset(0.0, 0.0);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()
      ..color = Colors.blue[400]
      ..style = PaintingStyle.fill;

    Offset centreLeft = size.centerLeft(position);
    Offset centreRight = size.centerRight(position);

    canvas.drawLine(centreLeft, centreRight, paint);

    Offset topCentre = size.topCenter(position);
    Offset bottomCentre = size.bottomCenter(position);

    canvas.drawLine(topCentre, bottomCentre, paint);
  }


  @override
  bool shouldRepaint(TouchPadGridPainter old) => position.dx != old.position.dx && position.dy !=old.position.dy;
}