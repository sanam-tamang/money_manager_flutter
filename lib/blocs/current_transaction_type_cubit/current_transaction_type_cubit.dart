import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../enum/category_type.dart';

part 'current_transaction_type_state.dart';

///telling the current transactiontype to statistics to page to show
///this cubit only used for updating data for according to the type
///suppose if you have type [TransactionType.income] and you want to switch to
///another type this cubit helps to inform about which current TransactionTYpe and
///this cubit basically work with [FilterCategoryWithAmountBloc]
class CurrentTransactionTypeCubit extends Cubit<CurrentTransactionTypeState> {
  CurrentTransactionTypeCubit() : super(const CurrentTransactionTypeState());
  void changeTransactionType(TransactionType type) {
    emit(CurrentTransactionTypeState(currentTransactionType: type));
  }
}
