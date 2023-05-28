// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'transactions_scroll_cubit.dart';

class TransactionsScrollState extends Equatable {
  const TransactionsScrollState(
    {required this.isScrollUp}
  );
  final bool isScrollUp;
  @override
  List<Object> get props => [isScrollUp];
}
