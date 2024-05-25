// ignore: file_names
/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "My WishList"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
            stream: FireStoreServices.getWishlist(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return "No wishlist yet"
                    .text
                    .color(darkFontGrey)
                    .makeCentered();
              } else {
                var data = snapshot.data!.docs;
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                                leading: Image.network(
                                  "${data[index]['P_img'][0]}",
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                                title: "${data[index]['P_name']} "
                                    .text
                                    .fontFamily(semibold)
                                    .size(16)
                                    .make(),
                                subtitle: "${data[index]['P_price']}"
                                    .numCurrency
                                    .text
                                    .fontFamily(semibold)
                                    .size(10)
                                    .color(redColor)
                                    .make(),
                                trailing: Icon(
                                  Icons.favorite,
                                  color: redColor,
                                ).onTap(
                                  () async {
                                    await firestore
                                        .collectionGroup(productCollections)
                                        .doc(data[index].id)
                                        .set({
                                          'P_wishlist':FieldValue.arrayRemove([currentUser])
                                        }, SetOptions(merge: true));
                                  },
                                ));
                          }),
                    ),
                  ],
                );
              }
            }));
  }
}*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 23, 105, 86),
      appBar: AppBar(
        title: Text(
          "My WishList",
          style: TextStyle(color: Colors.black, fontFamily: semibold),
        ),
      ),
      body: StreamBuilder(
        stream: FireStoreServices.getWishlist(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No wishlist yet",
                style: TextStyle(color: darkFontGrey),
              ),
            );
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Image.network(
                    "${data[index]['P_img'][0]}",
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    "${data[index]['P_name']}",
                    style: TextStyle(fontFamily: semibold, fontSize: 16),
                  ),
                  subtitle: Text(
                    "${data[index]['P_price']}".numCurrency,
                    style: TextStyle(
                        fontFamily: semibold, fontSize: 10, color: redColor),
                  ),
                  trailing: GestureDetector(
                    onTap: () async {
                      await firestore
                          .collection(productCollections)
                          .doc(data[index].id)
                          .set({
                        'P_wishlist': FieldValue.arrayRemove([currentUser!.uid])
                      }, SetOptions(merge: true));
                    },
                    child: Icon(
                      Icons.favorite,
                      color: redColor,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
