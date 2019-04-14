import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/painting.dart';

class Enemy extends BodyComponent {
  double _size = 5;

  Enemy(Box2DComponent box) : super(box) {
    _createBody();
  }

  @override
  void renderCircle(Canvas canvas, Offset center, double radius) {
    Paint paint = new Paint();
    paint.color = Color.fromARGB(255, 255, 0, 0);
    canvas.drawCircle(center, radius, paint);
  }

  _createBody() {
    CircleShape shape = new CircleShape();
    shape.radius = _size;

    final activeFixtureDef = new FixtureDef();
    activeFixtureDef.shape = shape;
    FixtureDef fixtureDef = activeFixtureDef;

    final activeBodyDef = new BodyDef();
    activeBodyDef.position = new Vector2(0, 20);
    activeBodyDef.type = BodyType.KINEMATIC;
    activeBodyDef.setUserData("Enemy");
    BodyDef bodyDef = activeBodyDef;

    this.body = world.createBody(bodyDef)
      ..createFixtureFromFixtureDef(fixtureDef);
  }
}