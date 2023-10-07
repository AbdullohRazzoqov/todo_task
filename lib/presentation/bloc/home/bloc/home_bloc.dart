import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_task/data/db/model/task_model.dart';
import 'package:todo_task/data/db/service/hive_service.dart';
import 'package:todo_task/main.dart';
import 'package:todo_task/presentation/pages/home_screen/widgets/calendar/calendar_date.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<Task?> allTask = [];

  HomeBloc() : super(HomeState(stateStatus: StateStatus.loading)) {
    allTask = getIt<HiveService>().getTaskAll();
    List<CalendarDay> calendarDay;
    SelectDate selectDate;
    CalendarMonthData calendarMonthData = CalendarMonthData();
    on<DefaultEvent>((event, emit) async {
      calendarDay = calendarMonthData.monthDate(0, allTask);
      selectDate = calendarMonthData.selectDay();
      String monthName = calendarMonthData.monthName;
      emit(state.copyWith(
          calendarDay: calendarDay,
          selectDate: selectDate,
          monthName: monthName,
          stateStatus: StateStatus.loaded));
    });
    on<SelectDayEvent>((event, emit) {
      selectDate = calendarMonthData.selectDay(
          selectDay: event.selectDay, selectIndex: event.selectIndex);
      emit(state.copyWith(
        selectDate: selectDate,
      ));
    });
    on<ChangeMonthEvent>((event, emit) {
      calendarDay = calendarMonthData.monthDate(event.monthNamber, allTask);
      String monthName = calendarMonthData.monthName;

      emit(state.copyWith(calendarDay: calendarDay, monthName: monthName));
    });
    on<TaskDeleteEvent>((event, emit) {
      allTask.remove(event.task);
      calendarDay = calendarMonthData.monthDate(0, allTask);
      emit(state.copyWith(calendarDay: calendarDay));
    });
    on<TaskUpdateEvent>((event, emit) {
      var a = allTask[allTask.indexWhere((element) => element == event.task)] =
         Task(taskName: 'taskName', color: Colors.red.value, dateTime: DateTime.now());
      print(a);
      calendarDay = calendarMonthData.monthDate(0, allTask);
      emit(state.copyWith(calendarDay: calendarDay));
    });

    add(DefaultEvent());
  }
}
