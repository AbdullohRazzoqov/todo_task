import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_task/core/utils/app_icons.dart';
import 'package:todo_task/data/db/model/task_model.dart';
import 'package:todo_task/presentation/pages/details/details.dart';

class EventItems extends StatelessWidget {
  EventItems({super.key, required this.currentDayTask});
  List<Task?> currentDayTask;
  @override
  Widget build(BuildContext context) {
    if (currentDayTask.isEmpty) {
      return Center(
        child: Column(
          children: [
            Lottie.asset(
              'assets/lottie/isEmpty.json',
              width: 200.w,
              height: 200.h,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Event Not Found',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.red,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: currentDayTask.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Details(
                  task: currentDayTask[index]!,
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 6.w),
            height: 100.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Color(currentDayTask[index]!.color).withOpacity(0.2.dg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 10.h,
                  decoration: BoxDecoration(
                    color: Color(currentDayTask[index]!.color),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      topRight: Radius.circular(10.r),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 12.h,
                      ),
                      Text(
                        currentDayTask[index]!.taskName,
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(currentDayTask[index]!.color)),
                      ),
                      currentDayTask[index]!.description == null
                          ? const SizedBox()
                          : Text(
                              currentDayTask[index]!.description!,
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
                          currentDayTask[index]!.date == null
                              ? SizedBox()
                              : Text(
                                  currentDayTask[index]!.date!,
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                      color:const Color(0xFF056EA1)),
                                ),
                          SizedBox(
                            width: 10.w,
                          ),
                          currentDayTask[index]!.location == null
                              ? SizedBox()
                              : SvgPicture.asset(
                                  AppIcons.locationIcon,
                                  color: const Color(0xFF066EA1),
                                ),
                          SizedBox(
                            width: 4.w,
                          ),
                          currentDayTask[index]!.location == null
                              ? SizedBox()
                              : Text(
                                  currentDayTask[index]!.location!,
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
    );
  }
}
