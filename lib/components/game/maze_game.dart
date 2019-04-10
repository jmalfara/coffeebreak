import 'package:coffeebreak/components/controls/joystick.dart';
import 'package:coffeebreak/dto/game/maze_game_dto.dart';
import 'package:coffeebreak/game/game.dart';
import 'package:coffeebreak/game/game_wrapper.dart';
import 'package:coffeebreak/game/worlds/maze_world.dart';
import 'package:flutter/material.dart';

class MazeGame extends StatelessWidget {
  final MazeGameDto gameDto;
  MazeWorld mazeWorld;

  MazeGame({Key key, this.gameDto}) : super(key: key) {
    mazeWorld = new MazeWorld(gameDto: gameDto);
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

  // renderGameControls() {
  //   return Column(
  //     children: <Widget> [
  //       RaisedButton(
  //         child: Text("Up"),
  //         onPressed: () {
  //           // gameDto.baseGame.player.setForce(new Vector2(0, -100));
  //           mazeWorld.movePlayerUp();
  //         },
  //       ),        
  //       RaisedButton(
  //         child: Text("Down"),
  //         onPressed: () {
  //           // gameDto.baseGame.player.setForce(new Vector2(0, -100));
  //           mazeWorld.movePlayerDown();
  //         },
  //       ),
  //       RaisedButton(
  //         child: Text("Right"),
  //         onPressed: () {
  //           // gameDto.baseGame.player.setForce(new Vector2(0, -100));
  //           mazeWorld.movePlayerRight();
  //         },
  //       ),        
  //       RaisedButton(
  //         child: Text("Left"),
  //         onPressed: () {
  //           // gameDto.baseGame.player.setForce(new Vector2(0, -100));
  //           mazeWorld.movePlayerLeft();
  //         },
  //       ),
  //       RaisedButton(
  //         child: Text("Stop"),
  //         onPressed: () {
  //           // gameDto.baseGame.player.setForce(new Vector2(0, -100));
  //           mazeWorld.stopPlayer();
  //         },
  //       )
  //     ]
  //   );
  // }

  renderGameControls() {
    return Container(
      padding: EdgeInsets.only(top: 500, left: 50),
      child: TouchPad(onChanged: (vector) {
        print(vector);
        mazeWorld.movePlayer(vector);
      })
    );
  }
}