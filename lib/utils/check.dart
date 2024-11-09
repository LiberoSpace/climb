import 'package:flutter/material.dart';

bool checkNickNamePattern(String nickName) {
  var pattern = r'^[a-zA-Z가-힣_.]{2,9}$';
  var regExp = RegExp(pattern);
  return regExp.hasMatch(nickName);
}

bool checkBirthDayPattern(String birthDay) {
  var pattern = r'^(19|20)\d{2}(0[1-9]|1[0-2])(0[1-9]|1\d|2\d|3[01])$';
  var regExp = RegExp(pattern);
  return regExp.hasMatch(birthDay);
}

bool checkStringIsDouble(String num) {
  try {
    double.parse(num);
    return true;
  } catch (e) {
    return false;
  }
}

void translateTextToDoubleForm(TextEditingController controller) {
  if (checkStringIsDouble(controller.text)) {
    controller.text = double.parse(controller.text).toStringAsFixed(1);
  } else {
    controller.text = "";
  }
}
