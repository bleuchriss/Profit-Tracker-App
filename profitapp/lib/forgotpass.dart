//import statements
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './sizeConfig.dart';

class ForgotPassword extends StatefulWidget {
  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  //creates an instance of firebase
  FirebaseAuth auth = FirebaseAuth.instance;

  //validator text
  String successText = "";

  //key for validator
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //text controller to receive user input
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //image asset variable for logo
    final logo = Image.asset('assets/PRShoe.png',
        width: SizeConfig.safeBlockHorizontal * 50,
        height: MediaQuery.of(context).viewInsets.bottom == 0.0
            ? SizeConfig.safeBlockVertical * 40
            : SizeConfig.safeBlockVertical * 25);

    //text field for email variable
    var emailField = TextFormField(
      controller: emailController,
      decoration: new InputDecoration(
          hintText: 'Email',
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please enter an email';
        }
        return null;
      },
    );

    //success text variable
    var success = Text(successText,
        style: TextStyle(
            color: successText == "Email does not exist, please try again"
                ? Colors.red
                : Colors.green));

    //variable for reset email button
    var sendEmailButton = RaisedButton(
      shape: StadiumBorder(),
      color: Colors.purple[600],
      onPressed: () async {
        try {
          await auth.sendPasswordResetEmail(email: emailController.text);
          setState(() {
            successText = 'Email successfully sent!';
          });
          emailController.clear();
        } on FirebaseAuthException catch (_) {
          setState(() {
            successText = "Email does not exist, please try again.";
            emailController.clear();
          });
        }
      },
      child: Text("      Send Reset Email      ",
          style: TextStyle(fontFamily: 'BebasNeue', fontSize: 24)),
    );

    //back button variable
    var backButton = RaisedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      shape: StadiumBorder(),
      color: Colors.purple[600],
      child: Text("            Back            ",
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'BebasNeue',
          )),
    );

//scaffold holding all widgets
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: SizeConfig.safeBlockVertical * 120,
        width: SizeConfig.safeBlockHorizontal * 120,
        child: Form(
            key: formKey,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    Row(children: [
                      SizedBox(width: SizeConfig.safeBlockHorizontal * 19),
                      logo
                    ]),
                    SizedBox(height: SizeConfig.safeBlockVertical),
                    emailField,
                    success,
                    SizedBox(height: SizeConfig.safeBlockVertical * 1),
                    Container(
                        alignment: Alignment.center,
                        child: Column(children: [sendEmailButton, backButton])),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
