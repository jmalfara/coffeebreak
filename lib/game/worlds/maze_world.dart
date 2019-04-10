import 'package:box2d_flame/box2d.dart';
import 'package:coffeebreak/dto/game/maze_game_dto.dart';
import 'package:coffeebreak/game/components/player.dart';
import 'package:flame/box2d/box2d_component.dart';

class MazeWorld extends Box2DComponent {
  MazeGameDto gameDto;
  PlayerComponent player;

  MazeWorld({this.gameDto}) : super(scale: 4.0) {
    player = new PlayerComponent(this);
  }

  void initializeWorld() {
    add(player);
    world.setGravity(new Vector2(0, 0));
  }

  void stopPlayer() {
    player.body.linearVelocity = new Vector2(0, 0);
  }

  void movePlayer(Vector2 force) {
    force.multiply(new Vector2(30, 30));
    player.body.linearVelocity = force;
  }

  @override
  void update(t) {
    super.update(t);
    cameraFollow(player, horizontal: 1, vertical: 1);
  }
}
