import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:money_manager/blocs/exports.dart';

part 'transactions_scroll_state.dart';

class TransactionsScrollCubit extends Cubit<TransactionsScrollState> {
  TransactionsScrollCubit()
      : super(const TransactionsScrollState(isScrollUp: true));

  void changeScroll(bool isScrollingUp) {
    final state = this.state;
    if (isScrollingUp) {
      if (!state.isScrollUp) {
        emit(const TransactionsScrollState(isScrollUp: true));
      }
    } else if (!isScrollingUp) {
      if (state.isScrollUp) {
        emit(const TransactionsScrollState(isScrollUp: false));
      }
    } 
  }
}
