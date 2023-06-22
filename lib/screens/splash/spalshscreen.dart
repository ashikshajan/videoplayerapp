import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videoplayerapp/Utilities/common.dart';
import 'package:videoplayerapp/Utilities/sharedpref.dart';
import 'package:videoplayerapp/screens/Loginpage/login.dart';
import 'package:videoplayerapp/screens/dashboard/dashboard.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      checklogin();
    });

    return Scaffold(
      backgroundColor: CommonUtilities.primaryclr,
      body: const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }

  checklogin() async {
    var loginval = await SharedPrefsUtil.getString(SharedPrefsUtil.login);

    if (loginval == "true") {
      Get.offAll(const DashboardScreen());
    } else {
      Get.offAll(const Login());
    }
  }
}
