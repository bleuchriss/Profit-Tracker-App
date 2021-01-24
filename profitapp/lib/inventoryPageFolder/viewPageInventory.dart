//import statements
import './inventoryPage.dart';
import 'package:flutter/material.dart';

class ViewPage extends StatefulWidget {
  @override
  ViewPageState createState() => ViewPageState();
}

class ViewPageState extends State<ViewPage> {
  @override
  Widget build(BuildContext context) {
    // back button variable
    var backButton = RaisedButton(
        shape: StadiumBorder(),
        color: Colors.purple[600],
        child: Text('              Back              ',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'BebasNeue',
            )),
        onPressed: () {
          Navigator.of(context).pop();
        });
    // item name text variable
    var itemNameText = Text(InventoryPageState.itemName,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 40, fontFamily: 'BebasNeue'));
    // item color text variable
    var itemColorText = Text(
        InventoryPageState.itemColor != null
            ? 'Item Colorway: ' + InventoryPageState.itemColor
            : 'Item Colorway: N/A ',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontFamily: 'BebasNeue',
        ));

    //item condition text variable
    var itemCondText =
        Text('Item Condition: ' + InventoryPageState.itemCondition,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'BebasNeue',
            ));
    //item location text variable
    var itemLocationText = Text(
        InventoryPageState.itemLocation == null
            ? 'Item Bought From: N/A'
            : 'Item Bought From: ' + InventoryPageState.itemLocation,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontFamily: 'BebasNeue',
        ));

    //item price text variable
    var itemPriceText =
        Text('Item Bought For: \$' + InventoryPageState.itemPrice.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'BebasNeue',
            ));

    //item size text variable
    var itemSizeText = Text('Item Size: ' + InventoryPageState.itemSize,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontFamily: 'BebasNeue',
        ));

    //scaffold holding all widgets
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
          backButton,
          itemNameText,
          SizedBox(height: 25),
          itemColorText,
          SizedBox(height: 25),
          itemCondText,
          SizedBox(height: 25),
          itemLocationText,
          SizedBox(height: 25),
          itemPriceText,
          SizedBox(height: 25),
          itemSizeText
        ])));
  }
}
