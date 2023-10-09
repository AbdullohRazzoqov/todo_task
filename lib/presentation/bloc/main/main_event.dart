part of 'main_bloc.dart';
class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}




class EventAdded extends MainEvent {
  EventAdded({required this.event});
  final Event event;
}

class EventEdited extends MainEvent {
  EventEdited({required this.event, required this.id});
  final int id;
  final Event event;
}

class EventDeleted extends MainEvent {
  EventDeleted({required this.event});
  final Event event;
}

class EventsLoaded extends MainEvent {
  EventsLoaded({required this.date});
  final DateTime date;
}
