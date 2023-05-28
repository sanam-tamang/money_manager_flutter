// ignore_for_file: public_member_api_docs, sort_constructors_first


part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoadedState extends TransactionState {
  final List<Transaction> transactions;
  final double totalExpenses;
  final double totalIncome;
  final double totalAmount;
  const TransactionLoadedState({
     this.transactions =const  [],
     this.totalExpenses = 0,
     this.totalIncome = 0,
     this.totalAmount = 0,
  });

  @override
  List<Object> get props =>
      [transactions, totalIncome, totalExpenses, totalAmount];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'transactions': transactions.map((x) => x.toMap()).toList(),
      'totalExpenses': totalExpenses,
      'totalIncome': totalIncome,
      'totalAmount': totalAmount,
    };
  }

  factory TransactionLoadedState.fromMap(Map<String, dynamic> map) {
    return TransactionLoadedState(
      transactions: List.from((map['transactions']).map((x) => Transaction.fromMap(x),),),
      totalExpenses: map['totalExpenses'] ,
      totalIncome: map['totalIncome'] ,
      totalAmount: map['totalAmount'],
    );
  }

}
