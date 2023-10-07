import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/utils/app_colors.dart';
import 'package:todo_task/presentation/bloc/home/bloc/home_bloc.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.stateStatus == StateStatus.loading) {
          return const Scaffold();
        }
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7),
          itemCount: state.calendarDay!.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                context.read<HomeBloc>().add(SelectDayEvent(
                    selectDay: state.calendarDay![index].day,
                    selectIndex: index));
              },
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: 25.h,
                      width: 25.w,
                      decoration: BoxDecoration(
                          border: state.calendarDay![index].isTuday &&
                                  index != state.selectDate!.index
                              ? Border.all(color: Colors.red)
                              : null,
                          color: index == state.selectDate!.index
                              ? const Color(0xFF009FEE)
                              : null,
                          shape: BoxShape.circle),
                      child: Center(
                        child: Text(
                          '${state.calendarDay![index].day}',
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: state.calendarDay![index].isTheMonth
                                  ? state.selectDate!.index == index
                                      ? AppColors.white
                                      : AppColors.black
                                  : Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (state.calendarDay![index].task.isEmpty) ...{
                          const SizedBox()
                        } else ...{
                          Text('${state.calendarDay![index].task.length}')
                          // Container(
                          //   height: 4.h,
                          //   width: 4.w,
                          //   decoration: const BoxDecoration(
                          //       shape: BoxShape.circle, color: AppColors.blue),
                          // ),
                          // Container(
                          //   margin: EdgeInsets.only(left: 4.w),
                          //   height: 4.h,
                          //   width: 4.w,
                          //   decoration: const BoxDecoration(
                          //       shape: BoxShape.circle, color: AppColors.blue),
                          // ),
                          // Container(
                          //   margin: EdgeInsets.only(left: 4.w),
                          //   height: 4.h,
                          //   width: 4.w,
                          //   decoration: const BoxDecoration(
                          //       shape: BoxShape.circle, color: AppColors.blue),
                          // )
                        }
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
