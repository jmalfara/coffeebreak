
import 'package:coffeebreak/game/components/barrier.dart';
import 'package:coffeebreak/game/components/enemy.dart';
import 'package:coffeebreak/game/components/goal.dart';
import 'package:coffeebreak/game/components/player.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:vector_math/vector_math_64.dart';

class Grid {
  int columns = 50;
  int rows = 50;
  double width, height;
  Box2DComponent box2dComponent;
  double columnSize;

  Grid({this.width, this.height, this.box2dComponent}) {
    print("$width : $height");
    columnSize = width / columns;
  }

  Vector2 _calculateScreenPosition(int x, int y) {
    double screenX = x * columnSize;
    double screenY = y * columnSize;
    return new Vector2(screenX, screenY);
  }

  Barrier createBarrierAt(int x, int y) {
    Vector2 position = _calculateScreenPosition(x, y);
    return new Barrier(box2dComponent, position);
  } 

  Player createPlayerAt(int x, int y) {
    Vector2 position = _calculateScreenPosition(x, y);
    return new Player(box2dComponent, position);
  } 

  Enemy createEnemyAt(int x, int y) {
    Vector2 position = _calculateScreenPosition(x, y);
    return new Enemy(box2dComponent, position);
  } 

  Goal createGoalAt(int x, int y) {
    Vector2 position = _calculateScreenPosition(x, y);
    return new Goal(box2dComponent, position);
  } 
}