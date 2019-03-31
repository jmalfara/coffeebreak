
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:coffeebreak/dto/NextGame.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String GAME_DETAILS_URL = "https://us-central1-coffeebreak-36ca9.cloudfunctions.net/upcoming";

class GameDetailsRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new GameDetailsState();
}

class GameDetailsState extends State<GameDetailsRoute> {
  bool isLoading;
  int statusCode;
  NextGame nextGame;

  @override
  void initState() {
    super.initState();

    isLoading = true;
    statusCode = 0;
    nextGame = null;
    _fetchNextGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetch Data JSON")
      ),
      body: Center(
        child: renderBody()
      ),
    );
  }

  renderBody() {
    if (isLoading) {
      return CircularProgressIndicator();
    }

    if (statusCode == 200 && nextGame != null) {
      return renderUpcomingGame();
    } else if (statusCode == 404) {
      return renderGameNotFound();
    } else if (statusCode == 500) {
      return renderError();
    }

    return Container();
  }

  renderUpcomingGame() {
    // String time = "From: "+nextGame.timeBegin+" to "+nextGame.timeEnd;
    String prizePool = "Prize Pool: \$"+nextGame.prizePool.toString();
    String timeBegin = DateFormat('MMM d hh:mm a').format(nextGame.timeBegin);
    String timeEnd = DateFormat('hh:mm a').format(nextGame.timeEnd);
    String time = "From $timeBegin to $timeEnd";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          nextGame.title,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text(prizePool)
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: Image.network(
            nextGame.thumbnailUrl,
            fit: BoxFit.contain,
            width: 300,
            height: 300,
          )
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text(time)
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: RaisedButton(
            child: Icon(Icons.play_arrow),
            onPressed: () {_fetchNextGame();},
          ),
        )
      ],
    );
  }

  renderGameNotFound() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "There are no upcoming games currently planned",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Text("Please check back in later."),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {_fetchNextGame();},
          ),
        )
      ],
    );
  }

  renderError() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
              "Something went wrong. Please try again later.",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )
        ),
        Center( 
          child: Padding(
            padding: EdgeInsets.all(16),
            child: IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {_fetchNextGame();},
            ),
          )
        )
      ],
    );
  }

  _fetchNextGame() async {
    setState(() {
      isLoading = true;
    });
    
    
    NextGame _nextGame;
    int _statusCode;

    try {
      final response = await http.get(GAME_DETAILS_URL);
      print(response.body);
      
      _statusCode = response.statusCode;
      if (response.statusCode == 200) {
        _nextGame = NextGame.fromJson(json.decode(response.body));
      }
    } catch (e) {
      _statusCode = 500;
    }

    setState(() {
      isLoading = false;
      nextGame = _nextGame;
      statusCode = _statusCode;
    });
  }
}