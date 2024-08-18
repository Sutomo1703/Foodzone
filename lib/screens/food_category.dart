import 'package:flutter/material.dart';
import 'package:flutter_foodzone/screens/default.dart';

class FoodCategory extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback press;
  const FoodCategory({
    Key? key,
    required this.title,
    this.isActive = false,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: isActive
                  ? TextStyle(
                      color: defaultTextColor,
                      fontWeight: FontWeight.bold,
                    )
                  : TextStyle(fontSize: 12),
            ),
            if (isActive)
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                height: 3,
                width: 22,
                decoration: BoxDecoration(
                  color: defaultPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


// class FoodCategory extends StatefulWidget {
//   const FoodCategory({ Key? key }) : super(key: key);

//   @override
//   State<FoodCategory> createState() => _FoodCategoryState();
// }

// class _FoodCategoryState extends State<FoodCategory> {
//   late final String title;
//   late final bool isActive;
//   late final VoidCallback press;
  
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: press,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//         child: Column(
//           children: <Widget>[
//             Text(
//               title,
//               style: isActive
//                   ? TextStyle(
//                       color: defaultTextColor,
//                       fontWeight: FontWeight.bold,
//                     )
//                   : TextStyle(fontSize: 12),
//             ),
//             if (isActive)
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 5),
//                 height: 3,
//                 width: 22,
//                 decoration: BoxDecoration(
//                   color: defaultPrimaryColor,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }