import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:coffeebreak/game/components/types.dart';
import 'package:flame/box2d/box2d_component.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/painting.dart';

class Goal extends BodyComponent {
  double _size = 5;
  Paint paint;

  Goal(Box2DComponent box, Vector2 position) : super(box) {
    _createBody(position);
    paint = new Paint();
    paint.color = Color.fromARGB(255, 0, 255, 0);
  }

  void renderPolygon(Canvas canvas, List<Offset> points) {
    final path = new Path()..addPolygon(points, true);
    canvas.drawPath(path, paint);
  }

  _createBody(Vector2 position) {
    PolygonShape shape = new PolygonShape();
    shape.setAsBoxXY(_size, _size);

    final activeFixtureDef = new FixtureDef();
    activeFixtureDef.shape = shape;
    FixtureDef fixtureDef = activeFixtureDef;

    final activeBodyDef = new BodyDef();
    activeBodyDef.position = position;
    activeBodyDef.type = BodyType.STATIC;
    activeBodyDef.setUserData(ComponentType.ENDPOINT);
    BodyDef bodyDef = activeBodyDef;

    this.body = world.createBody(bodyDef)
      ..createFixtureFromFixtureDef(fixtureDef);
  }
}