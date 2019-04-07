import 'dart:math';

import 'package:coffeebreak/cosmetic/background.dart';
import 'package:coffeebreak/dto/game/base_game_dto.dart';
import 'package:coffeebreak/game/game.dart';
import 'package:coffeebreak/game/game_wrapper.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class GameScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  bool isLoading;
  BaseGameDto gameDto;

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
          child: GameWrapper(
            game: Game(gameDto)
          )
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

  _downloadGame() async {
    // Download game
    setState(() {
     isLoading = true; 
    });

    BaseGameDto _game;
    try {
      String data = await DefaultAssetBundle.of(context).loadString("assets/game.json");
      final jsonResult = json.decode(data);
      _game = BaseGameDto.fromJson(jsonResult["base"]);
    } catch (e) {
      print(e);
    }

    setState(() {
     isLoading = false; 
     gameDto = _game;
    });
  }
}