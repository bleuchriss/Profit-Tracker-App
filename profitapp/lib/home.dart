import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './inventoryPageFolder/inventoryPage.dart';
import './profitPageFolder/profitsPage.dart';
import './accountPageFolder/accountPage.dart';
import './loginPage.dart';
import './sizeConfig.dart';

class Home2Page extends StatefulWidget {
  final User user;

  const Home2Page({Key key, this.user}) : super(key: key);
  @override
  Home2PageState createState() => Home2PageState();
}

class Home2PageState extends State<Home2Page> {
  PageController pageController = PageController();

  List<Widget> screens = [InventoryPage(), ProfitPage(), AccountPage()];

  static int currentIndex = 0;

  final tabs = [
    Center(child: Text('Inventory')),
    Center(child: Text('Profits')),
    Center(child: Text('Profile')),
  ];

  void onTapped(int index) {
    if (index == 1) {
      ProfitPageState.overallProfit = 0;
      FirebaseFirestore.instance
          .collection('userData')
          .doc(LoginPageState.returnUID())
          .collection('profits')
          .get()
          .then((collection) {
        collection.docs.forEach((doc) {
          ProfitPageState.overallProfit += doc['difference'];
        });
        pageController.jumpToPage(index);
      });

      setState(() {
        ProfitPageState.overallProfit = ProfitPageState.overallProfit;
      });
    } else {
      pageController.jumpToPage(index);
    }
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  var inventory = BottomNavigationBarItem(
    icon: Icon(Icons.inventory,
        color: currentIndex == 0 ? Colors.blue : Colors.black),
    title: Text("Inventory",
        style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black,
            fontSize: SizeConfig.safeBlockVertical * 2)),
  );

  var profits = BottomNavigationBarItem(
    icon: Icon(Icons.attach_money,
        color: currentIndex == 1 ? Colors.blue : Colors.black),
    title: Text("Profits",
        style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black,
            fontSize: SizeConfig.safeBlockVertical * 2)),
  );

  var account = BottomNavigationBarItem(
    icon: Icon(
      Icons.person,
      color: currentIndex == 2 ? Colors.blue : Colors.black,
    ),
    title: Text("Account",
        style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black,
            fontSize: SizeConfig.safeBlockVertical * 2)),
  );
  
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        body: PageView(
          controller: pageController,
          children: screens,
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          currentIndex: currentIndex,
          iconSize: SizeConfig.safeBlockVertical * 4,
          type: BottomNavigationBarType.fixed,
          items: [
            inventory,
            profits,
            account,
          ],
          onTap: onTapped,
        ));
  }
}
