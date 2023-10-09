import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/presentation/global_widgets/custom_button.dart';

class CustomTimePicker {
  static Future<DateTime?> timePicker(BuildContext context) async {
    DateTime? selectedTime;

    selectedTime = await showModalBottomSheet<DateTime>(
      context: context,
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0.r),
        ),
      ),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r)),
          height: 320.h,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 260.h,
                child: SafeArea(
                  top: false,
                  child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    mode: CupertinoDatePickerMode.date,
                    use24hFormat: true,
                    onDateTimeChanged: (DateTime newTime) {
                      selectedTime = newTime;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                child: CustomButton(
                  ontap: () {
                    Navigator.pop(context, selectedTime);
                  },
                  text: 'Go',
                ),
              )
            ],
          ),
        );
      },
    );
    if (selectedTime != null) {
      return selectedTime;
    } else {
      return null;
    }
  }
}
