// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'date_counter_bloc.dart';

abstract class DateCounterState extends Equatable {
  const DateCounterState();

  @override
  List<Object> get props => [];
}

class DateCounterInitial extends DateCounterState {}

class DateCounterLoadedState extends DateCounterState {
  final String printableDate;
  final DateTime dateFetchableDate;
 const  DateCounterLoadedState({
    required this.printableDate,
    required this.dateFetchableDate,
  });
   @override
  List<Object> get props => [printableDate,dateFetchableDate];
}
