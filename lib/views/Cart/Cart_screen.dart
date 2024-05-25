import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/cart_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/Cart/shipping_screen.dart';
import 'package:emart_app/widget%20common/button.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Cart_screen extends StatelessWidget {
  const Cart_screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: SizedBox(
        height: 50,
        child: button(
          color: Color.fromARGB(255, 23, 105, 86),
          onPress: () {
            Get.to(() => Shipping_Detail());
          },
          textColor: whiteColor,
          title: "Proceed to shipping", // Corrected spelling mistake
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping Cart"
            .text
            .color(Colors.black)
            .fontFamily(semibold)
            .make(),
      ),
      body: StreamBuilder(
        stream: FireStoreServices.getCart(
            currentUser?.uid), // Notice the null check here
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: "Cart is empty".text.color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calculate(data);

            controller.productSnapshot = data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image.network(
                            "${data[index]['img']}",
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          title:
                              "${data[index]['title']} (x${data[index]['qty']})"
                                  .text
                                  .fontFamily(semibold)
                                  .size(16)
                                  .make(),
                          subtitle: "${data[index]['tprice']}"
                              .numCurrency
                              .text
                              .fontFamily(semibold)
                              .size(10)
                              .color(Colors.lightBlue)
                              .make(),
                          trailing: Icon(
                            Icons.delete,
                            color: Colors.black,
                          ).onTap(() {
                            FireStoreServices.deleteDocument(data[index].id);
                          }),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total price"
                          .text
                          .fontFamily(semibold)
                          .color(Colors.black)
                          .make(),
                      Obx(
                        () => "${controller.totalP.value}"
                            .numCurrency
                            .text
                            .fontFamily(semibold)
                            .color(Color.fromARGB(255, 23, 105, 86))
                            .make(),
                      ),
                    ],
                  )
                      .box
                      .width(context.screenWidth)
                      .padding(EdgeInsets.all(12))
                      .color(lightGolden)
                      .roundedSM
                      .make(),
                  10.heightBox,
                  //  SizedBox(
                  //    width: context.screenWidth - 60,
                  //    child: button(
                  //     color: redColor,
                  //     onPress: () {},
                  //    textColor: whiteColor,
                  //     title:
                  //        "Proceed to shipping", // Corrected spelling mistake
                  //   ),
                  // ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
 //StreamBuilder(
      //  stream: FireStoreServices.getCart(currentUser?.uid),
    //    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
       //   if (snapshot.hasData) {
     //       return Center(
   //           child: const CircularProgressIndicator(
               // valueColor: AlwaysStoppedAnimation(redColor),
            ///  ),
          //  );
        //  } else if (snapshot.data!.docs.isNotEmpty) {
      //      return Center(
    //          child: "Cart is empty".text.color(darkFontGrey).make(),
  //          );
      //    } else {
         //   var data = snapshot.data!.docs;
       //     controller.calculate(data);
     //       return Padding(
   //           padding: const EdgeInsets.all(8.0),
             // child: Column(
            //    children: [
          //        Expanded(
        //            child: ListView.builder(
      //                itemCount: data.length,
    //                  itemBuilder: (BuildContext context, int index) {
                      //  return ListTile(
                    //        leading: Image.network("${data[index]['img']}"),
                  //          title:
                //                "${data[index]['title']} (x${data[index]['qty']})"
              //                      .text
            //                        .fontFamily(semibold)
         ///                           .size(16)
       //                             .make(),
     //                       subtitle: "${data[index]['tprice']}"
   //                             .numCurrency
                              //  .text
                            //    .fontFamily(semibold)
                          //      .size(10)
                        //        .color(redColor)
                      //          .make(),
                    //        trailing: Icon(
                  //            Icons.delete,
                //              color: redColor,
              //              ).onTap(() {
            //                  FireStoreServices.deleteDocument(data[index].id);
          //                  }));
        //              },
      //              ),
    //              ),
  //                Row(
                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 //   children: [
               //       "Total price"
             //             .text
          ///                .fontFamily(semibold)
        //                  .color(darkFontGrey)
      //                    .make(),
    //                  Obx(
  //                      () => "${controller.totalP.value}"
                          //  .numCurrency
                        //    .text
                      //      .fontFamily(semibold)
                    //        .color(redColor)
                  //          .make(),
               ///       ),
             //       ],
           //       )
         //             .box
       //               .width(context.screenWidth)
     //                 .padding(EdgeInsets.all(12))
                   //   .color(lightGolden)
                     // .roundedSM
                 //     .make(),
               //   10.heightBox,
             //     SizedBox(
             //         width: context.screenWidth - 60,
               //       child: button(
               //           color: redColor,
              //            onPress: () {},
             //             textColor: whiteColor,
            //              title: "Procced to shipping")),
    //            ],
   //           ),
     //       );
   //       }
  //      },
 //     ),