import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/orders_screen/components/order_placed_detail.dart';
import 'package:emart_app/views/orders_screen/components/order_status.dart';

import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatelessWidget {
  final dynamic data;
  const OrderDetails({Key? key, this.data, showDone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(data);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(
                color: redColor,
                icon: Icons.done,
                title: "Placed",
                showDone: data['order_placed'] == 'yes',
              ),
              orderStatus(
                  color: Colors.blue,
                  icon: Icons.thumb_up,
                  title: " Confirmed",
                  showDone: data['order_confrimed'] == 'yes'),
              orderStatus(
                  color: Colors.yellow,
                  icon: Icons.car_crash,
                  title: " On Delivery",
                  showDone: data['order_on_delivery'] == 'yes'),
              orderStatus(
                  color: Colors.purple,
                  icon: Icons.done_all_rounded,
                  title: "Deliverd",
                  showDone: data['order_delivered'] == 'yes'),
              Divider(),
              10.heightBox,
              Column(
                children: [
                  orderPlacedDetails(
                      d1: data['order_code'],
                      d2: data['shipping_method'],
                      title1: "Order Code",
                      title2: "Shipping Method"),
                  orderPlacedDetails(
                      d1: intl.DateFormat()
                          .add_yMd()
                          .format((data['order_date'].toDate())),
                      d2: data['payment_method'],
                      title1: "Order Date",
                      title2: "Payment Method"),
                  orderPlacedDetails(
                      d1: "Unpaid",
                      d2: "Order Placed",
                      title1: "Payment Status",
                      title2: "Delivery Status"),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Address".text.fontFamily(semibold).make(),
                            "${data['order_by_name']}".text.make(),
                            "${data['order_by_email']}".text.make(),
                            "${data['order_by_address']}".text.make(),
                            "${data['order_by_city']}".text.make(),
                            "${data['order_by_state']}".text.make(),
                            "${data['order_by_phonenumber']}".text.make(),
                            "${data['order_by_postalcode']}".text.make()
                          ],
                        ),
                        SizedBox(
                          width: 40,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Total Amount"
                                  .text
                                  .fontFamily(semibold)
                                  .color(redColor)
                                  .make(),
                              "${data['total_amount']}"
                                  .text
                                  .fontFamily(bold)
                                  .color(redColor)
                                  .make()
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ).box.outerShadowMd.white.make(),
              Divider(),
              "Ordered Product"
                  .text
                  .fontFamily(semibold)
                  .color(darkFontGrey)
                  .size(16)
                  .makeCentered(),
              10.heightBox,
              ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(data['orders'].length, (index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            orderPlacedDetails(
                                title1: data['orders'][index]['title'],
                                title2: data['orders'][index]['tprice'],
                                d1: {data['orders'][index]['qty']},
                                d2: "Non Refudable"),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                width: 30,
                                height: 20,
                                color: Color(data['orders'][index]['color']),
                              ),
                            ),
                            const Divider(),
                          ],
                        );
                      }).toList())
                  .box
                  .outerShadowSm
                  .white
                  .margin(EdgeInsets.only(bottom: 4))
                  .make(),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
