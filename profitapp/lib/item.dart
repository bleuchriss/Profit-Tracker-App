//item class
class Item {
  //item instance variables
  String itemName;
  double itemPrice;
  String itemLocation;
  String itemCondition;
  String itemSize;
  String itemColor;
  double sellValue;
  double difference;

//receiving user parameters and setting them to class instance variables
  Item(
    this.itemName,
    this.itemPrice,
    this.itemLocation,
    this.itemCondition,
    this.itemSize,
    this.itemColor,
    this.sellValue,
    this.difference,
  );

//converts item variables to Json type for firestore
  Map<String, dynamic> toJson() => {
        'itemName': itemName,
        'itemPrice': itemPrice,
        'itemLocation': itemLocation,
        'itemCondition': itemCondition,
        'itemSize': itemSize,
        'itemColor': itemColor,
        'sellValue': sellValue,
        'difference': difference,
      };
}
