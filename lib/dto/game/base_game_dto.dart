import 'dart:ui';

import 'package:coffeebreak/dto/player_dto.dart';

class BaseGameDto {
  final Player player;
  final Rect bounds;
  final String type;

  BaseGameDto._({
    this.type,
    this.bounds,
    this.player,
  });

  factory BaseGameDto.fromJson(Map<String, dynamic> json) {
    double boundHeight = json["bounds"]["height"];
    double boundWidth = json["bounds"]["width"];
    
    return new BaseGameDto._(
      type: json["type"],
      bounds: Rect.fromLTRB(0, 0, boundWidth, boundHeight),
      player: Player.fromJson(json["player"])
    );
  }
}