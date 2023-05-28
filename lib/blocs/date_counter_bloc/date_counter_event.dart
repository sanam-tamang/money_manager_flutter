// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'date_counter_bloc.dart';

abstract class DateCounterEvent extends Equatable {
  const DateCounterEvent();

  @override
  List<Object> get props => [];
}

class LoadDateCounter extends DateCounterEvent {
  final Frequency frequency;
  const LoadDateCounter({
    this.frequency = Frequency.today,
  });

  @override
  List<Object> get props => [frequency];
}

class IncrementDateCounter extends DateCounterEvent {
  const IncrementDateCounter();

  @override
  List<Object> get props => [];
}

class DecrementDateCounter extends DateCounterEvent {
  const DecrementDateCounter();
  @override
  List<Object> get props => [];
}

class ResetDateTimeCounter extends DateCounterEvent {}
