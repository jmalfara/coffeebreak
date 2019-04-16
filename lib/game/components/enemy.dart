import 'package:box2d_flame/box2d.dart';
import 'package:coffeebreak/game/components/types.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/painting.dart';

class Enemy extends BodyComponent {
  double size;

  Enemy(Box2DComponent box, Vector2 initialPosition, {this.size = 5}) : super(box) {
    _createBody(initialPosition);
  }

  @override
  void renderCircle(Canvas canvas, Offset center, double radius) {
    Paint paint = new Paint();
    paint.color = Color.fromARGB(255, 255, 0, 0);
    canvas.drawCircle(center, radius, paint);
  }

  _createBody(Vector2 initialPosition) {
    CircleShape shape = new CircleShape();
    shape.radius = size;

    final activeFixtureDef = new FixtureDef();
    activeFixtureDef.shape = shape;
    FixtureDef fixtureDef = activeFixtureDef;

    final activeBodyDef = new BodyDef();
    activeBodyDef.position = initialPosition;
    activeBodyDef.type = BodyType.KINEMATIC;
    activeBodyDef.setUserData(ComponentType.ENEMY);
    BodyDef bodyDef = activeBodyDef;

    this.body = world.createBody(bodyDef)
      ..createFixtureFromFixtureDef(fixtureDef);
  }
}