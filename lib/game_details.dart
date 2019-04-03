
import 'dart:convert';
import 'package:coffeebreak/components/gamedetails/play.dart';
import 'package:coffeebreak/components/gamedetails/profile.dart';
import 'package:coffeebreak/components/gamedetails/wallet.dart';
import 'package:coffeebreak/cosmetic/background.dart';

import 'package:coffeebreak/dto/NextGame.dart';
import 'package:coffeebreak/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String GAME_DETAILS_URL = "https://us-central1-coffeebreak-36ca9.cloudfunctions.net/upcoming";

class GameDetailsRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new GameDetailsState();
}

class GameDetailsState extends State<GameDetailsRoute> {
  bool isLoading;
  bool isLoadingUser;
  int statusCode;
  NextGame nextGame;
  int currentTabIndex;
  FirebaseUser user;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    isLoading = true;
    statusCode = 0;
    nextGame = null;
    currentTabIndex = 0;
    _fetchNextGame();
    _fetchCurrentFirebaseUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Background.decoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: _getCurrentTab(currentTabIndex)
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.play_arrow), title: Text('Play')),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), title: Text('Wallet')),
            BottomNavigationBarItem(icon: Icon(Icons.account_box), title: Text('Account')),
          ],
          currentIndex: 0,
          fixedColor: Colors.deepPurple,
          onTap: _onBottomBarItemTapped,
        )
      )
    );
  }

  void _onBottomBarItemTapped(int index) {
    setState(() {
     currentTabIndex = index; 
    });
  }

  _getCurrentTab(int index) {
    Widget _selectedTab;
    if (index == 0) {
      _selectedTab = PlayWidget(
          isLoading: this.isLoading, 
          nextGame: this.nextGame, 
          statusCode: this.statusCode, 
          requestFetchNextGame: this._fetchNextGame
        );
    } else if (index == 1) {
      _selectedTab = WalletWidget();
    } else if (index == 2) {
      _selectedTab = ProfileWidget(
          isLoading: this.isLoadingUser,
          user: this.user,
          onLogout: this._logoutUser,
          onRefreshUser: this._fetchCurrentFirebaseUser,
        );
    }
    return _selectedTab;
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

  _fetchCurrentFirebaseUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    setState(() {
      isLoadingUser = true;
    });

    FirebaseUser _user = await _auth.currentUser();

    setState(() {
     isLoadingUser = false;
     user = _user; 
    });
  }

  _logoutUser() {
    _auth.signOut();
    
    // Navigate to the next screen
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginBody()));
  }
}