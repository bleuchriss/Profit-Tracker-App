//import statements
import 'package:flutter/material.dart';
import 'package:profitapp/sizeConfig.dart';

class AboutPage extends StatefulWidget {
  @override
  AboutPageState createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    //returns scaffold holding all the widgets
    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(children: [
        SizedBox(width: SizeConfig.safeBlockHorizontal * 17),
        Image.asset('assets/PRShoe.png', height: 150) //image asset for logo
      ]),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("About this App",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'BebasNeue', fontSize: 36)) //text variable
        ],
      ),
      SizedBox(height: 50), //spaces out widgets veritcally
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              "Chris' Profit Tracker is a Flutter app \ncreated by Christopher Singh. The app is",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'BebasNeue',
                  fontSize: SizeConfig.safeBlockHorizontal *
                      7)) // //text holding information
        ],
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
            " designed for resellers who are \nlooking for an organized way to track \ntheir inventory and profits.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'BebasNeue',
              fontSize: SizeConfig.safeBlockHorizontal * 7,
            )), //text holding information
      ]),
      SizedBox(height: 50), //spaces out widgets vertically
      RaisedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        shape: StadiumBorder(),
        color: Colors.purple[600],
        child: Text("     Back     ",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'BebasNeue',
            )),
      ), //raised button variable
    ])));
  }
}
