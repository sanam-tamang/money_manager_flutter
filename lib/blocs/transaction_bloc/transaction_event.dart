// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class AddTransactionEvent extends TransactionEvent {
  final Transaction transaction;
  const AddTransactionEvent({
    required this.transaction,
  });
  @override
  List<Object> get props => [transaction];
}

class UpdateTransactionEvent extends TransactionEvent {
  final Transaction transaction;
  const UpdateTransactionEvent({
    required this.transaction,
  });
  @override
  List<Object> get props => [transaction];
}

class DeleteTransactionEvent extends TransactionEvent {
  final Transaction transaction;
  const DeleteTransactionEvent({
    required this.transaction,
  });
  @override
  List<Object> get props => [transaction];
}

class EmptyTransactionEvent extends TransactionEvent {}

class TrnCategoryUpdatedEvent extends TransactionEvent {
  final TransactionCategory category;
const   TrnCategoryUpdatedEvent({
    required this.category,
  });
    @override
  List<Object> get props => [category];
}


class TrnCategoryDeletedEvent extends TransactionEvent {
  final TransactionCategory category;
const   TrnCategoryDeletedEvent({
    required this.category,
  });
    @override
  List<Object> get props => [category];
}