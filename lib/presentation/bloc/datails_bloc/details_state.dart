part of 'details_bloc.dart';

class DetailsState extends Equatable {
  Task? task;
  DetailsState({this.task});

  @override
  List<Object?> get props => [task];
}

class DetailsInitial extends DetailsState {}
