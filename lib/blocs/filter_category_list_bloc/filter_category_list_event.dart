part of 'filter_category_list_bloc.dart';

abstract class FilterCategoryListEvent extends Equatable {
  const FilterCategoryListEvent();

  @override
  List<Object> get props => [];
}

class GetFilteredCategoryListEvent extends FilterCategoryListEvent {
  final TransactionType type;
  const GetFilteredCategoryListEvent({
    required this.type,
  });

  @override
  List<Object> get props => [type];
}
