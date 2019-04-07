
import 'package:coffeebreak/components/gamedetails/play.dart';
import 'package:coffeebreak/components/gamedetails/profile.dart';
import 'package:coffeebreak/cosmetic/background.dart';
import 'package:coffeebreak/game_screen.dart';

import 'package:flutter/material.dart';

class GameDetailsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new GameDetailsState();
}

class GameDetailsState extends State<GameDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        decoration: Background.decoration(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: TabBarView(
            children: [ 
              PlayWidget(
                onNavigateToGameScreen: _navigateToPlayScreen,
              ),
              ProfileWidget()
            ],
          ),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.play_arrow)),
              Tab(icon: Icon(Icons.account_box)),
            ],
          ),
        )
      )
    );
  }

  _navigateToPlayScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameScreen()),
    );
  }
}