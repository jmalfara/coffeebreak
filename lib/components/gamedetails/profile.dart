import 'package:coffeebreak/components/gamedetails/profile/update_email.dart';
import 'package:coffeebreak/cosmetic/text/white_subtitle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileWidget extends StatelessWidget {
  final FirebaseUser user;
  final bool isLoading;
  final Function onLogout;
  final Function onRefreshUser;

  const ProfileWidget({Key key, this.user, this.isLoading, this.onLogout, this.onRefreshUser});

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
          UpdateEmailWidget(onRefreshUser: onRefreshUser, onLogout: onLogout, user: user)
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
      child: WhiteSubtitleText(user.displayName)
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
            onPressed: onLogout,
          )
        ],
      )
    );
  }
}
