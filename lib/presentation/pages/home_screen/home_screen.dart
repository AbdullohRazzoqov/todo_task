import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_task/core/utils/app_colors.dart';
import 'package:todo_task/core/utils/app_icons.dart';
import 'package:todo_task/core/utils/text_style.dart';
import 'package:todo_task/presentation/global_widgets/custom_timer_picker.dart';
import 'package:todo_task/presentation/pages/add_task/add_task.dart';
import 'package:todo_task/presentation/pages/home_screen/widgets/calendar/calendar_widget.dart';
import 'package:todo_task/presentation/pages/home_screen/widgets/changeMonthButton.dart';
import 'package:todo_task/presentation/pages/home_screen/widgets/event_list.dart';

import '../../bloc/main/main_bloc.dart';

Text weekText(String text) => Text(
      text,
      style: TextStyle(
        color: AppColors.greyTextColor,
        fontSize: 12.sp,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        letterSpacing: -0.17,
      ),
    );

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        if (state.stateStatus == StateStatus.loading) {
          return const SizedBox();
        }
        return Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,

              surfaceTintColor: Colors.transparent,
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 28.w,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      DateTime? selectTime =
                          await CustomTimePicker.timePicker(context);
                      if (selectTime != null) {
                        context.read<MainBloc>().add(SelectGlobalTimeEvent(
                                goTime: DateTime(
                              selectTime.year,
                              selectTime.month,
                              selectTime.day,
                            )));
                      }
                    },
                    child: Column(
                      children: [
                        Text(state.selectDate!.weekName,
                            style: AppStyle.selectDayText),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                '${state.selectDate!.day} ${state.selectDate!.monthName} ${state.selectDate!.year}',
                                style: AppStyle.selectDaySupText),
                            const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              size: 14,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SvgPicture.asset(AppIcons.notifaticonIcon),
                ],
              ),
              elevation: 0.0,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: ListView(
                children: [
                  SizedBox(
                    height: 24.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Row(
                      children: [
                        Text(state.monthName, style: AppStyle.selectDayText),
                        const Expanded(child: SizedBox()),
                        ChangeMonthButton(
                          onTap: () {
                            context
                                .read<MainBloc>()
                                .add(const ChangeMonthEvent(monthNumber: -1));
                          },
                          icon: AppIcons.arrowBackIcon,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        ChangeMonthButton(
                          onTap: () {
                            context
                                .read<MainBloc>()
                                .add(const ChangeMonthEvent(monthNumber: 1));
                          },
                          icon: AppIcons.arrowBackOutlineIcon,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      weekText('Mon'),
                      weekText('Tue'),
                      weekText('Wed'),
                      weekText('Thu'),
                      weekText('Fri'),
                      weekText('Sat'),
                      weekText('Sun'),
                    ],
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  const CalendarWidget(),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Schedule',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (state.selectDate!.index == null) {
                            TopSnackBarMessage.message(
                                'Select a day to create an event',
                                Colors.orange);
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddTask(
                                  year: state.selectDate!.year,
                                  month: state.selectDate!.month,
                                  day: state.selectDate!.day,
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: 34.h,
                          width: 102.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: const Color(0xFF009FEE)),
                          child: Center(
                            child: Text(
                              '+ Add Event',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  EventItems(currentDayTask: state.selectDate!.events)
                ],
              ),
            ));
      },
    );
  }
}
