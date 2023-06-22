import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videoplayerapp/Utilities/common.dart';

import '../../controllers/logincontroller.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController logincontroller = Get.put(LoginController());
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: Obx(() => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Login Now",
                      style: CommonUtilities.dashboardtxt,
                    ),
                    Image(
                        height: Get.height / 3,
                        image: AssetImage(
                            CommonUtilities.assetImage("login.png"))),
                    if (logincontroller.otpvisible.value == false)
                      CommonUtilities.txtfield(
                          context,
                          logincontroller.userctrl,
                          "Mobile Number",
                          TextInputType.number,
                          false),
                    if (logincontroller.otpvisible.value == true)
                      CommonUtilities.txtfield(
                          context,
                          logincontroller.psswrdctrl,
                          "OTP",
                          TextInputType.number,
                          true),
                    if (logincontroller.otpvisible.value == false &&
                        logincontroller.isLoading.isFalse)
                      CommonUtilities.button(
                          CommonUtilities.primaryclr, "Sent OTP", () async {
                        if (logincontroller.userctrl.text.isNotEmpty) {
                          await logincontroller.verifyPhoneNumber();
                        }
                      }, const TextStyle(fontSize: 22, color: Colors.white)),
                    if (logincontroller.otpvisible.value == true &&
                        logincontroller.isLoading.isFalse)
                      CommonUtilities.button(
                          CommonUtilities.primaryclr, "Verify OTP", () async {
                        if (logincontroller.psswrdctrl.text.isNotEmpty) {
                          await logincontroller.signInWithOTP();
                        }
                      }, const TextStyle(fontSize: 22, color: Colors.white)),
                    if (logincontroller.isLoading.isTrue)
                      const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                  ],
                ))));
  }
}
