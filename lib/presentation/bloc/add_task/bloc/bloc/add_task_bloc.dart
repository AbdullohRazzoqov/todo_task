// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:todo_task/data/db/model/task_model.dart';
import 'package:todo_task/data/db/service/hive_service.dart';
import 'package:todo_task/main.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  String taskNameError = '';

  AddTaskBloc() : super(AddTaskInitial()) {
    on<SaveTaskEvent>((event, emit) async {
      _validate(event.taskName);
      if (taskNameError.isNotEmpty) {
        emit(ValidateErrorState(taskNameError: taskNameError));
      } else {
        getIt<HiveService>().addTask(Task(
          taskName: event.taskName,
          description: event.taskDescription,
          location: event.taskLocation,
          date: event.taskTime,
          color: event.taskColor,
          dateTime: DateTime.now(),
        ));
        emit(AddTaskInitial());
      }
    });
  }
  _validate(String taskName) {
    if (taskName.isEmpty) {
      taskNameError = "You must name the event";
    } else {
      taskNameError = '';
    }
  }
}
