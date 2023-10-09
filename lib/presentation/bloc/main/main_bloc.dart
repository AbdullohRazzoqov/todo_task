import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_task/data/db/model/event_model.dart';
import 'package:todo_task/data/db/service/local_storage/local_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/presentation/pages/home_screen/widgets/calendar/calendar_date.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  DateTime viewDate = DateTime.now();

  MainBloc() : super(MainState(stateStatus: StateStatus.loading)) {
    List<CalendarDay> calendarDay;
    late SelectDate selectDate;
    CalendarMonthData calendarMonthData = CalendarMonthData();
    on<EventsLoaded>((event, emit) async {
      calendarDay = calendarMonthData.monthDate(viewDate);
      selectDate = calendarMonthData.selectDay(viewDate: viewDate);
      String monthName = calendarMonthData.monthName;
      emit(
        state.copyWith(
            calendarDay: calendarDay,
            selectDate: selectDate,
            monthName: monthName,
            stateStatus: StateStatus.loaded,
            viewDate: viewDate),
      );
      try {
        final events =
            await LocalStorage.getAllEvents(date: event.date.toIso8601String());

        final allEvents = await LocalStorage.getAllEvents();
        if (events.isEmpty) {
          emit(state.copyWith(
              allEvents: allEvents,
              selectedDate: event.date,
              stateStatus: StateStatus.error,
              message: "Events not found"));
        } else {
          emit(state.copyWith(
            allEvents: allEvents,
            selectedDate: event.date,
            stateStatus: StateStatus.loaded,
          ));
        }
      } catch (e) {
        emit(
          state.copyWith(
            stateStatus: StateStatus.error,
            message: e.toString(),
          ),
        );
      }
    });
    on<EventAdded>((event, emit) async {
      print('normal');
      emit(state.copyWith(stateStatus: StateStatus.normal));
      try {
        print('try');
        await LocalStorage.insertEvent(event.event);
        print('save store');
        if(selectDate.events.isNotEmpty){
          if (selectDate.events[0].day == event.event.day) {
            print('if');
            selectDate.events.add(event.event);
          }
        }else{
          selectDate.events.add(event.event);
        }

        print('emit');
        emit(state.copyWith(
            stateStatus: StateStatus.save,
            allEvents: List.of(state.allEvents)..add(event.event),
            message: "Event saved successfully"));
      } catch (e) {
        print('Error: $e');
        emit(state.copyWith(
            stateStatus: StateStatus.error, message: e.toString()));
      }
    });
    on<SelectGlobalTimeEvent>((event, emit) {
      viewDate = event.goTime;
      calendarDay = calendarMonthData.monthDate(viewDate);
      selectDate = calendarMonthData.selectDay(viewDate: viewDate);

      emit(state.copyWith(
        calendarDay: calendarDay,
        selectDate: selectDate,
        viewDate: viewDate,
      ));
    });

    on<EventEdited>((event, emit) async {
      try {
        selectDate.events[selectDate.events
                .indexWhere((element) => element.id == event.event.id)] =
            event.event;
        await LocalStorage.editEvent(event.event, event.id).then((value) async {
          emit(
            state.copyWith(
              stateStatus: StateStatus.edit,
              message: "Event Edited!",
              allEvents: await LocalStorage.getAllEvents(),
              selectDate: selectDate,
            ),
          );
        });
      } catch (e) {
        emit(state.copyWith(
            stateStatus: StateStatus.error, message: e.toString()));
      }
    });
    on<EventDeleted>((event, emit) async {
      emit(state.copyWith(stateStatus: StateStatus.normal));
      try {
        await LocalStorage.deleteEventById(event.event.id!);
        selectDate.events.remove(event.event);
        emit(
          state.copyWith(
              stateStatus: StateStatus.success,
              allEvents: List.of(state.allEvents)..remove(event.event),
              selectDate: selectDate,
              message: 'Event delete'),
        );
      } catch (e) {
        emit(state.copyWith(
            stateStatus: StateStatus.error, message: e.toString()));
      }
    });
    //!///////////////////////////

    on<SelectDayEvent>((event, emit) {
      selectDate = calendarMonthData.selectDay(
          selectDay: event.selectDay,
          selectIndex: event.selectIndex,
          viewDate: viewDate);
      selectDate.events = event.events;
      emit(
        state.copyWith(
          selectDate: selectDate,
        ),
      );
    });
    on<ChangeMonthEvent>((event, emit) {
      // selectDate.index = null;
      viewDate = DateTime(
          viewDate.year, viewDate.month + event.monthNumber, viewDate.day);
      calendarDay = calendarMonthData.monthDate(viewDate);
      String monthName = calendarMonthData.monthName;
      emit(
        state.copyWith(
            calendarDay: calendarDay,
            monthName: monthName,
            viewDate: viewDate,
            selectDate: selectDate),
      );
    });
  }
}
