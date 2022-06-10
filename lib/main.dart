import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stock_management_system/view/screens/choose_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(1080, 1920),
        builder: () => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            // theme: ThemeData(
            //   visualDensity: VisualDensity.adaptivePlatformDensity
            // ),
            home: ChooseScreen()
        )
    );
  }
}
