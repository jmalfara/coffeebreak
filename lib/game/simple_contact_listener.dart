import 'package:box2d_flame/box2d.dart';

class SimpleContactListener extends ContactListener {
  final Function collision;

  SimpleContactListener({this.collision});

  @override
  void beginContact(Contact contact) {
    if (collision != null) {
      collision(contact);
    }
  }

  @override
  void endContact(Contact contact) {
  }

  @override
  void postSolve(Contact contact, ContactImpulse impulse) {
  }

  @override
  void preSolve(Contact contact, Manifold oldManifold) {
  }

}