import 'package:equatable/equatable.dart';
import 'package:money_manager/blocs/exports.dart';
import 'package:money_manager/core/date_time_formattor.dart';
import 'package:money_manager/enum/frequency_enum.dart';
import 'package:money_manager/models/transaction_model.dart';

import '../../enum/category_type.dart';

part 'filtered_transaction_event.dart';
part 'filtered_transaction_state.dart';

///this [FilteredTransactionBloc] helps to filter the data according to the [DateTIme]

class FilteredTransactionBloc
    extends Bloc<FilteredTransactionEvent, FilteredTransactionLoadedState> {
  final TransactionBloc _bloc;
  final FrequencyCubit _frequencyCubit;
  final DateCounterBloc _dateCounterBloc;
  FilteredTransactionBloc(
      {required FrequencyCubit frequencyCubit,
      required TransactionBloc bloc,
      required DateCounterBloc dateCouterBLoc})
      : _bloc = bloc,
        _frequencyCubit = frequencyCubit,
        _dateCounterBloc = dateCouterBLoc,
        super(const FilteredTransactionLoadedState()) {
    _bloc.stream.listen((state) {
      final dateState = _dateCounterBloc.state;
      if (dateState is DateCounterLoadedState) {
        (add(GetFilteredFrequencyTransaction(
            dateTime: dateState.dateFetchableDate,
            type: _frequencyCubit.state.selectedFrequency)));
      } else {
        (add(GetFilteredFrequencyTransaction(
            dateTime: DateTime.now(),
            type: _frequencyCubit.state.selectedFrequency)));
      }
    });

    _dateCounterBloc.stream.listen((state) {
      if (state is DateCounterLoadedState) {
        (add(GetFilteredFrequencyTransaction(
            dateTime: state.dateFetchableDate,
            type: _frequencyCubit.state.selectedFrequency)));
      }
    });
    on<GetFilteredFrequencyTransaction>(_onGetFilteredFrequencyTransactions);
  }

  void _onGetFilteredFrequencyTransactions(
      GetFilteredFrequencyTransaction event,
      Emitter<FilteredTransactionLoadedState> emit) {
    final trnState = _bloc.state;
    final dtState = _dateCounterBloc.state;
    if (trnState is TransactionLoadedState) {
      switch (event.type) {
        case Frequency.today:
          if (dtState is DateCounterLoadedState) {
            final formattedEventDate =
                formatDateTime(dtState.dateFetchableDate);
            _filteredTransactions(Frequency.today, trnState.transactions,
                formattedEventDate, emit);
          }

          return;

        case Frequency.week:
          final formattedEventDate = formatDateTimeWithYearWeek(event.dateTime);
          _filteredTransactions(Frequency.week, trnState.transactions,
              formattedEventDate, emit);

          return;
        case Frequency.month:
          final formattedEventDate =
              formatDateTimeYearandMonthOnly(event.dateTime);
          _filteredTransactions(Frequency.month, trnState.transactions,
              formattedEventDate, emit);

          return;
        case Frequency.year:
          final formattedEventDate = formatDateTimeYearOnly(event.dateTime);
          _filteredTransactions(Frequency.year, trnState.transactions,
              formattedEventDate, emit);
          return;
        case Frequency.overall:
          _showAllTransactions(transactions: trnState.transactions, emit: emit);
          return;
      }
    }
  }

  void _filteredTransactions(
      Frequency frequency,
      List<Transaction> transactions,
      String formattedEventDate,
      Emitter<FilteredTransactionLoadedState> emit) {
    List<Transaction> filteredTransactions = [];
    double totalIncome = 0;
    double totalExpenses = 0;
    double totalAmount = 0;
    for (int i = 0; i < transactions.length; i++) {
      final parsedDate = DateTime.parse(transactions[i].dateTime);
      String formatedExistingDateTime = formatDateTime(parsedDate);

      if (frequency == Frequency.today) {
        formatedExistingDateTime = formatDateTime(parsedDate);
      } else if (frequency == Frequency.week) {
        formatedExistingDateTime = formatDateTimeWithYearWeek(parsedDate);
      } else if (frequency == Frequency.month) {
        formatedExistingDateTime = formatDateTimeYearandMonthOnly(parsedDate);
      } else if (frequency == Frequency.year) {
        formatedExistingDateTime = formatDateTimeYearOnly(parsedDate);
      }

      ///comparing and additing the value
      if (formatedExistingDateTime.compareTo(formattedEventDate) == 0) {
        filteredTransactions.add(transactions[i]);

        if (transactions[i].category.type == TransactionType.income) {
          totalIncome += transactions[i].transactionAmount;
        } else if (transactions[i].category.type == TransactionType.expense) {
          totalExpenses += transactions[i].transactionAmount;
        }
      }
    }
    totalAmount = totalIncome - totalExpenses;
    emitter(emit,FilteredTransactionLoadedState(
        filteredTransactions: filteredTransactions,
        totalAmount: totalAmount,
        totalExpenses: totalExpenses,
        totalIncome: totalIncome));
  }

  void _showAllTransactions(
      {required List<Transaction> transactions,
      required Emitter<FilteredTransactionLoadedState> emit}) {
    double totalIncome = 0;
    double totalExpenses = 0;
    double totalAmount = 0;

    for (int i = 0; i < transactions.length; i++) {
      if (transactions[i].category.type == TransactionType.income) {
        totalIncome += transactions[i].transactionAmount;
      } else if (transactions[i].category.type == TransactionType.expense) {
        totalExpenses += transactions[i].transactionAmount;
      }
    }

    totalAmount = totalIncome - totalExpenses;
   emitter(emit,FilteredTransactionLoadedState(
        filteredTransactions: transactions,
        totalAmount: totalAmount,
        totalExpenses: totalExpenses,
        totalIncome: totalIncome));
    
  }

  void emitter(Emitter<FilteredTransactionLoadedState> emit,
      FilteredTransactionLoadedState loaded) {
    emit(loaded);
  }
}
