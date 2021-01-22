import 'package:flutter/material.dart';
import './sizeConfig.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './home.dart';

class EmailVerify extends StatefulWidget {
  @override
  EmailVerifyState createState() => EmailVerifyState();
}

class EmailVerifyState extends State<EmailVerify> {
  String errorText = "";
  @override
  Widget build(BuildContext context) {
    final verify = Text("Verify Email Address",
        style: (TextStyle(fontSize: 40, fontFamily: 'BebasNeue')));

    var sendVerificationEmail = RaisedButton(
      onPressed: () async {
        final currentUser = FirebaseAuth.instance.currentUser;
        await currentUser.sendEmailVerification();
      },
      shape: StadiumBorder(),
      color: Colors.blue[300],
      child: Text("Resend Email Verification",
          style: TextStyle(
            fontSize: SizeConfig.textScaleFactor * 20,
            fontFamily: 'BebasNeue',
          )),
    );

    var nextButton = RaisedButton(
      onPressed: () {
        var user = FirebaseAuth.instance.currentUser;
        user.reload();
        if (user.emailVerified) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Home2Page()));
        } else {
          setState(() {
            errorText = "Your email has not been verified yet!";
          });
        }
      },
      shape: StadiumBorder(),
      color: Colors.blue[300],
      child: Text("Next",
          style: TextStyle(
            fontSize: SizeConfig.textScaleFactor * 20,
            fontFamily: 'BebasNeue',
          )),
    );

    var errorField = Text(errorText,
        style: (TextStyle(
            fontSize: 20, color: Colors.red, fontFamily: 'BebasNeue')));
    
    return Scaffold(
        body: Container(
            height: SizeConfig.safeBlockVertical * 120,
            width: SizeConfig.safeBlockHorizontal * 120,
            child: Column(children: [
              SizedBox(height: SizeConfig.safeBlockVertical * 40),
              verify,
              sendVerificationEmail,
              nextButton,
              errorField
            ])));
  }
}
