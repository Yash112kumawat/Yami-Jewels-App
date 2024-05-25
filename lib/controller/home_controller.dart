import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

class home_controller extends GetxController {
  @override
  void onInit() {
    getUsername();

    super.onInit();
  }

  var currentNavIndex = 0.obs;

  var username = "";
  var featuredList = [];

  var SearchController = TextEditingController();
  getUsername() async {
    var n = await firestore
        .collection(userCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });

    username = n;
  }

  void changeNavIndex(int i) {}
}
