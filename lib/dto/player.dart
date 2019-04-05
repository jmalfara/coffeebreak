import 'dart:math';

class Player {
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
  final Point location;

  Player._({
    this.type,
    this.location
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return new Player._(
      type: _findPlayerType(json["type"]),
      location: Point(json["location"]["x"], json["location"]["y"])
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
