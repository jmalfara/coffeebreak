import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/game.dart';

class Game extends BaseGame {
  final Box2DComponent gameWorld;

  Game({this.gameWorld}) {
    print("Create World");
    gameWorld.initializeWorld();
    add(gameWorld);
  }
}
