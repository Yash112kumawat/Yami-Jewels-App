import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/auth_controller.dart';
import 'package:emart_app/views/HomesScreen/Home.dart';
import 'package:emart_app/widget%20common/applogo.dart';
import 'package:emart_app/widget%20common/bgwidget.dart';
import 'package:emart_app/widget%20common/button.dart';
import 'package:emart_app/widget%20common/custom_text.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class signup_screen extends StatefulWidget {
  const signup_screen({Key? key}) : super(key: key);
  @override
  State<signup_screen> createState() => _signup_screenState();
}

class _signup_screenState extends State<signup_screen> {
  bool? ischeck = false;
  var controller = Get.put(AuthController());

  //textcontroller
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var retypePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgwidget(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Column(
                children: [
                  (context.screenHeight * 0.1).heightBox,
                  applogoWidget(),
                  10.heightBox,
                  "Join the $appname"
                      .text
                      .fontFamily(bold)
                      .white
                      .size(18)
                      .make(),
                  15.heightBox,
                  Obx(
                    () => Column(
                      children: [
                        custom_text(
                            hint: nameHint,
                            title: name,
                            controller: nameController,
                            isPass: false),
                        custom_text(
                            hint: emailhint,
                            title: email,
                            controller: emailController,
                            isPass: false),
                        custom_text(
                            hint: passwordHint,
                            title: password,
                            controller: passwordController,
                            isPass: true),
                        custom_text(
                            hint: passwordHint,
                            title: retypePassword,
                            controller: retypePasswordController,
                            isPass: true),
                        Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {},
                                child: forgetPass.text.make())),
                        3.heightBox,
                        //button  call kiya ha

                        Row(
                          children: [
                            Checkbox(
                                checkColor: redColor,
                                value: ischeck,
                                onChanged: (newvalue) {
                                  setState(() {
                                    ischeck = newvalue;
                                  });
                                  ischeck = newvalue;
                                }),
                            5.heightBox,
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "I agree to the ",
                                    style: TextStyle(
                                        fontFamily: bold, color: fontGrey)),
                                TextSpan(
                                    text: "Terms/Conditions",
                                    style: TextStyle(
                                        fontFamily: bold, color: redColor)),
                              ]),
                            )
                          ],
                        ),
                        controller.isloading.value
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(redColor),
                              )
                            : button(
                                color: redColor,
                                title: signup,
                                textColor: whiteColor,
                                onPress: () async {
                                  if (ischeck != false) {
                                    controller.isloading(true);
                                    try {
                                      await controller
                                          .singupMethod(
                                              context: context,
                                              email: emailController.text,
                                              password: passwordController.text)
                                          .then((value) {
                                        return controller.storedUserData(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            name: nameController.text);
                                      }).then((value) {
                                        VxToast.show(context, msg: loggedin);
                                        Get.offAll(() => const Home());
                                      });
                                    } catch (e) {
                                      auth.signOut();
                                      VxToast.show(context, msg: e.toString());
                                      controller.isloading(false);
                                    }
                                  }
                                }).box.width(context.screenWidth - 50).make(),
                        5.heightBox,
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Alreadyhaveaccount? ",
                                style: TextStyle(
                                    fontFamily: bold, color: fontGrey)),
                            TextSpan(
                              text: "Log In",
                              style:
                                  TextStyle(fontFamily: bold, color: redColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.back();
                                },
                            )
                          ]),
                        ),
                      ],
                    )
                        .box
                        .white
                        .rounded
                        .padding(const EdgeInsets.all(16))
                        .width(context.screenWidth - 70)
                        .shadowSm
                        .make(),
                  )
                ],
              ),
            )));
  }
}
