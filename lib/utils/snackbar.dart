import 'package:flutter/material.dart';
import 'package:rt_innovation/utils/color.dart';

snackBar(BuildContext context, String s){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 2000),
      backgroundColor: MyColor.main,
      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Text(s,
        style: const TextStyle(
            color: MyColor.white,
            fontSize: 16,
            fontWeight: FontWeight.w600),
      ),
      behavior: SnackBarBehavior.floating,
    ),
  );
}