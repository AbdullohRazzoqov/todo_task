import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_task/core/utils/app_colors.dart';
import 'package:todo_task/core/utils/app_icons.dart';
import 'package:todo_task/data/db/model/task_model.dart';
import 'package:todo_task/presentation/bloc/home/bloc/home_bloc.dart';

class Details extends StatefulWidget {
  Task task;

  Details({super.key, required this.task});
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    // context.read<DetailsBloc>().add(DetailsEvent(index: widget.taskIndex));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            height: 248.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 62.h,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 40.w,
                        height: 40.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            AppIcons.arrowBackIcon,
                            width: 24.2,
                            height: 24.h,
                          ),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<HomeBloc>()
                            .add(TaskUpdateEvent(task: widget.task));
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.editIcon,
                            width: 14.w,
                            height: 14.h,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            'Edit',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  widget.task.taskName,
                  style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white),
                ),
                Text(
                  widget.task!.description!,
                  style: TextStyle(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.white),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.locationIcon,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      '17:00 - 18:30',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.timeIcon,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      widget.task!.location!,
                      style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: ListView(
                children: [
                  const Text(
                    'Reminder',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const Text(
                    '15 minutes befor',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF7C7B7B)),
                  ),
                  SizedBox(
                    height: 22.h,
                  ),
                  const Text(
                    'Description',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black),
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus vel ex sit amet neque dignissim mattis non eu est. Etiam pulvinar est mi, et porta magna accumsan nec. Ut vitae urna nisl. Integer gravida sollicitudin massa, ut congue orci posuere sit amet. Aenean laoreet egestas est, ut auctor nulla suscipit non. ',
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF999999)),
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _openCustomDialog(widget.task);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 28.h),
            height: 54.h,
            decoration: BoxDecoration(
                color: const Color(0xFFFEE8E9),
                borderRadius: BorderRadius.circular(10.r)),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppIcons.deleteIcon),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  'Delete Event',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                )
              ],
            )),
          ),
        ),
        SizedBox(
          height: 28.h,
        )
      ],
    ));
  }

  void _openCustomDialog(Task task) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                content: Text(
                  'Are you sure you want to delete this event?',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'No',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blue),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<HomeBloc>().add(TaskDeleteEvent(task: task));
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text('Yes',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blue)),
                  ),
                ],
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return const Text('data');
        });
  }
}
