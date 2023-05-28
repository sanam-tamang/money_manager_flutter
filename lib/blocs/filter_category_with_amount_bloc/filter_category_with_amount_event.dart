// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filter_category_with_amount_bloc.dart';

abstract class FilterCategoryWithAmountEvent extends Equatable {
  const FilterCategoryWithAmountEvent();

  @override
  List<Object> get props => [];
}

class GetFilterCategoryWithAmount extends FilterCategoryWithAmountEvent {
  final TransactionType type;
 const  GetFilterCategoryWithAmount({
    required this.type,
  });
  
  @override
  List<Object> get props => [type];
}
