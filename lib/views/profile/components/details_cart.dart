import 'package:emart_app/consts/consts.dart';

Widget details_cart({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.color(darkFontGrey).fontFamily(semibold).size(15).make(),
      5.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
      5.heightBox,
    ],
  ).box.white.rounded.width(width).height(60).padding(EdgeInsets.all(4)).make();
}
