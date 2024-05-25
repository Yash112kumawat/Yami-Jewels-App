import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/cart_controller.dart';
import 'package:emart_app/views/Cart/payment_method.dart';
import 'package:emart_app/widget%20common/button.dart';
import 'package:emart_app/widget%20common/custom_text.dart';
import 'package:get/get.dart';

class Shipping_Detail extends StatelessWidget {
  const Shipping_Detail({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(Colors.black)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: button(
          onPress: () {
            if (controller.addressController.text.length > 30) {
              Get.to(() => const PaymentMethod());
            } else {
              VxToast.show(context, msg: "Please fill the form");
            }
          },
          color: const Color.fromARGB(255, 23, 105, 86),
          textColor: whiteColor,
          title: "Continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            custom_text(
                hint: "Address",
                isPass: false,
                title: "Address",
                controller: controller.addressController),
            custom_text(
                hint: "City",
                isPass: false,
                title: "City",
                controller: controller.cityController),
            custom_text(
                hint: "State",
                isPass: false,
                title: "State",
                controller: controller.stateController),
            custom_text(
                hint: "Phone Number",
                isPass: false,
                title: "Phone Number",
                controller: controller.phonenumberController),
            custom_text(
                hint: "Postal Code",
                isPass: false,
                title: "Postal Code",
                controller: controller.postalcodeController),
          ],
        ),
      ),
    );
  }
}
