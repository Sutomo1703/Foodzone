import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodzone/screens/editprofile.dart';
import 'package:flutter_foodzone/screens/home_screen.dart';
import 'package:flutter_foodzone/screens/orderhistory.dart';
import 'package:flutter_foodzone/utils/colors.dart';
import 'package:flutter_foodzone/widgets/account_widget.dart';
import 'package:flutter_foodzone/widgets/app_icon.dart';
import 'package:flutter_foodzone/widgets/big_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodzone/model/user_model.dart';
import 'package:flutter_foodzone/screens/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

// class AccountPage extends StatelessWidget {
//   const AccountPage({Key? key}) : super(key: key);

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (context) => new OrderHistory(
                title: toString(),
              )));
    } else if (index == 0) {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (context) => new HomeScreen(
                title: toString(),
              )));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF89dad0),
        title: BigText(
          text: "Profile",
          size: 24,
          color: Colors.white,
        ),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            //profileicon
            AppIcon(
              icon: Icons.person,
              backgroundColor: Color(0xFF89dad0),
              iconColor: Colors.white,
              iconSize: 75,
              size: 10 * 10,
            ),
            SizedBox(
              height: 30,
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //name

                    AppIcon(
                      icon: Icons.person,
                      backgroundColor: Color(0xFF89dad0),
                      iconColor: Colors.white,
                      iconSize: 10 * 5 / 2,
                      size: 10 * 5,
                    ),
                    Text(
                      "${loggedInUser.firstname} ${loggedInUser.secondname}",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    //phonenumber

                    AppIcon(
                      icon: Icons.phone,
                      backgroundColor: Color(0xFF89dad0),
                      iconColor: Colors.white,
                      iconSize: 10 * 5 / 2,
                      size: 10 * 5,
                    ),
                    Text(
                      "${loggedInUser.telephone}",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    AppIcon(
                      icon: Icons.email,
                      backgroundColor: Color(0xFF89dad0),
                      iconColor: Colors.white,
                      iconSize: 10 * 5 / 2,
                      size: 10 * 5,
                    ),
                    Text(
                      "${loggedInUser.email}",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => editProfile()));
                        },
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    ActionChip(
                        label: Text("Logout"),
                        onPressed: () {
                          logout(context);
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
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

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
    Fluttertoast.showToast(msg: "Logout Successfully");
  }
}
