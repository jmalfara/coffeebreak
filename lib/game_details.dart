
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String GAME_DETAILS_URL = "http://localhost:5000/coffeebreak-36ca9/us-central1/next_game";

class GameDetailsRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new GameDetailsState();
}

class GameDetailsState extends State<GameDetailsRoute> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetch Data JSON"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RaisedButton(
            child: new Text("Fetch Data"),
            onPressed: () => _fetchData(),
          ),
      ),
      body: Container(),
    );
  }

  _fetchData() async {
    print("Fetching Data");

    setState(() {
      isLoading = true;
    });
    print(GAME_DETAILS_URL);
    final response = await http.get(GAME_DETAILS_URL);
    if (response.statusCode == 200) {
      // list = json.decode(response.body) as List
      print(response.body);

      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }
}