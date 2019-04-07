import 'dart:ui';

import 'package:coffeebreak/dto/game/base_game_dto.dart';

class MazeGameDto {
  final BaseGameDto baseGame;

  MazeGameDto._({
    this.baseGame
  });

  factory MazeGameDto.fromJson(Map<String, dynamic> json) {
    return new MazeGameDto._(
      baseGame: BaseGameDto.fromJson(json["base"])
    );
  }
}
