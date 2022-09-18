import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thiran_task2/app/widgets/text.customized.dart';

snackBarCustomized({required String title, required String messege}) {
  return Get.snackbar("", "",
  animationDuration: const Duration(seconds: 1),
      isDismissible: true,
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.orange,
      messageText: TextCustomized(
        textAlign: TextAlign.left,
        textSize: 16,
        textColor: Colors.black45,
        text: messege,
      ),
      titleText: TextCustomized(
        textAlign: TextAlign.left,
        textSize: 16,
        text: title,
        fontWeight: FontWeight.bold,
        textColor: Colors.white,
      ));
}
