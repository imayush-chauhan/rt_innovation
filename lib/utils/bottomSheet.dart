import 'package:flutter/material.dart';

class MySheet {

  static bottomSheet(BuildContext context,Widget widget,Color color) async {
    return await showModalBottomSheet(
        context: context,
        elevation: 10,
        useSafeArea: true,
        backgroundColor: color,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))),
        builder: (context) {
          return widget;
        });
  }

}