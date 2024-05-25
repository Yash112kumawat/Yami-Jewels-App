import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/categories_screen/items_detail.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({Key? key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
        future: FireStoreServices.searchProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No products found".text.makeCentered();
          } else {
            var data = snapshot.data!.docs;
            var filltered = data
                .where(
                  (element) => element['P_name']
                      .toString()
                      .toLowerCase()
                      .contains(title!.toLowerCase()),
                )
                .toList();

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 300),
                children: filltered
                    .mapIndexed((currentValue, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              filltered[index]['P_img'][0],
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                            Spacer(),
                            " ${filltered[index]['P_name']}"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            10.heightBox,
                            "${filltered[index]['P_price']}"
                                .text
                                .color(redColor)
                                .fontFamily(bold)
                                .size(18)
                                .make()
                          ],
                        )
                            .box
                            .white
                            .margin(const EdgeInsets.symmetric(horizontal: 6))
                            .roundedSM
                            .padding(const EdgeInsets.all(12))
                            .make()
                            .onTap(() {
                          Get.to(
                            () => items_detail(
                              title: " ${filltered[index]['P_name']}",
                              data: filltered[index],
                            ),
                          );
                        }))
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
