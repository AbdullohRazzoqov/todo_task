import 'package:flutter/material.dart';

class GlobalInputDecoration{
  static InputDecoration items ({required String hintext,Widget? suffixIcons }){
    return InputDecoration(
      fillColor: const Color(0xffF5F5F5),
      filled: true,
      hintText: hintext,
      suffixIcon: suffixIcons,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }
}