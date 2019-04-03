import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateEmailWidget extends StatefulWidget {
  final FirebaseUser user;
  final Function onRefreshUser;
  final Function onLogout;

  const UpdateEmailWidget({key, this.user, this.onRefreshUser, this.onLogout}) : super(key: key);

  @override
  _UpdateEmailWidgetState createState() => _UpdateEmailWidgetState();
}

class _UpdateEmailWidgetState extends State<UpdateEmailWidget> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Card(
        child: TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.link),
            labelText: "Payment Email"
          ),
          keyboardType: TextInputType.emailAddress,
          maxLines: 1,
          initialValue: widget.user.email,
          onFieldSubmitted: showEmailConfirmation,
        )
      )
    );
  }

  showLoginDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Authentication Required"),
          content: new Text("Reauthentication is required to change your email. Please re-login in and try again."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Login Again"),
              onPressed: () {
                widget.onLogout();
              },
            ),
          ],
        );
      },
    );
  }

  showEmailConfirmation(String email) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm Email Update"),
          content: new Text("Confirming will update the email used for payouts. Do you want to continue?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Update"),
              onPressed: () {
                Navigator.of(context).pop();
                _onUpdateEmail(email);
              },
            ),
          ],
        );
      },
    );
  }

  _onUpdateEmail(String email) async {
    if (widget.user != null) {
      try {
        await widget.user.updateEmail(email);
      } catch (e) {
        Text text;
        if (e.code == "ERROR_INVALID_EMAIL") {
           text = Text("Invalid. Please use a different email address.");
        } if (e.code == "ERROR_REQUIRES_RECENT_LOGIN") {
           // Reqires reauth.
           showLoginDialog();
           return;
        } else {
           text = Text("Something went wrong. Please try again later.");
        }
        Scaffold.of(context).showSnackBar(new SnackBar(content: text));
      }
    }
    print("Refresh");
    widget.onRefreshUser();
  }
}