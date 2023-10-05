// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:todo_task/data/db/model/task_model.dart';
import 'package:todo_task/data/db/service/hive_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState(stateStatus: StateStatus.loading)) {
    DateTime now = DateTime.now();
    DateTime viewDate = DateTime.now();
    HiveService hiveService;
    List<Task?> allTask = [];

    CalendarView calendarView = CalendarView(
        monthName: DateFormat.LLLL().format(viewDate),
        monthLength: DateTime(viewDate.year, viewDate.month + 1, 0).day,
        monthNumber: viewDate.month);

    SelectDate selectDate = SelectDate(
      year: now.year,
      monthName: DateFormat.LLLL().format(now),
      weekName: DateFormat.EEEE().format(now),
      day: now.day,
    );

    on<HomeEvent>((event, emit) async {
      hiveService = await HiveService.create();
      allTask = hiveService.getTaskAll();
      emit(state.copyWith(
          timeParse: selectDate,
          stateStatus: StateStatus.loaded,
          calendarView: calendarView,allTask: allTask));
    });
    on<SelectDayEvent>((event, emit) {
      int selectDay = event.day;
      now = DateTime(now.year, now.month, selectDay);
      selectDate = SelectDate(
          year: viewDate.year,
          monthName: DateFormat.LLLL().format(viewDate),
          weekName: DateFormat.EEEE().format(now),
          day: selectDay);

      emit(state.copyWith(timeParse: selectDate, selectDay: selectDay));
    });
    on<ChangeMonthEvent>((event, emit) {
      emit(
        state.copyWith(
            calendarView: calendarView, stateStatus: StateStatus.loading),
      );
      viewDate = DateTime(viewDate.year, event.monthNamber, viewDate.day);
      calendarView = CalendarView(
          monthName: DateFormat.LLLL().format(viewDate),
          monthLength: DateTime(viewDate.year, event.monthNamber, 0).day,
          monthNumber: viewDate.month);
      emit(
        state.copyWith(
            calendarView: calendarView, stateStatus: StateStatus.loaded),
      );
    });
    add(HomeEvent());
  }
}

class SelectDate {
  int year;
  String monthName;
  String weekName;
  int day;
  SelectDate({
    required this.year,
    required this.monthName,
    required this.weekName,
    required this.day,
  });
}

class CalendarView {
  String monthName;
  int monthLength;
  int monthNumber;
  CalendarView(
      {required this.monthName,
      required this.monthLength,
      required this.monthNumber});
}
