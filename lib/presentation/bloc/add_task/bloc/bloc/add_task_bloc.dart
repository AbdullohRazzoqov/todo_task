import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_task/data/db/model/task_model.dart';
import 'package:todo_task/data/db/service/hive_service.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  AddTaskBloc() : super(AddTaskInitial()) {
    late HiveService hiveService;
    on<AddTaskEvent>((event, emit) async {
      print('ADD TASK EVENT');
    });
    on<SaveTaskEvent>((event, emit) async {
      hiveService = await HiveService.create();
      hiveService.addTask(Task(
          taskName: 'UzBek',
          description: 'description',
          location: 'location',
          date: 'date',
          color: Colors.blue.value,
          dateTime: DateTime.now()));
      var a = hiveService.getTaskAll();
    
    });
  }
}
