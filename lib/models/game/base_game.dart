import 'dart:ui';

import 'package:coffeebreak/models/player.dart';

class BaseGameModel {
  final double time;
  final PlayerModel player;
  final Rect bounds;
  final String type;

  BaseGameModel._({
    this.time,
    this.type,
    this.bounds,
    this.player,
  });

  factory BaseGameModel.fromJson(Map<String, dynamic> json) {
    double boundHeight = json["bounds"]["height"];
    double boundWidth = json["bounds"]["width"];
    
    return new BaseGameModel._(
      time: json["time"],
      type: json["type"],
      bounds: Rect.fromLTRB(0, 0, boundWidth, boundHeight),
      player: PlayerModel.fromJson(json["player"])
    );
  }
}