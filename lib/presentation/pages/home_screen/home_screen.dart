import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_task/core/utils/app_colors.dart';
import 'package:todo_task/core/utils/app_icons.dart';
import 'package:todo_task/presentation/bloc/home/bloc/home_bloc.dart';
import 'package:todo_task/presentation/pages/add_task/add_task.dart';
import 'package:todo_task/presentation/pages/home_screen/widgets/calendar/calendar_widget.dart';
import 'package:todo_task/presentation/pages/home_screen/widgets/event_list.dart';

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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.stateStatus == StateStatus.loading) {
          return const Scaffold();
        }

        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 28.w,
                  ),
                  Column(
                    children: [
                      Text(
                        state.selectDate!.weekName,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${state.selectDate!.day} ${state.selectDate!.monthName} ${state.selectDate!.year}',
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w400),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            size: 14,
                          ),
                        ],
                      )
                    ],
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
                        Text(
                          state.monthName,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        GestureDetector(
                          onTap: () {
                            context
                                .read<HomeBloc>()
                                .add(ChangeMonthEvent(monthNamber: -1));
                          },
                          child: Container(
                            width: 23.h,
                            height: 23.h,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFEFEFEF)),
                            child: Center(
                              child: SvgPicture.asset(
                                AppIcons.arrowBackIcon,
                                width: 15.w,
                                height: 15.h,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            context
                                .read<HomeBloc>()
                                .add(ChangeMonthEvent(monthNamber: 1));
                          },
                          child: Container(
                            width: 23.h,
                            height: 23.h,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFEFEFEF)),
                            child: Center(
                              child: SvgPicture.asset(
                                  AppIcons.arrowBackOutlineIcon),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
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
                    height: 20.h,
                  ),
                  const CalendarWidget(),
                  SizedBox(
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddTask(),
                            ),
                          );
                        },
                        child: Container(
                          height: 30.h,
                          width: 102.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: const Color(0xFF009FEE)),
                          child: Center(
                            child: Text(
                              '+ Add Event',
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  EventItems(
                      currentDayTask: state.selectDate!.index == null
                          ? []
                          : state.calendarDay![state.selectDate!.index!].task)
                ],
              ),
            ));
      },
    );
  }
}
