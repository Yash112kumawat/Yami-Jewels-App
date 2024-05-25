import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';

import 'package:emart_app/views/orders_screen/orders_details.dart';

import 'package:get/get.dart';

class Orderscreen extends StatelessWidget {
  const Orderscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title:
              "My Orders".text.color(darkFontGrey).fontFamily(semibold).make(),
        ),
        body: StreamBuilder(
            stream: FireStoreServices.getAllOrders(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return "No orders yet".text.color(darkFontGrey).makeCentered();
              } else {
                var data = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: "${index + 1}"
                          .text
                          .fontFamily(bold)
                          .color(darkFontGrey)
                          .xl
                          .make(),
                      title: data[index]['order_by']
                          .toString()
                          .text
                          .color(redColor)
                          .fontFamily(semibold)
                          .make(),
                      subtitle: data[index]['total_amount']
                          .toString()
                          .numCurrency
                          .text
                          .fontFamily(bold)
                          .make(),
                      trailing: IconButton(
                        onPressed: () {
                          Get.to(() => OrderDetails(data: data[index]));
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: darkFontGrey,
                        ),
                      ),
                    );
                  },
                );
              }
            }));
  }
}
