import 'package:coffeebreak/cosmetic/text/white_subtitle.dart';
import 'package:coffeebreak/cosmetic/text/white_title.dart';
import 'package:coffeebreak/dto/NextGame.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlayWidget extends StatelessWidget {
  bool isLoading;
  int statusCode;
  NextGame nextGame;

  Function requestFetchNextGame;

  PlayWidget({this.isLoading, this.statusCode, this.nextGame, this.requestFetchNextGame});

  @override
  Widget build(BuildContext context) {
    return renderBody();
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
        WhiteTitleText(nextGame.title),
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: WhiteSubtitleText(prizePool)
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
          child: WhiteSubtitleText(time)
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: RaisedButton(
            shape: CircleBorder(),
            padding: EdgeInsets.all(16),
            child: Icon(Icons.play_arrow),
            onPressed: requestFetchNextGame,
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
            onPressed: requestFetchNextGame,
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
              onPressed: requestFetchNextGame,
            ),
          )
        )
      ],
    );
  }

}