import 'package:emart_app/consts/consts.dart';

Widget custom_text({String? title, String? hint, controller, isPass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text
          .color(Color.fromARGB(255, 23, 105, 86))
          .fontFamily(semibold)
          .size(16)
          .make(),
      5.heightBox,
      TextFormField(
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
            hintStyle: TextStyle(fontFamily: semibold, color: textfieldGrey),
            hintText: hint,
            isDense: true,
            fillColor: lightGrey,
            filled: true,
            border: InputBorder.none,
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: redColor))),
      ),
      5.heightBox,
    ],
  );
}
