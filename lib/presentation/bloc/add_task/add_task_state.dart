// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_task_bloc.dart';

sealed class AddTaskState extends Equatable {
  const AddTaskState();

  @override
  List<Object> get props => [];
}

final class AddTaskInitial extends AddTaskState {}

class ValidateErrorState extends AddTaskState {
  String taskNameError;
  ValidateErrorState({
    required this.taskNameError,
  });
  @override
  List<Object> get props => [taskNameError];
}
