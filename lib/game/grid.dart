import 'package:coffeebreak/game/components/barrier.dart';
import 'package:coffeebreak/game/components/enemy.dart';
import 'package:coffeebreak/game/components/goal.dart';
import 'package:coffeebreak/game/components/player.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:vector_math/vector_math_64.dart';

class Grid {
  int columns;
  int rows;
  double width, height;
  Box2DComponent box2dComponent;
  double columnSize;

  Grid({this.width, this.height, this.box2dComponent, Vector2 bounds}) {
    columns = bounds.x.round();
    rows = bounds.y.round();
    columnSize = width / columns;
  }

  double scaledConstant() {
    return columnSize;
  }

  Vector2 _calculateScreenPosition(int x, int y) {
    double screenX = x * columnSize;
    double screenY = y * columnSize;
    return new Vector2(screenX, screenY);
  }

  List<Barrier> createBarrierBounds() {
    int maxX = (columns / 2).round();
    int maxY = (rows / 2).round();

    List<Barrier> barriers = [];

    // Create 4 barriers
    Vector2 topVector = _calculateScreenPosition(0, maxY);
    Barrier top = new Barrier(
      box2dComponent, 
      topVector,
      sizeX: (maxX * columnSize),
      sizeY: columnSize
    );
    barriers.add(top);

    Vector2 bottomVector = _calculateScreenPosition(0, -maxY);
    Barrier bottom = new Barrier(
      box2dComponent, 
      bottomVector,
      sizeX: (maxX * columnSize),
      sizeY: columnSize
    );
    barriers.add(bottom);

    Vector2 leftVector = _calculateScreenPosition(maxX, 0);
    Barrier left = new Barrier(
      box2dComponent, 
      leftVector,
      sizeX: columnSize,
      sizeY: (maxY * columnSize)
    );
    barriers.add(left);

    Vector2 rightVector = _calculateScreenPosition(-maxX, 0);
    Barrier right = new Barrier(
      box2dComponent, 
      rightVector,
      sizeX: columnSize,
      sizeY: (maxY * columnSize)
    );
    barriers.add(right);

    return barriers;
  }

  Barrier createBarrierAt(int x, int y) {
    Vector2 position = _calculateScreenPosition(x, y);
    return new Barrier(box2dComponent, position, sizeX: columnSize, sizeY: columnSize);
  } 

  Player createPlayerAt(int x, int y) {
    Vector2 position = _calculateScreenPosition(x, y);
    return new Player(box2dComponent, position, size: columnSize);
  } 

  Enemy createEnemyAt(int x, int y) {
    Vector2 position = _calculateScreenPosition(x, y);
    return new Enemy(box2dComponent, position, size: columnSize);
  } 

  Goal createGoalAt(int x, int y) {
    Vector2 position = _calculateScreenPosition(x, y);
    return new Goal(box2dComponent, position, size: columnSize);
  } 
}