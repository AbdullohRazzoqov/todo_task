import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/utils/app_colors.dart';
import 'package:todo_task/presentation/bloc/add_task/add_task_bloc.dart';
import 'package:todo_task/presentation/bloc/main/main_bloc.dart';
import 'package:todo_task/presentation/pages/home_screen/home_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(
            create: (context) => MainBloc()
              ..add(EventsLoaded(
                  date: DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
              )))),
        BlocProvider<AddTaskBloc>(create: (context) => AddTaskBloc()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Todo task',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
