// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class DefaultEvent extends HomeEvent {}

class SelectDayEvent extends HomeEvent {
  int? selectDay;
  int? selectIndex;
  SelectDayEvent({this.selectDay, this.selectIndex});

  @override
  List<Object> get props => [];
}

class ChangeMonthEvent extends HomeEvent {
  int monthNamber;
  ChangeMonthEvent({
    required this.monthNamber,
  });
}

class TaskUpdateEvent extends HomeEvent {
  Task task;
  TaskUpdateEvent({
    required this.task,
  });
}

class TaskDeleteEvent extends HomeEvent {
  Task task;
  TaskDeleteEvent({
    required this.task,
  });
}
