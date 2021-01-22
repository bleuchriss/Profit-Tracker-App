import './inventoryPage.dart';
import 'package:profitapp/loginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:profitapp/item.dart';
import 'package:profitapp/sizeConfig.dart';
import 'package:flutter/services.dart';

class SellPopUp extends StatefulWidget {
  @override
  SellPopUpState createState() => SellPopUpState();
}

class SellPopUpState extends State<SellPopUp> {
  //final double sellValue = 0;
  static double soldFor;
  static final TextEditingController sellValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Column(children: [
          SizedBox(height: SizeConfig.safeBlockVertical * 35),
          Text('Sold For:',
              style: TextStyle(fontFamily: 'BebasNeue', fontSize: 35)),
          SizedBox(height: 20),
          TextFormField(
              controller: sellValue,
              inputFormatters: [LengthLimitingTextInputFormatter(6)],
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "ex. 430",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)))),
          SizedBox(height: 50),
          RaisedButton(
            onPressed: () async {
              final uid = LoginPageState.returnUID();
              soldFor = double.parse(sellValue.text);

              var item = new Item(
                  InventoryPageState.itemName.toString(),
                  double.parse(InventoryPageState.itemPrice),
                  InventoryPageState.itemLocation.toString(),
                  InventoryPageState.itemCondition.toString(),
                  InventoryPageState.itemSize.toString(),
                  InventoryPageState.itemColor.toString(),
                  soldFor,
                  (soldFor - double.parse(InventoryPageState.itemPrice)));

              await FirebaseFirestore.instance
                  .collection('userData')
                  .doc(uid)
                  .collection('items')
                  .doc(InventoryPageState.doc_id)
                  .delete();

              FirebaseFirestore.instance
                  .collection('userData')
                  .doc(uid)
                  .collection('profits')
                  .add(item.toJson());
              Navigator.of(context).pop();
              sellValue.clear();
            },
            color: Colors.green,
            shape: StadiumBorder(),
            child: Text("Sell Item",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'BebasNeue',
                )),
          ),
          RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: Colors.blue[300],
              shape: StadiumBorder(),
              child: Text('   Back   ',
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'BebasNeue',
                  ))),
        ])));
  }
}
