import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/utils/app_colors.dart';

class InputWidgets extends StatelessWidget {
  InputWidgets({
    super.key,
    this.hint,
    this.onIconTap,
    required this.text,
    this.icon,
    required this.inputText,
    this.maxLinges = 1
  });

  final String? hint;
  final VoidCallback? onIconTap;
  final String text;
  final Widget? icon;
  TextEditingController inputText;
  int maxLinges;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 16.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                height: 1.43,
                letterSpacing: 0.25,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 2.w,
        ),
        Container(
          height: 42.h,
          decoration: BoxDecoration(
            color: AppColors.inputColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: TextFormField(
              // autofocus: true,
              maxLines: maxLinges,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              controller: inputText,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  suffixIcon: icon ?? const SizedBox(),
                  contentPadding: EdgeInsets.all(5.w),
                  hintText: hint,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none),
            ),
          ),
        ),
      ],
    );
  }
}
