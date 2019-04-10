import 'dart:async';
import 'dart:math';

import 'package:vector_math/vector_math_64.dart';

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

  // Observable force Vector
  final StreamController<Vector2> _forceStreamController = StreamController<Vector2>();
  Stream<Vector2> get force => _forceStreamController.stream;
  
  Player._({
    this.type,
    Point location,
    Vector2 force
  }) {
    setLocation(location);
    print(force);
    setForce(force);
  }

  setLocation(Point location) {
    _locationStreamController.add(location);
  }

  setForce(Vector2 force) {
    _forceStreamController.add(force);
  }

  // Close all of the streams
  void dispose() {
    _locationStreamController.close();
    _forceStreamController.close();
  }

  factory Player.fromJson(Map<String, dynamic> json) {
    Point _location = Point(json["location"]["x"], json["location"]["y"]);
    Vector2 _force = new Vector2(json["force"]["x"], json["force"]["y"]);
    
    return new Player._(
      type: _findPlayerType(json["type"]),
      location: _location,
      force: _force
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
