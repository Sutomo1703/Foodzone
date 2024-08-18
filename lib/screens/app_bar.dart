import 'package:flutter/material.dart';
import 'package:flutter_foodzone/screens/body.dart';
import 'package:flutter_foodzone/screens/default.dart';
import 'package:flutter_foodzone/screens/home_screen.dart';
import 'package:flutter_foodzone/screens/order_page.dart';

AppBar orderAppBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(
              title: 'Place Your Order',
            ),
          ),
        );
      },
    ),
    title: RichText(
      text: TextSpan(
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: "My Favorite!",
            style: TextStyle(color: defaultSecondaryColor),
          ),
          TextSpan(
            text: "Restaurant",
            style: TextStyle(color: defaultPrimaryColor),
          ),
        ],
      ),
    ),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(
                              title: 'Place Your Order',
                            ),
                          ),
                        );
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'OK');
                        final snackBar = SnackBar(
                          content: const Text(
                              'Your order has been recorded! Please wait.'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
          child: const Text('Confirm Order'),
          style: TextButton.styleFrom(primary: Colors.white)),
    ],
  );
}