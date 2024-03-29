import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_task/core/helpers/parse.dart';
import 'package:todo_task/core/utils/app_colors.dart';
import 'package:todo_task/core/utils/app_icons.dart';
import 'package:todo_task/data/db/model/event_model.dart';
import 'package:todo_task/presentation/pages/add_task/widgets/input_text.dart';

import '../../bloc/main/main_bloc.dart';

class AddTask extends StatefulWidget {
  const AddTask({
    super.key,
    required this.year,
    required this.month,
    required this.day,
  });

  final int year;
  final int month;
  final int day;

  @override
  State<AddTask> createState() => _AddTaskState();
}

TextEditingController inputName = TextEditingController();
TextEditingController inputLocation = TextEditingController();
TextEditingController inputDescription = TextEditingController();
List<Color> items = const [
  Color(0xFF009FEE),
  Color(0xFFEE2B00),
  Color(0xFFEE8F00),
];
late DateTime dateTime;
Color selectColor = const Color(0xFF009FEE);

class _AddTaskState extends State<AddTask> {
  String firstTime = '00:00';
  String secondTime = '00:59';

  @override
  void initState() {
    dateTime = DateTime(widget.year, widget.month, widget.day);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainBloc, MainState>(
      listener: (context, state) {
        if (state.stateStatus == StateStatus.save) {
          Navigator.pop(context);
          TopSnackBarMessage.message(state.message!, Colors.green);
          inputName.clear();
          inputDescription.clear();
          inputLocation.clear();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16.h + 48.h,
              ),
              Row(
                children: [
                  GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pop(context);
                        inputDescription.clear();
                        inputName.clear();
                        inputLocation.clear();
                      },
                      child: SvgPicture.asset(
                        AppIcons.arrowLeftIcon,
                        height: 24.h,
                        width: 24.h,
                      ))
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              InputWidgets(
                text: 'Event name',
                inputText: inputName,
              ),
              const SizedBox(
                height: 2,
              ),
              InputWidgets(
                inputText: inputDescription,
                text: 'Event Description',
                maxLinges: 7,
              ),
              InputWidgets(
                text: 'Event location',
                inputText: inputLocation,
              ),
              SizedBox(
                height: 16.sp,
              ),
              Text(
                'Priority color',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 6.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 76.h,
                    height: 36.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        8.r,
                      ),
                      color: const Color(0xFFF3F4F6),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<Color>(
                          value: selectColor,
                          icon: SvgPicture.asset(AppIcons.chevronDownIcon),
                          items: items.map((Color item) {
                            return DropdownMenuItem<Color>(
                              value: item,
                              child: Container(
                                width: 24.w,
                                height: 22.h,
                                color: item,
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectColor = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                'Event time',
                style: TextStyle(
                  color: AppColors.inputTitleColor,
                  fontSize: 14.sp,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 1.43,
                  letterSpacing: 0.25,
                ),
              ),
              Container(
                height: 46.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.inputColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        firstTime = await timePicker(context) ?? firstTime;
                        setState(() {});
                      },
                      child: Text(
                        firstTime,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 4.h),
                      width: 1,
                      color: AppColors.greyTextColor,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        secondTime = await timePicker(context) ?? secondTime;
                        setState(() {});
                      },
                      child: Text(
                        secondTime,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (inputName.text.isEmpty) {
                    print('Hello');
                    TopSnackBarMessage.message(
                        "Event name must not be empty", Colors.red);
                  } else {
                    context.read<MainBloc>().add(
                          EventAdded(
                            event: Event(
                                name: inputName.text,
                                description: inputDescription.text,
                                secondDate: secondTime,
                                firstDate: firstTime,
                                location: inputLocation.text,
                                day: dateTime.toIso8601String(),
                                color: selectColor.value),
                          ),
                        );
                    print('object');
                    // Navigator.pop(context);
                  }
                },
                child: Container(
                  height: 46.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFF009FEE)),
                  child: Center(
                    child: Text(
                      'Add',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> timePicker(BuildContext context) async {
    DateTime? selectedTime;

    selectedTime = await showModalBottomSheet<DateTime>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
          height: 300.h,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 250.h,
                child: SafeArea(
                  top: false,
                  child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    mode: CupertinoDatePickerMode.time,
                    use24hFormat: true,
                    onDateTimeChanged: (DateTime newTime) {
                      selectedTime = newTime;
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, selectedTime);
                },
                child: Container(
                  height: 46.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFF009FEE),
                  ),
                  child: Center(
                    child: Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );

    if (selectedTime != null) {
      return '${convertToTwoDigit(selectedTime!.hour)}:${convertToTwoDigit(selectedTime!.minute)}';
    } else {
      return null;
    }
  }
}

class TopSnackBarMessage {
  static message(String text, Color color) {
    Fluttertoast.showToast(
        msg: text,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
