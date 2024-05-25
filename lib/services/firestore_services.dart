import 'package:emart_app/consts/consts.dart';

//user data get kar rahen hai
class FireStoreServices {
  static getuser(uid) {
    return firestore
        .collection(userCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  //category kai according product lenge

  static getProducts(category) {
    return firestore
        .collection(productCollections)
        .where('P_category', isEqualTo: category)
        .snapshots();
  }

  static getSubCategoryProducts(title) {
    return firestore
        .collection(productCollections)
        .where('P_subcategory', isEqualTo: title)
        .snapshots();
  }

  //get cart

  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where("added_by", isEqualTo: uid)
        .snapshots();
  }

  //delete
  static deleteDocument(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

//saare message show karne kai liye
  static getChatMessages(docId) {
    return firestore
        .collection(chatCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getAllOrders() {
    return firestore
        .collection(orderCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getWishlist() {
    return firestore
        .collection(wishlist)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getAllMessages() {
    return firestore
        .collection(chatCollection)
        .where('fromId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getCounts() async {
    var res = await Future.wait([
      firestore
          .collection(cartCollection)
          .where('added_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(wishlist)
          .where('p_wishlist', arrayContains: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(orderCollection)
          .where('order_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }

  static allProducts() {
    return firestore.collection(productCollections).snapshots();
  }

  static searchProducts(title) {
    return firestore.collection(productCollections).get();
  }
}
