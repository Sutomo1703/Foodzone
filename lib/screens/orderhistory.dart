import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodzone/screens/home_screen.dart';
import 'package:flutter_foodzone/screens/profile_page.dart';
import 'package:flutter_foodzone/services/dbservices.dart';
import 'package:flutter_foodzone/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<OrderHistory> createState() => _OrderHistoryState();
  // TODO: implement createState
}

class _OrderHistoryState extends State<OrderHistory> {
  User? user = FirebaseAuth.instance.currentUser;

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (context) => new HomeScreen(
                title: toString(),
              )));
    } else if (index == 2) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new AccountPage()));
    }
  }

  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My History Orders",
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: Database.getData(uid),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('ERROR');
            } else if (snapshot.hasData || snapshot.data != null) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    DocumentSnapshot dsData = snapshot.data!.docs[index];
                    String lvorderName = dsData['orderName'];
                    int lvorderPrice = dsData['orderPrice'];
                    int lvorderQty = dsData['orderQty'];
                    return ListTile(
                      title: Text(lvorderName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(lvorderPrice.toString()),
                          Text(lvorderQty.toString()),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (content, index) => SizedBox(
                        height: 8.0,
                      ),
                  itemCount: snapshot.data!.docs.length);
            }
            return Center();
          }),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Order History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
