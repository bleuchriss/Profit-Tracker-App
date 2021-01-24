//import statements
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
  //sold for variable
  static double soldFor;

  //text editing controller for amount sold for
  static final TextEditingController sellValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //text variable
    var soldForText = Text('Sold For:',
        style: TextStyle(fontFamily: 'BebasNeue', fontSize: 35));

    //sold for text field variable
    var sellValueField = TextFormField(
        controller: sellValue,
        inputFormatters: [LengthLimitingTextInputFormatter(6)],
        keyboardType: TextInputType.number,
        decoration: new InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "ex. 430",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    //sell button variable
    var sellButton = RaisedButton(
      onPressed: () async {
        final uid = LoginPageState.returnUID();
        soldFor = double.parse(sellValue.text);

        //creates an instance of item class and passes data into it
        var item = new Item(
            InventoryPageState.itemName.toString(),
            double.parse(InventoryPageState.itemPrice),
            InventoryPageState.itemLocation.toString(),
            InventoryPageState.itemCondition.toString(),
            InventoryPageState.itemSize.toString(),
            InventoryPageState.itemColor.toString(),
            soldFor,
            (soldFor - double.parse(InventoryPageState.itemPrice)));

        //deletes item from firebase items section
        await FirebaseFirestore.instance
            .collection('userData')
            .doc(uid)
            .collection('items')
            .doc(InventoryPageState.doc_id)
            .delete();

        //adds item to firebase profits section
        FirebaseFirestore.instance
            .collection('userData')
            .doc(uid)
            .collection('profits')
            .add(item.toJson());

        //returns user back to inventory page
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
    );

    //raised button variable
    var backButton = RaisedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        color: Colors.purple[600],
        shape: StadiumBorder(),
        child: Text('   Back   ',
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'BebasNeue',
            )));

    //scaffold holding all widgets
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Column(children: [
          SizedBox(height: SizeConfig.safeBlockVertical * 35),
          soldForText,
          SizedBox(height: 20),
          sellValueField,
          SizedBox(height: 50),
          sellButton,
          backButton
        ])));
  }
}
