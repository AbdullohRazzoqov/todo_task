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
import 'package:todo_task/presentation/global_widgets/custom_timer_picker.dart';
import 'package:todo_task/presentation/pages/add_task/add_task.dart';
import 'package:todo_task/presentation/pages/add_task/widgets/input_text.dart';

import '../../bloc/main/main_bloc.dart';

class EditEvent extends StatefulWidget {
  EditEvent({super.key, required this.event});
  Event event;
  @override
  State<EditEvent> createState() => _EditEventState();
}

TextEditingController inputName = TextEditingController();
TextEditingController inputLocation = TextEditingController();
TextEditingController inputDescription = TextEditingController();
late DateTime dateTime;
List<Color> items = const [
  Color(0xFF009FEE),
  Color(0xFFEE2B00),
  Color(0xFFEE8F00),
];

Color selectColor = const Color(0xFF009FEE);

class _EditEventState extends State<EditEvent> {
  String firstTime = '';
  String secondTime = '';
  late DateTime dateTime;
  @override
  void initState() {
    Event event = widget.event;
    inputName.text = event.name;
    inputLocation.text = event.location;
    inputDescription.text = event.description;
    firstTime = event.firstDate;
    secondTime = event.secondDate;
    dateTime = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainBloc, MainState>(
      listener: (context, state) {
        if (state.stateStatus == StateStatus.edit) {
          Navigator.pop(context);
          Navigator.pop(context);
          TopSnackBarMessage.message(
              "The event was successfully modified", Colors.green);
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
                        inputLocation.clear();
                        inputName.clear();
                        inputDescription.clear();
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
                inputText: inputDescription,maxLinges: 7, text: 'Event Description',
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
                      onTap: () async {
                        dateTime = await CustomTimePicker.timePicker(context) ??
                            dateTime;
                        setState(() {});
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Text(
                        '${dateTime.day}-${dateTime.month}-${dateTime.year}',
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
              SizedBox(
                height: 16.h,
              ),
              const Expanded(child: SizedBox()),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (inputName.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Event name must not be empty",
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    context.read<MainBloc>().add(
                          EventEdited(
                            event: Event(
                                name: inputName.text,
                                description: inputDescription.text,
                                secondDate: secondTime,
                                firstDate: firstTime,
                                location: inputLocation.text,
                                day: dateTime.toIso8601String(),
                                color: selectColor.value,
                                id: widget.event.id),
                            id: widget.event.id!,
                          ),
                        );
                  }
                },
                child: Container(
                  height: 46.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFF009FEE)),
                  child: Center(
                    child: Text(
                      'Edit',
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
                behavior: HitTestBehavior.opaque,
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
                      'Edit',
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
