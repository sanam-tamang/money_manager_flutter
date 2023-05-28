// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filter_category_list_bloc.dart';

abstract class FilterCategoryListState extends Equatable {
  const FilterCategoryListState();

  @override
  List<Object> get props => [];
}

class FilterCategoryListInitial extends FilterCategoryListState {}

class FilterCategoryListLoadedState extends FilterCategoryListState {
  final List<TransactionCategory> filteredCategories;
  const FilterCategoryListLoadedState({
     this.filteredCategories = const[],
  });

  @override
  List<Object> get props => [filteredCategories];
}
