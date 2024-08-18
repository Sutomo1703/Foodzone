import 'package:flutter/material.dart';

class OrderPageBody extends StatefulWidget {
  final String orderedName;
  final int orderedPrice;
  final int orderedQty;
  const OrderPageBody(
      {Key? key,
      required this.orderedName,
      required this.orderedPrice,
      required this.orderedQty})
      : super(key: key);

  @override
  State<OrderPageBody> createState() => _OrderPageBodyState();
}

class _OrderPageBodyState extends State<OrderPageBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //fetch data from API
    // getData();
  }

  // getData() async {
  //   posts = await RemoteService().getPosts();
  //   if (posts != null) {
  //     setState(() {
  //       isLoaded = true;
  //     });
  //   }
  // }

  var isLoaded = false;

  late int totalPrice;

  // List<Post>? posts;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        Text(
          'Name: ${widget.orderedName}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Price per Qty: Rp${widget.orderedPrice.toString()},-',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text('Qty: ${widget.orderedQty.toString()}',
            textAlign: TextAlign.center),
        Text(
          'Total price: Rp${widget.orderedPrice.toInt() * widget.orderedQty.toInt()},-',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ]),
    );
  }
}