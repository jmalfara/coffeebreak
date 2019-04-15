
import 'package:coffeebreak/models/game/base_game.dart';

class MazeGameModel {
  final BaseGameModel baseGame;

  MazeGameModel._({
    this.baseGame
  });

  factory MazeGameModel.fromJson(Map<String, dynamic> json) {
    return new MazeGameModel._(
      baseGame: BaseGameModel.fromJson(json["base"])
    );
  }
}
