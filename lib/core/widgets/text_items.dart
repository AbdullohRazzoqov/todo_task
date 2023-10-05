

import 'package:flutter/material.dart';

class CustomText{
  static  Text items({required String text,required double size,Color?color,var fontWeight,}){
    return Text(
      text,style: TextStyle(fontWeight: fontWeight,color: color,fontSize: size),
    );
  }
}