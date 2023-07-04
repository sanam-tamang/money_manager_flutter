import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../core/date_time_formattor.dart';
import '../../core/printable_date.dart';
import '../../enum/frequency_enum.dart';

import '../frequency_cubit/frequency_cubit.dart';

part 'date_counter_event.dart';
part 'date_counter_state.dart';

class DateCounterBloc extends Bloc<DateCounterEvent, DateCounterState> {
  final FrequencyCubit _cubit;

  DateCounterBloc({required FrequencyCubit cubit})
      : _cubit = cubit,
        super(DateCounterInitial()) {
    _cubit.stream.listen((state) {
      (add(LoadDateCounter(frequency: state.selectedFrequency)));
    });
    on<LoadDateCounter>(_loadDateCounter);
    on<IncrementDateCounter>(_incrementDateCounter);
    on<DecrementDateCounter>(_decrementDateCounter);
    on<ResetDateTimeCounter>(_resetDateTimeCounter);
  }

  _loadDateCounter(LoadDateCounter event, Emitter<DateCounterState> emit) {
    final state = this.state;
    if (state is DateCounterLoadedState) {
      final date = state.dateFetchableDate;
      switch (_cubit.state.selectedFrequency) {
        case Frequency.today:
          final printableDate = PrintableDate.yearMonthDay(date);

          emit(DateCounterLoadedState(
              printableDate: printableDate, dateFetchableDate: date));
          return;
        case Frequency.week:
          int weekday = state.dateFetchableDate.weekday;
          DateTime date = state.dateFetchableDate;
          DateTime weekStartedDate = date.subtract(Duration(days: weekday - 1));
          DateTime weekEndDate = weekStartedDate.add(const Duration(days: 6));

          DateTime newDate = DateTime.now();

          String frmStartedWeek = PrintableDate.monthDay(weekStartedDate);

          String frmEndWeek = PrintableDate.monthDay(weekEndDate);

          emit(DateCounterLoadedState(
              printableDate: '$frmStartedWeek to $frmEndWeek',
              dateFetchableDate: newDate));
          return;
        case Frequency.month:
          final printableDate = PrintableDate.yearMonth(date);
          emit(DateCounterLoadedState(
              printableDate: printableDate, dateFetchableDate: date));
          return;
        case Frequency.year:
          final printableDate = formatDateTimeYearOnly(date);
          emit(DateCounterLoadedState(
              printableDate: printableDate, dateFetchableDate: date));
          return;
        case Frequency.overall:
          emit(DateCounterLoadedState(
              printableDate: '', dateFetchableDate: DateTime.now()));
          return;
      }
    } else {
      //##when first time loaded this will execute so
      final date = DateTime.now();

      final printableDate = formatDateTime(date);
      emit(DateCounterLoadedState(
          printableDate: printableDate, dateFetchableDate: date));
    }
  }

  void _incrementDateCounter(
      IncrementDateCounter event, Emitter<DateCounterState> emit) {
    final state = this.state;
    if (state is DateCounterLoadedState) {
      switch (_cubit.state.selectedFrequency) {
        case Frequency.today:
          DateTime newDate =
              state.dateFetchableDate.add(const Duration(days: 1));
          final printableDate = PrintableDate.yearMonthDay(newDate);

          emit(DateCounterLoadedState(
              printableDate: printableDate, dateFetchableDate: newDate));
          return;
        case Frequency.week:
          int weekday = state.dateFetchableDate.weekday;

          DateTime date = state.dateFetchableDate.add(const Duration(days: 7));
          DateTime weekStartedDate = date.subtract(Duration(days: weekday - 1));
          DateTime weekEndDate = weekStartedDate.add(const Duration(days: 6));
          String frmStartedWeek = PrintableDate.monthDay(weekStartedDate);

          String frmEndWeek = PrintableDate.monthDay(weekEndDate);

          emit(DateCounterLoadedState(
              printableDate: '$frmStartedWeek to $frmEndWeek',
              dateFetchableDate: date));
          return;
        case Frequency.month:

          ///get month and add 1 and so on
          int month = state.dateFetchableDate.month + 1;
          int year = state.dateFetchableDate.year;
          DateTime newDate = DateTime(year, month, 1);

          final printableDate = PrintableDate.yearMonth(newDate);

          emit(DateCounterLoadedState(
              printableDate: printableDate, dateFetchableDate: newDate));
          return;
        case Frequency.year:
          int year = state.dateFetchableDate.year + 1;
          DateTime newDate = DateTime(year, 1, 1);

          final printableDate = formatDateTimeYearOnly(newDate);
          emit(DateCounterLoadedState(
              printableDate: printableDate, dateFetchableDate: newDate));
          return;
        case Frequency.overall:
          emit(DateCounterLoadedState(
              printableDate: '', dateFetchableDate: DateTime.now()));
          return;
      }
    }
  }

