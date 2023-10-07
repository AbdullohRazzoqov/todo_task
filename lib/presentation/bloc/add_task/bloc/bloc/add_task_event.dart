// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_task_bloc.dart';

sealed class AddTaskEvent extends Equatable {
  const AddTaskEvent();

  @override
  List<Object> get props => [];
}

class SaveTaskEvent extends AddTaskEvent {
  String taskName;
  String taskDescription;
  String taskLocation;
  int taskColor;
  String taskTime;
  SaveTaskEvent({
    required this.taskName,
    required this.taskDescription,
    required this.taskLocation,
    required this.taskColor,
    required this.taskTime,
  });
  @override
  List<Object> get props => [taskName];
}
