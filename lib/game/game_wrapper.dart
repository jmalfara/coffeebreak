import 'package:coffeebreak/dto/game/base_game_dto.dart';
import 'package:coffeebreak/game/game.dart';
import 'package:flutter/widgets.dart';

class GameWrapper extends StatelessWidget {
  final Game game;

  const GameWrapper({Key key, this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return game.widget;
  }
}