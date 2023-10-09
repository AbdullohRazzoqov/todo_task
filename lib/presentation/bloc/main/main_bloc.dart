import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_task/data/db/model/event_model.dart';
import 'package:todo_task/data/db/model/task_model.dart';
import 'package:todo_task/data/db/service/local_storage/local_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  List<Task?> allTask = [];

  MainBloc() : super(MainState(stateStatus: StateStatus.loading)) {
    on<MainEvent>(_onEvent, transformer: sequential());
  }

  _onEvent(
    MainEvent event,
    Emitter<MainState> emit,
  ) {
    if (event is EventsLoaded) return _onEventsLoaded(event, emit);
    if (event is EventAdded) return _onEventAdded(event, emit);
    if (event is EventEdited) return _onEventEdited(event, emit);
    if (event is EventDeleted) return _onEventDeleted(event, emit);
  }

  _onEventsLoaded(EventsLoaded event, Emitter<MainState> emit) async {
    print('object');
    try {
      final events =
          await LocalStorage.getAllEvents(date: event.date.toIso8601String());
      print(events);

      final allEvents = await LocalStorage.getAllEvents();
      print(allEvents);
      if (events.isEmpty) {
        emit(state.copyWith(
            events: events,
            allEvents: allEvents,
            selectedDate: event.date,
            stateStatus: StateStatus.error, //failure
            message: "Events not found"));
      } else {
        emit(state.copyWith(
          events: events,
          allEvents: allEvents,
          selectedDate: event.date,
          stateStatus: StateStatus.loaded,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
          stateStatus: StateStatus.error, message: e.toString()));
    }
  }

  _onEventAdded(EventAdded event, Emitter<MainState> emit) async {
    try {
      await LocalStorage.insertEvent(event.event);
      emit(state.copyWith(
          stateStatus: StateStatus.success,
          allEvents: List.of(state.allEvents)..add(event.event),
          message: "Event Added!"));
    } catch (e) {
      emit(state.copyWith(
          stateStatus: StateStatus.error, message: e.toString()));
    }
  }

  _onEventEdited(EventEdited event, Emitter<MainState> emit) async {
    try {
      await LocalStorage.editEvent(event.event, event.id).then((value) async {
        emit(
          state.copyWith(
              stateStatus: StateStatus.success,
              message: "Event Edited!",
              allEvents: await LocalStorage.getAllEvents(),
              events: await LocalStorage.getAllEvents(date: event.event.day)),
        );
      });
    } catch (e) {
      emit(state.copyWith(
          stateStatus: StateStatus.error, message: e.toString()));
    }
  }

  _onEventDeleted(EventDeleted event, Emitter<MainState> emit) async {
    try {
      await LocalStorage.deleteEventById(event.event.id!);
      emit(state.copyWith(
          // status: OverviewStatus.deleted,
          allEvents: List.of(state.allEvents)..remove(event.event),
          events: List.of(state.events)..remove(event.event)));
    } catch (e) {
      emit(state.copyWith(
          stateStatus: StateStatus.error, message: e.toString()));
    }

    //! >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    //   allTask = getIt<HiveService>().getTaskAll();
    //   List<CalendarDay> calendarDay;
    //   SelectDate selectDate;
    //   CalendarMonthData calendarMonthData = CalendarMonthData();
    //   on<DefaultEvent>((event, emit) async {

    // try {
    //     final events =
    //         await LocalStorage.getAllEvents(date: event.date.toIso8601String());
    //     final allEvents = await LocalStorage.getAllEvents();
    //     if (events.isEmpty) {
    //       // emit(state.copyWith(
    //       //     events: events,
    //       //     allEvents: allEvents,
    //       //     selectedDate: event.date,
    //       //     status: OverviewStatus.failure,
    //       //     message: "Events not found"));
    //     } else {
    //       // emit(state.copyWith(
    //       //   events: events,
    //       //   allEvents: allEvents,
    //       //   selectedDate: event.date,
    //       //   status: OverviewStatus.loaded,
    //       // ));
    //     }
    //   } catch (e) {
    //     emit(state.copyWith(
    //         status: OverviewStatus.failure, message: e.toString()));
    //   }

    //     calendarDay = calendarMonthData.monthDate(0, allTask);
    //     selectDate = calendarMonthData.selectDay();
    //     String monthName = calendarMonthData.monthName;
    //     emit(state.copyWith(
    //         calendarDay: calendarDay,
    //         selectDate: selectDate,
    //         monthName: monthName,
    //         stateStatus: StateStatus.loaded));
    //   });
    //   on<SelectDayEvent>((event, emit) {
    //     selectDate = calendarMonthData.selectDay(
    //         selectDay: event.selectDay, selectIndex: event.selectIndex);
    //     emit(state.copyWith(
    //       selectDate: selectDate,
    //     ));
    //   });
    //   on<ChangeMonthEvent>((event, emit) {
    //     calendarDay = calendarMonthData.monthDate(event.monthNamber, allTask);
    //     String monthName = calendarMonthData.monthName;

    //     emit(state.copyWith(calendarDay: calendarDay, monthName: monthName));
    //   });
    //   on<TaskDeleteEvent>((event, emit) {
    //     allTask.remove(event.task);
    //     calendarDay = calendarMonthData.monthDate(0, allTask);
    //     emit(state.copyWith(calendarDay: calendarDay));
    //   });
    //   on<TaskUpdateEvent>((event, emit) {
    //     var a = allTask[allTask.indexWhere((element) => element == event.task)] =
    //        Task(taskName: 'taskName', color: Colors.red.value, dateTime: DateTime.now());
    //     print(a);
    //     calendarDay = calendarMonthData.monthDate(0, allTask);
    //     emit(state.copyWith(calendarDay: calendarDay));
    //   });

    //   add(DefaultEvent());
  }
}
