import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../current_transaction_type_cubit/current_transaction_type_cubit.dart';

import '../../models/filter_category_with_amount_model.dart';
import '../../models/transaction_category.dart';

import '../../enum/category_type.dart';
import '../filtered_transaction_by_date_bloc/filtered_transaction_bloc.dart';

part 'filter_category_with_amount_event.dart';
part 'filter_category_with_amount_state.dart';

///this bloc helps to filter list of data
///if it is type TransactionType.income then
///income could have eg salary , it may have multiple salary in it
///for that reason this bloc comes here
///here we only filter those data but we take the data from another filtered data
///which provides the data according base [Dates] and that bloc is
///[FilteredTransactionBloc] this bloc already filtered the data so we are gonna implement this bloc in this
///bloc over here
class FilterCategoryWithAmountBloc
    extends Bloc<FilterCategoryWithAmountEvent, FilterCategoryWithAmountState> {
  final FilteredTransactionBloc _bloc;
  final CurrentTransactionTypeCubit _cubit;
  FilterCategoryWithAmountBloc(
      {required FilteredTransactionBloc bloc,
      required CurrentTransactionTypeCubit cubit})
      : _bloc = bloc,
        _cubit = cubit,
        super(const FilterCategoryWithAmountState()) {
    _bloc.stream.listen((state) {
      (add(GetFilterCategoryWithAmount(
          type: _cubit.state.currentTransactionType)));
    });
    on<GetFilterCategoryWithAmount>(_onGetFilterCategoryWithAmount);
  }

  void _onGetFilterCategoryWithAmount(GetFilterCategoryWithAmount event,
      Emitter<FilterCategoryWithAmountState> emit) {
    final flTState = _bloc.state;
    double amount = 0;
    TransactionCategory? category;
    Set<FilterCategoryWithAmount> fltCategoryWithAmountList = {};
    bool isSame = false;
    for (int i = 0; i < flTState.filteredTransactions.length; i++) {
      if (flTState.filteredTransactions[i].category.type == event.type) {
        for (int j = 0; j < flTState.filteredTransactions.length; j++) {

          if (flTState.filteredTransactions[i].category.id ==
              flTState.filteredTransactions[j].category.id) {
            isSame = true;
            amount =
                amount + flTState.filteredTransactions[j].transactionAmount;
            category = flTState.filteredTransactions[i].category;
          }
        }
        isSame
            ? fltCategoryWithAmountList.add(
                FilterCategoryWithAmount(amount: amount, category: category!))
            : fltCategoryWithAmountList.add(FilterCategoryWithAmount(
                amount: flTState.filteredTransactions[i].transactionAmount,
                category: flTState.filteredTransactions[i].category));
      }

      amount = 0;
      category = null;
      isSame = false;
    }
    double totalAmount = 0;
    for (var element in fltCategoryWithAmountList) {
      totalAmount = totalAmount + element.amount;
    }

    emit(FilterCategoryWithAmountState(
      totalAmount: totalAmount,
        filteredList: fltCategoryWithAmountList.toList()));
  }
}
