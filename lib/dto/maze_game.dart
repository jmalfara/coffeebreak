import 'dart:ui';

import 'package:coffeebreak/dto/player.dart';

class MazeGame {
  final Player player;
  final Rect bounds;

  MazeGame._({
    this.bounds,
    this.player,
  });

  factory MazeGame.fromJson(Map<String, dynamic> json) {
    print(json);
    double boundHeight = json["bounds"]["height"];
    double boundWidth = json["bounds"]["width"];
    
    return new MazeGame._(
      bounds: Rect.fromLTRB(0, 0, boundWidth, boundHeight),
      player: Player.fromJson(json["player"])
    );
  }
}