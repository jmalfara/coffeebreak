import 'package:coffeebreak/dto/game/base_game_dto.dart';
import 'package:coffeebreak/game/worlds/debug_world.dart';
import 'package:flame/game.dart';

class Game extends BaseGame {
  final BaseGameDto gameDto;

  Game(this.gameDto) {
    print("Create Debug World");
    DebugWorld debugWorld = new DebugWorld(gameDto: gameDto);
    debugWorld.initializeWorld();
    add(debugWorld);
  }
}
