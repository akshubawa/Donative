import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({required String message, BuildContext? context}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Theme.of(context!).colorScheme.primaryContainer,
      textColor: Theme.of(context).colorScheme.primary,
      fontSize: 16.0);
}
