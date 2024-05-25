import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget orderStatus({
  required IconData icon,
  required Color color,
  required String title,
  required showDone, // Added parameter to indicate completion
}) {
  return ListTile(
    leading: Icon(
      icon,

      color: Colors.grey, // Color changes based on completion
    )
        .box
        .border(color: Colors.grey)
        .roundedSM
        .padding(const EdgeInsets.all(4))
        .make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          title.text
              .color(darkFontGrey)
              .make(), // Use the color from your constants
          // Only show the done icon if the step is completed
          Icon(
            Icons.done,
            color: color,
          ),
        ],
      ),
    ),
  );
}

//my code

