// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'main_bloc.dart';

class MainState extends Equatable {
  StateStatus stateStatus = StateStatus.normal;
  final List<Event> events;
  final DateTime? selectedDate;
  final String? message;
  final List<Event> allEvents;

  MainState({
    this.stateStatus = StateStatus.normal,
    this.events = const [],
    this.allEvents = const [],
    this.selectedDate,
    this.message,
  });

  MainState copyWith({
    StateStatus? stateStatus,
    List<Event>? events,
    DateTime? selectedDate,
    String? message,
    List<Event>? allEvents,
  }) {
    return MainState(
        stateStatus: stateStatus ?? this.stateStatus,
        selectedDate: selectedDate ?? this.selectedDate,
        events: events ?? this.events,
        message: message ?? this.message,
        allEvents: allEvents ?? this.allEvents);
  }

  @override
  List<Object?> get props => [
        stateStatus,
      ];
}

class HomeInitial extends MainState {}

enum StateStatus { normal, loading, loaded, success, error }
