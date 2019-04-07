import 'dart:async';
import 'dart:math';

/*
 * The observable class used to define a player.
 */
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

  // Observable location
  final StreamController<Point> _locationStreamController = StreamController<Point>();
  Stream<Point> get location => _locationStreamController.stream;
  void dispose() => _locationStreamController.close();
  
  Player._({
    this.type,
    Point location
  }) {
    setLocation(location);
  }

  setLocation(Point location) {
    _locationStreamController.add(location);
  }

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
