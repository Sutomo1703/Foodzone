import 'package:flutter/material.dart';
import 'package:flutter_foodzone/screens/category_list.dart';
import 'package:flutter_foodzone/screens/post.dart';
import 'package:flutter_foodzone/screens/remote_service.dart';
import 'package:flutter_foodzone/screens/category_list.dart';
import 'package:flutter_foodzone/screens/default.dart';
import 'package:flutter_foodzone/screens/food_category.dart';
import 'package:flutter_foodzone/screens/order_page.dart';
import 'package:flutter_foodzone/screens/post.dart';
import 'package:flutter_foodzone/screens/remote_service.dart';
import 'package:flutter_foodzone/screens/search_box.dart';
import 'package:quantity_input/quantity_input.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => BodyState();
}

class BodyState extends State<Body> {
  int simpleIntInput = 0;

  static List<Post>? posts;

  var isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //fetch data from API
    getData();
  }

  getData() async {
    posts = await RemoteService().getPosts();
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  // int qty = 0;
  // int addQty = 1;
  // int reduceQty = -1;

  // void AddQty() {
  //   qty = qty + 1;
  // }

  // void ReduceQty() {
  //   qty = qty - 1;
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "Our Menu:",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        categoryList(),
        Expanded(
          child: Visibility(
            visible: isLoaded,
            child: ListView.builder(
              scrollDirection: categoryListState.scrollDirection,
              controller: categoryListState.controller,
              itemCount: posts?.length,
              itemBuilder: (context, index) {
                return AutoScrollTag(
                  key: ValueKey(index),
                  controller: categoryListState.controller,
                  index: index,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[300],
                          ),
                          child: Image.network(posts![index].url,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.amber,
                              alignment: Alignment.center,
                              child: const Text(
                                'Whoops!',
                                style: TextStyle(fontSize: 18),
                              ),
                            );
                          }),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                posts![index].name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Rp${posts![index].price.toString()},-',
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
                                            if (posts![index].qty == 0) {
                                              posts![index].qty = 0;
                                            } else {
                                              posts![index].qty--;
                                            }
                                          });
                                        },
                                        child: Text("-")),
                                  ),
                                  Expanded(
                                    child: Text('Qty: ${posts![index].qty}',
                                        textAlign: TextAlign.center),
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            posts![index].qty++;
                                          });
                                        },
                                        child: Text("+")),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ],
    );
  }
}