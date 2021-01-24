//import statements
import 'package:flutter/material.dart';
import './sizeConfig.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './home.dart';

class EmailVerify extends StatefulWidget {
  @override
  EmailVerifyState createState() => EmailVerifyState();
}

class EmailVerifyState extends State<EmailVerify> {
  //error text variable
  String errorText = "";
  @override
  Widget build(BuildContext context) {
    //verify text variable
    final verify = Text("Verify Email Address",
        style: (TextStyle(fontSize: 40, fontFamily: 'BebasNeue')));

    //button to resend email verification variable
    var sendVerificationEmail = RaisedButton(
      onPressed: () async {
        final currentUser = FirebaseAuth.instance.currentUser;
        await currentUser.sendEmailVerification();
      },
      shape: StadiumBorder(),
      color: Colors.purple[600],
      child: Text("Resend Email Verification",
          style: TextStyle(
            fontSize: SizeConfig.textScaleFactor * 20,
            fontFamily: 'BebasNeue',
          )),
    );

    //button to push to inventory page if email verified variable
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
      color: Colors.purple[600],
      child: Text("Next",
          style: TextStyle(
            fontSize: SizeConfig.textScaleFactor * 20,
            fontFamily: 'BebasNeue',
          )),
    );

    //error text variable
    var errorField = Text(errorText,
        style: (TextStyle(
            fontSize: 20, color: Colors.red, fontFamily: 'BebasNeue')));

    //scaffold holding all widgets
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
