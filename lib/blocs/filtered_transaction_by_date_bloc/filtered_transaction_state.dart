part of 'filtered_transaction_bloc.dart';

class FilteredTransactionLoadedState extends Equatable {
  const FilteredTransactionLoadedState({this.totalExpenses = 0, this.totalIncome = 0, this.totalAmount = 0,this.filteredTransactions = const []});
  final List<Transaction> filteredTransactions;
    final double totalExpenses;
  final double totalIncome;
  final double totalAmount;
  @override
  List<Object> get props => [filteredTransactions, totalAmount, totalExpenses, totalIncome];
}
