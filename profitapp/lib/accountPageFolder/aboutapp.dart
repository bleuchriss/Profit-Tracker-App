import 'package:flutter/material.dart';
import 'package:profitapp/sizeConfig.dart';

class AboutPage extends StatefulWidget {
  @override
  AboutPageState createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(children: [
        SizedBox(width: SizeConfig.safeBlockHorizontal * 17),
        Image.asset('assets/PRShoe.png', height: 150)
      ]),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("About this App",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'BebasNeue', fontSize: 36))
        ],
      ),
      SizedBox(height: 50),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              "Profit Runner is a Flutter app created by \nClifford Xing and Christopher Singh \nin 2020-2021. The app is",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'BebasNeue',
                  fontSize: SizeConfig.safeBlockHorizontal * 7))
        ],
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
            " designed for resellers who are \nlooking for an organized way to track \ntheir inventory and profits.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'BebasNeue',
              fontSize: SizeConfig.safeBlockHorizontal * 7,
            )),
      ]),
      SizedBox(height: 50),
      RaisedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        shape: StadiumBorder(),
        color: Colors.blue[300],
        child: Text("     Back     ",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'BebasNeue',
            )),
      ),
    ])));
  }
}
