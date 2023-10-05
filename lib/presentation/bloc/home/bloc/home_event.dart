// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class SelectDayEvent extends HomeEvent {
  int day;
  SelectDayEvent({
    required this.day,
  });

  @override
  List<Object> get props => [day];
}

class ChangeMonthEvent extends HomeEvent {
  int monthNamber;
  ChangeMonthEvent({
    required this.monthNamber,
  });
}
