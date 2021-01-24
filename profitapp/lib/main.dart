import './loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './sizeConfig.dart';
import './home.dart';
import './signUpPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize firebase
  Firebase.initializeApp();
  // run the app
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage()); // returns the home page
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Widget build(BuildContext ctx) {
    // sets an only portrait orientation
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // call the SizeConfig initilization
    SizeConfig().init(ctx);
    // logo image variable
    final logo = Image.asset('assets/PRLOGO.png',
        height: SizeConfig.safeBlockVertical * 70,
        width: SizeConfig.safeBlockHorizontal * 75);

    // login button variables
    final loginButton = RaisedButton(
        shape: StadiumBorder(),
        color: Colors.purple[600],
        child: Text('                  Login                  ',
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'BebasNeue',
            )),
        onPressed: () {
          FirebaseAuth.instance.authStateChanges().listen((User user) {
            if (user == null) {
              Navigator.of(ctx)
                  .push(MaterialPageRoute(builder: (context) => LoginPage()));
            } else {
              Navigator.of(ctx)
                  .push(MaterialPageRoute(builder: (context) => Home2Page()));
            }
          });
        });

    // sign up button variable
    final signUpButton = RaisedButton(
        shape: StadiumBorder(),
        color: Colors.purple[600],
        child: Text('         Account Setup         ',
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'BebasNeue',
            )),
        onPressed: () {
          Navigator.of(ctx)
              .push(MaterialPageRoute(builder: (context) => Register()));
        });

    return Scaffold(
        body: Container(
            height: SizeConfig.safeBlockVertical * 120,
            width: SizeConfig.safeBlockHorizontal * 120,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/particles.gif'), // uses the particles gif
                    fit: BoxFit.cover)),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(children: [
                SizedBox(width: 100),
                logo
              ]), // puts the logo in a row
              Spacer(flex: 2),
              loginButton, // login button
              SizedBox(height: SizeConfig.safeBlockVertical * 1),
              signUpButton, // sign up button
              Spacer(flex: 10)
            ])));
  }
}
