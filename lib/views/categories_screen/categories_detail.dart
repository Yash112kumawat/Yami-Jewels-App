import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/product_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/categories_screen/items_detail.dart';
import 'package:emart_app/widget%20common/bgwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class categories_detail extends StatefulWidget {
  final String? title;
  const categories_detail({Key? key, required this.title}) : super(key: key);

  @override
  State<categories_detail> createState() => _categories_detailState();
}

class _categories_detailState extends State<categories_detail> {
  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      productMethod = FireStoreServices.getSubCategoryProducts(title);
    } else {
      productMethod = FireStoreServices.getProducts(title);
    }
  }

  var controller = Get.put(ProductController());

  dynamic productMethod;
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable

    return bgwidget(
        child: Scaffold(
      appBar: AppBar(
        title: widget.title!.text.black.fontFamily(bold).make(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                controller.subcat.length,
                (index) => "${controller.subcat[index]}"
                    .text
                    .size(12)
                    .color(fontGrey)
                    .fontFamily(semibold)
                    .makeCentered()
                    .box
                    .white
                    .roundedSM
                    .size(120, 50)
                    .margin(const EdgeInsets.symmetric(horizontal: 4))
                    .make()
                    .onTap(() {
                  switchCategory("${controller.subcat[index]}");
                  setState(() {});
                }),
              ),
            ),
          ),
          20.heightBox,
          StreamBuilder(
            stream: productMethod,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Expanded(
                  child: Center(
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ),
                  ),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Expanded(
                  child: "No Product Found!"
                      .text
                      .color(darkFontGrey)
                      .makeCentered(),
                );
              } else {
                var data = snapshot.data!.docs;
                return
                    //items

                    Expanded(
                        child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 250,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    data[index]['P_img'][0],
                                    height: 150,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  " ${data[index]['P_subcategory']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  10.heightBox,
                                  "${data[index]['P_price']}"
                                      .text
                                      .color(redColor)
                                      .fontFamily(bold)
                                      .size(18)
                                      .make()
                                ],
                              )
                                  .box
                                  .white
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 6))
                                  .roundedSM
                                  .outerShadowSm
                                  .padding(const EdgeInsets.all(12))
                                  .make()
                                  .onTap(() {
                                controller.checkIfFav(data[index]);
                                Get.to(() => items_detail(
                                      title: "${data[index]['P_name']}",
                                      data: data[index],
                                    ));
                              });
                            }));
              }
            },
          ),
        ],
      ),
    ));
  }
}
