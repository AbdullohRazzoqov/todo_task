part of 'main_bloc.dart';

class MainState extends Equatable {
  StateStatus stateStatus = StateStatus.normal;
  final DateTime? selectedDate;
  final String? message;
  final List<Event> allEvents;
  List<CalendarDay>? calendarDay = [];
  SelectDate? selectDate;
  String monthName;
  DateTime? viewDate;
  MainState({
    this.stateStatus = StateStatus.normal,
    this.allEvents = const [],
    this.selectedDate,
    this.message,
    this.calendarDay,
    this.selectDate,
    this.monthName = '',
    this.viewDate,
  });

  MainState copyWith(
      {StateStatus? stateStatus,
      DateTime? selectedDate,
      String? message,
      List<Event>? allEvents,
      List<CalendarDay> calendarDay = const [],
      SelectDate? selectDate,
      String monthName = '',
      DateTime? viewDate}) {
    return MainState(
        stateStatus: stateStatus ?? this.stateStatus,
        selectedDate: selectedDate ?? this.selectedDate,
        message: message ?? this.message,
        allEvents: allEvents ?? this.allEvents,
        calendarDay: calendarDay.isEmpty ? this.calendarDay : calendarDay,
        selectDate: selectDate ?? this.selectDate,
        monthName: monthName.isEmpty ? this.monthName : monthName,
        viewDate: viewDate ?? this.viewDate);
  }

  @override
  List<Object?> get props => [
        stateStatus,
        selectedDate,
        message,
        allEvents,
        monthName,
        selectDate,
        calendarDay,
      ];
}

enum StateStatus { normal, loading, loaded, success, error, save, edit }
