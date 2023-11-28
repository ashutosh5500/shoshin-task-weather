import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static showSnackBar(BuildContext context, String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: Colors.blueGrey,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
