import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:coffeebreak/game/components/types.dart';
import 'package:flame/box2d/box2d_component.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/painting.dart';

class Barrier extends BodyComponent {
  double sizeX, sizeY;

  Barrier(Box2DComponent box, Vector2 position, {this.sizeX = 5, this.sizeY = 5}) : super(box) {
    _createBody(position);
  }

  _createBody(Vector2 position) {
    PolygonShape shape = new PolygonShape();
    shape.setAsBoxXY(sizeX, sizeY);

    final activeFixtureDef = new FixtureDef();
    activeFixtureDef.shape = shape;
    FixtureDef fixtureDef = activeFixtureDef;

    final activeBodyDef = new BodyDef();
    activeBodyDef.position = position;
    activeBodyDef.type = BodyType.STATIC;
    activeBodyDef.setUserData(ComponentType.BARRIER);
    BodyDef bodyDef = activeBodyDef;

    this.body = world.createBody(bodyDef)
      ..createFixtureFromFixtureDef(fixtureDef);
  }
}