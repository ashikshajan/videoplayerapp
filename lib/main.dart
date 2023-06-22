// ignore_for_file: must_be_immutable

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/dashboardctrl.dart';
import 'screens/splash/spalshscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  DashbrdController dashbrdcontroller = Get.put(DashbrdController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashbrdController>(builder: (controller) {
      dashbrdcontroller.preventScreenshots();

      return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'VideoPlayer',
          theme: ThemeData(primarySwatch: Colors.red),

          // standard dark theme
          darkTheme: ThemeData.dark(),
          themeMode: dashbrdcontroller.themeModee,
          home: const Splash());
    });
  }
}
