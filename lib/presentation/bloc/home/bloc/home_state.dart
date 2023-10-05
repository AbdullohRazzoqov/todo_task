// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState extends Equatable {
  StateStatus stateStatus;
  SelectDate? selectDate;
  int? selectDay;
  CalendarView? calendarView;
  List<Task?>? allTask;
  HomeState(
      {this.selectDate,
      this.stateStatus = StateStatus.normal,
      this.selectDay,
      this.calendarView,
      this.allTask});
  @override
  List<Object?> get props => [selectDate, stateStatus, selectDay];

  HomeState copyWith(
      {StateStatus? stateStatus,
      SelectDate? timeParse,
      int? selectDay,
      CalendarView? calendarView,
      List<Task?>? allTask}) {
    return HomeState(
      stateStatus: stateStatus ?? this.stateStatus,
      selectDate: timeParse ?? this.selectDate,
      selectDay: selectDay ?? this.selectDay,
      calendarView: calendarView ?? this.calendarView,
      allTask: allTask ?? this.allTask,
    );
  }
}

class HomeInitial extends HomeState {}

enum StateStatus { loading, loaded, normal }
