import 'dart:math';

/*
 * The observable class used to define a player.
 */
class PlayerModel {
  /*
  "player": {
    "location": {
      "x": 0,
      "y": 0
    }
  },
  */
  Point location;
  
  PlayerModel._({this.location});

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    Point _location = Point(json["location"]["x"], json["location"]["y"]);
    
    return new PlayerModel._(
      location: _location
    );
  }
}