import 'dart:math';

/*
 * The observable class used to define a player.
 */
class PlayerModel {
  /*
  "player": {
    "type": "circle",
    "location": {
      "x": 0,
      "y": 0
    }
  },
  */
  final PlayerType type;
  Point location;
  
  PlayerModel._({this.type, this.location});

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    Point _location = Point(json["location"]["x"], json["location"]["y"]);
    
    return new PlayerModel._(
      type: _findPlayerType(json["type"]),
      location: _location
    );
  }

  static PlayerType _findPlayerType(String statusAsString) {
    for (PlayerType element in PlayerType.values) {
      if (element.toString() == statusAsString) {
          return element;
      }
    }
    return null;
  }
}

enum PlayerType {
  CIRCLE,
  SQUARE
}
