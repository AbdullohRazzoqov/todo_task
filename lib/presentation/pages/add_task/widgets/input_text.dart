
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/utils/app_colors.dart';

class InputWidgets extends StatelessWidget {
  InputWidgets({super.key, required this.inputText, required this.nameText});
  TextEditingController inputText;
  String nameText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 16.h,
        ),
        Text(
          nameText,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormField(
          controller: inputText,
          cursorColor: AppColors.blue,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF3F4F6),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
          ),
          keyboardType: TextInputType.text,
        ),
      ],
    );
  }
}
