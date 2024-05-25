import 'package:emart_app/views/splash_screen/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'consts/consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCIKUWcjZJ9Qjw06M_Avx2lAg1IkSZK824",
          appId: "1:344554622496:android:8ea1977c023eb5339c7645",
          messagingSenderId: "344554622496",
          storageBucket: "yami-jewels-72d42.appspot.com",
          projectId: "yami-jewels-72d42"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 23, 105, 86),
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: darkFontGrey),
            backgroundColor: Color.fromARGB(255, 23, 105, 86),
          ),
          fontFamily: regular),
      home: const SplashScreen(),
    );
  }
}




/* loading indicator 
CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                 )*/ 