import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class categoryList extends StatefulWidget {
  const categoryList({Key? key}) : super(key: key);

  @override
  State<categoryList> createState() => categoryListState();
}

class categoryListState extends State<categoryList> {
  static ScrollController scrollController = ScrollController();

  static const scrollDirection = Axis.vertical;

  static AutoScrollController controller = AutoScrollController();

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: scrollDirection);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              controller.scrollToIndex(0,
                  preferPosition: AutoScrollPosition.begin);
            },
            child: const Text('Indonesian Foods'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              controller.scrollToIndex(10,
                  preferPosition: AutoScrollPosition.begin);
            },
            child: const Text('Chinese Foods'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              controller.scrollToIndex(20,
                  preferPosition: AutoScrollPosition.begin);
            },
            child: const Text('Japanese Foods'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              controller.scrollToIndex(30,
                  preferPosition: AutoScrollPosition.begin);
            },
            child: const Text('Korean Foods'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              controller.scrollToIndex(40,
                  preferPosition: AutoScrollPosition.begin);
            },
            child: const Text('Western Foods'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              controller.scrollToIndex(50,
                  preferPosition: AutoScrollPosition.begin);
            },
            child: const Text('Beverages'),
          ),
        ],
      ),
    );
  }
}
