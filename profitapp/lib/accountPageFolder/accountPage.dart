import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './changepassword.dart';
import './aboutapp.dart';
import 'package:profitapp/sizeConfig.dart';
import 'package:profitapp/main.dart';

class AccountPage extends StatefulWidget {
  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(children: [
          SizedBox(height: SizeConfig.safeBlockVertical * 5),
          Image.asset('assets/profileicon.png',
              height: SizeConfig.blockSizeVertical * 15),
          Text(currentUser.displayName + "\'s account",
              style: TextStyle(
                  fontFamily: 'BebasNeue',
                  fontSize: SizeConfig.blockSizeVertical * 4,
                  color: Colors.black)),
          SizedBox(height: SizeConfig.safeBlockHorizontal * 10),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ChangePassword()));
            },
            shape: StadiumBorder(),
            color: Colors.blue[300],
            child: Text("      Change Password      ",
                style: TextStyle(
                  fontSize: SizeConfig.blockSizeVertical * 3,
                  color: Colors.black,
                  fontFamily: 'BebasNeue',
                )),
          ),
          SizedBox(height: SizeConfig.safeBlockHorizontal * 4),
          RaisedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AboutPage()));
            },
            shape: StadiumBorder(),
            color: Colors.blue[300],
            child: Text("      About this App      ",
                style: TextStyle(
                  fontSize: SizeConfig.blockSizeVertical * 3,
                  color: Colors.black,
                  fontFamily: 'BebasNeue',
                )),
          ),
          SizedBox(height: SizeConfig.safeBlockHorizontal * 4),
          RaisedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage()));
            },
            shape: StadiumBorder(),
            color: Colors.blue[300],
            child: Text("      Sign Out      ",
                style: TextStyle(
                  fontSize: SizeConfig.blockSizeVertical * 3,
                  color: Colors.black,
                  fontFamily: 'BebasNeue',
                )),
          ),
        ])));
  }
}
