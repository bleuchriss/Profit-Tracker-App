//import statements
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
  //creates instance of firebase
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    //returns scaffold holding all the widgets
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(children: [
          SizedBox(
              height: SizeConfig.safeBlockVertical *
                  5), //spaces out widgets vertically
          Image.asset('assets/profileicon.png',
              height: SizeConfig.blockSizeVertical *
                  15), //image asset widget holding logo
          Text(currentUser.displayName + "\'s account",
              style: TextStyle(
                  fontFamily: 'BebasNeue',
                  fontSize: SizeConfig.blockSizeVertical * 4,
                  color: Colors.black)), //text widget
          SizedBox(
              height: SizeConfig.safeBlockHorizontal *
                  10), ////spaces out widgets vertically
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ChangePassword()));
            },
            shape: StadiumBorder(),
            color: Colors.purple[600],
            child: Text("      Change Password      ",
                style: TextStyle(
                  fontSize: SizeConfig.blockSizeVertical * 3,
                  color: Colors.black,
                  fontFamily: 'BebasNeue',
                )),
          ), //change password button variable
          SizedBox(
              height: SizeConfig.safeBlockHorizontal *
                  4), //spaces out widgets vertically
          RaisedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AboutPage()));
            },
            shape: StadiumBorder(),
            color: Colors.purple[600],
            child: Text("      About this App      ",
                style: TextStyle(
                  fontSize: SizeConfig.blockSizeVertical * 3,
                  color: Colors.black,
                  fontFamily: 'BebasNeue',
                )),
          ), //about this app button variable
          SizedBox(
              height: SizeConfig.safeBlockHorizontal *
                  4), //spaces out widgets vertically
          RaisedButton(
            onPressed: () async {
              await FirebaseAuth.instance
                  .signOut(); //signs user out of firebase
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      HomePage())); //pushes user back to home page
            },
            shape: StadiumBorder(),
            color: Colors.purple[600],
            child: Text("      Sign Out      ",
                style: TextStyle(
                  fontSize: SizeConfig.blockSizeVertical * 3,
                  color: Colors.black,
                  fontFamily: 'BebasNeue',
                )),
          ), //sign out button variable
        ])));
  }
}
