import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isloading = false.obs;
//textcontroller

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //loginmethod

  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

//signup

  Future<UserCredential?> singupMethod({email, password, context}) async {
    UserCredential? userCredential;

    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

//storingdata

  storedUserData({name, password, email}) async {
    DocumentReference store =
        await firestore.collection(userCollection).doc(currentUser!.uid);
    store.set({
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
      'id': currentUser?.uid,
      'cart_count': '00',
      'order_count': '00',
      'wishlist_count': '00',
    });
  }
  //signout method

  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
