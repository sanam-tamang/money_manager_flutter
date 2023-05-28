import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:money_manager/enum/category_type.dart';
import 'package:money_manager/models/transaction_category.dart';
import 'package:money_manager/models/transaction_model.dart';
part 'transaction_event.dart';
part 'transaction_state.dart';

///this [TransactionBloc] performs the crud operations for the transaction
class TransactionBloc extends Bloc<TransactionEvent, TransactionState>
    with HydratedMixin {
  TransactionBloc() : super(const TransactionLoadedState()) {
    on<AddTransactionEvent>(_onAddtransaction);
    on<UpdateTransactionEvent>(_onUpdatetransaction);
    on<DeleteTransactionEvent>(_onDeletetransaction);
    on<EmptyTransactionEvent>(_onEmptyTransactoinEvent);
    on<TrnCategoryDeletedEvent>(_onCategoryDeleted);
    on<TrnCategoryUpdatedEvent>(_onCategoryUpdated);
  }

  void _onAddtransaction(
      AddTransactionEvent event, Emitter<TransactionState> emit) {
    final state = this.state;
    if (state is TransactionLoadedState) {
      List<Transaction> transactions = List.from(state.transactions)
        ..add(event.transaction);
      __showAndPerformtransaction(transactions: transactions, emit: emit);
    }
  }

  void _onDeletetransaction(
      DeleteTransactionEvent event, Emitter<TransactionState> emit) {
    final state = this.state;
    if (state is TransactionLoadedState) {
      List<Transaction> transactions = List.from(state.transactions)
        ..remove(event.transaction);
      __showAndPerformtransaction(transactions: transactions, emit: emit);
    }
  }

  void _onUpdatetransaction(
      UpdateTransactionEvent event, Emitter<TransactionState> emit) {
    final state = this.state;
    if (state is TransactionLoadedState) {
      List<Transaction> transactions = List.from(state.transactions);
      Iterable<Transaction> updatedTransaction =
          transactions.map((transaction) {
        if (transaction.id == event.transaction.id) {
          return event.transaction;
        } else {
          return transaction;
        }
      });
      __showAndPerformtransaction(
          transactions: updatedTransaction.toList(), emit: emit);
    }
  }

  void _onEmptyTransactoinEvent(
      EmptyTransactionEvent event, Emitter<TransactionState> emit) {
    emit(const TransactionLoadedState(
        transactions: [], totalAmount: 0, totalIncome: 0, totalExpenses: 0));
  }

  void _onCategoryUpdated(
      TrnCategoryUpdatedEvent event, Emitter<TransactionState> emit) {
    final state = this.state;
    if (state is TransactionLoadedState) {
      final List<Transaction> transactions = List.from(state.transactions);
      final newTransactions = transactions.map((transaction) {
        if (transaction.category.id == event.category.id) {
          return transaction.copyWith(category: event.category);
        } else {
          return transaction;
        }
      }).toList();

      __showAndPerformtransaction(transactions: newTransactions, emit: emit);
    }
  }

  void _onCategoryDeleted(
      TrnCategoryDeletedEvent event, Emitter<TransactionState> emit) {
    final state = this.state;
    if (state is TransactionLoadedState) {
      final List<Transaction> transactions = List.from(state.transactions);
      transactions.removeWhere(
          (transaction) => transaction.category.id == event.category.id);

      __showAndPerformtransaction(transactions: transactions, emit: emit);
    }
  }

  void __showAndPerformtransaction(
      {required List<Transaction> transactions,
      required Emitter<TransactionState> emit}) {
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
    emit(TransactionLoadedState(
      transactions: transactions,
      totalIncome: totalIncome,
      totalExpenses: totalExpenses,
      totalAmount: totalAmount,
    ));
  }

  @override
  TransactionState? fromJson(Map<String, dynamic> json) {
    return TransactionLoadedState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TransactionState state) {
    if (state is TransactionLoadedState) {
      return state.toMap();
    } else {
      return {};
    }
  }
}
