import 'package:coffeebreak/game/components/barrier.dart';
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

  Vector2 calculateScreenPosition(int x, int y) {
    double screenX = x * columnSize;
    double screenY = y * columnSize;
    return new Vector2(screenX, screenY);
  }

  Barrier createBoxAt(int x, int y) {
    Vector2 position = calculateScreenPosition(x, y);
    print(position);
    return new Barrier(box2dComponent, position);
  } 
}