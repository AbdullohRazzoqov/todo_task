import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_task/core/utils/app_colors.dart';
import 'package:todo_task/core/utils/app_icons.dart';
import 'package:todo_task/data/db/model/event_model.dart';
import 'package:todo_task/presentation/pages/add_task/add_task.dart';
import 'package:todo_task/presentation/pages/edit_screen/edit_event.dart';

import '../../bloc/main/main_bloc.dart';

class Details extends StatefulWidget {
  Event event;

  Details({super.key, required this.event});
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<MainBloc, MainState>(
      listener: (context, state) {
        if (state.stateStatus == StateStatus.error) {
          TopSnackBarMessage.message(state.message ?? '', Colors.red);
        } else if (state.stateStatus == StateStatus.success) {
          TopSnackBarMessage.message(state.message ?? '', Colors.green);
        }
      },
      child: Scaffold(
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
                        behavior: HitTestBehavior.opaque,
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
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditEvent(event: widget.event)));
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
                    widget.event.name,
                    style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white),
                  ),
                  widget.event.description.isEmpty
                      ? SizedBox()
                      : Text(
                          widget.event.description,
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
                        '${widget.event.firstDate} - ${widget.event.secondDate}',
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
                  widget.event.location.isEmpty
                      ? SizedBox()
                      : Row(
                          children: [
                            SvgPicture.asset(
                              AppIcons.timeIcon,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              widget.event.location,
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
                    widget.event.description.isEmpty
                        ? SizedBox()
                        : const Text(
                            'Description',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black),
                          ),
                    Text(
                      widget.event.description,
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
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _openCustomDialog(widget.event);
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
      )),
    );
  }

  void _openCustomDialog(Event event) {
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
                    behavior: HitTestBehavior.opaque,
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
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      context.read<MainBloc>().add(EventDeleted(event: event));
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
