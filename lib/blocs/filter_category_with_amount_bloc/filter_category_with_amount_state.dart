// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filter_category_with_amount_bloc.dart';

class FilterCategoryWithAmountState extends Equatable {
  const FilterCategoryWithAmountState({
     this.filteredList = const [],
     this.totalAmount = 0,
  });
  final List<FilterCategoryWithAmount> filteredList;
  final double totalAmount;
  @override
  List<Object> get props => [filteredList, totalAmount];
}
