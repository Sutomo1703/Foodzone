import 'package:flutter/material.dart';
import 'package:flutter_foodzone/model/menuModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_foodzone/model/order_model.dart';
import 'package:flutter_foodzone/services/dbservices.dart';

class OrderPage extends StatefulWidget {
  final List<OrderModel> cart;

  const OrderPage({Key? key, required this.cart}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Order in Cart'),
        backgroundColor: Color(0xFF89dad0),
        actions: <Widget>[
          TextButton(
              onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Are you sure about your order?'),
                      content: const Text(
                          'Click OK to confirm your order, or click Cancel if you want to change your order'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'Cancel');
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            for (int i = 0; i < widget.cart.length; i++) {
                              Database.addData(order: widget.cart[i]);
                            }
                            Navigator.pop(context, 'OK');
                            final snackBar = SnackBar(
                              content: const Text(
                                  'Your order has been recorded! Please wait.'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ),
              child: const Text('Confirm Order'),
              style: TextButton.styleFrom(primary: Colors.white)),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: widget.cart.length,
                itemBuilder: (context, index) {
                  var item = widget.cart[index];
                  var calculateOrder = item.orderQty * item.orderPrice;
                  return Card(
                      elevation: 4.0,
                      child: Stack(
                        fit: StackFit.loose,
                        alignment: Alignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  item.orderName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  // style: Theme.of(context).textTheme.subhead,
                                ),
                                Text(
                                  'Rp${item.orderPrice.toString()},-',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              if (item.orderQty == 0) {
                                                widget.cart.remove(item);
                                              } else {
                                                item.orderQty--;
                                              }
                                            });
                                          },
                                          child: Text("-")),
                                    ),
                                    Expanded(
                                      child: Text('Qty: ${item.orderQty}',
                                          textAlign: TextAlign.center),
                                    ),
                                    Expanded(
                                      child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              item.orderQty++;
                                            });
                                          },
                                          child: Text("+")),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Total price: Rp$calculateOrder,-',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 8.0,
                              bottom: 8.0,
                            ),
                            // child: Align(
                            //   alignment: Alignment.bottomRight,
                            //   child: GestureDetector(
                            //       child: Icon(
                            //         Icons.remove_circle,
                            //         color: Colors.red,
                            //       ),
                            //       onTap: () {
                            //         setState(() {
                            //           widget.cart.remove(item);
                            //         });
                            //       }),
                            // ),
                          ),
                        ],
                      ));
                }),
          ),
          Container(
            height: 30,
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                var item = widget.cart[index];
                var calculateOrder = item.orderQty * item.orderPrice;
                double total = 0;
                for (var item in widget.cart) {
                  total += item.totalPrice();
                }
                total;

                return Text('Total price: $total,-',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
