import 'package:box2d_flame/box2d.dart';
import 'package:coffeebreak/dto/game/maze_game_dto.dart';
import 'package:coffeebreak/game/components/grid.dart';
import 'package:coffeebreak/game/components/player.dart';
import 'package:coffeebreak/game/simple_contact_listener.dart';
import 'package:flame/box2d/box2d_component.dart';

class MazeWorld extends Box2DComponent {
  MazeGameDto gameDto;
  PlayerComponent player;
  Grid grid;

  MazeWorld({this.gameDto}) : super(scale: 1.0) {
    player = new PlayerComponent(this);
    grid = new Grid(width: viewport.width, height: viewport.height, box2dComponent: this);
    world.setContactListener(new SimpleContactListener());
  }

  void initializeWorld() {
    add(player);
    _buildBarriers();
    // world.setGravity(new Vector2(0, 0));
  }

  void stopPlayer() {
    player.body.linearVelocity = new Vector2(0, 0);
  }

  void movePlayer(Vector2 force) {
    force.multiply(new Vector2(100, 100));
    player.body.linearVelocity = force;
  }

  // TODO Implement With GameDto
  void _buildBarriers() {
    // Left
    add(grid.createBoxAt(5, 5));
    add(grid.createBoxAt(5, 4));
    add(grid.createBoxAt(5, 3));
    add(grid.createBoxAt(5, 2));
    add(grid.createBoxAt(5, 1));
    add(grid.createBoxAt(5, 0));
    add(grid.createBoxAt(5, -1));
    add(grid.createBoxAt(5, -2));
    add(grid.createBoxAt(5, -3));
    add(grid.createBoxAt(5, -4));
    add(grid.createBoxAt(5, -5));
    
    // Right
    add(grid.createBoxAt(-5, 5));
    add(grid.createBoxAt(-5, 4));
    add(grid.createBoxAt(-5, 3));
    add(grid.createBoxAt(-5, 2));
    add(grid.createBoxAt(-5, 1));
    add(grid.createBoxAt(-5, 0));
    add(grid.createBoxAt(-5, -1));
    add(grid.createBoxAt(-5, -2));
    add(grid.createBoxAt(-5, -3));
    add(grid.createBoxAt(-5, -4));
    add(grid.createBoxAt(-5, -5));

    // Top
    add(grid.createBoxAt(5, 5));
    add(grid.createBoxAt(4, 5));
    add(grid.createBoxAt(3, 5));
    add(grid.createBoxAt(2, 5));
    add(grid.createBoxAt(1, 5));
    add(grid.createBoxAt(0, 5));
    add(grid.createBoxAt(-1, 5));
    add(grid.createBoxAt(-2, 5));
    add(grid.createBoxAt(-3, 5));
    add(grid.createBoxAt(-4, 5));
    add(grid.createBoxAt(-5, 5));

    // Bottom
    add(grid.createBoxAt(5, -5));
    add(grid.createBoxAt(4, -5));
    add(grid.createBoxAt(3, -5));
    add(grid.createBoxAt(2, -5));
    add(grid.createBoxAt(1, -5));
    add(grid.createBoxAt(0, -5));
    add(grid.createBoxAt(-1, -5));
    add(grid.createBoxAt(-2, -5));
    add(grid.createBoxAt(-3, -5));
    add(grid.createBoxAt(-4, -5));
    add(grid.createBoxAt(-5, -5));
  }
}
