import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/home_controller.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var totalP = 0.obs;

  //text controller for shipping details

  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var phonenumberController = TextEditingController();
  var postalcodeController = TextEditingController();

  var paymentIndex = 0.obs;

  late dynamic productSnapshot;

  var products = [];

  var placingOrder = false.obs;

  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

  placeOrder({required orderPaymentMethod, required totalAmount}) async {
    placingOrder(true);

    await getProductsDetails();

    await firestore.collection(orderCollection).doc().set({
      "order_code": "23937384",
      "order_date": FieldValue.serverTimestamp(),
      "order_by": currentUser!.uid,
      "order_by_name": Get.find<home_controller>().username,
      "order_by_email": currentUser!.email,
      "order_by_address": addressController.text,
      "order_by_state": stateController.text,
      "order_by_city": cityController.text,
      "order_by_phonenumber": phonenumberController.text,
      "order_by_postalcode": postalcodeController.text,
      "shipping_method": "Home Delivery",
      "payment_method": orderPaymentMethod,
      "order_placed": true,
      "order_confrimed": false,
      "order_delivered": false,
      "order_on_delivery": false,
      "total_amount": totalAmount,
      "orders": FieldValue.arrayUnion(products),
    });
    placingOrder(false);
  }

  getProductsDetails() {
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        "color": productSnapshot[i]['color'],
        "img": productSnapshot[i]['img'],
        "vendor_id": productSnapshot[i]['vendor_id'],
        "tprice": productSnapshot[i]['tprice'],
        "qty": productSnapshot[i]['qty'],
        "title": productSnapshot[i]['title'],
      });
    }
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}
