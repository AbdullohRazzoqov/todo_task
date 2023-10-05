import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_task/data/db/model/task_model.dart';
import 'package:todo_task/data/db/service/hive_service.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial()) {
    print('Hello Task Details');
    HiveService hiveService;
    List<Task?> task;
    on<DetailsEvent>((event, emit) async {
      hiveService = await HiveService.create();
      print('object');
      task = hiveService.getTaskAll();
      print(task.length)
;      print('sdfasdfasdfasd${task[event.index]}');
      emit(DetailsState(task: task[event.index]));
    });
  }
}
