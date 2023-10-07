// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState extends Equatable {
  StateStatus stateStatus;
  List<CalendarDay>? calendarDay = [];
  SelectDate? selectDate;
  String monthName;

  HomeState(
      {this.stateStatus = StateStatus.normal,
      this.calendarDay,
      this.selectDate,
      this.monthName = ''});
  @override
  List<Object?> get props => [
        stateStatus,
        monthName,
        selectDate,
        calendarDay,
      ];

  HomeState copyWith({
    StateStatus? stateStatus,
    List<CalendarDay> calendarDay = const [],
    SelectDate? selectDate,
    CalendarMonthData? calendarMonthData,
    String monthName = '',
  }) {
    return HomeState(
        stateStatus: stateStatus ?? this.stateStatus,
        calendarDay: calendarDay.isEmpty?this.calendarDay:calendarDay,
        selectDate: selectDate ?? this.selectDate,
        monthName: monthName.isEmpty?this.monthName:monthName);
  }
}

class HomeInitial extends HomeState {}

enum StateStatus { loading, loaded, normal }
