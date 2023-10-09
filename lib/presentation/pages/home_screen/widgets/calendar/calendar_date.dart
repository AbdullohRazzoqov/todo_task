import 'package:intl/intl.dart';
import 'package:todo_task/data/db/model/event_model.dart';

class CalendarMonthData {
  int? selectIndex;
  String monthName = '';

  List<CalendarDay> calendarDay = [];

  late int startingWeekday;

  SelectDate selectDay(
      {int? selectDay, int? selectIndex, required DateTime viewDate}) {
    DateTime selectday =
        DateTime(viewDate.year, viewDate.month, selectDay ?? viewDate.day);
    SelectDate selectDate = SelectDate(
      year: selectday.year,
      monthName: DateFormat.LLLL().format(selectday),
      weekName: DateFormat.EEEE().format(selectday),
      day: selectDay ?? selectday.day,
      index: selectIndex,
      month: viewDate.month,
    );
    return selectDate;
  }

  List<CalendarDay> monthDate(DateTime viewDate) {
    DateTime monthDay = viewDate;
    monthName = DateFormat.LLLL().format(viewDate);
    DateTime now = DateTime.now();
    List<CalendarDay> calendarDay = [];
    startingWeekday = monthDay.weekday;
    startingWeekday = (startingWeekday + 4) % 7;
    monthDay = DateTime(monthDay.year, monthDay.month, -startingWeekday - 1);
    for (int i = 1; i <= 42; i++) {
      monthDay = DateTime(monthDay.year, monthDay.month, monthDay.day + 1);
      if (now.year == monthDay.year &&
          now.month == monthDay.month &&
          now.day == monthDay.day) {
        calendarDay.add(
          CalendarDay(
            day: monthDay,
            isTuday: true,
          ),
        );
      } else {
        if (i < 20 && monthDay.day > 20 || i > 20 && monthDay.day < 14) {
          calendarDay.add(
            CalendarDay(
              day: monthDay,
              isTheMonth: false,
            ),
          );
        } else {
          calendarDay.add(CalendarDay(
            day: monthDay,
          ));
        }
      }
    }
    return calendarDay;
  }
}

class CalendarDay {
  DateTime day;
  bool isTuday;
  bool isTheMonth;
  CalendarDay({
    required this.day,
    this.isTuday = false,
    this.isTheMonth = true,
  });
}

class SelectDate {
  int year;
  String monthName;
  String weekName;
  int day;
  int? index;
  int month;
  List<Event> events;
  SelectDate({
    required this.year,
    required this.monthName,
    required this.weekName,
    required this.day,
    required this.index,
    required this.month,
    this.events = const [],
  });
}
