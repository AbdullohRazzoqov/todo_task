part of 'add_task_bloc.dart';

sealed class AddTaskEvent extends Equatable {
  const AddTaskEvent();

  @override
  List<Object> get props => [];
}
class SaveTaskEvent extends AddTaskEvent{}
