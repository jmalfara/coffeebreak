import 'package:coffeebreak/game_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffeebreak',
      home: Container(
        decoration: BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            // // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0.0, 1.0],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              Colors.indigo[800],
              Colors.indigo[300]
            ],
          ),
        ),
        child: LoginBody()
      )
    );
  }
}

class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = false;
    checkUserLoginStatusAndNavigate();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screenWidgets = <Widget>[
      // TODO Figure out why this is red with a underline
      Padding (
        padding: EdgeInsets.only(bottom: 32),
        child: Text("Coffeebreak")
      )
    ];

    if (isLoading) {
      screenWidgets.addAll(renderLoadingIndicator());
    } else {
      screenWidgets.addAll(renderLoginOptions());
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: screenWidgets
    );
  }

  List<Widget> renderLoadingIndicator() {
    return <Widget> [
      CircularProgressIndicator()
    ];
  }

  List<Widget> renderLoginOptions() {
    return <Widget> [
      SignInButton(
        Buttons.Google,
        text: "Sign in with Google",
        onPressed: _loginWithGoogle,
      ),
    ];
  }

  void _loginWithGoogle() async {
    _googleSignIn.signOut();
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    
    setState(() {
     isLoading = true; 
    });

    await _auth.signInWithCredential(credential);
    checkUserLoginStatusAndNavigate();
  }

  void checkUserLoginStatusAndNavigate() {
    _auth.currentUser().then((user) {
      if (user == null) {
        setState(() {
          isLoading = false; 
        });
      } else {
        print("Already Logged in");
        print(user);
        // Navigate to the next screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => GameDetailsRoute()),
        );
      }
    });
  }
}
