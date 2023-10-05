import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_task/core/utils/app_colors.dart';
import 'package:todo_task/core/utils/app_icons.dart';
import 'package:todo_task/presentation/bloc/home/bloc/home_bloc.dart';
import 'package:todo_task/presentation/pages/add_task/add_task.dart';
import 'package:todo_task/presentation/pages/details/details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        print('UI');
        if (state.stateStatus == StateStatus.loading) {
          return Scaffold();
        }
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Column(
                children: [
                  Text(
                    state.selectDate!.weekName,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
                      )
                    ],
                  )
                ],
              ),
              actions: [
                SvgPicture.asset(AppIcons.notifaticonIcon),
                SizedBox(
                  width: 28.w,
                )
              ],
              elevation: 0.0,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: ListView(
                children: [
                  Row(
                    children: [
                      Text(
                        state.calendarView!.monthName,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () {
                          print('<<<<<<<<<<<UII>>>>>>>>>>>');
                          context.read<HomeBloc>().add(ChangeMonthEvent(
                              monthNamber:
                                  state.calendarView!.monthNumber - 1));
                        },
                        child: Container(
                          width: 23.h,
                          height: 23.h,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFFEFEFEF)),
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
                          context.read<HomeBloc>().add(ChangeMonthEvent(
                              monthNamber:
                                  state.calendarView!.monthNumber + 1));
                        },
                        child: Container(
                          width: 23.h,
                          height: 23.h,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFFEFEFEF)),
                          child: Center(
                            child:
                                SvgPicture.asset(AppIcons.arrowBackOutlineIcon),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    child: Row(
                        children: List.generate(
                            7,
                            (index) => Expanded(
                                  child: Text('data',
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF969696))),
                                ))),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 320,
                    child: CalendarWidget(),
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
                  SizedBox(
                    height: 18.h,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Details(),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 6.w),
                          height: 100.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Color(state.allTask![index]!.color)
                                  .withOpacity(0.2.dg)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 10.h,
                                decoration: BoxDecoration(
                                  color: Color(state.allTask![index]!.color),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.r),
                                    topRight: Radius.circular(10.r),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Text(
                                      state.allTask![index]!.taskName,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF056EA1)),
                                    ),
                                    state.allTask![index]!.description == null
                                        ? const SizedBox()
                                        : Text(
                                            state.allTask![index]!.description!,
                                            style: TextStyle(
                                              fontSize: 8.sp,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xFF056EA1),
                                            ),
                                          ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppIcons.timeIcon,
                                          color: const Color(0xFF066EA1),
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        state.allTask![index]!.date == null
                                            ? SizedBox()
                                            : Text(
                                                state.allTask![index]!.date!,
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF056EA1)),
                                              ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        state.allTask![index]!.location == null
                                            ? SizedBox()
                                            : SvgPicture.asset(
                                                AppIcons.locationIcon,
                                                color: const Color(0xFF066EA1),
                                              ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        state.allTask![index]!.location == null
                                            ? SizedBox()
                                            : Text(
                                                state
                                                    .allTask![index]!.location!,
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF056EA1)),
                                              ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ));
      },
    );
  }
}

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.stateStatus == StateStatus.loading) {
            return const SizedBox();
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7),
            itemCount: state.calendarView!.monthLength,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  context.read<HomeBloc>().add(SelectDayEvent(day: index));
                },
                child: Column(
                  children: [
                    Container(
                      height: 25.h,
                      width: 25.w,
                      decoration: BoxDecoration(
                          border: index == state.selectDate!.day &&
                                  index != state.selectDay
                              ? Border.all(color: Colors.red)
                              : null,
                          color: index == state.selectDay
                              ? const Color(0xFF009FEE)
                              : null,
                          shape: BoxShape.circle),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: index != state.selectDay
                                  ? const Color(0xFF292929)
                                  : AppColors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                     // if()...{} 
                       Container(
                          height: 4.h,
                          width: 4.w,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: AppColors.blue),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 4.w),
                          height: 4.h,
                          width: 4.w,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: AppColors.blue),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 4.w),
                          height: 4.h,
                          width: 4.w,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: AppColors.blue),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
