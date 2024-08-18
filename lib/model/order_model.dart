class OrderModel {
  String uid;
  String orderName;
  int orderPrice;
  int orderQty;

  OrderModel(
      {required this.uid,
      required this.orderName,
      required this.orderPrice,
      required this.orderQty});

  int totalPrice() {
    return orderQty * orderPrice;
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "orderName": orderName,
      "orderPrice": orderPrice,
      "orderQty": orderQty
    };
  }

  // receiving data from server
  factory OrderModel.fromMap(map) {
    return OrderModel(
      uid: map['uid'],
      orderName: map['orderName'],
      orderPrice: map['orderPrice'],
      orderQty: map['orderQty'],
    );
  }

  //sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'orderName': orderName,
      'orderPrice': orderPrice,
      'orderQty': orderQty,
    };
  }
}
