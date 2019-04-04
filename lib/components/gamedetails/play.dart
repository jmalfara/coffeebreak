import 'dart:convert';
import 'package:coffeebreak/cosmetic/text/white_subtitle.dart';
import 'package:coffeebreak/cosmetic/text/white_title.dart';
import 'package:coffeebreak/dto/NextGame.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

const String GAME_DETAILS_URL = "https://us-central1-coffeebreak-36ca9.cloudfunctions.net/upcoming";

class PlayWidget extends StatefulWidget {

  const PlayWidget({ Key key }) : super(key: key);

  @override
  _PlayWidgetState createState() => _PlayWidgetState();
}

class _PlayWidgetState extends State<PlayWidget> with AutomaticKeepAliveClientMixin {
  bool isLoading;
  int statusCode;
  NextGame nextGame;
  
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    statusCode = 404;
    nextGame = null;
    _fetchNextGame();
  }

  @override
  Widget build(BuildContext context) {
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
    final double imageDimension = 300;
    // String time = "From: "+nextGame.timeBegin+" to "+nextGame.timeEnd;
    String prizePool = "Prize Pool: \$"+nextGame.prizePool.toString();
    String timeBegin = DateFormat('MMM d hh:mm a').format(nextGame.timeBegin);
    String timeEnd = DateFormat('hh:mm a').format(nextGame.timeEnd);
    String time = "From $timeBegin to $timeEnd";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WhiteTitleText(text: nextGame.title),
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: WhiteSubtitleText(text: prizePool)
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: imageDimension,
                height: imageDimension,
                decoration: BoxDecoration(color: Colors.grey),
              ),
              Image.network(
                nextGame.thumbnailUrl,
                fit: BoxFit.contain,
                width: imageDimension,
                height: imageDimension,
              ),
              RaisedButton(
                shape: CircleBorder(),
                color: Colors.grey[400].withAlpha(180),
                padding: EdgeInsets.all(16),
                child: Icon(Icons.play_arrow, size: 40),
                onPressed: _fetchNextGame,
              ),
            ],
          )
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: WhiteSubtitleText(text: time)
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
            onPressed: _fetchNextGame,
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
              onPressed: _fetchNextGame,
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