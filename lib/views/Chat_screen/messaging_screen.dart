import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/Chat_screen/chat_screen.dart';
import 'package:get/get.dart';

class MessagagesScreen extends StatelessWidget {
  const MessagagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "My Messages"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
            stream: FireStoreServices.getAllMessages(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return "No Messages yet"
                    .text
                    .color(darkFontGrey)
                    .makeCentered();
              } else {
                var data = snapshot.data!.docs;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  child: ListTile(
                                    onTap: () {
                                      Get.to(
                                        () => ChatScreen(),
                                        arguments: [
                                          data[index]['friendname'].toString(),
                                          data[index]['toId'].toString(),
                                        ],
                                      );
                                    },
                                    leading: const CircleAvatar(
                                      backgroundColor:
                                          Color.fromARGB(255, 43, 105, 75),
                                      child: Icon(
                                        Icons.person,
                                        color: whiteColor,
                                      ),
                                    ),
                                    title: "${data[index]['friendname']}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    subtitle: "${data[index]['last_msg']}"
                                        .text
                                        .make(),
                                  ),
                                );
                              }))
                    ],
                  ),
                );
              }
            }));
  }
}
