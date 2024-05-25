import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/controller/home_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/HomesScreen/components/featuredbutton.dart';
import 'package:emart_app/views/HomesScreen/search_screen.dart';
import 'package:emart_app/views/categories_screen/items_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/widget%20common/home_button.dart';

class home_screen extends StatelessWidget {
  const home_screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<home_controller>();
    return Container(
      // Background color
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            color: lightGrey,
            child: TextFormField(
              controller: controller.SearchController,
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: GestureDetector(
                    child: const Icon(Icons.search).onTap(() {
                  if (controller.SearchController.text.isNotEmptyAndNotNull) {
                    Get.to(() => SearchScreen(
                          title: controller.SearchController.text,
                        ));
                  }
                })),
                filled: true,
                fillColor: whiteColor,
                hintText: searchanything,
                hintStyle: TextStyle(color: textfieldGrey),
              ),
            ).box.outerShadowSm.make(),
          ),
          10.heightBox,
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: sliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          sliderList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      }),
                  20.heightBox,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: featuredCategories.text
                          .color(Color.fromARGB(255, 3, 36, 51))
                          .fontFamily(semibold)
                          .size(25)
                          .make()),
                  20.heightBox,

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
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        featuredproduct.text.black
                            .fontFamily(semibold)
                            .size(25)
                            .make(),
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
                                        "Emarld Blue Earring"
                                            .text
                                            .fontFamily(bold)
                                            .color(Colors.black)
                                            .make(),
                                        10.heightBox,
                                        "Rs-1888"
                                            .text
                                            .color(Colors.white)
                                            .fontFamily(semibold)
                                            .size(16)
                                            .make()
                                      ],
                                    )
                                        .box
                                        .color(Color.fromARGB(255, 23, 105, 86))
                                        .margin(const EdgeInsets.symmetric(
                                            horizontal: 6))
                                        .roundedSM
                                        .padding(const EdgeInsets.all(8))
                                        .make()),
                          ),
                        )
                      ],
                    ),
                  ),

                  20.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        3,
                        (index) => home_button(
                              height: context.screenHeight * 0.15,
                              width: context.screenWidth / 3.5,
                              icon: index == 0
                                  ? icTopCategories
                                  : index == 1
                                      ? icBrands
                                      : icTopSeller,
                              title: index == 0
                                  ? topcategories
                                  : index == 1
                                      ? trendingitems
                                      : bestselling,
                            )),
                  ),

                  //thirdswip

                  20.heightBox,
                  "TREND"
                      .text
                      .color(Colors.black)
                      .fontFamily(semibold)
                      .size(30)
                      .make(),
                  10.heightBox,
                  StreamBuilder(
                    stream: FireStoreServices.allProducts(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(redColor),
                        );
                      } else {
                        var allproductsdata = snapshot.data!.docs;

                        return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: allproductsdata.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    mainAxisExtent: 300),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    allproductsdata[index]['P_img'][0],
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  Spacer(),
                                  " ${allproductsdata[index]['P_name']}"
                                      .text
                                      .fontFamily(bold)
                                      .color(Colors.black)
                                      .size(18)
                                      .make(),
                                  10.heightBox,
                                  "${allproductsdata[index]['P_price']}"
                                      .text
                                      .color(Colors.black)
                                      .fontFamily(bold)
                                      .size(16)
                                      .make()
                                ],
                              )
                                  .box
                                  .white
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 6))
                                  .roundedSM
                                  .padding(const EdgeInsets.all(12))
                                  .make()
                                  .onTap(() {
                                Get.to(
                                  () => items_detail(
                                    title:
                                        " ${allproductsdata[index]['P_name']}",
                                    data: allproductsdata[index],
                                  ),
                                );
                              });
                            });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
