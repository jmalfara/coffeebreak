import 'package:coffeebreak/cosmetic/background.dart';
import 'package:coffeebreak/cosmetic/text/white_title.dart';
import 'package:coffeebreak/game_details_screen.dart';
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
      home: LoginScreen()
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
      Padding (
        padding: EdgeInsets.only(bottom: 32),
        child: WhiteTitleText(text: "Coffeebreak")
      )
    ];

    if (isLoading) {
      screenWidgets.addAll(renderLoadingIndicator());
    } else {
      screenWidgets.addAll(renderLoginOptions());
    }

    return Container(
      decoration: Background.decoration(),
      child: Scaffold (
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: screenWidgets
          )
        )
      )
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
          MaterialPageRoute(builder: (context) => GameDetailsScreen()),
        );
      }
    });
  }
}
