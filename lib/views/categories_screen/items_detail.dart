import 'dart:core';

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controller/product_controller.dart';
import 'package:emart_app/views/Chat_screen/chat_screen.dart';
import 'package:emart_app/views/HomesScreen/components/featuredbutton.dart';
import 'package:emart_app/widget%20common/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/state_manager.dart';

import 'package:velocity_x/velocity_x.dart';

class items_detail extends StatelessWidget {
  final String? title;
  final dynamic data;

  const items_detail({Key? key, required this.title, this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ProductController controller = Get.put(ProductController());
    var controller = Get.put(ProductController());
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              controller.resetValues();
              Get.back();
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                )),
            Obx(
              () => IconButton(
                  onPressed: () {
                    if (controller.isFav.value) {
                      controller.removeFromWishList(data.id, context);
                    } else {
                      controller.addToWishList(data.id, context);
                    }
                  },
                  icon: Icon(
                    Icons.favorite_outline,
                    color: controller.isFav.value ? redColor : darkFontGrey,
                  )),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
                    padding: EdgeInsets.all(8),
                    child: SingleChildScrollView(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VxSwiper.builder(
                          autoPlay: true,
                          height: 350,
                          itemCount: data['P_img'].length,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          itemBuilder: (context, index) {
                            return Image.network(
                              data['P_img'][index],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                        10.heightBox,
                        title!.text
                            .size(16)
                            .color(darkFontGrey)
                            .fontFamily(semibold)
                            .make(),
                        10.heightBox,
                        VxRating(
                          isSelectable: false,
                          value: double.parse(data['P_ratings']),
                          onRatingUpdate: (value) {},
                          normalColor: textfieldGrey,
                          selectionColor: golden,
                          count: 5,
                          size: 25,
                          stepInt: false,
                          maxRating: 5,
                        ),
                        10.heightBox,
                        "Rs"
                                "${data['P_price']}"
                            .text
                            .color(fontGrey)
                            .size(18)
                            .fontFamily(bold)
                            .make(),
                        10.heightBox,
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Seller".text.white.fontFamily(semibold).make(),
                                5.heightBox,
                                "${data['P_seller']}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make()
                              ],
                            )),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.message_rounded,
                                color: darkFontGrey,
                              ),
                            ).onTap(() {
                              Get.to(
                                () => ChatScreen(),
                                arguments: [
                                  data['P_seller'],
                                  data['vendor_id']
                                ],
                              );
                            })
                          ],
                        )
                            .box
                            .height(60)
                            .padding(EdgeInsets.symmetric(horizontal: 16))
                            .color(textfieldGrey)
                            .make(),

                        //color section
                        20.heightBox,
                        Obx(
                          () => Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: "Size:"
                                        .text
                                        .color(textfieldGrey)
                                        .make(),
                                  ),
                                  Row(
                                    children: List.generate(
                                        data['P_colors'].length,
                                        (index) => Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                VxBox()
                                                    .size(40, 40)
                                                    .roundedFull
                                                    .color(Color(
                                                            data['P_colors']
                                                                [index])
                                                        .withOpacity(1.0))
                                                    .margin(
                                                        EdgeInsets.symmetric(
                                                            horizontal: 4))
                                                    .make()
                                                    .onTap(() {
                                                  controller
                                                      .changeColorIndex(index);
                                                }),
                                                Visibility(
                                                    visible: index ==
                                                        controller
                                                            .colorIndex.value,
                                                    child: const Icon(
                                                        Icons.done,
                                                        color: Colors.white))
                                              ],
                                            )),
                                  )
                                ],
                              ).box.padding(EdgeInsets.all(8)).make(),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: "Quantity:"
                                        .text
                                        .color(textfieldGrey)
                                        .make(),
                                  ),
                                  1.widthBox,
                                  Obx(
                                    () => Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              controller.decreaseQuantity();
                                              controller.calculateTotalPrice(
                                                  int.parse(data['P_price']));
                                            },
                                            icon: Icon(Icons.remove)),
                                        controller.quantity.value.text
                                            .color(darkFontGrey)
                                            .size(16)
                                            .fontFamily(semibold)
                                            .make(),
                                        IconButton(
                                            onPressed: () {
                                              controller.increaseQuantity(
                                                  int.parse(
                                                      data['P_quantity']));
                                              controller.calculateTotalPrice(
                                                  int.parse(data['P_price']));
                                            },
                                            icon: Icon(Icons.add)),
                                        "(${data['P_quantity']} Available)"
                                            .text
                                            .color(textfieldGrey)
                                            .size(16)
                                            .fontFamily(semibold)
                                            .make()
                                      ],
                                    ),
                                  ),
                                ],
                              ).box.padding(EdgeInsets.all(8)).make(),

                              //total row

                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: "Total:"
                                        .text
                                        .color(textfieldGrey)
                                        .make(),
                                  ),
                                  "${controller.totalPrice.value}"
                                      .numCurrency
                                      .text
                                      .color(redColor)
                                      .size(16)
                                      .fontFamily(bold)
                                      .make(),
                                ],
                              ).box.padding(EdgeInsets.all(8)).make(),
                            ],
                          ).box.white.shadowSm.make(),
                        ),
                        10.heightBox,
                        "Description"
                            .text
                            .color(darkFontGrey)
                            .fontFamily(semibold)
                            .make(),
                        10.heightBox,
                        "${data['P_dersc']}"
                            .text
                            .color(darkFontGrey)
                            .fontFamily(bold)
                            .size(18)
                            .make(),
                        10.heightBox,
                        ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                              itemsdetailbuttonList.length,
                              (index) => ListTile(
                                    title: "${itemsdetailbuttonList[index]}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    trailing: const Icon(Icons.arrow_forward),
                                  )),
                        ),
                        20.heightBox,
                        productsyoumaylike.text
                            .fontFamily(bold)
                            .color(darkFontGrey)
                            .size(16)
                            .make(),
                        10.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                3,
                                (index) => Column(
                                      children: [
                                        featuredbutton(
                                          icon: featuredImages1[index],
                                          title: featuredtitles1[index],
                                        ),
                                        10.heightBox,
                                        featuredbutton(
                                            icon: featuredImages2[index],
                                            title: featuredtitles2[index])
                                      ],
                                    )).toList(),
                          ),
                        ),
                        20.heightBox,
                        Container(
                          padding: const EdgeInsets.all(12),
                          width: double.infinity,
                          decoration: const BoxDecoration(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              10.heightBox,
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                      6,
                                      (index) => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                imgP1,
                                                width: 150,
                                                fit: BoxFit.cover,
                                              ),
                                              10.heightBox,
                                              " Laptop 4GB/6GB"
                                                  .text
                                                  .fontFamily(bold)
                                                  .color(darkFontGrey)
                                                  .make(),
                                              10.heightBox,
                                              "Rs-1888"
                                                  .text
                                                  .color(Colors.black)
                                                  .fontFamily(semibold)
                                                  .size(18)
                                                  .make()
                                            ],
                                          )
                                              .box
                                              .white
                                              .margin(
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6))
                                              .roundedSM
                                              .padding(const EdgeInsets.all(8))
                                              .make()),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )))),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: button(
                  color: Color.fromARGB(255, 23, 105, 86),
                  onPress: () {
                    if (controller.quantity.value > 0) {
                      controller.addToCart(
                          color: data['P_colors'][controller.colorIndex.value],
                          context: context,
                          vendorId: data['vendor_id'],
                          img: data['P_img'][0],
                          qty: controller.quantity.value,
                          sellername: data['P_seller'],
                          title: data['P_name'],
                          tprice: controller.totalPrice.value);

                      VxToast.show(context, msg: "Added to cart");
                    } else {
                      VxToast.show(context, msg: "Quantity Can't be Zero");
                    }
                  },
                  textColor: whiteColor,
                  title: "Add to cart"),
            ),
          ],
        ),
      ),
    );
  }
}
