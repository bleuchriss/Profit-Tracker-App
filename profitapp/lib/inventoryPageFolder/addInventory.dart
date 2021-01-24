//import statements
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profitapp/loginPage.dart';
import 'package:profitapp/item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:profitapp/sizeConfig.dart';

class AddInventoryPage extends StatefulWidget {
  @override
  AddInventoryPageState createState() => AddInventoryPageState();
}

class AddInventoryPageState extends State<AddInventoryPage> {
  //creates firebase instance
  final db = FirebaseFirestore.instance;

  //key for validators
  final _formKey = GlobalKey<FormState>();

  //text editing controller sto receive user input
  static final TextEditingController name = TextEditingController();
  static final TextEditingController price = TextEditingController();
  static final TextEditingController condition = TextEditingController();
  static final TextEditingController size = TextEditingController();
  static final TextEditingController location = TextEditingController();
  static final TextEditingController colorway = TextEditingController();

  //text variables
  static final documentId = '';
  var errorTextPrice;
  @override
  Widget build(BuildContext context) {
    //name field text field variable
    final nameField = TextFormField(
        inputFormatters: [LengthLimitingTextInputFormatter(37)],
        controller: name,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter item name';
          }
        },
        decoration: new InputDecoration(
            hintText: "ex. Jordan 1s",
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    //price field text field variable
    final priceField = TextFormField(
        inputFormatters: [LengthLimitingTextInputFormatter(6)],
        controller: price,
        keyboardType: TextInputType.number,
        decoration: new InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "ex. 400",
            errorText: errorTextPrice,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    //location field text field variable
    final locationField = TextFormField(
        inputFormatters: [LengthLimitingTextInputFormatter(16)],
        controller: location,
        decoration: new InputDecoration(
            hintText: "ex. StockX",
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    //condition field text field variable
    final conditionField = TextFormField(
        inputFormatters: [LengthLimitingTextInputFormatter(16)],
        controller: condition,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter the condition';
          }
        },
        decoration: new InputDecoration(
            hintText: "ex. 10 or DS",
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    //size field text field variable
    final sizeField = TextFormField(
        inputFormatters: [LengthLimitingTextInputFormatter(20)],
        controller: size,
        validator: (value) {
          if (value == '') {
            return 'Please enter a size';
          }
        },
        decoration: new InputDecoration(
            hintText: "ex. 10.5 Mens",
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    //color field text field variable
    final colorField = TextFormField(
        inputFormatters: [LengthLimitingTextInputFormatter(16)],
        controller: colorway,
        decoration: new InputDecoration(
            hintText: "ex. Royal Blue ",
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    //back button variable
    var backButton = RaisedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      shape: StadiumBorder(),
      color: Colors.purple[600],
      child: Text("     Back     ",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'BebasNeue',
          )),
    );

    //text variables:
    var nameText = Text('    Name*',
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'BebasNeue',
        ));

    var purchasePriceText = Text('    Purchased Price*',
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'BebasNeue',
        ));

    var locationText = Text('    Purchased From',
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'BebasNeue',
        ));

    var conditionText = Text('    Condition*',
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'BebasNeue',
        ));

    var colorwayText = Text('    Colorway',
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'BebasNeue',
        ));

    var sizeText = Text('    Size*',
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'BebasNeue',
        ));

    //add button variable
    var addButton = RaisedButton(
      onPressed: () async {
        try {
          setState(() {
            errorTextPrice = null;
          });
          // if the form key is validated (no text field errors)
          if (_formKey.currentState.validate()) {
            // create the item object and feed in the parameters
            final Item item = new Item(
                name.text,
                double.parse(price.text),
                location.text,
                condition.text,
                size.text,
                colorway.text,
                0.0,
                0.0);
            // get the users uid
            final uid = await LoginPageState.getCurrentUID();
            //add the item to the database
            await db
                .collection("userData")
                .doc(uid)
                .collection("items")
                .add(item.toJson());
            // jump back to previous page
            Navigator.of(context).pop();
            // reset all the field variables(so it's empty)
            name.text = '';
            price.text = '';
            location.text = '';
            condition.text = '';
            size.text = '';
            colorway.text = '';
          }
        } catch (e) {
          setState(() {
            errorTextPrice = 'Please enter a price';
          });
        }
      },
      shape: StadiumBorder(),
      color: Colors.purple[600],
      child: Text("     Add Item     ",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'BebasNeue',
          )),
    );
    //scaffold holding all widgets
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Form(
                key: _formKey,
                child: ListView(children: [
                  Row(children: [
                    SizedBox(width: SizeConfig.safeBlockHorizontal * 23),
                    Image.asset('assets/additem.png', height: 150)
                  ]),
                  backButton,
                  SizedBox(height: 100),
                  nameText,
                  nameField,
                  SizedBox(height: 125),
                  purchasePriceText,
                  priceField,
                  SizedBox(height: 125),
                  locationText,
                  locationField,
                  SizedBox(height: 125),
                  conditionText,
                  conditionField,
                  SizedBox(height: 125),
                  colorwayText,
                  colorField,
                  SizedBox(height: 125),
                  sizeText,
                  sizeField,
                  SizedBox(height: 250),
                  addButton
                ]))));
  }
}
