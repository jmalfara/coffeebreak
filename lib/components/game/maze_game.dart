import 'package:coffeebreak/components/controls/dpad.dart';
import 'package:coffeebreak/components/controls/joystick.dart';
import 'package:coffeebreak/dto/game/maze_game_dto.dart';
import 'package:coffeebreak/game/game.dart';
import 'package:coffeebreak/game/game_wrapper.dart';
import 'package:coffeebreak/game/worlds/maze_world.dart';
import 'package:flutter/material.dart';

class MazeGame extends StatefulWidget {
  final MazeGameDto gameDto;
  MazeWorld mazeWorld;

  MazeGame({Key key, this.gameDto}) : super(key: key) {
    mazeWorld = new MazeWorld(gameDto: gameDto);
  }

  @override
  _MazeGameState createState() => _MazeGameState();
}

class _MazeGameState extends State<MazeGame> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        renderGameWrapper(),
        renderGameControls()
      ]
    );
  }

  renderGameWrapper() {
    return ConstrainedBox(
      constraints: new BoxConstraints.tightFor(height: 500),
      child: GameWrapper(
        game: Game(
          gameWorld: widget.mazeWorld
        ),
      )
    );
  }

  renderGameControls() {
    return Center(
      child: DigitalJoystick(
        onChange: (vector) {
          widget.mazeWorld.movePlayer(vector);
        },
      )
    );
  }
}