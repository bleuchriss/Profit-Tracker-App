import 'package:profitapp/loginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './inventoryPage.dart';
import 'package:profitapp/sizeConfig.dart';

class Dialogs {
  static information(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Container(
              //width: SizeConfig.safeBlockHorizontal * 300,
              child: AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [],
              ),
            ),
            actions: [
              Column(children: [
                Text(
                  'Warning: Deleting this item will remove it permanently!',
                  style: (TextStyle(
                      fontFamily: 'BebasNeue',
                      fontSize: SizeConfig.safeBlockHorizontal * 7,
                      color: Colors.red)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.safeBlockHorizontal * 4),
                Column(children: [
                  SizedBox(height: SizeConfig.safeBlockHorizontal * 1),
                  RaisedButton(
                      color: Colors.red,
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await FirebaseFirestore.instance
                            .collection('userData')
                            .doc(LoginPageState.returnUID())
                            .collection('items')
                            .doc(InventoryPageState.doc_id)
                            .delete();
                      },
                      child: Text('     Confirm     ',
                          style: (TextStyle(
                              fontFamily: 'BebasNeue',
                              fontSize: SizeConfig.safeBlockHorizontal * 5,
                              color: Colors.black)))),
                  //SizedBox(width: SizeConfig.safeBlockHorizontal * 29),
                  RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel',
                          style: (TextStyle(
                              fontFamily: 'BebasNeue',
                              fontSize: SizeConfig.safeBlockHorizontal * 5,
                              color: Colors.black)))),
                ])
              ])
            ],
          ));
        });
  }

  static confirm(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Container(
              child: AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [],
              ),
            ),
            actions: [
              Column(children: [
                Text(
                  'Please verify your email or you will not be able to login!',
                  style: (TextStyle(
                      fontFamily: 'BebasNeue',
                      fontSize: SizeConfig.safeBlockHorizontal * 7,
                      color: Colors.red)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.safeBlockHorizontal * 4),
                Column(children: [
                  SizedBox(height: SizeConfig.safeBlockHorizontal * 1),
                  RaisedButton(
                      color: Colors.red,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('     Ok     ',
                          style: (TextStyle(
                              fontFamily: 'BebasNeue',
                              fontSize: SizeConfig.safeBlockHorizontal * 5,
                              color: Colors.black)))),
                  //SizedBox(width: SizeConfig.safeBlockHorizontal * 29),
                ])
              ])
            ],
          ));
        });
  }
}
