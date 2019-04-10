import 'dart:ui';

import 'package:coffeebreak/dto/player_dto.dart';

class BaseGameDto {
  final double time;
  final Player player;
  final Rect bounds;
  final String type;

  BaseGameDto._({
    this.time,
    this.type,
    this.bounds,
    this.player,
  });

  factory BaseGameDto.fromJson(Map<String, dynamic> json) {
    double boundHeight = json["bounds"]["height"];
    double boundWidth = json["bounds"]["width"];
    
    return new BaseGameDto._(
      time: json["time"],
      type: json["type"],
      bounds: Rect.fromLTRB(0, 0, boundWidth, boundHeight),
      player: Player.fromJson(json["player"])
    );
  }
}