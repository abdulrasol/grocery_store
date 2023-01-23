import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color color = Colors.black87; //Color(0xFF144DDE);
const SizedBox sizedBox = SizedBox(height: 20);

const boxBorder = BorderSide(
  color: color, //Color(0xFF134EDE),
  width: 1.0,
  style: BorderStyle.solid,
);

const textEditField = InputDecoration(
  border: border,
  focusedBorder: border,
);

const border = OutlineInputBorder(
  borderSide: BorderSide(
    width: 1,
  ),
  borderRadius: BorderRadius.all(Radius.circular(7.0)),
);

subtitleText(String subtitle) {
  return Text(
    subtitle,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );
}

pageTitle(String title) {
  return Text(
    title,
    textAlign: TextAlign.center,
    style: const TextStyle(
      fontSize: 38,
      fontWeight: FontWeight.bold,
    ),
  );
}

OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15),
  borderSide: const BorderSide(
    color: Colors.black,
    width: 1,
  ),
);
InputDecoration inputDecoration = InputDecoration(
  border: _outlineInputBorder,
  focusedBorder: _outlineInputBorder,
  enabledBorder: _outlineInputBorder,
);

showSnackbar(String title, String message, String image,
    {TextButton? mainButton, bool isLocalImage = false}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.TOP,
    isDismissible: true,
    backgroundColor: Colors.black,
    colorText: Colors.white,
    icon: Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 8),
      child:
          isLocalImage ? Image.asset(image) : Image.memory(base64Decode(image)),
    ),
    shouldIconPulse: true,
    mainButton: mainButton,
  );
}
