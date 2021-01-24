//import statements
import 'package:profitapp/loginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './inventoryPage.dart';
import 'package:profitapp/sizeConfig.dart';

//pop up dialog class
class Dialogs {
  static information(BuildContext context) {
    //returns dialog widget with text and buttons inside
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
                  'Warning: Deleting this item will remove it permanently!',
                  style: (TextStyle(
                      fontFamily: 'BebasNeue',
                      fontSize: SizeConfig.safeBlockHorizontal * 7,
                      color: Colors.purple[600])),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.safeBlockHorizontal * 4),
                Column(children: [
                  SizedBox(height: SizeConfig.safeBlockHorizontal * 1),
                  //confirm button that deletes the item in the database
                  RaisedButton(
                      color: Colors.purple[600],
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
                  // cancel button that returns you back to the last screen
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
}
