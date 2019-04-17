import 'package:box2d_flame/box2d.dart';
import 'package:coffeebreak/game/components/types.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/painting.dart';

class Player extends BodyComponent {
  double size;
  Paint paint;

  Player(Box2DComponent box, Vector2 initialPosition, {this.size = 5}) : super(box) {
    _createBody(initialPosition);
    paint = new Paint();
    paint.color = Color.fromARGB(255, 0, 0, 200);
  }

  @override
  void renderCircle(Canvas canvas, Offset center, double radius) {
    canvas.drawCircle(center, radius, paint);
  }

  _createBody(Vector2 initialPostion) {
    CircleShape shape = new CircleShape();
    shape.radius = size;

    final activeFixtureDef = new FixtureDef();
    activeFixtureDef.shape = shape;
    FixtureDef fixtureDef = activeFixtureDef;

    final activeBodyDef = new BodyDef();
    activeBodyDef.position = initialPostion;
    activeBodyDef.type = BodyType.DYNAMIC;
    activeBodyDef.setUserData(ComponentType.player);
    BodyDef bodyDef = activeBodyDef;

    this.body = world.createBody(bodyDef)
      ..createFixtureFromFixtureDef(fixtureDef);
  }
}