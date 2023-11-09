import 'package:flutter/material.dart';
import 'package:rt_innovation/utils/color.dart';
import 'package:rt_innovation/utils/textStyle.dart';

class MyTextField {

  static textField(String name, TextEditingController controller, TextInputType type, bool val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SizedBox(
        height: 40,
        child: TextFormField(
          controller: controller,
          cursorColor: Colors.black54,
          cursorHeight: 22.5,
          keyboardType: type,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person_outline,color: MyColor.main,size: 20,),
            hintText: name,
            hintStyle: MyTextStyle.fontD,
            // fillColor: Colors.black12,
            // filled: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: MyColor.border,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: MyColor.border,
                )),
            contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
          ),
          validator: (_) {
            if (val == false) {
              return "Invalid text";
            }
            return null;
          },
          style: MyTextStyle.fontB,
        ),
      ),
    );
  }

}