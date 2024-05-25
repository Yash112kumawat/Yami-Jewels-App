import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controller/product_controller.dart';
import 'package:emart_app/views/categories_screen/categories_detail.dart';
import 'package:emart_app/widget%20common/bgwidget.dart';
import 'package:get/get.dart';

class categorie_screen extends StatelessWidget {
  const categorie_screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var controller = Get.put(ProductController());

    return bgwidget(
        child: Scaffold(
      appBar: AppBar(
        title: categories.text.black.fontFamily(bold).size(18).make(),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: 11,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              mainAxisExtent: 200),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Image.asset(
                  categoryImages[index],
                  height: 120,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                20.heightBox,
                " ${categoriesList[index]}"
                    .text
                    .color(Color.fromARGB(255, 23, 105, 86))
                    .fontFamily(semibold)
                    .size(10)
                    .make()
              ],
            )
                .box
                .white
                .roundedSM
                .clip(Clip.antiAlias)
                .outerShadowSm
                .make()
                .onTap(() {
              controller.getSubCategories(categoriesList[index]);
              Get.to(() => categories_detail(title: categoriesList[index]));
            });
          },
        ),
      ),
    ));
  }
}
