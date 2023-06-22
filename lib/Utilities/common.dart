import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonUtilities {
  static Widget txtfield(context, controller, hinttxt, keyboardType, obsectxt) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xffeaeaea),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            keyboardType: keyboardType,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            obscureText: obsectxt,
            textAlign: TextAlign.center,
            controller: controller,
            decoration: InputDecoration(
                fillColor: const Color(0xffeaeaea),
                filled: true,
                hintText: hinttxt,
                hintStyle: const TextStyle(color: Colors.black),
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }

  static Color primaryclr = Colors.red;

  static button(clr, text, ontap, style) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 50,
        width: 120,
        decoration:
            BoxDecoration(color: clr, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            text,
            style: style,
          ),
        ),
      ),
    );
  }

  // static toastMessage(String message, [isShort = true, int gravity = 2]) {
  //   return Fluttertoast.showToast(
  //       msg: message,
  //       toastLength: isShort ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
  //       gravity: gravity == 2
  //           ? ToastGravity.BOTTOM
  //           : (gravity == 1 ? ToastGravity.CENTER : ToastGravity.TOP),
  //       timeInSecForIosWeb: isShort ? 1 : 3,
  //       backgroundColor: Colors.black87,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  // }

  static String assetImage(String imageName) {
    return 'assets/images/$imageName';
  }

  // static Future<bool> checkStoragePermission() async {
  //   await Future.delayed(const Duration(seconds: 1));
  //   PermissionStatus? checkResult = await Permission.storage.request();
  //   if (checkResult != PermissionStatus.granted) {
  //     var status = await Permission.storage.request();
  //     if (status == PermissionStatus.granted) {
  //       return true;
  //     }
  //   } else {
  //     return true;
  //   }
  //   return false;
  // }
  // static alertdialog(title, content) {
  //   return Get.dialog(AlertDialog(title: title, content: content),
  //       barrierDismissible: false);
  // }

  static TextStyle dashboardtxt =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w400);
  static TextStyle drwertxt =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  static TextStyle drwertxt2 = const TextStyle(
      fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500);
}
