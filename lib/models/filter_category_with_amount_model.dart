import 'package:equatable/equatable.dart';

import 'transaction_category.dart';

class FilterCategoryWithAmount extends Equatable {
  final double amount;
  final TransactionCategory category;
  const FilterCategoryWithAmount({
    required this.amount,
    required this.category,
  });
  
  @override
  List<Object?> get props => [amount,category];
}