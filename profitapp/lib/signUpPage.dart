import './home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './sizeConfig.dart';
import './emailVerifyPage.dart';

class Register extends StatefulWidget {
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController displayName = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordCheckController = TextEditingController();
  var errorTextSignUp;
  bool isSuccess;
  String userEmail;

  @override
  Widget build(BuildContext context) {
    void _registerAccount() async {
      final User user = (await auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ))
          .user;

      if (user != null) {
        if (!user.emailVerified) {
          await user.sendEmailVerification();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => EmailVerify()));
          await user.updateProfile(displayName: displayName.text);
        } else {
          final user1 = auth.currentUser;
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => Home2Page(
                    user: user1,
                  )));
        }
      } else {
        isSuccess = false;
      }
    }
   
    final logo = Image.asset('assets/PRShoe.png',
        width: SizeConfig.safeBlockHorizontal * 50,
        height: MediaQuery.of(context).viewInsets.bottom == 0.0
            ? SizeConfig.safeBlockVertical * 30
            : SizeConfig.safeBlockVertical * 15);

    var displayNameField = TextFormField(
      controller: displayName,
      decoration: new InputDecoration(
          hintText: 'Display Name',
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please enter a display name';
        }
        return null;
      },
    );

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

    var passwordField = TextFormField(
      controller: passwordController,
      decoration: new InputDecoration(
          hintText: 'Password (Must be 6 or more characters)',
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          errorText: errorTextSignUp,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a password';
        }
        return null;
      },
      obscureText: true,
    );

    var passwordCheckField = TextFormField(
      controller: passwordCheckController,
      obscureText: true,
      decoration: new InputDecoration(
          hintText: 'Re-enter the same password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          errorText: errorTextSignUp,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please re-enter the password';
        }
        return null;
      },
    );

    final createAccountButton = RaisedButton(
      shape: StadiumBorder(),
      color: Colors.blue[300],
      child: Text("        Create Account        ",
          style: TextStyle(fontFamily: 'BebasNeue', fontSize: 24)),
      onPressed: () async {
        setState(() {
          errorTextSignUp = null;
          if (passwordController.text != passwordCheckController.text) {
            errorTextSignUp = 'Passwords don\'t match';
          }
          if (passwordController.text.length < 6) {
            setState(() {
              errorTextSignUp = 'Password must be 6 characters or longer';
            });
          }
        });

        if (formKey.currentState.validate() &&
            passwordController.text == passwordCheckController.text) {
          try {
            _registerAccount();
          } on FirebaseAuthException catch (e) {
            setState(() {
              errorTextSignUp = 'Failed to register account';
            });
          }
        }
      },
    );

    final backButton = RaisedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      shape: StadiumBorder(),
      color: Colors.blue[300],
      child: Text("            Back            ",
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'BebasNeue',
          )),
    );

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
                      SizedBox(width: SizeConfig.safeBlockHorizontal * 13),
                      logo
                    ]),
                    displayNameField,
                    SizedBox(height: SizeConfig.safeBlockVertical),
                    emailField,
                    SizedBox(height: SizeConfig.safeBlockVertical * 1),
                    passwordField,
                    SizedBox(height: SizeConfig.safeBlockVertical),
                    passwordCheckField,
                    SizedBox(height: SizeConfig.safeBlockVertical * 1),
                    Container(
                        alignment: Alignment.center,
                        child: Column(
                            children: [createAccountButton, backButton])),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
