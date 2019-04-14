import 'package:box2d_flame/box2d.dart';

class SimpleContactListener extends ContactListener {
  @override
  void beginContact(Contact contact) {
    print(contact.fixtureB.getBody().userData);
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