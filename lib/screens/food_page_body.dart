import 'package:flutter/cupertino.dart';
import 'package:flutter_foodzone/utils/colors.dart';
import 'package:flutter_foodzone/widgets/big_text.dart';
import 'package:flutter_foodzone/widgets/icon_and_text_widget.dart';
import 'package:flutter_foodzone/widgets/small_text.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  // double _scaleFactor = 0.8;
  double _height = 220;

  @override
  void iniState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //color: Color(0xFF9294cc),
          height: 320,
          child: PageView.builder(
              controller: pageController,
              itemCount: 5,
              itemBuilder: (context, position) {
                return _buildPageItem(position);
              }),
        ),
      ],
    );
  }

  Widget _buildPageItem(int index) {
    // Matrix4 matrix = new Matrix4.identity();
    // if (index == _currPageValue.floor()) {
    //   var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
    //   var currTrans = _height * (1 - currScale) / 2;
    //   matrix = Matrix4.diagonal3Values(1, currScale, 1)
    //     ..setTranslationRaw(0, currTrans, 0);
    // } else if (index == _currPageValue.floor() + 1) {
    //   var currScale =
    //       _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
    //   var currTrans = _height * (1 - currScale) / 2;
    //   matrix = Matrix4.diagonal3Values(1, currScale, 1);
    //   matrix = Matrix4.diagonal3Values(1, currScale, 1)
    //     ..setTranslationRaw(0, currTrans, 0);
    // } else if (index == _currPageValue.floor() - 1) {
    //   var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
    //   var currTrans = _height * (1 - currScale) / 2;
    //   matrix = Matrix4.diagonal3Values(1, currScale, 1);
    //   matrix = Matrix4.diagonal3Values(1, currScale, 1)
    //     ..setTranslationRaw(0, currTrans, 0);
    // } else {
    //   var currScale = 0.8;
    //   matrix = Matrix4.diagonal3Values(1, currScale, 1)
    //     ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    // }
    return Stack(children: [
      Container(
        height: 220,
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage("assets/food1.jpg"))),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 120,
          margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xFF9294cc),
            // boxShadow: [
            //   BoxShadow(
            //       color: Color(0xFFe8e8e8),
            //       blurRadius: 5.0,
            //       offset: Offset(0, 5)),
            //   BoxShadow(color: Color(0xFFe8e8e8), offset: Offset(-5, 0)),
            //   BoxShadow(color: Color(0xFFe8e8e8), offset: Offset(5, 0)),
            // ]
          ),
          child: Container(
            padding: EdgeInsets.only(top: 10, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(text: "Chinese Side"),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Wrap(
                      children: List.generate(5, (index) {
                        return Icon(
                          IconAndTextWidget.star,
                          color: AppColors.mainColor,
                          size: 15,
                        );
                      }),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SmallText(text: "4.5"),
                    SizedBox(
                      width: 10,
                    ),
                    SmallText(text: "5578"),
                    SizedBox(
                      width: 10,
                    ),
                    SmallText(text: "comments")
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconAndTextWidget(
                        icon: IconAndTextWidget.star,
                        text: "Normal",
                        iconColor: AppColors.iconColor1),
                    IconAndTextWidget(
                        icon: IconAndTextWidget.star,
                        text: "17.2km",
                        iconColor: AppColors.iconColor1),
                    IconAndTextWidget(
                        icon: IconAndTextWidget.star,
                        text: "32min",
                        iconColor: AppColors.iconColor1)
                  ],
                )
              ],
            ),
          ),
        ),
      )
    ]); //pakai boxfit supaya gambarnya fill ke boxnya
  }
}
