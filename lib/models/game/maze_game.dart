
import 'package:coffeebreak/models/game/base_game.dart';
import 'package:coffeebreak/models/game_object.dart';

class MazeGameModel {
  final BaseGameModel baseGame;
  final List<GameObjectModel> objects;

  MazeGameModel._({
    this.baseGame,
    this.objects
  });

  factory MazeGameModel.fromJson(Map<String, dynamic> json) {
    var list = json['objects'] as List;
    List<GameObjectModel> objects = list.map((i) => GameObjectModel.fromJson(i)).toList();

    return new MazeGameModel._(
      baseGame: BaseGameModel.fromJson(json["base"]),
      objects: objects
    );
  }
}
