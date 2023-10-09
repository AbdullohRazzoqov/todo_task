import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/utils/app_colors.dart';

import '../../../../../data/db/model/event_model.dart';
import '../../../../bloc/main/main_bloc.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  List<Event> eventsSelect = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        if (state.stateStatus == StateStatus.loading) {
          return const SizedBox();
        }
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7),
          itemCount: 42,
          itemBuilder: (context, index) {
            for (var i = 0; i < state.allEvents.length; i++) {}

            final item = state.allEvents
                .where((element) =>
                    element.day ==
                    DateTime(state.viewDate!.year, state.viewDate!.month,
                            state.calendarDay![index].day.day)
                        .toIso8601String())
                .toList();
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                eventsSelect = item;

                if (state.calendarDay![index].isTheMonth) {
                  context.read<MainBloc>().add(
                        SelectDayEvent(
                          selectIndex: index,
                          selectDay: state.calendarDay![index].day.day,
                          events: item,
                        ),
                      );
                } else {}
              },
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
                        color: state.calendarDay![index].day.year ==
                                    state.selectDate!.year &&
                                state.calendarDay![index].day.day ==
                                    state.selectDate!.day &&
                                state.calendarDay![index].day.month ==
                                    state.selectDate!.month &&
                                state.selectDate!.index != null
                            ? const Color(0xFF009FEE)
                            : Colors.transparent,
                        shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        '${state.calendarDay![index].day.day}',
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: index == state.selectDate!.index &&
                                    state.selectDate!.month ==
                                        state.calendarDay![index].day.month
                                ? AppColors.white
                                : state.calendarDay![index].isTheMonth
                                    ? AppColors.black
                                    : AppColors.greyTextColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
              state.selectDate!.month == state.calendarDay![index].day.month?   SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        item.length >= 3 ? 3 : item.length,
                        (index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1.w),
                          child: CircleAvatar(
                            radius: 1.5.r,
                            backgroundColor: Color(item[index].color),
                          ),
                        ),
                      )
                    ),
                  ):SizedBox(),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