  void _decrementDateCounter(
      DecrementDateCounter event, Emitter<DateCounterState> emit) {
    final state = this.state;
    if (state is DateCounterLoadedState) {
      switch (_cubit.state.selectedFrequency) {
        case Frequency.today:
          DateTime newDate =
              state.dateFetchableDate.subtract(const Duration(days: 1));
          final printableDate = PrintableDate.yearMonthDay(newDate);

          emit(DateCounterLoadedState(
              printableDate: printableDate, dateFetchableDate: newDate));
          return;
        case Frequency.week:
          int weekday = state.dateFetchableDate.weekday;

          DateTime date =
              state.dateFetchableDate.subtract((const Duration(days: 7)));
          DateTime weekStartedDate = date.subtract(Duration(days: weekday - 1));
          DateTime weekEndDate = weekStartedDate.add(const Duration(days: 6));
          String frmStartedWeek = PrintableDate.monthDay(weekStartedDate);
          String frmEndWeek = PrintableDate.monthDay(weekEndDate);

          emit(DateCounterLoadedState(
              printableDate: '$frmStartedWeek to $frmEndWeek',
              dateFetchableDate: date));
          return;
        case Frequency.month:
          int month = state.dateFetchableDate.month - 1;
          int year = state.dateFetchableDate.year;
          DateTime newDate = DateTime(year, month, 1);

          final printableDate = PrintableDate.yearMonth(newDate);

          emit(DateCounterLoadedState(
              printableDate: printableDate, dateFetchableDate: newDate));
          return;
        case Frequency.year:
          int year = state.dateFetchableDate.year - 1;
          DateTime newDate = DateTime(year, 1, 1);

          final printableDate = formatDateTimeYearOnly(newDate);
          emit(DateCounterLoadedState(
              printableDate: printableDate, dateFetchableDate: newDate));
          return;
        case Frequency.overall:
          emit(DateCounterLoadedState(
              printableDate: '', dateFetchableDate: DateTime.now()));
          return;
      }
    }
  }

  void _resetDateTimeCounter(
      ResetDateTimeCounter event, Emitter<DateCounterState> emit) {
    final state = this.state;
    if (state is DateCounterLoadedState) {
      final date = DateTime.now();
      switch (_cubit.state.selectedFrequency) {
        case Frequency.today:
          final printableDate = PrintableDate.yearMonthDay(date);

          emit(DateCounterLoadedState(
              printableDate: printableDate, dateFetchableDate: date));
          return;
        case Frequency.week:
          int weekday = state.dateFetchableDate.weekday;
         
          DateTime weekStartedDate = date.subtract(Duration(days: weekday - 1));
          DateTime weekEndDate = weekStartedDate.add(const Duration(days: 6));

          DateTime newDate = weekEndDate;

          String frmStartedWeek = PrintableDate.monthDay(weekStartedDate);

          String frmEndWeek = PrintableDate.monthDay(weekEndDate);

          emit(DateCounterLoadedState(
              printableDate: '$frmStartedWeek to $frmEndWeek',
              dateFetchableDate: newDate));
          return;
        case Frequency.month:
          final printableDate = PrintableDate.yearMonth(date);

          emit(DateCounterLoadedState(
              printableDate: printableDate, dateFetchableDate: date));
          return;
        case Frequency.year:
          final printableDate = formatDateTimeYearOnly(date);
          emit(DateCounterLoadedState(
              printableDate: printableDate, dateFetchableDate: date));
          return;
        case Frequency.overall:
          emit(DateCounterLoadedState(
              printableDate: '', dateFetchableDate: DateTime.now()));
          return;
      }
    } else {
      //##when first time loaded this will execute so
      final date = DateTime.now();

      final printableDate = formatDateTime(date);
      emit(DateCounterLoadedState(
          printableDate: printableDate, dateFetchableDate: date));
    }
  }
}
