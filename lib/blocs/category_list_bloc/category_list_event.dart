part of 'category_list_bloc.dart';

abstract class CategoryListEvent extends Equatable {
  const CategoryListEvent();

  @override
  List<Object> get props => [];
}

class LoadCategoryEvent extends CategoryListEvent{}

class AddCategoryEvent extends CategoryListEvent {
  final TransactionCategory category;
  const AddCategoryEvent({
    required this.category,
  });
  @override
  List<Object> get props => [category];
}

class UpdateCategoryEvent extends CategoryListEvent {
  final TransactionCategory category;
  const UpdateCategoryEvent({
    required this.category,
  });
  @override
  List<Object> get props => [category];
}

class DeleteCategoryEvent extends CategoryListEvent {
  final TransactionCategory category;
  const DeleteCategoryEvent({
    required this.category,
  });
  @override
  List<Object> get props => [category];
}

class EmptyCategoryEvent extends CategoryListEvent{}