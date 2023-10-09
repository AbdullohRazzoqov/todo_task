import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/utils/app_colors.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.ontap, this.text = ''});
  final GestureTapCallback ontap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 46.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFF009FEE),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
