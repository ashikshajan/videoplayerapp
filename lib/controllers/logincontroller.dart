import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videoplayerapp/screens/dashboard/dashboard.dart';

import '../Utilities/sharedpref.dart';

class LoginController extends GetxController {
  final psswrdctrl = TextEditingController();
  final userctrl = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationIdreceived = "";
  RxBool otpvisible = false.obs;
  RxBool isLoading = false.obs;

  Future<void> verifyPhoneNumber() async {
    isLoading.value = true;
    await auth.verifyPhoneNumber(
      phoneNumber: "+91${userctrl.text}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth
            .signInWithCredential(credential)
            .then((value) => {log("You are logged in")});
        otpvisible.value = true;
        isLoading.value = false;
        update();
      },
      verificationFailed: (FirebaseAuthException e) {
        log('Verification failed: ${e.code}');
        Get.snackbar(
          "Failed",
          e.code,
          backgroundColor: Colors.white,
          colorText: Colors.black,
        );
        isLoading.value = false;
      },
      codeSent: (String verificationId, int? resendToken) {
        log('Verification ID: $verificationId');
        verificationIdreceived = verificationId.toString();
        otpvisible.value = true;
        isLoading.value = false;
        update();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        isLoading.value = false;
        log('Code retrieval timeout');
      },
    );
  }

  Future<void> signInWithOTP() async {
    isLoading.value = true;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIdreceived,
        smsCode: psswrdctrl.text,
      );
      await auth.signInWithCredential(credential);
      await SharedPrefsUtil.setString(SharedPrefsUtil.login, "true");
      isLoading.value = false;
      Get.offAll(const DashboardScreen());
    } catch (e) {
      Get.snackbar(
        "Failed",
        "Invalid verification code",
        backgroundColor: Colors.white,
        colorText: Colors.black,
      );
      log('Authentication failed: $e');
      isLoading.value = false;
    }
  }
}
