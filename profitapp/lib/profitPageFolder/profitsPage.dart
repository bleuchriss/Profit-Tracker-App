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
  static var doc_idProfits;
  static String itemName;
  static String itemColor;
  static String itemCondition;
  static String itemLocation;
  static String itemPrice;
  static String itemSize;
  static String soldFor;
  static double overallProfit;

  void initState() {
    setState(() {
      overallProfit = overallProfit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      SizedBox(
        height: SizeConfig.safeBlockVertical * 3,
      ),
      Text(' Profits ',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'BebasNeue',
              fontSize: SizeConfig.safeBlockHorizontal * 9,
              color: Colors.black)),
      Text(
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
                      : Colors.green)),
      Container(
          height: SizeConfig.screenHeight -
              MediaQuery.of(context).viewInsets.bottom -
              166,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("userData")
                  .doc(LoginPageState.returnUID())
                  .collection('profits')
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
                      return Container(
                          child: Card(
                              child: Padding(
                                  padding: EdgeInsets.all(25),
                                  child: Row(children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Text(
                                              document['sellValue'] -
                                                          document[
                                                              'itemPrice'] <
                                                      0
                                                  ? '- \$' +
                                                      ((document['sellValue'] -
                                                                  document[
                                                                      'itemPrice']) *
                                                              -1)
                                                          .toStringAsFixed(2)
                                                  : '+ \$' +
                                                      ((document['sellValue'] -
                                                              document[
                                                                  'itemPrice'])
                                                          .toStringAsFixed(2)),
                                              style: TextStyle(
                                                  fontFamily: 'BebasNeue',
                                                  color: (document[
                                                                  'sellValue'] -
                                                              document[
                                                                  'itemPrice']) <
                                                          0
                                                      ? Colors.red
                                                      : Colors.green,
                                                  fontSize: SizeConfig
                                                          .safeBlockVertical *
                                                      4.5)),
                                          RaisedButton(
                                            onPressed: () async {
                                              var uid =
                                                  LoginPageState.returnUID();

                                              itemCondition =
                                                  document['itemCondition']
                                                      .toString();
                                              itemName = document['itemName']
                                                  .toString();

                                              itemColor = document['itemColor']
                                                  .toString();

                                              itemLocation =
                                                  document['itemLocation']
                                                      .toString();
                                              itemPrice = document['itemPrice']
                                                  .toStringAsFixed(2);
                                              itemSize = document['itemSize']
                                                  .toString();
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
                                                overallProfit = overallProfit -
                                                    document['difference'];
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
                                            color: Colors.red,
                                            child: Text("Back To Inventory",
                                                style: TextStyle(
                                                  fontSize: SizeConfig
                                                          .safeBlockVertical *
                                                      2.5,
                                                  fontFamily: 'BebasNeue',
                                                )),
                                          ),
                                          RaisedButton(
                                            onPressed: () async {
                                              itemCondition =
                                                  document['itemCondition']
                                                      .toString();
                                              itemName = document['itemName']
                                                  .toString();

                                              itemColor = document['itemColor']
                                                  .toString();

                                              itemLocation =
                                                  document['itemLocation']
                                                      .toString();
                                              itemPrice = document['itemPrice']
                                                  .toStringAsFixed(2);
                                              itemSize = document['itemSize']
                                                  .toString();
                                              soldFor = document['sellValue']
                                                  .toStringAsFixed(2);
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ViewPageProfits()));
                                            },
                                            color: Colors.blue[300],
                                            child: Text(
                                                "              View              ",
                                                style: TextStyle(
                                                  fontSize: SizeConfig
                                                          .safeBlockVertical *
                                                      2.5,
                                                  fontFamily: 'BebasNeue',
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
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
                                            Row(children: [
                                              Text(
                                                document['itemName'].length > 12
                                                    ? document['itemName']
                                                            .substring(0, 9) +
                                                        '...'
                                                    : document['itemName'],
                                                style: TextStyle(
                                                    fontFamily: 'BebasNeue',
                                                    fontSize: SizeConfig
                                                            .safeBlockVertical *
                                                        5,
                                                    color: Colors.black),
                                              )
                                            ]),
                                            Row(children: [
                                              Text(
                                                document['itemPrice']
                                                            .toStringAsFixed(2)
                                                            .length >
                                                        8
                                                    ? 'Bought For: \$' +
                                                        document['itemPrice']
                                                            .toStringAsFixed(2)
                                                            .substring(0, 5) +
                                                        '...'
                                                    : 'Bought For: \$' +
                                                        document['itemPrice']
                                                            .toStringAsFixed(2),
                                                style: TextStyle(
                                                    fontFamily: 'BebasNeue',
                                                    fontSize: SizeConfig
                                                            .safeBlockVertical *
                                                        3,
                                                    color: Colors.black),
                                              )
                                            ]),
                                            Row(children: [
                                              Text(
                                                document['sellValue']
                                                            .toStringAsFixed(2)
                                                            .length >
                                                        8
                                                    ? 'Sold For: \$' +
                                                        document['sellValue']
                                                            .toStringAsFixed(2)
                                                            .substring(0, 5) +
                                                        '....'
                                                    : 'Sold For: \$' +
                                                        document['sellValue']
                                                            .toStringAsFixed(2),
                                                style: TextStyle(
                                                    fontFamily: 'BebasNeue',
                                                    fontSize: SizeConfig
                                                            .safeBlockVertical *
                                                        3,
                                                    color: Colors.black),
                                              )
                                            ])
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
