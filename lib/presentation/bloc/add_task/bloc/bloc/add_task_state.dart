part of 'add_task_bloc.dart';

sealed class AddTaskState extends Equatable {
  const AddTaskState();
  
  @override
  List<Object> get props => [];
}

final class AddTaskInitial extends AddTaskState {}
