import 'package:flutter/material.dart';

extension TimeHelperExtension on TimeOfDay {
  String getHourAndMinute() {
    var min = minute < 10 ? "0$minute" : "$minute";
    return "$hour:$min";
  }
}
