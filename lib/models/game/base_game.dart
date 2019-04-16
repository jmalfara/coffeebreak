import 'package:coffeebreak/models/player.dart';
import 'package:vector_math/vector_math_64.dart';

class BaseGameModel {
  final double time;
  final PlayerModel player;
  final Vector2 bounds;
  final String type;

  BaseGameModel._({
    this.time,
    this.type,
    this.bounds,
    this.player,
  });

  factory BaseGameModel.fromJson(Map<String, dynamic> json) {
    double boundHeight = (json["bounds"]["height"] as int).toDouble();
    double boundWidth = (json["bounds"]["width"] as int).toDouble();
    
    return new BaseGameModel._(
      time: json["time"],
      type: json["type"],
      bounds: new Vector2(boundWidth, boundHeight),
      player: PlayerModel.fromJson(json["player"])
    );
  }
}