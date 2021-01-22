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
  Firebase.initializeApp();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Widget build(BuildContext ctx) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SizeConfig().init(ctx);

    final logo = Image.asset('assets/PRLOGO.png',
        height: SizeConfig.safeBlockVertical * 70,
        width: SizeConfig.safeBlockHorizontal * 98);

    final loginButton = RaisedButton(
        shape: StadiumBorder(),
        color: Colors.blue[300],
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

    final signUpButton = RaisedButton(
        shape: StadiumBorder(),
        color: Colors.blue[300],
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
                    image: AssetImage('assets/particles.gif'),
                    fit: BoxFit.cover)),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(children: [logo]),
              Spacer(flex: 2),
              loginButton,
              SizedBox(height: SizeConfig.safeBlockVertical * 1),
              signUpButton,
              Spacer(flex: 10)
            ])));
  }
}
