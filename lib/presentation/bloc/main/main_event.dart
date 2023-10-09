// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'main_bloc.dart';

class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class EventAdded extends MainEvent {
  EventAdded({required this.event});
   Event event;
   @override
  List<Object> get props => [event];
}

class EventEdited extends MainEvent {
  EventEdited({required this.event, required this.id});
  final int id;
  final Event event;
   @override
  List<Object> get props => [event];
}

class EventDeleted extends MainEvent {
  EventDeleted({required this.event});
  final Event event;
}

class EventsLoaded extends MainEvent {
  EventsLoaded({required this.date});
  final DateTime date;
}

class SelectDayEvent extends MainEvent {
  int? selectDay;
  int? selectIndex;
  List<Event> events;

  SelectDayEvent({this.selectDay, this.selectIndex, required this.events});

  @override
  List<Object> get props => [];
}

class ChangeMonthEvent extends MainEvent {
  final int monthNumber;
  const ChangeMonthEvent({
    required this.monthNumber,
  });
}

class SelectGlobalTimeEvent extends MainEvent {
  DateTime goTime;
  SelectGlobalTimeEvent({
    required this.goTime,
  });
}
