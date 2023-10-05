part of 'details_bloc.dart';

class DetailsEvent extends Equatable {
  int index ;
  DetailsEvent({required this.index});

  @override
  List<Object> get props => [index];
}
