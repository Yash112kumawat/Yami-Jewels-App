import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controller/auth_controller.dart';
import 'package:emart_app/controller/profile_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/Chat_screen/messaging_screen.dart';
import 'package:emart_app/views/log_Screen/loginscreen.dart';
import 'package:emart_app/views/orders_screen/Order_Screen.dart';
import 'package:emart_app/views/profile/Editprofile%20_screen.dart';
import 'package:emart_app/views/profile/components/details_cart.dart';
import 'package:emart_app/views/wishlist_screen/Wishlist_Screen.dart';
import 'package:emart_app/widget%20common/bgwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile_screen extends StatelessWidget {
  const Profile_screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var controller = Get.put(ProfileController());
    FireStoreServices.getCounts();

    return bgwidget(
        child: Scaffold(
            body: StreamBuilder(
                stream: FireStoreServices.getuser(currentUser!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      ),
                    );
                  } else {
                    // ignore: unused_local_variable
                    var data = snapshot.data!.docs[0];
                    return SafeArea(
                        child: Column(
                      children: [
                        //edit profile

                        Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        ).onTap(() {
                          controller.nameController.text = data['name'];

                          Get.to(() => Editprofile_screen(
                                data: data,
                              ));
                        }),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              data['imageUrl'] == ''
                                  ? Image.asset(
                                      imgProfile2,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    )
                                      .box
                                      .roundedFull
                                      .clip(Clip.antiAlias)
                                      .make()
                                  : Image.network(
                                      data['imageUrl'],
                                      width: 120,
                                      fit: BoxFit.cover,
                                    )
                                      .box
                                      .roundedFull
                                      .clip(Clip.antiAlias)
                                      .make(),
                              10.heightBox,
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  "${data['name']}"
                                      .text
                                      .color(Colors.black)
                                      .fontFamily(semibold)
                                      .make(),
                                  "${data['email']}"
                                      .text
                                      .color(Colors.black)
                                      .make(),
                                ],
                              )),
                              OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          color: Colors.black)),
                                  onPressed: () async {
                                    await Get.put(AuthController())
                                        .signoutMethod(context);
                                    Get.offAll(() => const loginscreen());
                                  },
                                  child: "Logout"
                                      .text
                                      .fontFamily(semibold)
                                      .color(const Color.fromARGB(
                                          255, 147, 211, 240))
                                      .make())
                            ],
                          ),
                        ),
                        20.heightBox,

                        FutureBuilder(
                          future: FireStoreServices.getCounts(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(redColor),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } else if (!snapshot.hasData) {
                              return Center(
                                child: Text('No data'),
                              );
                            } else {
                              List<int> countData = snapshot.data;

                              if (countData.length < 3) {
                                return Center(
                                  child: Text('Insufficient data'),
                                );
                              }

                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  details_cart(
                                    count: countData[0].toString(),
                                    title: "In Your Cart",
                                    width: context.screenWidth / 3.2,
                                  ),
                                  details_cart(
                                    count: countData[1].toString(),
                                    title: "Wishlist",
                                    width: context.screenWidth / 3.2,
                                  ),
                                  details_cart(
                                    count: countData[2].toString(),
                                    title: "Your Order",
                                    width: context.screenWidth / 3.2,
                                  ),
                                ],
                              );
                            }
                          },
                        ),

                        /*  FutureBuilder(
                            future: FireStoreServices.getCounts(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(redColor),
                                  ),
                                );
                              } else {
                                var countData = snapshot.data;

                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    details_cart(
                                        count: countData[Index][0].toString(),
                                        title: "In Your Cart",
                                        width: context.screenWidth / 3.2),
                                    details_cart(
                                        count: countData[1].toString(),
                                        title: "WishList",
                                        width: context.screenWidth / 3.2),
                                    details_cart(
                                        count: countData[2].toString(),
                                        title: " Your Order",
                                        width: context.screenWidth / 3.2),
                                  ],
                                );
                              }
                            }),*/

                        40.heightBox,
                        //button section
                        ListView.separated(
                                shrinkWrap: true,
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    color: lightGrey,
                                  );
                                },
                                itemCount: profilebuttonList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                      onTap: () {
                                        switch (index) {
                                          case 0:
                                            Get.to(() => Orderscreen());
                                            break;
                                          case 1:
                                            Get.to(() => WishlistScreen());
                                            break;
                                          case 2:
                                            Get.to(() => MessagagesScreen());
                                            break;
                                        }
                                      },
                                      leading: Image.asset(
                                        profilebuttonIcons[index],
                                        width: 22,
                                        color: darkFontGrey,
                                      ),
                                      title: profilebuttonList[index]
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make());
                                })
                            .box
                            .white
                            .rounded
                            .margin(EdgeInsets.all(12))
                            .padding(EdgeInsets.symmetric(horizontal: 16))
                            .shadowSm
                            .make()
                      ],
                    ));
                  }
                })));
  }
}
