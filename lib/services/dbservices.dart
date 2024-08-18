import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_foodzone/model/order_model.dart';

CollectionReference tblOrder = FirebaseFirestore.instance.collection("orders");

class Database {
  static Stream<QuerySnapshot> getData (String uid) {
    if (uid != "") {
      return tblOrder
      .where("uid", isEqualTo: uid)
      .snapshots();
    } else {
      throw "Error. Harap isi uid dulu.";
    }
  }

  static Future<void> addData ({required OrderModel order}) async {
    DocumentReference docRef = tblOrder.doc();
    await docRef
    .set(order.toJson())
    .whenComplete(() => print("data berhasil diinput"))
    .catchError((e) => print(e));
  }
}