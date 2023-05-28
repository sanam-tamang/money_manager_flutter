// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'current_transaction_type_cubit.dart';

class CurrentTransactionTypeState extends Equatable {
  const CurrentTransactionTypeState(
      {this.currentTransactionType = TransactionType.income});
  final TransactionType currentTransactionType;
  @override
  List<Object> get props => [currentTransactionType];
}
