import 'package:coffeebreak/components/controls/joystick.dart';
import 'package:coffeebreak/dto/game/maze_game_dto.dart';
import 'package:coffeebreak/game/game.dart';
import 'package:coffeebreak/game/game_wrapper.dart';
import 'package:coffeebreak/game/worlds/maze_world.dart';
import 'package:flutter/material.dart';

class MazeGame extends StatefulWidget {
  final MazeGameDto gameDto;

  MazeGame({Key key, this.gameDto}) : super(key: key);

  @override
  _MazeGameState createState() => _MazeGameState();
}

class _MazeGameState extends State<MazeGame> {
  MazeWorld mazeWorld;

  @override
  void initState() {
    super.initState();
    mazeWorld = new MazeWorld(gameDto: widget.gameDto);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        renderGameWrapper(),
        renderGameControls()
      ]
    );
  }

  renderGameWrapper() {
    return GameWrapper(
      game: Game(
        gameWorld: mazeWorld
      ),
    );
  }

  renderGameControls() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: DigitalJoystick(
        onChange: (vector) {
          mazeWorld.movePlayer(vector);
        },
      )
    );
  }
}