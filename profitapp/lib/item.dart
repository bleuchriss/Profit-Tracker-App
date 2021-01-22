class Item {
  String itemName;
  double itemPrice;
  String itemLocation;
  String itemCondition;
  String itemSize;
  String itemColor;
  double sellValue;
  double difference;

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