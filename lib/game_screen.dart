import 'package:coffeebreak/components/game/maze_game.dart';
import 'package:coffeebreak/cosmetic/background.dart';
import 'package:coffeebreak/dto/game/base_game_dto.dart';
import 'package:coffeebreak/dto/game/maze_game_dto.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class GameScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  bool isLoading;
  MazeGameDto gameDto;

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
    return MazeGame(
      gameDto: gameDto,
    );
  }

  _downloadGame() async {
    // Download game
    setState(() {
     isLoading = true; 
    });

    MazeGameDto _game;
    try {
      // TODO Create network download.
      String data = await DefaultAssetBundle.of(context).loadString("assets/game.json");
      final jsonResult = json.decode(data);
      _game = MazeGameDto.fromJson(jsonResult);
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