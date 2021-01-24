//import statements
import 'package:profitapp/loginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './addInventory.dart';
import './sellPopup.dart';
import './viewPageInventory.dart';
import './confirmPopUp.dart';
import 'package:profitapp/sizeConfig.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InventoryPage extends StatefulWidget {
  @override
  InventoryPageState createState() => InventoryPageState();
}

class InventoryPageState extends State<InventoryPage> {
  static var doc_id;
  static String itemName;
  static String itemColor;
  static String itemCondition;
  static String itemLocation;
  static String itemPrice;
  static String itemSize;
  var user = FirebaseAuth.instance.currentUser;
  Widget build(BuildContext context) {
    var inventoryText = Text('Inventory',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'BebasNeue',
            fontSize: SizeConfig.screenHeight * 0.050,
            color: Colors.purple[600]));

    final addButton = RaisedButton(
        shape: StadiumBorder(),
        color: Colors.purple[600],
        child: Text('              Add New Item              ',
            style: TextStyle(
              fontSize: SizeConfig.screenHeight * 0.030,
              fontFamily: 'BebasNeue',
            )),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddInventoryPage()));
        });

    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: null,
        body: ListView(children: [
          inventoryText,
          addButton,
          SizedBox(height: SizeConfig.screenHeight * 0.002),
          Container(
              height: SizeConfig.screenHeight * 0.7225,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("userData")
                      .doc(LoginPageState.returnUID())
                      .collection('items')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView(
                        children: snapshot.data.docs.map((document) {
                          // sell button variable that move the current item to
                          // profits page and removes it from the inventory page
                          var sellButton = RaisedButton(
                            onPressed: () async {
                              itemName = document['itemName'].toString();

                              itemColor = document['itemColor'].toString();

                              itemLocation =
                                  document['itemLocation'].toString();
                              itemPrice =
                                  document['itemPrice'].toStringAsFixed(2);
                              itemSize = document['itemSize'].toString();
                              itemCondition =
                                  document['itemCondition'].toString();
                              doc_id = document.id;

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SellPopUp()));
                            },
                            color: Colors.blue[600],
                            child: Text("       Sell       ",
                                style: TextStyle(
                                    fontSize: SizeConfig.safeBlockVertical * 3,
                                    fontFamily: 'BebasNeue',
                                    color: Colors.black)),
                          );

                          // view button that shows the current item in more detail
                          var viewButton = RaisedButton(
                            onPressed: () {
                              itemCondition =
                                  document['itemCondition'].toString();
                              itemName = document['itemName'].toString();

                              itemColor = document['itemColor'].toString();

                              itemLocation =
                                  document['itemLocation'].toString();
                              itemPrice =
                                  document['itemPrice'].toStringAsFixed(2);
                              itemSize = document['itemSize'].toString();

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ViewPage()));
                            },
                            color: Colors.purple[600],
                            child: Text("       View       ",
                                style: TextStyle(
                                    fontSize: SizeConfig.safeBlockVertical * 3,
                                    fontFamily: 'BebasNeue',
                                    color: Colors.black)),
                          );

                          //delete button that shows the confirm delete dialog
                          var deleteButton = RaisedButton(
                            onPressed: () {
                              Dialogs.information(context);

                              doc_id = document.id;
                            },
                            color: Colors.indigo[600],
                            child: Text("     Delete     ",
                                style: TextStyle(
                                    fontSize: SizeConfig.safeBlockVertical * 3,
                                    fontFamily: 'BebasNeue',
                                    color: Colors.black)),
                          );
                          // text variables with formatting
                          var itemNameText = Text(
                            document['itemName'].length > 12
                                ? document['itemName'].substring(0, 9) + '...'
                                : document['itemName'],
                            style: TextStyle(
                              fontFamily: 'BebasNeue',
                              fontSize: SizeConfig.safeBlockVertical * 5,
                            ),
                          );
                          var itemSizeText = Text(
                            document['itemSize'].length > 10
                                ? 'Size: ' +
                                    document['itemSize'].substring(0, 7) +
                                    '...'
                                : 'Size: ' + document['itemSize'],
                            style: TextStyle(
                              fontFamily: 'BebasNeue',
                              fontSize: SizeConfig.safeBlockVertical * 3,
                            ),
                          );
                          var itemCondText = Text(
                            document['itemCondition'].length > 10
                                ? "Condition: " +
                                    document['itemCondition'].substring(0, 7) +
                                    '...'
                                : "Condition: " + document['itemCondition'],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'BebasNeue',
                              fontSize: SizeConfig.safeBlockVertical * 3,
                            ),
                          );
                          var itemPriceText = Text(
                            document['itemPrice'].toStringAsFixed(2).length > 10
                                ? 'Price: \$' +
                                    document['itemPrice']
                                        .toStringAsFixed(2)
                                        .substring(0, 8) +
                                    '...'
                                : 'Price: \$' +
                                    document['itemPrice'].toStringAsFixed(2),
                            style: TextStyle(
                              fontFamily: 'BebasNeue',
                              fontSize: SizeConfig.safeBlockVertical * 3,
                            ),
                          );

                          return Container(
                              child: Card(
                                  color: Colors.white,
                                  child: Padding(
                                      padding: EdgeInsets.all(25),
                                      child: Row(children: [
                                        Container(
                                            child: Column(children: [
                                          sellButton,
                                          viewButton,
                                          deleteButton
                                        ])),
                                        SizedBox(
                                            width:
                                                SizeConfig.safeBlockHorizontal *
                                                    5),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(children: [itemNameText]),
                                              Row(children: [itemSizeText]),
                                              Row(children: [itemCondText]),
                                              Row(children: [itemPriceText])
                                            ])
                                      ]))));
                        }).toList(),
                      );
                    }
                  }))
        ]));
  }
}
