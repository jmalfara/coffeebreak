import 'package:coffeebreak/components/maze/maze_game.dart';
import 'package:coffeebreak/cosmetic/background.dart';
import 'package:coffeebreak/models/game/base_game.dart';
import 'package:coffeebreak/models/game/maze_game.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class GameScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  bool isLoading;
  var gameDto;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    _downloadGame();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return renderLoading();
    }

    return Container(
      decoration: Background.decoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: renderGame()
        )
      )
    );
  }

  renderLoading() {
    return Container(
      decoration: Background.decoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator()
            ]
          ),
        )
      )
    );
  }

  renderGame() {
    if (gameDto is MazeGameModel) {
      return MazeGame(gameDto: gameDto);
    }

    return Text("Unsupported Game");
  }

  _downloadGame() async {
    // Download game
    setState(() {
     isLoading = true; 
    });
    
    MazeGameModel _game;
    try {
      // TODO Create network download.
      String data = await DefaultAssetBundle.of(context).loadString("assets/game.json");
      final jsonResult = json.decode(data);
      // Must parse json twice. Once for the game type and second for the the full game details
      BaseGameModel baseGameModel = BaseGameModel.fromJson(jsonResult["base"]);
      switch(baseGameModel.type) {
        case GameType.maze:
          _game = MazeGameModel.fromJson(jsonResult);
          break;
        default:
          print("Game not supported.");
          // TODO Handle error case for unsupported game
      }
    } catch (e) {
      print(e);
    }

    print(_game);
    setState(() {
     isLoading = false; 
     gameDto = _game;
    });
  }
}