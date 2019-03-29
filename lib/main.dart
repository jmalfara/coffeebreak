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
      home:Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo Home Page')
        ),
        body: LoginBody(),
      )
    );
  }
}

class LoginBody extends StatefulWidget {
  LoginBody({Key key}) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Widget> _widgets = <Widget> [ CircularProgressIndicator() ];

  @override
  void initState() {
    super.initState();

    _auth.currentUser().then((user) {
      if (user == null) {
        setState(() {
          _widgets = renderLoginOptions();
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

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _widgets
        ),
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

    print(credential);

    final FirebaseUser user = await _auth.signInWithCredential(credential);

    print(user);
  }
}
