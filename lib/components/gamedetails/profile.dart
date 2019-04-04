import 'package:coffeebreak/components/gamedetails/profile/update_email.dart';
import 'package:coffeebreak/cosmetic/text/white_subtitle.dart';
import 'package:coffeebreak/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileWidget extends StatefulWidget {

  const ProfileWidget({ Key key }) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> with AutomaticKeepAliveClientMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  FirebaseUser user;
  
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _fetchCurrentFirebaseUser();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SafeArea(
        child: CircularProgressIndicator()
      );
    }

    return SafeArea(
      child: Column(
        children: <Widget> [
          renderRoundImage(),
          renderDisplayName(),
          renderLoggoutChip(),
          UpdateEmailWidget(onRefreshUser: _fetchCurrentFirebaseUser, onLogout: _logoutUser, user: user)
        ]
      )
    );
  }

  Widget renderRoundImage() {
    double diameter = 100;
    return Padding(
      padding: EdgeInsets.only(top: 60),
      child: Container(
        width: diameter,
        height: diameter,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
            fit: BoxFit.fill,
            image:  NetworkImage(
              user.photoUrl
            )
          )
        )
      )
    );
  }

  Widget renderDisplayName() {
    return Padding(
      padding: EdgeInsets.all(16), 
      child: WhiteSubtitleText(text: user.displayName)
    );
  }

  Widget renderLoggoutChip() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ActionChip(
            avatar: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.keyboard_return),
            ),
            label: Text('Logout'),
            onPressed: _logoutUser,
          )
        ],
      )
    );
  }

  _fetchCurrentFirebaseUser() async {
    setState(() {
      isLoading = true;
    });

    FirebaseUser _user = await _auth.currentUser();

    setState(() {
     isLoading = false;
     user = _user; 
    });

    print("Loaded User");
  }

  _logoutUser() {
    _auth.signOut();
    
    // Navigate to the next screen
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
