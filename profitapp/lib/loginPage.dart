import 'package:flutter/material.dart';
import './home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './forgotpass.dart';
import './sizeConfig.dart';

class LoginPage extends StatefulWidget {
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  static String uid;

  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<String> getCurrentUID() async {
    uid = await _auth.currentUser.uid;
    return uid;
  }

  static String returnUID() {
    uid = _auth.currentUser.uid;
    return uid;
  }

  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  static var emailValue = '';
  var errorTextPass;

  @override
  Widget build(BuildContext ctx) {
    SizeConfig().init(ctx);
    void _signInWithEmailAndPassword() async {
      try {
        setState(() {
          errorTextPass = null;
        });
        final User user = (await _auth.signInWithEmailAndPassword(
          email: email.text,
          password: pass.text,
        ))
            .user;
        if (!user.emailVerified) {
          await user.sendEmailVerification();
        }
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          return Home2Page(
            user: user,
          );
        }));
      } catch (e) {
        setState(() {
          errorTextPass = 'Incorrect Password or Email or Not Verified';
        });
      }
    }
    
    final emailField = TextFormField(
        obscureText: false,
        controller: email,
        decoration: new InputDecoration(
            hintText: "Enter your email",
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    
    final passField = TextFormField(
        obscureText: true,
        controller: pass,
        keyboardType: TextInputType.text,
        decoration: new InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            errorText: errorTextPass,
            hintText: "Enter your password",
            fillColor: Colors.white,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    
    final logo = Image.asset('assets/PRShoe.png',
        width: SizeConfig.safeBlockHorizontal * 50,
        height: MediaQuery.of(context).viewInsets.bottom == 0.0
            ? SizeConfig.safeBlockVertical * 50
            : SizeConfig.safeBlockVertical * 25);

    var signInButton = RaisedButton(
      onPressed: () async {
        _signInWithEmailAndPassword();
        Home2PageState.currentIndex = 0;
      },
      shape: StadiumBorder(),
      color: Colors.blue[300],
      child: Text("            Login            ",
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'BebasNeue',
          )),
    );

    var forgotPasswordButton = RaisedButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ForgotPassword()));
      },
      shape: StadiumBorder(),
      color: Colors.blue[300],
      child: Text("Forgot Password?",
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'BebasNeue',
          )),
    );

    var backButton = RaisedButton(
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
            //if viewInsets.bottom == 1;
            height: SizeConfig.safeBlockVertical * 120,
            width: SizeConfig.safeBlockHorizontal * 120,
            color: Colors.white,
            child: Column(children: [
              Row(children: [
                SizedBox(width: SizeConfig.safeBlockHorizontal * 19),
                logo
              ]),
              emailField,
              SizedBox(
                height: SizeConfig.safeBlockVertical * 2,
              ),
              passField,
              SizedBox(height: SizeConfig.safeBlockVertical * 2),
              signInButton,
              forgotPasswordButton,
              backButton,
              Spacer(flex: 20)
            ])));
  }
}
