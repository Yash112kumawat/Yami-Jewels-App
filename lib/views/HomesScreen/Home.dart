/*import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/home_controller.dart';
import 'package:emart_app/views/Cart/Cart_screen.dart';
import 'package:emart_app/views/HomesScreen/home_screen.dart';
import 'package:emart_app/views/categories_screen/categorie_screen.dart';
import 'package:emart_app/views/profile/Profile_screen.dart';
import 'package:emart_app/widget%20common/exit_dailogue.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(home_controller());

    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(icHome, width: 26), label: home),
      BottomNavigationBarItem(
          icon: Image.asset(icCategories, width: 26), label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(icCart, width: 26), label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(icProfile, width: 26), label: account)
    ];

    var navBody = [
      const home_screen(),
      const categorie_screen(),
      const Cart_screen(),
      const Profile_screen(),
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDailogue(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(() => Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value))),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: redColor,
            selectedLabelStyle: TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            items: navbarItem,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
*/

import 'package:emart_app/views/Chat_screen/messaging_screen.dart';
import 'package:flutter/material.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/home_controller.dart';
import 'package:emart_app/views/Cart/Cart_screen.dart';
import 'package:emart_app/views/HomesScreen/home_screen.dart';
import 'package:emart_app/views/categories_screen/categorie_screen.dart';
import 'package:emart_app/views/profile/Profile_screen.dart';
import 'package:emart_app/widget%20common/exit_dailogue.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(home_controller());

    var navDrawerItems = [
      DrawerItem(
          icon: icCategories,
          label: categories,
          onTap: () {
            Get.to(() => categorie_screen());
          }),
      DrawerItem(
          icon: icMessages,
          label: messagesCollection,
          onTap: () {
            Get.to(() => MessagagesScreen());
          }),
      DrawerItem(
          icon: icProfile,
          label: account,
          onTap: () {
            Get.to(() => Profile_screen());
          }),
    ];

    var navBody = [
      const home_screen(),
      const categorie_screen(),
      const Cart_screen(),
      const Profile_screen(),
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDailogue(context));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Yami Jewels',
          ),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 25),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => Cart_screen());
                },
                icon: Icon(
                  Icons.trolley,
                  color: Colors.black,
                  size: 25,
                ))
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 23, 105, 86),
                ),
                child: Text(
                  'Hello User',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              for (var item in navDrawerItems)
                ListTile(
                  title: Text(item.label),
                  leading: Image.asset(item.icon, width: 26),
                  onTap: item.onTap,
                ),
            ],
          ),
        ),
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: navBody.elementAt(controller.currentNavIndex.value),
        ),
      ),
    );
  }
}

class DrawerItem {
  final String icon;
  final String label;
  final VoidCallback onTap;

  DrawerItem({required this.icon, required this.label, required this.onTap});
}
