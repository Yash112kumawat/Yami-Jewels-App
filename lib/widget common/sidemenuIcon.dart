import 'package:emart_app/consts/consts.dart';

Widget sideMenuIcon({required IconData icon, required String label}) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        SizedBox(height: 8),
        Text(label),
      ],
    ),
  );
}
