import 'package:intl/intl.dart';
import 'package:todo_task/data/db/model/task_model.dart';

class CalendarMonthData {

  int? selectIndex;
  String monthName = '';
  DateTime viewDate = DateTime.now();

  List<CalendarDay> calendarDay = [];

  late int startingWeekday;

  SelectDate selectDay({int? selectDay, int? selectIndex}) {
    DateTime selectday =
        DateTime(viewDate.year, viewDate.month, selectDay ?? viewDate.day);
    SelectDate selectDate = SelectDate(
        year: selectday.year,
        monthName: DateFormat.LLLL().format(selectday),
        weekName: DateFormat.EEEE().format(selectday),
        day: selectDay ?? selectday.day,
        index: selectIndex);
    return selectDate;
  }

  List<CalendarDay> monthDate(int changeMonth, List<Task?> allTask ) {
    viewDate =
        DateTime(viewDate.year, viewDate.month + changeMonth, viewDate.day);
    DateTime dateTime = viewDate;
    DateTime monthdays = viewDate;
    monthName = DateFormat.LLLL().format(viewDate);
    DateTime now = DateTime.now();
    List<CalendarDay> calendarDay = [];
    startingWeekday = monthdays.weekday;
    startingWeekday = (startingWeekday + 6) % 7;
    monthdays = DateTime(monthdays.year, monthdays.month, -startingWeekday - 1);
    for (int i = 1; i <= 42; i++) {
      monthdays = DateTime(monthdays.year, monthdays.month, monthdays.day + 1);

      if (now.year == monthdays.year &&
          now.month == monthdays.month &&
          now.day == monthdays.day) {
        calendarDay.add(
          CalendarDay(task: [], day: monthdays.day, isTuday: true, index: i),
        );
      } else {
        if (i < 20 && monthdays.day > 20 || i > 20 && monthdays.day < 14) {
          calendarDay.add(
            CalendarDay(
                task: [], day: monthdays.day, isTheMonth: false, index: i),
          );
        } else {
          calendarDay.add(CalendarDay(task: [], day: monthdays.day, index: i));
        }
      }
      for (int j = 0; j < allTask.length; j++) {
        if (dateTime.year == allTask[j]!.dateTime.year &&
            dateTime.month == allTask[j]!.dateTime.month &&
            monthdays.day == allTask[j]!.dateTime.day) {
          calendarDay[i - 1].task.add(allTask[j]!);
        }
      }
    }
    return calendarDay;
  }
}

class CalendarDay {
  List<Task> task = [];
  int day;
  bool isTuday;
  bool isTheMonth;
  int index;

  CalendarDay({
    required this.task,
    required this.day,
    this.isTuday = false,
    this.isTheMonth = true,
    required this.index,
  });
}

class SelectDate {
  int year;
  String monthName;
  String weekName;
  int day;
  int? index;
  SelectDate(
      {required this.year,
      required this.monthName,
      required this.weekName,
      required this.day,
      required this.index});
}
