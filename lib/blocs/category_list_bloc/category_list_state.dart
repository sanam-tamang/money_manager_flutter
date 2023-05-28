
part of 'category_list_bloc.dart';

abstract class CategoryListState extends Equatable {
  const CategoryListState();

  @override
  List<Object> get props => [];
}

class CategoryInitialState extends CategoryListState {
  const CategoryInitialState();

  @override
  List<Object> get props => [];
}

class CategoryLoadedState extends CategoryListState {
  final List<TransactionCategory> categories;
  const CategoryLoadedState({this.categories = const []});

  @override
  List<Object> get props => [categories];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categories': categories.map((x) => x.toMap()).toList(),
    };
  }

  factory CategoryLoadedState.fromMap(Map<String, dynamic> map) {
   final List<TransactionCategory> categories =  List.from(
        (map['categories']).map(
          (x) => TransactionCategory.fromMap(x)
        ));
    return CategoryLoadedState(
      categories: categories
      );
    
  }
}
