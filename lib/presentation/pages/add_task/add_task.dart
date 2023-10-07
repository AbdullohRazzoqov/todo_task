import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_task/core/utils/app_colors.dart';
import 'package:todo_task/core/utils/app_icons.dart';
import 'package:todo_task/presentation/bloc/add_task/bloc/bloc/add_task_bloc.dart';
import 'package:todo_task/presentation/pages/add_task/widgets/input_text.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

TextEditingController inputName = TextEditingController();
TextEditingController inputLocation = TextEditingController();
TextEditingController inputTime = TextEditingController();
TextEditingController inputDescription = TextEditingController();
List<Color> items = const [
  Color(0xFF009FEE),
  Color(0xFFEE2B00),
  Color(0xFFEE8F00),
];
Color selectColor = const Color(0xFF009FEE);

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: ListView(
          children: [
            SizedBox(
              height: 16.h,
            ),
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(AppIcons.arrowLeftIcon))
              ],
            ),
            SizedBox(
              height: 32.h,
            ),
            InputWidgets(
              nameText: 'Event name',
              inputText: inputName,
            ),
            const SizedBox(
              height: 2,
            ),
            BlocBuilder<AddTaskBloc, AddTaskState>(
              builder: (context, state) {
                if (state is ValidateErrorState) {
                  return Text(
                    state.taskNameError,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.red),
                  );
                }
                return SizedBox();
              },
            ),
            InputWidgets(
              nameText: 'Event description',
              inputText: inputDescription,
            ),
            InputWidgets(
              nameText: 'Event location',
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
            InputWidgets(
              nameText: 'Event time',
              inputText: inputTime,
            ),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('This is snackbar'),
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height - 100,
                      left: 10,
                      right: 10,
                    ),
                  ),
                ); // showTopSnackBar(
                //     Overlay.of(context),
                //     CustomSnackBar.success(
                //       message:
                //           "Good job, your release is successful. Have a nice day",
                //     ));
                // context.read<AddTaskBloc>().add(SaveTaskEvent(
                //     taskName: inputName.text,
                //     taskDescription: inputDescription.text,
                //     taskLocation: inputLocation.text,
                //     taskColor: selectColor.value,
                //     taskTime: 'taskTime'));
                // Navigator.pop(context);
              },
              child: Container(
                height: 46.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFF009FEE)),
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
            )
          ],
        ),
      ),
    );
  }
}

class SnackBarService {
  static final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  static void showSnackBar({required String content}) {
    scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(content)));
  }
}
