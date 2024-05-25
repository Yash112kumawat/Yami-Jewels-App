import 'dart:io';

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/strings.dart';
import 'package:emart_app/controller/profile_controller.dart';
import 'package:emart_app/widget%20common/bgwidget.dart';
import 'package:emart_app/widget%20common/button.dart';
import 'package:emart_app/widget%20common/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Editprofile_screen extends StatelessWidget {
  final dynamic data;

  const Editprofile_screen({Key? key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgwidget(
        child: Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //agar data image url or controller khaali hai
            data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                ? Image.asset(
                    imgProfile2,
                    width: 120,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make()
//or yaha data khaali nhi hai magar controller khaali hai

                : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                    ? Image.network(
                        data['imageUrl'],
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()

                    // or dono hii khaali hue toh ye
                    : Image.file(
                        File(controller.profileImgPath.value),
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            button(
                color: Color.fromARGB(255, 23, 105, 86),
                onPress: () {
                  controller.changeImage(context);
                },
                textColor: whiteColor,
                title: "Change"),
            const Divider(),
            20.heightBox,
            custom_text(
                controller: controller.nameController,
                hint: nameHint,
                title: name,
                isPass: false),
            10.heightBox,
            custom_text(
                controller: controller.oldpassController,
                hint: passwordHint,
                title: oldpass,
                isPass: true),
            10.heightBox,
            custom_text(
                controller: controller.newpassController,
                hint: passwordHint,
                title: newpass,
                isPass: true),
            20.heightBox,
            controller.isloading.value
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : SizedBox(
                    width: context.screenWidth - 40,
                    child: button(
                        color: Color.fromARGB(255, 23, 105, 86),
                        onPress: () async {
                          controller.isloading(true);
//agar image change nahi ho rahi

                          if (controller.profileImgPath.value.isNotEmpty) {
                            await controller.uploadProfileImage();
                          } else {
                            controller.profileImageLink = data['imageUrl'];
                          }

// purana  password sahi hua toh naya change hoga
                          if (data['password'] ==
                              controller.oldpassController.text) {
                            await controller.changeAuthPassword(
                                email: data['email'],
                                password: controller.oldpassController.text,
                                newpassword: controller.newpassController.text);

                            await controller.updateProfile(
                              imgUrl: controller.profileImageLink,
                              name: controller.nameController.text,
                              password: controller.newpassController.text,
                            );
                            VxToast.show(context, msg: "Updated");
                          } else {
                            VxToast.show(context, msg: "Wrong Old Password");
                            controller.isloading(false);
                          }
                        },
                        textColor: whiteColor,
                        title: "Save"),
                  ),
          ],
        )
            .box
            .white
            .shadowSm
            .padding(const EdgeInsets.all(10))
            .margin(const EdgeInsets.only(top: 2, left: 10, right: 10))
            .roundedSM
            .make(),
      ),
    ));
  }
}
