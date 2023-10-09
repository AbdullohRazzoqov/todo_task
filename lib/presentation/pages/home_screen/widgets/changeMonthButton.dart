import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ChangeMonthButton extends StatelessWidget {
const  ChangeMonthButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

 final GestureTapCallback onTap;
 final String icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: const Color(0xFFEFEFEF),
        child: Center(
          child: SvgPicture.asset(
            icon,
            width: 20.w,
            height: 20.h,
          ),
        ),
      ),
    );
  }
}
