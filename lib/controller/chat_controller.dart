import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/home_controller.dart';
import 'package:get/get.dart';

class Chat_controller extends GetxController {
  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  var chats = firestore.collection(chatCollection);

  var friendName = Get.arguments[0];
  var friensId = Get.arguments[1];

  var senderName = Get.find<home_controller>().username;
  var currentId = currentUser!.uid;

  var msgController = TextEditingController();

  dynamic chatDocId;

  var isloading = false.obs;

  getChatId() async {
    isloading(true);
    await chats
        .where("user", isEqualTo: {friensId: null, currentId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            chatDocId = snapshot.docs.single.id;
          } else {
            chats.add({
              'created_on': null,
              'last_msg': '',
              'users': {friensId: null, currentId: null},
              'toId': '',
              'fromId': '',
              'friendname': friendName,
              'sendername': senderName
            }).then((value) {
              {
                chatDocId = value.id;
              }
            });
          }
        });
    isloading(false);
  }

  sendMsg(String msg) async {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': friensId,
        'fromId': currentId,
      });

      chats.doc(chatDocId).collection(messagesCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId,
      });
    }
  }

  void changeNavIndex(int i) {}
}
