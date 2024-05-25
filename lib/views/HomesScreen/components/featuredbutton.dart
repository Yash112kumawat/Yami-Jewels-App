import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/categories_screen/categories_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget featuredbutton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.fontFamily(semibold).color(Colors.black).make()
    ],
  )
      .box
      .width(200)
      .margin(EdgeInsets.symmetric(horizontal: 4))
      .white
      .padding(EdgeInsets.all(4))
      .roundedSM
      .outerShadowSm
      .make()
      .onTap(() {
    Get.to(() => categories_detail(title: title));
  });
}
