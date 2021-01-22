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
  final db = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();

  static final TextEditingController name = TextEditingController();
  static final TextEditingController price = TextEditingController();
  static final TextEditingController condition = TextEditingController();
  static final TextEditingController size = TextEditingController();
  static final TextEditingController location = TextEditingController();
  static final TextEditingController colorway = TextEditingController();
  static final documentId = '';
  var errorTextPrice;
  @override
  Widget build(BuildContext context) {
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

    final locationField = TextFormField(
        inputFormatters: [LengthLimitingTextInputFormatter(16)],
        controller: location,
        decoration: new InputDecoration(
            hintText: "ex. StockX",
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

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

    final colorField = TextFormField(
        inputFormatters: [LengthLimitingTextInputFormatter(16)],
        controller: colorway,
        decoration: new InputDecoration(
            hintText: "ex. Royal Blue ",
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

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
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    shape: StadiumBorder(),
                    color: Colors.blue[300],
                    child: Text("     Back     ",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'BebasNeue',
                        )),
                  ),
                  SizedBox(height: 100),
                  Text('    Name*',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'BebasNeue',
                      )),
                  nameField,
                  SizedBox(height: 125),
                  Text('    Purchased Price*',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'BebasNeue',
                      )),
                  priceField,
                  SizedBox(height: 125),
                  Text('    Purchased From',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'BebasNeue',
                      )),
                  locationField,
                  SizedBox(height: 125),
                  Text('    Condition*',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'BebasNeue',
                      )),
                  conditionField,
                  SizedBox(height: 125),
                  Text('    Colorway',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'BebasNeue',
                      )),
                  colorField,
                  SizedBox(height: 125),
                  Text('    Size*',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'BebasNeue',
                      )),
                  sizeField,
                  SizedBox(height: 250),
                  RaisedButton(
                    onPressed: () async {
                      try {
                        setState(() {
                          errorTextPrice = null;
                        });
                        if (_formKey.currentState.validate()) {
                          final Item item = new Item(
                              name.text,
                              double.parse(price.text),
                              location.text,
                              condition.text,
                              size.text,
                              colorway.text,
                              0.0,
                              0.0);
                          final uid = await LoginPageState.getCurrentUID();
                          await db
                              .collection("userData")
                              .doc(uid)
                              .collection("items")
                              .add(item.toJson());
                          Navigator.of(context).pop();
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
                    color: Colors.blue[300],
                    child: Text("     Add Item     ",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'BebasNeue',
                        )),
                  ),
                ]))));
  }
}
