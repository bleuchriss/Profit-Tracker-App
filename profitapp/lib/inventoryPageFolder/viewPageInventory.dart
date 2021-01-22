import './inventoryPage.dart';
import 'package:flutter/material.dart';

class ViewPage extends StatefulWidget {
  @override
  ViewPageState createState() => ViewPageState();
}

class ViewPageState extends State<ViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.black,
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
          RaisedButton(
            shape: StadiumBorder(),
            color: Colors.blue[300],
            child: Text('              Back              ',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'BebasNeue',
                )),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Text(InventoryPageState.itemName,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40, fontFamily: 'BebasNeue')),
          SizedBox(height: 25),
          Text(
              InventoryPageState.itemColor != null
                  ? 'Item Colorway: ' + InventoryPageState.itemColor
                  : 'Item Colorway: N/A ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'BebasNeue',
              )),
          SizedBox(height: 25),
          Text('Item Condition: ' + InventoryPageState.itemCondition,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'BebasNeue',
              )),
          SizedBox(height: 25),
          Text(
              InventoryPageState.itemLocation == null
                  ? 'Item Bought From: N/A'
                  : 'Item Bought From: ' + InventoryPageState.itemLocation,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'BebasNeue',
              )),
          SizedBox(height: 25),
          Text('Item Bought For: \$' + InventoryPageState.itemPrice.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'BebasNeue',
              )),
          SizedBox(height: 25),
          Text('Item Size: ' + InventoryPageState.itemSize,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'BebasNeue',
              )),
        ])));
  }
}
