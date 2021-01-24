//imports
import 'package:flutter/material.dart';
import 'package:profitapp/loginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './viewPageProfits.dart';
import 'package:profitapp/item.dart';
import 'package:profitapp/sizeConfig.dart';

class ProfitPage extends StatefulWidget {
  @override
  ProfitPageState createState() => ProfitPageState();
}

class ProfitPageState extends State<ProfitPage> {
  //item variables
  static var doc_idProfits;
  static String itemName;
  static String itemColor;
  static String itemCondition;
  static String itemLocation;
  static String itemPrice;
  static String itemSize;
  static String soldFor;
  static double overallProfit;

//sets state on overallprofit variable when page is initailized
  void initState() {
    setState(() {
      overallProfit = overallProfit;
    });
  }

  @override
  Widget build(BuildContext context) {
    //profit text variable
    var profitText = Text(' Profits ',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'BebasNeue',
            fontSize: SizeConfig.safeBlockHorizontal * 9,
            color: Colors.black));

    //money text variable
    var moneyText = Text(
        overallProfit < 0
            ? '-\$' + (overallProfit * -1).toStringAsFixed(2)
            : overallProfit == 0
                ? '\$' + overallProfit.toStringAsFixed(2)
                : '+\$' + overallProfit.toStringAsFixed(2),
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'BebasNeue',
            fontSize: SizeConfig.safeBlockHorizontal * 8,
            color: overallProfit < 0
                ? Colors.red
                : overallProfit == 0
                    ? Colors.black
                    : Colors.green));

    //scaffold holding all widgets
    return Scaffold(
        body: ListView(children: [
      SizedBox(
        height: SizeConfig.safeBlockVertical * 3,
      ),
      profitText, // profit text
      moneyText, // money amount text
      Container(
          height: SizeConfig.screenHeight -
              MediaQuery.of(context).viewInsets.bottom -
              166,
          child: StreamBuilder(
              // creating a stream of information based on Firestore
              stream: FirebaseFirestore.instance
                  .collection("userData")
                  .doc(LoginPageState.returnUID())
                  .collection('profits')
                  .snapshots(),
              // use the information and building it into a snapshot of the data
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                // if there is not data then show a spinning circle
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  // otherwise return a list view of the data
                  return ListView(
                    // parse through each document
                    children: snapshot.data.docs.map((document) {
                      // a text variable for the difference in bought for and sold for prices
                      var sellText = Text(
                          document['sellValue'] - document['itemPrice'] < 0
                              ? '- \$' +
                                  ((document['sellValue'] -
                                              document['itemPrice']) *
                                          -1)
                                      .toStringAsFixed(2)
                              : '+ \$' +
                                  ((document['sellValue'] -
                                          document['itemPrice'])
                                      .toStringAsFixed(2)),
                          style: TextStyle(
                              fontFamily: 'BebasNeue',
                              color: (document['sellValue'] -
                                          document['itemPrice']) <
                                      0
                                  ? Colors.red
                                  : Colors.green,
                              fontSize: SizeConfig.safeBlockVertical * 4.5));

                      // a button variable that move the current item back to the
                      // inventory page and remove it from the profits database
                      // and re adds it to the inventory database
                      var backToInventoryButton = RaisedButton(
                        onPressed: () async {
                          var uid = LoginPageState.returnUID();

                          itemCondition = document['itemCondition'].toString();
                          itemName = document['itemName'].toString();

                          itemColor = document['itemColor'].toString();

                          itemLocation = document['itemLocation'].toString();
                          itemPrice = document['itemPrice'].toStringAsFixed(2);
                          itemSize = document['itemSize'].toString();
                          var returnItem = new Item(
                              itemName.toString(),
                              double.parse(itemPrice),
                              itemLocation.toString(),
                              itemCondition.toString(),
                              itemSize.toString(),
                              itemColor.toString(),
                              0.0,
                              0.0);
                          doc_idProfits = document.id;
                          setState(() {
                            overallProfit =
                                overallProfit - document['difference'];
                          });
                          await FirebaseFirestore.instance
                              .collection('userData')
                              .doc(uid)
                              .collection('profits')
                              .doc(doc_idProfits)
                              .delete();

                          FirebaseFirestore.instance
                              .collection('userData')
                              .doc(uid)
                              .collection('items')
                              .add(returnItem.toJson());
                        },
                        color: Colors.blue,
                        child: Text("Back To Inventory",
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockVertical * 2.5,
                              fontFamily: 'BebasNeue',
                            )),
                      );

                      // a button variable the displays that item in full details
                      var viewButton = RaisedButton(
                        onPressed: () async {
                          itemCondition = document['itemCondition'].toString();
                          itemName = document['itemName'].toString();

                          itemColor = document['itemColor'].toString();

                          itemLocation = document['itemLocation'].toString();
                          itemPrice = document['itemPrice'].toStringAsFixed(2);
                          itemSize = document['itemSize'].toString();
                          soldFor = document['sellValue'].toStringAsFixed(2);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewPageProfits()));
                        },
                        color: Colors.purple[600],
                        child: Text("              View              ",
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockVertical * 2.5,
                              fontFamily: 'BebasNeue',
                            )),
                      );

                      // text variable for the name and formatting based on characters
                      var itemNameText = Text(
                        document['itemName'].length > 12
                            ? document['itemName'].substring(0, 9) + '...'
                            : document['itemName'],
                        style: TextStyle(
                            fontFamily: 'BebasNeue',
                            fontSize: SizeConfig.safeBlockVertical * 5,
                            color: Colors.black),
                      );

                      // text variable for the price and formatting based on characters
                      var itemPriceText = Text(
                        document['itemPrice'].toStringAsFixed(2).length > 8
                            ? 'Bought For: \$' +
                                document['itemPrice']
                                    .toStringAsFixed(2)
                                    .substring(0, 5) +
                                '...'
                            : 'Bought For: \$' +
                                document['itemPrice'].toStringAsFixed(2),
                        style: TextStyle(
                            fontFamily: 'BebasNeue',
                            fontSize: SizeConfig.safeBlockVertical * 3,
                            color: Colors.black),
                      );

                      // text variable for the sold value and formatting based on characters
                      var sellValueText = Text(
                        document['sellValue'].toStringAsFixed(2).length > 8
                            ? 'Sold For: \$' +
                                document['sellValue']
                                    .toStringAsFixed(2)
                                    .substring(0, 5) +
                                '....'
                            : 'Sold For: \$' +
                                document['sellValue'].toStringAsFixed(2),
                        style: TextStyle(
                            fontFamily: 'BebasNeue',
                            fontSize: SizeConfig.safeBlockVertical * 3,
                            color: Colors.black),
                      );

                      return Container(
                          child: Card(
                              child: Padding(
                                  padding: EdgeInsets.all(25),
                                  child: Row(children: [
                                    Container(
                                        child: Column(children: [
                                      sellText, // sell text
                                      backToInventoryButton, //back to inventory button
                                      viewButton, // view button
                                    ])),
                                    SizedBox(
                                        width:
                                            SizeConfig.safeBlockVertical * 2),
                                    Row(children: [
                                      SizedBox(
                                          width:
                                              SizeConfig.safeBlockVertical * 1),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: SizeConfig
                                                      .safeBlockHorizontal *
                                                  12,
                                            ),
                                            Row(children: [itemNameText]),
                                            Row(children: [itemPriceText]),
                                            Row(children: [sellValueText])
                                          ])
                                    ]),
                                  ]))));
                    }).toList(),
                  );
                }
              }))
    ]));
  }
}
