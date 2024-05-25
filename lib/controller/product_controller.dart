import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/models/Category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var quantity = 0.obs;
  var colorIndex = 0.obs;

  var totalPrice = 0.obs;
  var subcat = [];

  var isFav = false.obs;

  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/Category_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();

    if (s.isNotEmpty) {
      for (var e in s[0].subcategory) {
        subcat.add(e);
      }
    } else {
      // Handle the case where 's' is empty
      print('No category found with the name $title');
    }
  }

  void changeColorIndex(int index) {
    colorIndex.value = index; // Assign to 'value' of 'RxInt'
  }
//  changeColorIndex(index) {
  //   colorIndex = index;
  // }

  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  addToCart(
      {title, img, sellername, color, qty, tprice, context, vendorId}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'color': color,
      'qty': qty,
      'vendor_id': vendorId,
      'tprice': tprice,
      'added_by': currentUser!.uid
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues() {
    totalPrice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
  }

  addToWishList(docId, context) async {
    await firestore.collection(productCollections).doc(docId).set({
      'P_wishlist': FieldValue.arrayUnion([currentUser?.uid]),
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Added to Wishlist");
  }

  removeFromWishList(docId, context) async {
    await firestore.collection(productCollections).doc(docId).set({
      'P_wishlist': FieldValue.arrayRemove([currentUser?.uid]),
    }, SetOptions(merge: true));

    isFav(false);

    VxToast.show(context, msg: "Removed from Wishlist");
  }

  checkIfFav(data) async {
    if (data['P_wishlist'].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }

  void changeNavIndex(int i) {}
}
