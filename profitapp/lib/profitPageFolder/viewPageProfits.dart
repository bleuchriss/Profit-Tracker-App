//import statements
import './profitsPage.dart';
import 'package:flutter/material.dart';
import 'package:profitapp/sizeConfig.dart';

class ViewPageProfits extends StatefulWidget {
  @override
  ViewPageProfitsState createState() => ViewPageProfitsState();
}

class ViewPageProfitsState extends State<ViewPageProfits> {
  @override
  Widget build(BuildContext context) {
    //variable for back button
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
      },
    );

    //item text variable
    var itemText = Text(ProfitPageState.itemName.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: SizeConfig.safeBlockVertical * 7,
            fontFamily: 'BebasNeue'));

    //color text variable
    var colorText = Text(
        ProfitPageState.itemColor != null
            ? 'Item Colorway: ' + ProfitPageState.itemColor.toString()
            : 'Item Colorway: N/A ',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: SizeConfig.safeBlockVertical * 5,
          fontFamily: 'BebasNeue',
        ));

    //profit text variable
    var conditionText =
        Text('Item Condition: ' + ProfitPageState.itemCondition.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: SizeConfig.safeBlockVertical * 5,
              fontFamily: 'BebasNeue',
            ));
    //location text variable
    var locationText = Text(
        ProfitPageState.itemLocation == null
            ? 'Item Bought From: N/A'
            : 'Item Bought From: ' + ProfitPageState.itemLocation.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: SizeConfig.safeBlockVertical * 5,
          fontFamily: 'BebasNeue',
        ));

    //bought from location text variable
    var boughtForText =
        Text('Item Bought For: \$' + ProfitPageState.itemPrice.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: SizeConfig.safeBlockVertical * 5,
              fontFamily: 'BebasNeue',
            ));

    //text for item size variable
    var sizeText = Text('Item Size: ' + ProfitPageState.itemSize.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: SizeConfig.safeBlockVertical * 5,
          fontFamily: 'BebasNeue',
        ));

    //text for sold for variable
    var soldForText = Text('Sold For: \$' + ProfitPageState.soldFor.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: SizeConfig.safeBlockVertical * 5,
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
          itemText,
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          colorText,
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          conditionText,
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          locationText,
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          boughtForText,
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          sizeText,
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          soldForText,
        ])));
  }
}
