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
    var backButton = RaisedButton(
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
    );

    var itemText = Text(ProfitPageState.itemName.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: SizeConfig.safeBlockVertical * 7,
            fontFamily: 'BebasNeue'));

    
    
    
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
          backButton,
          itemText,
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          Text(
              ProfitPageState.itemColor != null
                  ? 'Item Colorway: ' + ProfitPageState.itemColor.toString()
                  : 'Item Colorway: N/A ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SizeConfig.safeBlockVertical * 5,
                fontFamily: 'BebasNeue',
              )),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          Text('Item Condition: ' + ProfitPageState.itemCondition.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SizeConfig.safeBlockVertical * 5,
                fontFamily: 'BebasNeue',
              )),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          Text(
              ProfitPageState.itemLocation == null
                  ? 'Item Bought From: N/A'
                  : 'Item Bought From: ' +
                      ProfitPageState.itemLocation.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SizeConfig.safeBlockVertical * 5,
                fontFamily: 'BebasNeue',
              )),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          Text('Item Bought For: \$' + ProfitPageState.itemPrice.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SizeConfig.safeBlockVertical * 5,
                fontFamily: 'BebasNeue',
              )),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          Text('Item Size: ' + ProfitPageState.itemSize.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SizeConfig.safeBlockVertical * 5,
                fontFamily: 'BebasNeue',
              )),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          Text('Sold For: \$' + ProfitPageState.soldFor.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SizeConfig.safeBlockVertical * 5,
                fontFamily: 'BebasNeue',
              )),
        ])));
  }
}
