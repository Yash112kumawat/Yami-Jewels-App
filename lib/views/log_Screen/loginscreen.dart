import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controller/auth_controller.dart';
import 'package:emart_app/views/HomesScreen/home_screen.dart';
import 'package:emart_app/views/log_Screen/signup_screen.dart';
import 'package:emart_app/widget%20common/applogo.dart';
import 'package:emart_app/widget%20common/bgwidget.dart';
import 'package:emart_app/widget%20common/button.dart';
import 'package:emart_app/widget%20common/custom_text.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class loginscreen extends StatelessWidget {
  const loginscreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgwidget(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Column(
                children: [
                  (context.screenHeight * 0.1).heightBox,
                  applogoWidget(),
                  10.heightBox,
                  "Log in to $appname"
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
                            hint: emailhint,
                            title: email,
                            isPass: false,
                            controller: controller.emailController),
                        custom_text(
                            hint: password,
                            title: password,
                            isPass: true,
                            controller: controller.passwordController),
                        Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {},
                                child: forgetPass.text.make())),
                        5.heightBox,
                        //button  call kiya hai

                        controller.isloading.value
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(redColor),
                              )
                            : button(
                                color: redColor,
                                title: login,
                                textColor: whiteColor,
                                onPress: () async {
                                  controller.isloading(true);
                                  await controller
                                      .loginMethod(context: context)
                                      .then((value) {
                                    if (value != null) {
                                      VxToast.show(context, msg: loggedin);
                                      Get.offAll(() => const home_screen());
                                    } else {
                                      controller.isloading(false);
                                    }
                                  });
                                },
                              ).box.width(context.screenWidth - 50).make(),

                        5.heightBox,

                        createnewaccount.text.color(fontGrey).make(),

                        5.heightBox,

                        button(
                            color: lightGolden,
                            title: signup,
                            textColor: redColor,
                            onPress: () {
                              Get.to(() => const signup_screen());
                            }).box.width(context.screenWidth - 50).make(),

                        10.heightBox,

                        loginwith.text.color(fontGrey).make(),
                        5.heightBox,
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                                3,
                                (index) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        backgroundColor: lightGrey,
                                        radius: 25,
                                        child: Image.asset(
                                          sociallist[index],
                                          width: 30,
                                        ),
                                      ),
                                    ))),
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
