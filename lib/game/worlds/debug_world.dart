import 'package:box2d_flame/box2d.dart';
import 'package:coffeebreak/dto/game/base_game_dto.dart';
import 'package:coffeebreak/game/components/player.dart';
import 'package:flame/box2d/box2d_component.dart';

class DebugWorld extends Box2DComponent {
  BaseGameDto gameDto;
  PlayerComponent player;

  DebugWorld({this.gameDto}) : super(scale: 4.0) {
    player = new PlayerComponent(this);
  }

  void initializeWorld() {
    add(player);
    world.setGravity(new Vector2(0, 0));
  }

  @override
  void update(t) {
    super.update(t);
    cameraFollow(player, horizontal: 1, vertical: 1);
  }
}
