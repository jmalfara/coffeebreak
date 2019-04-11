import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/painting.dart';

class PlayerComponent extends BodyComponent {
  PlayerComponent(Box2DComponent box) : super(box) {
    _createBody();
  }

  @override
  void renderCircle(Canvas canvas, Offset center, double radius) {
    Paint paint = new Paint();
    paint.color = Color.fromARGB(255, 0, 0, 200);
    canvas.drawCircle(center, radius, paint);
  }

  _createBody() {
    print("Create body");
    // Define a shape
    CircleShape circle = new CircleShape();
    circle.radius = 2;

    final activeFixtureDef = new FixtureDef();
    activeFixtureDef.shape = circle;
    activeFixtureDef.restitution = 1;
    activeFixtureDef.density = 0.05;
    activeFixtureDef.friction = 0.0;
    FixtureDef fixtureDef = activeFixtureDef;

    final activeBodyDef = new BodyDef();
    activeBodyDef.linearVelocity = new Vector2(0.0, 0.0);
    activeBodyDef.position = new Vector2(0.0, 15.0);
    activeBodyDef.type = BodyType.DYNAMIC;
    activeBodyDef.bullet = true;
    BodyDef bodyDef = activeBodyDef;

    this.body = world.createBody(bodyDef)
      ..createFixtureFromFixtureDef(fixtureDef);
  }
}