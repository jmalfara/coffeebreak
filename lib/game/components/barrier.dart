import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/painting.dart';

class Barrier extends BodyComponent {
  double _size = 5;

  Barrier(Box2DComponent box, Vector2 position) : super(box) {
    _createBody(position);
    
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
    activeBodyDef.setUserData("Barrier");
    BodyDef bodyDef = activeBodyDef;

    this.body = world.createBody(bodyDef)
      ..createFixtureFromFixtureDef(fixtureDef);
  }
}