import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/router/router.dart';

showSnackBarCustom({
  Color? backgroundColor,
  // required Color textColor,
  required String text,
}) {
  return ScaffoldMessenger.of(NavigationManager.navigatorKey.currentContext!)
      .showSnackBar(SnackBar(
    content: Text(
      text,
      style: TextStyle(fontSize: 15, color: Colors.white),
    ),
    backgroundColor: backgroundColor ?? Colors.red,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.only(
      left: 20,
      right: 20,
      bottom: 20,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(7),
    ),
    duration: const Duration(seconds: 4),
    elevation: 0,
  ));
}
