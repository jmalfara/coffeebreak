import 'dart:math';

/*
 * The observable class used to define a object.
 */
class GameObjectModel {
  /*
  "player": {
    "location": {
      "x": 0,
      "y": 0
    }
  },
  */
  Point location;
  String type;
  
  GameObjectModel._({this.location, this.type});

  factory GameObjectModel.fromJson(Map<String, dynamic> json) {
    Point _location = Point(json["location"]["x"], json["location"]["y"]);
    
    return new GameObjectModel._(
      location: _location,
      type: json["type"]
    );
  }
}