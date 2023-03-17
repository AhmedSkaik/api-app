import 'package:flutter/material.dart';

mixin Helpers {
  void showSnackBar(BuildContext context,
      {required String massage, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(massage),
        backgroundColor: error ? Colors.red : Colors.green,
        dismissDirection: DismissDirection.horizontal));
  }
}
