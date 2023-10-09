import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


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
